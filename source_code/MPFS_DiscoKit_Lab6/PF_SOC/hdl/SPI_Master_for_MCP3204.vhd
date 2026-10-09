--------------------------------------------------------------------------------
-- Company: Plant Health System AG
-- Author:  Simon Schaeffler
--
-- File: SPI_Master_for_MCP3204.vhd
-- File history:
--      1.0: 2026-06-14: Erstellt - SPI Master fuer MCP3204 CH0
--      1.1: 2026-06-21: Timing-Korrektur (SPI Mode 0 Sampling + Bit-Alignment Fix)
--      1.2: 2026-06-23: Kommentare korrigiert (19 SCK-Zyklen, MISO-Sampling-Mechanismus dokumentiert)
--
-- Description:
--   SPI-Master-Controller fuer den Microchip MCP3204 12-Bit ADC.
--   Liest Kanal CH0 im Single-Ended-Modus aus und stellt die Werte
--   als 12-Bit Digitalwert (0..4095) in der FPGA-Fabric bereit.
--
--   MCP3204 Kommunikationsprotokoll (19 SCK-Zyklen pro Wandlung):
--     Zyklus 1      : MOSI = '1'  (START-Bit)
--     Zyklus 2      : MOSI = '1'  (SGL/DIFF = '1' -> Single-Ended)
--     Zyklus 3      : MOSI = '0'  (D2 = '0' -> Kanal CH0)
--     Zyklus 4      : MOSI = '0'  (D1 = '0' -> Kanal CH0)
--     Zyklus 5      : MOSI = '0'  (D0 = '0' -> Kanal CH0)
--     Zyklus 6      : MISO = '1'  (MISO idle/high-Z, ADC noch nicht aktiv)
--     Zyklus 7      : MISO = '0'  (NULL-Bit vom ADC)
--     Zyklus 8-19   : MISO = B11..B0 (12-Bit Ergebnis, MSB first)
--
--   MISO-Sampling (Selbstkorrektur durch 12-Bit-Schieberegister):
--     Sampling beginnt bei Zyklus 6 (bit_cnt >= 5) -> 14 Samples total:
--       idle='1', NULL='0', B11, B10, ..., B0
--     Das Schieberegister ist nur 12 Bit breit: die ersten 2 Samples
--     (idle + NULL) werden automatisch herausgeschoben.
--     Ergebnis nach 14 Samples: shift_reg = B11..B0  (korrekt)
--
--   SPI-Modus: Mode 0 (CPOL=0, CPHA=0)
--     - MOSI wird vor der steigenden SCK-Flanke stabil gesetzt
--     - MCP3204 sampelt MOSI an der steigenden Flanke
--     - MCP3204 aktualisiert MISO nach der fallenden Flanke
--     - Master sampelt MISO synchron zur steigenden SCK-Flanke
--
--   WICHTIG (Fix in Version 1.1):
--     - MISO wird ausschließlich auf der steigenden SCK-Flanke abgetastet
--       (korrektes SPI Mode 0 Timing)
--     - Sampling startet bei bit_cnt=5 (Zyklus 6), erfasst 14 MISO-Bits
--     - Die ersten 2 Samples (idle='1', NULL='0') werden durch die
--       12-Bit-Breite des Schieberegisters automatisch verworfen
--       → shift_reg = B11..B0 nach Abschluss der Uebertragung
--
--   Konfiguration ueber Generics:
--     SPI_CLK_DIV:
--       Halbe SPI-Taktperiode in Systemtakten
--       Formel: SYS_CLK / (2 * SPI_CLK)
--       Beispiel: 125 MHz / (2 * 1 MHz) ≈ 63
--
--     SAMPLE_RATE_DIV:
--       Wartezeit zwischen zwei ADC-Wandlungen in Systemtakten
--       bestimmt zusammen mit 18 SCK-Zyklen die Abtastrate
--       Beispiel: ca. 1 kHz Samplingrate bei 125 MHz Systemtakt
--
--   Timing-Anforderungen MCP3204 (bei VDD = 3.3V):
--     SCK max. 1.8 MHz @ 2.7V, 3.2 MHz @ 5V
--     t_CSS (CS setup time): min. 100 ns  → erfüllt
--     t_CSH (CS high time):  min. 500 ns  → erfüllt
--
-- Targeted device: Microchip PolarFire SoC MPFS095T (FCSG325)
--
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SPI_Master_for_MCP3204 is
    generic (
        SPI_CLK_DIV     : integer := 63;
        SAMPLE_RATE_DIV : integer := 122732
    );
    port (
        CLK         : in  std_logic;
        RESET_N     : in  std_logic;

        SCK         : out std_logic;
        CS_N        : out std_logic;
        MOSI        : out std_logic;
        MISO        : in  std_logic;

        ADC_DATA    : out std_logic_vector(11 downto 0);
        DATA_VALID  : out std_logic;
        BUSY        : out std_logic
    );
end entity;

architecture rtl of SPI_Master_for_MCP3204 is

    constant C_CMD_BITS   : integer := 5;
    constant C_DATA_BITS  : integer := 12;
    constant C_TOTAL_BITS : integer := 18;

    constant C_CMD : std_logic_vector(4 downto 0) := "11000";

    type t_state is (IDLE, ASSERT_CS, TRANSFER, DEASSERT_CS);
    signal state : t_state := IDLE;

    signal clk_div_cnt : integer range 0 to SPI_CLK_DIV := 0;
    signal sample_cnt  : integer range 0 to SAMPLE_RATE_DIV := 0;
    signal bit_cnt     : integer range 0 to C_TOTAL_BITS := 0;

    signal sck_r      : std_logic := '0';
    signal cs_n_r     : std_logic := '1';
    signal mosi_r     : std_logic := '0';

    signal adc_data_r : std_logic_vector(11 downto 0) := (others => '0');
    signal shift_reg  : std_logic_vector(11 downto 0) := (others => '0');

    signal data_valid_r : std_logic := '0';
    signal busy_r       : std_logic := '0';

begin

    SCK        <= sck_r;
    CS_N       <= cs_n_r;
    MOSI       <= mosi_r;
    ADC_DATA   <= adc_data_r;
    DATA_VALID <= data_valid_r;
    BUSY       <= busy_r;

    process(CLK, RESET_N)
    begin
        if RESET_N = '0' then
            state        <= IDLE;
            clk_div_cnt  <= 0;
            sample_cnt   <= 0;
            bit_cnt      <= 0;

            sck_r        <= '0';
            cs_n_r       <= '1';
            mosi_r       <= '0';

            shift_reg    <= (others => '0');
            adc_data_r   <= (others => '0');

            data_valid_r <= '0';
            busy_r       <= '0';

        elsif rising_edge(CLK) then

            data_valid_r <= '0';

            case state is

                ----------------------------------------------------------------
                -- IDLE
                ----------------------------------------------------------------
                when IDLE =>
                    sck_r  <= '0';
                    cs_n_r <= '1';
                    busy_r <= '0';

                    if sample_cnt = SAMPLE_RATE_DIV then
                        sample_cnt <= 0;
                        state      <= ASSERT_CS;
                    else
                        sample_cnt <= sample_cnt + 1;
                    end if;

                ----------------------------------------------------------------
                -- CS LOW + Vorbereitung
                ----------------------------------------------------------------
                when ASSERT_CS =>
                    cs_n_r      <= '0';
                    busy_r      <= '1';

                    bit_cnt     <= 0;
                    clk_div_cnt <= 0;

                    mosi_r      <= C_CMD(4); -- START + SGL
                    sck_r       <= '0';

                    shift_reg   <= (others => '0');

                    state       <= TRANSFER;

                ----------------------------------------------------------------
                -- SPI TRANSFER (19 SCK-Zyklen, 14 MISO-Samples)
                ----------------------------------------------------------------
                when TRANSFER =>

                    -- Clock divider
                    if clk_div_cnt = SPI_CLK_DIV then
                        clk_div_cnt <= 0;

                        -- Toggle SCK
                        sck_r <= not sck_r;

                        ----------------------------------------------------------------
                        -- RISING EDGE: sample MISO
                        ----------------------------------------------------------------
                        if sck_r = '0' then

                            -- ab bit_cnt=5 (Zyklus 6): 14 Samples total
                            -- idle='1', NULL='0', B11..B0
                            -- 12-Bit-Schieberegister: erste 2 Samples werden herausgeschoben
                            if bit_cnt >= C_CMD_BITS then
                                shift_reg <= shift_reg(10 downto 0) & MISO;
                            end if;

                        ----------------------------------------------------------------
                        -- FALLING EDGE: next bit / MOSI update
                        ----------------------------------------------------------------
                        else

                            if bit_cnt < C_TOTAL_BITS then
                                bit_cnt <= bit_cnt + 1;

                                -- CMD Bits
                                if bit_cnt < C_CMD_BITS then
                                    mosi_r <= C_CMD(3 - bit_cnt);
                                else
                                    mosi_r <= '0';
                                end if;

                            else
                                state <= DEASSERT_CS;
                            end if;

                        end if;

                    else
                        clk_div_cnt <= clk_div_cnt + 1;
                    end if;

                ----------------------------------------------------------------
                -- CS HIGH + Output
                ----------------------------------------------------------------
                when DEASSERT_CS =>
                    cs_n_r       <= '1';
                    sck_r        <= '0';
                    mosi_r       <= '0';

                    adc_data_r   <= shift_reg;
                    data_valid_r <= '1';
                    busy_r       <= '0';

                    state        <= IDLE;

                when others =>
                    state <= IDLE;

            end case;
        end if;
    end process;

end architecture;