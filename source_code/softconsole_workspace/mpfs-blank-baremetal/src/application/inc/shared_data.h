#ifndef SHARED_DATA_H
#define SHARED_DATA_H

#include <stdint.h>

/*
 * Letzter berechneter 10s-Durchschnitt der Bodenfeuchte in Prozent (0..100).
 * Wird vom E51 alle 10 Sekunden aktualisiert.
 */
extern volatile uint32_t g_soil_humidity_pct;

/*
 * Zähler: wird nach jeder neuen 10s-Berechnung um 1 erhöht.
 * Andere Harts können ihn pollen um Änderungen zu erkennen.
 */
extern volatile uint32_t g_soil_humidity_update_counter;

/*
 * Producer-Consumer zwischen E51-ISR (Producer) und U54_1 (Consumer).
 *
 * g_adc_raw_sample : letzter ADC-Rohwert (0..4095), direkt in der ISR gelesen.
 *                    Gültig sobald g_adc_sample_seq sich ändert.
 * g_adc_sample_seq : Sequenzzähler — wird in der ISR nach dem Schreiben von
 *                    g_adc_raw_sample inkrementiert. U54_1 vergleicht diesen
 *                    Wert mit seinem lokalen last_seq um neue Samples zu erkennen.
 *
 * Protokoll (RISC-V fence sichert Sichtbarkeit):
 *   E51-ISR :  g_adc_raw_sample = raw;  fence;  g_adc_sample_seq++;
 *   U54_1   :  while (g_adc_sample_seq == last_seq) {}
 *              fence;  raw = g_adc_raw_sample;  last_seq++;
 */
extern volatile uint32_t g_adc_raw_sample;
extern volatile uint32_t g_adc_sample_seq;

#endif /* SHARED_DATA_H */
