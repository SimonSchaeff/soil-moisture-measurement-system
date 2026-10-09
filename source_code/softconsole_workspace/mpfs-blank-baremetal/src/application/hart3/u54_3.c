/*******************************************************************************
 * u54_3.c
 *
 * Rolle dieses Cores:
 * -------------------
 * U54_3 ist der UART-Interface-Core für Bodenfeuchte-Daten.
 * Einziger aktiver UART-Kanal im System (MMUART0).
 *
 * Aufgaben:
 * 1) UART initialisieren und auf Kommandos warten
 * 2) Kommando "COUNT":
 *      - Gibt die Anzahl der bisher gespeicherten 10s-Messwerte aus
 * 3) Kommando "DUMP":
 *      - Gibt alle gespeicherten Werte als CSV aus: "index,wert\r\n"
 *      - Abgeschlossen mit "END\r\n"
 *      - Python: zeit_s = index * 10
 *
 * SRAM-Layout (Basisadresse 0x60000000):
 *   Offset 0x00       : write_index — Anzahl gespeicherter Werte (uint32_t)
 *   Offset 0x04+i*4   : history[i]  — Bodenfeuchte in % 0..100 (uint32_t)
 *
 * Kapazität: 2047 Einträge = ~5h 41min bei 1 Wert/10s
 *
 * Architekturpfad:
 * ----------------
 * U54_3 -> MSS AXI Master -> FIC0 -> AXI Interconnect -> Fabric SRAM
 *
 * UART:
 * -----
 * MMUART0 (Discovery Kit). U54_2 ist im wfi und gibt den Kanal frei.
 ******************************************************************************/

#include <stdio.h>
#include <string.h>
#include <stdint.h>

#include "mpfs_hal/mss_hal.h"
#include "drivers/mss/mss_mmuart/mss_uart.h"
#include "inc/uart_mapping.h"

/* U54_3 verwendet denselben UART wie U54_2 */
extern struct mss_uart_instance* p_uartmap_u54_2;
#define p_uartmap_u54_3 p_uartmap_u54_2

volatile uint32_t count_sw_ints_h3 = 0U;

/******************************************************************************
 * UART Hilfsfunktionen
 *****************************************************************************/
static void uart_puts(const char *text)
{
    MSS_UART_polled_tx_string(p_uartmap_u54_3, (const uint8_t *)text);
}

static void uart_putc(char c)
{
    MSS_UART_polled_tx(p_uartmap_u54_3, (const uint8_t *)&c, 1u);
}

static void print_prompt(void)
{
    uart_puts("[U54_3] COUNT/DUMP ? ");
}

/******************************************************************************
 * Liest eine Zeile vom UART ein.
 *
 * Eigenschaften:
 * - Blocking
 * - Echo aktiv
 * - Backspace/Delete unterstützt
 *****************************************************************************/
static uint32_t uart_get_line(char *buffer, uint32_t max_len)
{
    uint32_t idx = 0u;
    uint8_t ch = 0u;

    while (1)
    {
        if (MSS_UART_get_rx(p_uartmap_u54_3, &ch, 1u) > 0u)
        {
            if ((ch == '\r') || (ch == '\n'))
            {
                buffer[idx] = '\0';
                uart_puts("\r\n");
                return idx;
            }

            if ((ch == '\b') || (ch == 127u))
            {
                if (idx > 0u)
                {
                    idx--;
                    uart_puts("\b \b");
                }
            }
            else if (idx < (max_len - 1u))
            {
                buffer[idx++] = (char)ch;
                uart_putc((char)ch);
            }
        }
    }
}

/******************************************************************************
 * Hauptfunktion von U54_3
 *****************************************************************************/
void u54_3(void)
{
    char input[32];

    /*----------------------------------------------------------------------
     * Wakeup vorbereiten und auf Software-Interrupt vom E51 warten
     *----------------------------------------------------------------------*/
    clear_soft_interrupt();
    set_csr(mie, MIP_MSIP);

#if (IMAGE_LOADED_BY_BOOTLOADER == 0)
    while ((read_csr(mip) & MIP_MSIP) == 0u)
    {
        __asm("wfi");
    }

    clear_soft_interrupt();
#endif

    PLIC_init();
    __enable_irq();

    /*----------------------------------------------------------------------
     * Gemeinsamen UART mit U54_2 initialisieren
     *----------------------------------------------------------------------*/
    (void)mss_config_clk_rst(MSS_PERIPH_MMUART_U54_3,
                             (uint8_t)MPFS_HAL_FIRST_HART,
                             PERIPHERAL_ON);

    MSS_UART_init(p_uartmap_u54_3,
                  MSS_UART_115200_BAUD,
                  MSS_UART_DATA_8_BITS | MSS_UART_NO_PARITY | MSS_UART_ONE_STOP_BIT);

    uart_puts("\r\n[U54_3] Bodenfeuchte UART Interface\r\n");
    uart_puts("[U54_3] Shared UART with U54_2\r\n");
    uart_puts("[U54_3] SRAM: 0x60000000=write_index, 0x60000004..=history[]\r\n");
    uart_puts("[U54_3] Commands: COUNT | DUMP\r\n");

    while (1u)
    {
        uart_puts("\r\n");
        print_prompt();
        uart_get_line(input, sizeof(input));

        /*------------------------------------------------------------------
         * COUNT: Anzahl gespeicherter Messwerte ausgeben
         *------------------------------------------------------------------*/
        if (strcmp(input, "COUNT") == 0)
        {
            uint32_t count = *(volatile uint32_t *)0x60000000u;
            char msg[32];
            snprintf(msg, sizeof(msg), "COUNT=%lu\r\n", (unsigned long)count);
            uart_puts(msg);
            continue;
        }

        /*------------------------------------------------------------------
         * DUMP: Alle Messwerte als CSV ausgeben
         * Format: index,wert\r\n   (abgeschlossen mit "END\r\n")
         * Python-Seite: zeit_s = index * 10
         *------------------------------------------------------------------*/
        if (strcmp(input, "DUMP") == 0)
        {
            uint32_t count = *(volatile uint32_t *)0x60000000u;
            char ln[32];
            snprintf(ln, sizeof(ln), "COUNT=%lu\r\n", (unsigned long)count);
            uart_puts(ln);
            for (uint32_t i = 0u; i < count; i++)
            {
                uint32_t val = *(volatile uint32_t *)(0x60000004u + i * 4u);
                snprintf(ln, sizeof(ln), "%lu,%lu\r\n",
                         (unsigned long)i, (unsigned long)val);
                uart_puts(ln);
            }
            uart_puts("END\r\n");
            continue;
        }

        uart_puts("[U54_3] Unknown command\r\n");
    }
}

/******************************************************************************
 * Software-Interrupt-Handler für Hart 3
 *****************************************************************************/
void Software_h3_IRQHandler(void)
{
    count_sw_ints_h3++;
}
