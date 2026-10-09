/*******************************************************************************
 * u54_2.c
 *
 * Rolle dieses Cores:
 * -------------------
 * U54_2 wartet auf Aufgaben. UART ist initialisiert und bereit.
 * Weitere Funktionalität folgt in einer späteren Aufgabe.
 ******************************************************************************/

#include <stdio.h>
#include <string.h>
#include <stdint.h>

#include "mpfs_hal/mss_hal.h"
#include "drivers/mss/mss_mmuart/mss_uart.h"
#include "inc/uart_mapping.h"
#include "inc/shared_data.h"

extern struct mss_uart_instance* p_uartmap_u54_2;

volatile uint32_t count_sw_ints_h2 = 0U;

static const uint8_t g_start_msg[] =
    "\r\n\r\n[U54_2] Core running. Waiting for tasks.\r\n\r\n";

/******************************************************************************
 * Hauptfunktion von U54_2
 *****************************************************************************/
void u54_2(void)
{
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

    (void)mss_config_clk_rst(MSS_PERIPH_MMUART_U54_2,
                             (uint8_t)MPFS_HAL_FIRST_HART,
                             PERIPHERAL_ON);

    MSS_UART_init(p_uartmap_u54_2,
                  MSS_UART_115200_BAUD,
                  MSS_UART_DATA_8_BITS | MSS_UART_NO_PARITY | MSS_UART_ONE_STOP_BIT);

    MSS_UART_polled_tx_string(p_uartmap_u54_2, g_start_msg);

    while (1U)
    {
        __asm("wfi");
    }
}

/******************************************************************************
 * Software-Interrupt-Handler von U54_2
 *****************************************************************************/
void Software_h2_IRQHandler(void)
{
    count_sw_ints_h2++;
}