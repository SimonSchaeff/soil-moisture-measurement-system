#include "shared_data.h"

volatile uint32_t g_soil_humidity_pct            = 0u;
volatile uint32_t g_soil_humidity_update_counter = 0u;

/* ADC-Producer-Consumer (E51-ISR -> U54_1) */
volatile uint32_t g_adc_raw_sample               = 0u;
volatile uint32_t g_adc_sample_seq               = 0u;
