/*******************************************************************************
 * e51.c
 *
 * Rolle dieses Cores:
 * -------------------
 * E51 ist der ADC-Lese- und Berechnungs-Core.
 *
 * Ablauf:
 * 1) UART, FIC3 (APB -> CoreGPIO) und FIC0 (AXI4 -> Fabric-SRAM) initialisieren.
 * 2) CoreGPIO initialisieren:
 *      GPIO_IN[11:0] = ADC_DATA[11:0]  (kein Interrupt, nur Daten)
 *      GPIO_IN[12]   = DATA_VALID       (Rising Edge -> INT_OR -> F2M[0])
 * 3) U54-Harts 1-3 aufwecken.
 * 4) Fabric-Interrupt F2M[0] freigeben.
 * 5) Bei jedem DATA_VALID-Interrupt (~1 kHz):
 *      - ADC-Rohwert über APB (CoreGPIO) lesen
 *      - Rohwert akkumulieren
 * 6) Nach 10.000 Samples (= 10 Sekunden bei 1 kHz):
 *      - Durchschnitt berechnen
 *      - In Bodenfeuchte umrechnen:
 *          0    = 0%   Feuchte
 *          4095 = 100% Feuchte
 *          humidity_pct = (raw_avg * 100) / 4095
 *      - Feuchte-Prozentwert in Fabric-SRAM schreiben (via AXI4 / FIC0)
 *      - Shared Variable für andere Harts aktualisieren
 *
 * HINWEIS: UART bleibt initialisiert für spätere Aufgaben.
 ******************************************************************************/

#include <stdio.h>
#include <string.h>
#include <stdint.h>

#include "mpfs_hal/mss_hal.h"
#include "drivers/fpga_ip/CoreGPIO/core_gpio.h"
#include "inc/shared_data.h"

/*---------------------------------------------------------------------------
 * Fabric-Adressen
 *
 * COREGPIO_ADC_BASE : Basisadresse CoreGPIO (APB3-Slave via FIC3)
 *   CoreAPB3 UPR_NIBBLE_POSN=6 → 64 Byte pro Slot
 *   CoreGPIO ist an PSELS4 → Offset = 4 × 64 = 0x100
 *   → FIC3-Basis 0x40000000 + 0x100 = 0x40000100
 * SRAM_BASE         : Basisadresse PF_SRAM   (AXI4-Slave via FIC0)
 *--------------------------------------------------------------------------*/
#define COREGPIO_ADC_BASE   0x40000100u
#define SRAM_BASE           0x60000000u

/*---------------------------------------------------------------------------
 * SRAM-Layout (via FIC0 / AXI4, je 4 Byte)
 *
 * Offset 0x00       : Anzahl gespeicherter Messwerte (write_index), uint32_t
 * Offset 0x04+i*4   : history[i] = Bodenfeuchte in % (0..100), uint32_t
 *
 * Kapazität: (8192 - 4) / 4 = 2047 Einträge
 *            2047 x 10 s = 20470 s  ~= 5 h 41 min
 * Wenn voll: keine weiteren Schreibzugriffe (letzter Wert bleibt stehen).
 *--------------------------------------------------------------------------*/
#define SRAM_MAX_ENTRIES   2047u
#define SRAM_WRITE_IDX    (*(volatile uint32_t*)(SRAM_BASE + 0x00u))
#define SRAM_VALUE(i)     (*(volatile uint32_t*)(SRAM_BASE + 0x04u + (uint32_t)(i) * 4u))

/*---------------------------------------------------------------------------
 * Sensor-Konfiguration
 *--------------------------------------------------------------------------*/
#define ADC_MAX_RAW       4095u    /* 12-Bit ADC Maximalwert               */
#define ADC_SAMPLES_10S   10000u   /* Samples pro 10s bei 1 kHz Abtastrate */

volatile uint32_t count_sw_ints_h0 = 0U;

/* Flag: in ISR gesetzt, in Hauptschleife verarbeitet */
static volatile uint8_t g_f2m0_event_pending = 0U;

/* Letzter ADC-Rohwert — direkt in SoftConsole beobachtbar */
static volatile uint32_t g_last_adc_raw = 0u;

/* CoreGPIO-Instanz für ADC-Datenlesen via APB */
static gpio_instance_t g_gpio_adc;

volatile uint32_t raw;
volatile uint32_t raw_now;

/******************************************************************************
 * Hauptfunktion des E51
 *****************************************************************************/
void e51(void)
{

    /*----------------------------------------------------------------------
     * FIC3 (APB -> CoreGPIO) aktivieren
     *----------------------------------------------------------------------*/
    (void)mss_config_clk_rst(MSS_PERIPH_FIC3,
                             (uint8_t)MPFS_HAL_FIRST_HART,
                             PERIPHERAL_ON);

    /*----------------------------------------------------------------------
     * FIC0 (AXI4 -> Fabric-SRAM) aktivieren
     *----------------------------------------------------------------------*/
    (void)mss_config_clk_rst(MSS_PERIPH_FIC0,
                             (uint8_t)MPFS_HAL_FIRST_HART,
                             PERIPHERAL_ON);

    mss_enable_fabric();

    /*----------------------------------------------------------------------
     * CoreGPIO initialisieren
     * GPIO_IN[11:0] = ADC_DATA[11:0]  -> kein Interrupt, nur Daten
     * GPIO_IN[12]   = DATA_VALID       -> Rising Edge -> INT_OR -> F2M[0]
     *----------------------------------------------------------------------*/
    GPIO_init(&g_gpio_adc, COREGPIO_ADC_BASE, GPIO_APB_32_BITS_BUS);

    /* SRAM-History zurücksetzen */
    SRAM_WRITE_IDX = 0u;

#if (IMAGE_LOADED_BY_BOOTLOADER == 0)
    /*----------------------------------------------------------------------
     * U54-Harts aufwecken
     *----------------------------------------------------------------------*/
    clear_soft_interrupt();
    set_csr(mie, MIP_MSIP);

    raise_soft_interrupt(1U);
    raise_soft_interrupt(2U);
    raise_soft_interrupt(3U);
#endif

    /*----------------------------------------------------------------------
     * PLIC: Fabric-Interrupt F2M[0] freigeben
     * Quelle: DATA_VALID vom SPI_Master -> CoreGPIO GPIO_IN[12] -> INT_OR
     *----------------------------------------------------------------------*/
    PLIC_init();
    PLIC_SetPriority_Threshold(0U);
    PLIC_SetPriority(FABRIC_F2H_0_PLIC, 2U);
    PLIC_EnableIRQ(FABRIC_F2H_0_PLIC);

    __enable_irq();

    /*----------------------------------------------------------------------
     * Hauptschleife
     *
     * Die gesamte Akkumulation und SRAM-Schreiblogik liegt auf U54_1.
     * E51 liest den ADC-Rohwert direkt in der ISR und signalisiert U54_1
     * per Sequenzzähler. Hier nur warten.
     *----------------------------------------------------------------------*/
    while (1U)
    {
        /* alles erledigt die ISR und U54_1 */
    }
}

/******************************************************************************
 * Software-Interrupt-Handler des E51
 *****************************************************************************/
void Software_h0_IRQHandler(void)
{
    count_sw_ints_h0++;
}

/******************************************************************************
 * Fabric-Interrupt-Handler für F2M[0]
 *
 * Ausgelöst durch: DATA_VALID (Rising Edge) vom SPI_Master_for_MCP3204
 *   -> CoreGPIO GPIO_IN[12] -> INT_OR -> MSS F2H_INTERRUPT[0]
 *
 * ADC-Rohwert wird SOFORT hier gelesen (GPIO_IN[11:0] = ADC_DATA[11:0]).
 * Damit wird die Race-Condition vermieden: würde der Wert erst im Main-Loop
 * gelesen, könnte bis dahin schon die nächste Conversion fertig sein und
 * ADC_DATA den neuen Wert enthalten.
 *
 * Ablauf:
 *   1. GPIO_get_inputs() -> Bits [11:0] = aktueller Rohwert
 *   2. Rohwert in g_adc_raw_sample speichern
 *   3. RISC-V fence: stellt sicher dass U54_1 g_adc_raw_sample vor
 *      g_adc_sample_seq sieht
 *   4. g_adc_sample_seq inkrementieren -> signalisiert U54_1
 *   5. CoreGPIO-Interrupt löschen (INT_OR zurücksetzen)
 *****************************************************************************/
uint8_t fabric_f2h_0_plic_IRQHandler(void)
{
    /* ADC-Rohwert sofort lesen, solange ADC_DATA noch gültig ist */
    raw_now = GPIO_get_inputs(&g_gpio_adc) & 0x00000FFFu;

    /* Für SoftConsole Live-Watch */
    g_last_adc_raw = raw_now;

    /* Rohwert für U54_1 bereitstellen */
    g_adc_raw_sample = raw_now;

    /* fence: g_adc_raw_sample muss vor g_adc_sample_seq sichtbar sein */
    __asm__ volatile ("fence" ::: "memory");

    /* Sequenzzähler erhöhen -> U54_1 erkennt neues Sample */
    g_adc_sample_seq++;

    GPIO_clear_irq(&g_gpio_adc, GPIO_12);  /* CoreGPIO INT_OR zurücksetzen */
    return EXT_IRQ_KEEP_ENABLED;
}

