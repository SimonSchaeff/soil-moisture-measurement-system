--
-- Synopsys
-- Vhdl wrapper for top level design, written on Tue Jun 23 16:57:45 2026
--
library ieee;
use ieee.std_logic_1164.all;

entity wrapper_for_Top is
   port (
      EXT_RST_N : in std_logic;
      MMUART_0_RXD_F2M : in std_logic;
      MMUART_1_RXD : in std_logic;
      MMUART_4_RXD : in std_logic;
      Mikrobus_Miso : in std_logic;
      REFCLK : in std_logic;
      REFCLK_N : in std_logic;
      MMUART_0_TXD_M2F : out std_logic;
      MMUART_1_TXD : out std_logic;
      MMUART_4_TXD : out std_logic;
      Mikrobus_Cs : out std_logic;
      Mikrobus_Mosi : out std_logic;
      Mikrobus_Sck : out std_logic
   );
end wrapper_for_Top;

architecture rtl of wrapper_for_Top is

component Top
 port (
   EXT_RST_N : in std_logic;
   MMUART_0_RXD_F2M : in std_logic;
   MMUART_1_RXD : in std_logic;
   MMUART_4_RXD : in std_logic;
   Mikrobus_Miso : in std_logic;
   REFCLK : in std_logic;
   REFCLK_N : in std_logic;
   MMUART_0_TXD_M2F : out std_logic;
   MMUART_1_TXD : out std_logic;
   MMUART_4_TXD : out std_logic;
   Mikrobus_Cs : out std_logic;
   Mikrobus_Mosi : out std_logic;
   Mikrobus_Sck : out std_logic
 );
end component;

signal tmp_EXT_RST_N : std_logic;
signal tmp_MMUART_0_RXD_F2M : std_logic;
signal tmp_MMUART_1_RXD : std_logic;
signal tmp_MMUART_4_RXD : std_logic;
signal tmp_Mikrobus_Miso : std_logic;
signal tmp_REFCLK : std_logic;
signal tmp_REFCLK_N : std_logic;
signal tmp_MMUART_0_TXD_M2F : std_logic;
signal tmp_MMUART_1_TXD : std_logic;
signal tmp_MMUART_4_TXD : std_logic;
signal tmp_Mikrobus_Cs : std_logic;
signal tmp_Mikrobus_Mosi : std_logic;
signal tmp_Mikrobus_Sck : std_logic;

begin

tmp_EXT_RST_N <= EXT_RST_N;

tmp_MMUART_0_RXD_F2M <= MMUART_0_RXD_F2M;

tmp_MMUART_1_RXD <= MMUART_1_RXD;

tmp_MMUART_4_RXD <= MMUART_4_RXD;

tmp_Mikrobus_Miso <= Mikrobus_Miso;

tmp_REFCLK <= REFCLK;

tmp_REFCLK_N <= REFCLK_N;

MMUART_0_TXD_M2F <= tmp_MMUART_0_TXD_M2F;

MMUART_1_TXD <= tmp_MMUART_1_TXD;

MMUART_4_TXD <= tmp_MMUART_4_TXD;

Mikrobus_Cs <= tmp_Mikrobus_Cs;

Mikrobus_Mosi <= tmp_Mikrobus_Mosi;

Mikrobus_Sck <= tmp_Mikrobus_Sck;



u1:   Top port map (
		EXT_RST_N => tmp_EXT_RST_N,
		MMUART_0_RXD_F2M => tmp_MMUART_0_RXD_F2M,
		MMUART_1_RXD => tmp_MMUART_1_RXD,
		MMUART_4_RXD => tmp_MMUART_4_RXD,
		Mikrobus_Miso => tmp_Mikrobus_Miso,
		REFCLK => tmp_REFCLK,
		REFCLK_N => tmp_REFCLK_N,
		MMUART_0_TXD_M2F => tmp_MMUART_0_TXD_M2F,
		MMUART_1_TXD => tmp_MMUART_1_TXD,
		MMUART_4_TXD => tmp_MMUART_4_TXD,
		Mikrobus_Cs => tmp_Mikrobus_Cs,
		Mikrobus_Mosi => tmp_Mikrobus_Mosi,
		Mikrobus_Sck => tmp_Mikrobus_Sck
       );
end rtl;
