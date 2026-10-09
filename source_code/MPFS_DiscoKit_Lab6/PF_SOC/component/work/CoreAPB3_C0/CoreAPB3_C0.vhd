----------------------------------------------------------------------
-- Created by SmartDesign Thu Apr  9 16:42:05 2026
-- Version: 2025.2 2025.2.0.14
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Component Description (Tcl) 
----------------------------------------------------------------------
--# Exporting Component Description of CoreAPB3_C0 to TCL
--# Family: PolarFireSoC
--# Part Number: MPFS095T-1FCSG325E
--# Create and Configure the core component CoreAPB3_C0
--create_and_configure_core -core_vlnv {Actel:DirectCore:CoreAPB3:4.2.100} -component_name {CoreAPB3_C0} -params {\
--"APB_DWIDTH:32"  \
--"APBSLOT0ENABLE:true"  \
--"APBSLOT1ENABLE:false"  \
--"APBSLOT2ENABLE:false"  \
--"APBSLOT3ENABLE:false"  \
--"APBSLOT4ENABLE:true"  \
--"APBSLOT5ENABLE:false"  \
--"APBSLOT6ENABLE:false"  \
--"APBSLOT7ENABLE:false"  \
--"APBSLOT8ENABLE:false"  \
--"APBSLOT9ENABLE:false"  \
--"APBSLOT10ENABLE:false"  \
--"APBSLOT11ENABLE:false"  \
--"APBSLOT12ENABLE:false"  \
--"APBSLOT13ENABLE:false"  \
--"APBSLOT14ENABLE:false"  \
--"APBSLOT15ENABLE:false"  \
--"IADDR_OPTION:0"  \
--"MADDR_BITS:32"  \
--"SC_0:false"  \
--"SC_1:false"  \
--"SC_2:false"  \
--"SC_3:false"  \
--"SC_4:false"  \
--"SC_5:false"  \
--"SC_6:false"  \
--"SC_7:false"  \
--"SC_8:false"  \
--"SC_9:false"  \
--"SC_10:false"  \
--"SC_11:false"  \
--"SC_12:false"  \
--"SC_13:false"  \
--"SC_14:false"  \
--"SC_15:false"  \
--"UPR_NIBBLE_POSN:6"   }
--# Exporting Component Description of CoreAPB3_C0 to TCL done

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library polarfire;
use polarfire.all;
library COREAPB3_LIB;
use COREAPB3_LIB.all;
use COREAPB3_LIB.components.all;
----------------------------------------------------------------------
-- CoreAPB3_C0 entity declaration
----------------------------------------------------------------------
entity CoreAPB3_C0 is
    -- Port list
    port(
        -- Inputs
        PADDR     : in  std_logic_vector(31 downto 0);
        PENABLE   : in  std_logic;
        PRDATAS0  : in  std_logic_vector(31 downto 0);
        PRDATAS4  : in  std_logic_vector(31 downto 0);
        PREADYS0  : in  std_logic;
        PREADYS4  : in  std_logic;
        PSEL      : in  std_logic;
        PSLVERRS0 : in  std_logic;
        PSLVERRS4 : in  std_logic;
        PWDATA    : in  std_logic_vector(31 downto 0);
        PWRITE    : in  std_logic;
        -- Outputs
        PADDRS    : out std_logic_vector(31 downto 0);
        PENABLES  : out std_logic;
        PRDATA    : out std_logic_vector(31 downto 0);
        PREADY    : out std_logic;
        PSELS0    : out std_logic;
        PSELS4    : out std_logic;
        PSLVERR   : out std_logic;
        PWDATAS   : out std_logic_vector(31 downto 0);
        PWRITES   : out std_logic
        );
end CoreAPB3_C0;
----------------------------------------------------------------------
-- CoreAPB3_C0 architecture body
----------------------------------------------------------------------
architecture RTL of CoreAPB3_C0 is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- CoreAPB3   -   Actel:DirectCore:CoreAPB3:4.2.100
-- using entity instantiation for component CoreAPB3
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal APB3mmaster_PRDATA        : std_logic_vector(31 downto 0);
signal APB3mmaster_PREADY        : std_logic;
signal APB3mmaster_PSLVERR       : std_logic;
signal APBmslave0_PADDR          : std_logic_vector(31 downto 0);
signal APBmslave0_PENABLE        : std_logic;
signal APBmslave0_PSELx          : std_logic;
signal APBmslave0_PWDATA         : std_logic_vector(31 downto 0);
signal APBmslave0_PWRITE         : std_logic;
signal APBmslave4_PSELx          : std_logic;
signal APB3mmaster_PRDATA_net_0  : std_logic_vector(31 downto 0);
signal APB3mmaster_PREADY_net_0  : std_logic;
signal APB3mmaster_PSLVERR_net_0 : std_logic;
signal APBmslave0_PADDR_net_0    : std_logic_vector(31 downto 0);
signal APBmslave0_PSELx_net_0    : std_logic;
signal APBmslave0_PENABLE_net_0  : std_logic;
signal APBmslave0_PWRITE_net_0   : std_logic;
signal APBmslave0_PWDATA_net_0   : std_logic_vector(31 downto 0);
signal APBmslave4_PSELx_net_0    : std_logic;
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal GND_net                   : std_logic;
signal VCC_net                   : std_logic;
signal IADDR_const_net_0         : std_logic_vector(31 downto 0);
signal PRDATAS1_const_net_0      : std_logic_vector(31 downto 0);
signal PRDATAS2_const_net_0      : std_logic_vector(31 downto 0);
signal PRDATAS3_const_net_0      : std_logic_vector(31 downto 0);
signal PRDATAS5_const_net_0      : std_logic_vector(31 downto 0);
signal PRDATAS6_const_net_0      : std_logic_vector(31 downto 0);
signal PRDATAS7_const_net_0      : std_logic_vector(31 downto 0);
signal PRDATAS8_const_net_0      : std_logic_vector(31 downto 0);
signal PRDATAS9_const_net_0      : std_logic_vector(31 downto 0);
signal PRDATAS10_const_net_0     : std_logic_vector(31 downto 0);
signal PRDATAS11_const_net_0     : std_logic_vector(31 downto 0);
signal PRDATAS12_const_net_0     : std_logic_vector(31 downto 0);
signal PRDATAS13_const_net_0     : std_logic_vector(31 downto 0);
signal PRDATAS14_const_net_0     : std_logic_vector(31 downto 0);
signal PRDATAS15_const_net_0     : std_logic_vector(31 downto 0);
signal PRDATAS16_const_net_0     : std_logic_vector(31 downto 0);

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 GND_net               <= '0';
 VCC_net               <= '1';
 IADDR_const_net_0     <= B"00000000000000000000000000000000";
 PRDATAS1_const_net_0  <= B"00000000000000000000000000000000";
 PRDATAS2_const_net_0  <= B"00000000000000000000000000000000";
 PRDATAS3_const_net_0  <= B"00000000000000000000000000000000";
 PRDATAS5_const_net_0  <= B"00000000000000000000000000000000";
 PRDATAS6_const_net_0  <= B"00000000000000000000000000000000";
 PRDATAS7_const_net_0  <= B"00000000000000000000000000000000";
 PRDATAS8_const_net_0  <= B"00000000000000000000000000000000";
 PRDATAS9_const_net_0  <= B"00000000000000000000000000000000";
 PRDATAS10_const_net_0 <= B"00000000000000000000000000000000";
 PRDATAS11_const_net_0 <= B"00000000000000000000000000000000";
 PRDATAS12_const_net_0 <= B"00000000000000000000000000000000";
 PRDATAS13_const_net_0 <= B"00000000000000000000000000000000";
 PRDATAS14_const_net_0 <= B"00000000000000000000000000000000";
 PRDATAS15_const_net_0 <= B"00000000000000000000000000000000";
 PRDATAS16_const_net_0 <= B"00000000000000000000000000000000";
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 APB3mmaster_PRDATA_net_0  <= APB3mmaster_PRDATA;
 PRDATA(31 downto 0)       <= APB3mmaster_PRDATA_net_0;
 APB3mmaster_PREADY_net_0  <= APB3mmaster_PREADY;
 PREADY                    <= APB3mmaster_PREADY_net_0;
 APB3mmaster_PSLVERR_net_0 <= APB3mmaster_PSLVERR;
 PSLVERR                   <= APB3mmaster_PSLVERR_net_0;
 APBmslave0_PADDR_net_0    <= APBmslave0_PADDR;
 PADDRS(31 downto 0)       <= APBmslave0_PADDR_net_0;
 APBmslave0_PSELx_net_0    <= APBmslave0_PSELx;
 PSELS0                    <= APBmslave0_PSELx_net_0;
 APBmslave0_PENABLE_net_0  <= APBmslave0_PENABLE;
 PENABLES                  <= APBmslave0_PENABLE_net_0;
 APBmslave0_PWRITE_net_0   <= APBmslave0_PWRITE;
 PWRITES                   <= APBmslave0_PWRITE_net_0;
 APBmslave0_PWDATA_net_0   <= APBmslave0_PWDATA;
 PWDATAS(31 downto 0)      <= APBmslave0_PWDATA_net_0;
 APBmslave4_PSELx_net_0    <= APBmslave4_PSELx;
 PSELS4                    <= APBmslave4_PSELx_net_0;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- CoreAPB3_C0_0   -   Actel:DirectCore:CoreAPB3:4.2.100
CoreAPB3_C0_0 : entity COREAPB3_LIB.CoreAPB3
    generic map( 
        APB_DWIDTH      => ( 32 ),
        APBSLOT0ENABLE  => ( 1 ),
        APBSLOT1ENABLE  => ( 0 ),
        APBSLOT2ENABLE  => ( 0 ),
        APBSLOT3ENABLE  => ( 0 ),
        APBSLOT4ENABLE  => ( 1 ),
        APBSLOT5ENABLE  => ( 0 ),
        APBSLOT6ENABLE  => ( 0 ),
        APBSLOT7ENABLE  => ( 0 ),
        APBSLOT8ENABLE  => ( 0 ),
        APBSLOT9ENABLE  => ( 0 ),
        APBSLOT10ENABLE => ( 0 ),
        APBSLOT11ENABLE => ( 0 ),
        APBSLOT12ENABLE => ( 0 ),
        APBSLOT13ENABLE => ( 0 ),
        APBSLOT14ENABLE => ( 0 ),
        APBSLOT15ENABLE => ( 0 ),
        FAMILY          => ( 27 ),
        IADDR_OPTION    => ( 0 ),
        MADDR_BITS      => ( 32 ),
        SC_0            => ( 0 ),
        SC_1            => ( 0 ),
        SC_2            => ( 0 ),
        SC_3            => ( 0 ),
        SC_4            => ( 0 ),
        SC_5            => ( 0 ),
        SC_6            => ( 0 ),
        SC_7            => ( 0 ),
        SC_8            => ( 0 ),
        SC_9            => ( 0 ),
        SC_10           => ( 0 ),
        SC_11           => ( 0 ),
        SC_12           => ( 0 ),
        SC_13           => ( 0 ),
        SC_14           => ( 0 ),
        SC_15           => ( 0 ),
        UPR_NIBBLE_POSN => ( 6 )
        )
    port map( 
        -- Inputs
        PRESETN    => GND_net, -- tied to '0' from definition
        PCLK       => GND_net, -- tied to '0' from definition
        PWRITE     => PWRITE,
        PENABLE    => PENABLE,
        PSEL       => PSEL,
        PREADYS0   => PREADYS0,
        PSLVERRS0  => PSLVERRS0,
        PREADYS1   => VCC_net, -- tied to '1' from definition
        PSLVERRS1  => GND_net, -- tied to '0' from definition
        PREADYS2   => VCC_net, -- tied to '1' from definition
        PSLVERRS2  => GND_net, -- tied to '0' from definition
        PREADYS3   => VCC_net, -- tied to '1' from definition
        PSLVERRS3  => GND_net, -- tied to '0' from definition
        PREADYS4   => PREADYS4,
        PSLVERRS4  => PSLVERRS4,
        PREADYS5   => VCC_net, -- tied to '1' from definition
        PSLVERRS5  => GND_net, -- tied to '0' from definition
        PREADYS6   => VCC_net, -- tied to '1' from definition
        PSLVERRS6  => GND_net, -- tied to '0' from definition
        PREADYS7   => VCC_net, -- tied to '1' from definition
        PSLVERRS7  => GND_net, -- tied to '0' from definition
        PREADYS8   => VCC_net, -- tied to '1' from definition
        PSLVERRS8  => GND_net, -- tied to '0' from definition
        PREADYS9   => VCC_net, -- tied to '1' from definition
        PSLVERRS9  => GND_net, -- tied to '0' from definition
        PREADYS10  => VCC_net, -- tied to '1' from definition
        PSLVERRS10 => GND_net, -- tied to '0' from definition
        PREADYS11  => VCC_net, -- tied to '1' from definition
        PSLVERRS11 => GND_net, -- tied to '0' from definition
        PREADYS12  => VCC_net, -- tied to '1' from definition
        PSLVERRS12 => GND_net, -- tied to '0' from definition
        PREADYS13  => VCC_net, -- tied to '1' from definition
        PSLVERRS13 => GND_net, -- tied to '0' from definition
        PREADYS14  => VCC_net, -- tied to '1' from definition
        PSLVERRS14 => GND_net, -- tied to '0' from definition
        PREADYS15  => VCC_net, -- tied to '1' from definition
        PSLVERRS15 => GND_net, -- tied to '0' from definition
        PREADYS16  => VCC_net, -- tied to '1' from definition
        PSLVERRS16 => GND_net, -- tied to '0' from definition
        PADDR      => PADDR,
        PWDATA     => PWDATA,
        PRDATAS0   => PRDATAS0,
        PRDATAS1   => PRDATAS1_const_net_0, -- tied to X"0" from definition
        PRDATAS2   => PRDATAS2_const_net_0, -- tied to X"0" from definition
        PRDATAS3   => PRDATAS3_const_net_0, -- tied to X"0" from definition
        PRDATAS4   => PRDATAS4,
        PRDATAS5   => PRDATAS5_const_net_0, -- tied to X"0" from definition
        PRDATAS6   => PRDATAS6_const_net_0, -- tied to X"0" from definition
        PRDATAS7   => PRDATAS7_const_net_0, -- tied to X"0" from definition
        PRDATAS8   => PRDATAS8_const_net_0, -- tied to X"0" from definition
        PRDATAS9   => PRDATAS9_const_net_0, -- tied to X"0" from definition
        PRDATAS10  => PRDATAS10_const_net_0, -- tied to X"0" from definition
        PRDATAS11  => PRDATAS11_const_net_0, -- tied to X"0" from definition
        PRDATAS12  => PRDATAS12_const_net_0, -- tied to X"0" from definition
        PRDATAS13  => PRDATAS13_const_net_0, -- tied to X"0" from definition
        PRDATAS14  => PRDATAS14_const_net_0, -- tied to X"0" from definition
        PRDATAS15  => PRDATAS15_const_net_0, -- tied to X"0" from definition
        PRDATAS16  => PRDATAS16_const_net_0, -- tied to X"0" from definition
        IADDR      => IADDR_const_net_0, -- tied to X"0" from definition
        -- Outputs
        PREADY     => APB3mmaster_PREADY,
        PSLVERR    => APB3mmaster_PSLVERR,
        PWRITES    => APBmslave0_PWRITE,
        PENABLES   => APBmslave0_PENABLE,
        PSELS0     => APBmslave0_PSELx,
        PSELS1     => OPEN,
        PSELS2     => OPEN,
        PSELS3     => OPEN,
        PSELS4     => APBmslave4_PSELx,
        PSELS5     => OPEN,
        PSELS6     => OPEN,
        PSELS7     => OPEN,
        PSELS8     => OPEN,
        PSELS9     => OPEN,
        PSELS10    => OPEN,
        PSELS11    => OPEN,
        PSELS12    => OPEN,
        PSELS13    => OPEN,
        PSELS14    => OPEN,
        PSELS15    => OPEN,
        PSELS16    => OPEN,
        PRDATA     => APB3mmaster_PRDATA,
        PADDRS     => APBmslave0_PADDR,
        PWDATAS    => APBmslave0_PWDATA 
        );

end RTL;
