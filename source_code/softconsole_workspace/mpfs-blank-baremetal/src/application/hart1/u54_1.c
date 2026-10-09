/*******************************************************************************
 * u54_1.c
 *
 * Rolle dieses Cores:
 * -------------------
 * U54_1 ist der Akkumulations- und SRAM-Schreib-Core für ADC-Daten.
 *
 * Ablauf:
 * 1) Auf Software-Interrupt vom E51 warten (Aufwecken).
 * 2) Shared Variable g_adc_sample_seq pollen (gesetzt von E51-ISR).
 * 3) Pro neuem Sample: g_adc_raw_sample lesen, akkumulieren.
 * 4) Nach ADC_SAMPLES_10S Samples (= 10 s bei 1 kHz):
 *      - Durchschnitt berechnen
 *      - In Bodenfeuchte % umrechnen (0=0%, 4095=100%)
 *      - Ergebnis in Fabric-SRAM schreiben (via FIC0 / AXI4)
 *      - Shared Variables für andere Harts aktualisieren
 *
 * Producer-Consumer-Protokoll mit E51:
 *   E51-ISR schreibt g_adc_raw_sample, setzt fence, inkrementiert
 *   g_adc_sample_seq. U54_1 erkennt neues Sample an der Änderung von
 *   g_adc_sample_seq, liest dann g_adc_raw_sample.
 ******************************************************************************/

#include <stdint.h>
#include "mpfs_hal/mss_hal.h"
#include "inc/shared_data.h"

/*---------------------------------------------------------------------------
 * SRAM-Layout (via FIC0 / AXI4, je 4 Byte) — identisch zu e51.c
 *--------------------------------------------------------------------------*/
#define SRAM_BASE           0x60000000u
#define SRAM_MAX_ENTRIES    2047u
#define SRAM_WRITE_IDX      (*(volatile uint32_t*)(SRAM_BASE + 0x00u))
#define SRAM_VALUE(i)       (*(volatile uint32_t*)(SRAM_BASE + 0x04u + (uint32_t)(i) * 4u))

/*---------------------------------------------------------------------------
 * Sensor-Konfiguration — identisch zu e51.c
 *--------------------------------------------------------------------------*/
#define ADC_MAX_RAW         4095u
#define ADC_SAMPLES_10S     10000u

#define ADC_DRY_RAW   2274u
#define ADC_WET_RAW   3276u
#define ADC_RANGE     (ADC_WET_RAW - ADC_DRY_RAW)

volatile uint32_t count_sw_ints_h1 = 0U;
volatile uint32_t humidity_pct;

/******************************************************************************
 * Hauptfunktion von U54_1
 *****************************************************************************/
void u54_1(void)
{
    uint32_t adc_accumulator  = 0u;
    uint32_t adc_sample_count = 0u;
    uint32_t last_seq         = 0u;   /* zuletzt verarbeiteter Sequenzwert */

    set_csr(mie, MIP_MSIP);

#if (IMAGE_LOADED_BY_BOOTLOADER == 0)
    do
    {
        __asm("wfi");
    }
    while (0 == (read_csr(mip) & MIP_MSIP));

    clear_soft_interrupt();
#endif

    PLIC_init();
    __enable_irq();

    /*----------------------------------------------------------------------
     * Akkumulationsschleife
     *
     * Pollen von g_adc_sample_seq: wenn E51-ISR einen neuen ADC-Wert
     * bereitgestellt hat, ist g_adc_sample_seq != last_seq.
     * fence stellt sicher, dass g_adc_raw_sample bereits sichtbar ist
     * bevor es gelesen wird.
     *----------------------------------------------------------------------*/
    while (1U)
    {
        /* Warten bis E51-ISR ein neues Sample signalisiert */
        while (g_adc_sample_seq == last_seq)
        {
            /* busy-wait (kein wfi: sofortige Reaktion nötig bei 1 kHz) */
        }

        /* fence: stellt sicher, dass g_adc_raw_sample sichtbar ist */
        __asm__ volatile ("fence" ::: "memory");

        /* Rohwert lesen und Sequenz bestätigen */
        uint32_t raw = g_adc_raw_sample;
        last_seq = g_adc_sample_seq;

        /* Akkumulieren */
        adc_accumulator  += raw;
        adc_sample_count++;

        /* Nach 10 Sekunden: Durchschnitt berechnen und speichern */
        if (adc_sample_count >= ADC_SAMPLES_10S)
        {
            uint32_t raw_avg      = adc_accumulator / ADC_SAMPLES_10S;
            // this line was used in initial testsetup
            //uint32_t humidity_pct = (raw_avg * 100u) / ADC_MAX_RAW;

            if (raw_avg <= ADC_DRY_RAW)
            {
                humidity_pct = 0u;
            }
            else if (raw_avg >= ADC_WET_RAW)
            {
                humidity_pct = 100u;
            }
            else
            {
                humidity_pct = ((raw_avg - ADC_DRY_RAW) * 100u) / ADC_RANGE;
            }

            /* Shared Variable für andere Harts */
            g_soil_humidity_pct = humidity_pct;
            g_soil_humidity_update_counter++;

            /* Messwert in Fabric-SRAM schreiben */
            if (g_soil_humidity_update_counter <= SRAM_MAX_ENTRIES)
            {
                SRAM_VALUE(g_soil_humidity_update_counter - 1u) = humidity_pct;
                SRAM_WRITE_IDX = g_soil_humidity_update_counter;
            }

            /* Akkumulator zurücksetzen */
            adc_accumulator  = 0u;
            adc_sample_count = 0u;
        }
    }
}

/******************************************************************************
 * Software-Interrupt-Handler von U54_1
 *****************************************************************************/
void Software_h1_IRQHandler(void)
{
    count_sw_ints_h1++;
}
