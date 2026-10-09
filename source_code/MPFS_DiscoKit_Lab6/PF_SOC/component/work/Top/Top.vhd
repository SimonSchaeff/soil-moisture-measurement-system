----------------------------------------------------------------------
-- Created by SmartDesign Tue Jun 23 16:57:09 2026
-- Version: 2025.2 2025.2.0.14
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library polarfire;
use polarfire.all;
----------------------------------------------------------------------
-- Top entity declaration
----------------------------------------------------------------------
entity Top is
    -- Port list
    port(
        -- Inputs
        EXT_RST_N        : in  std_logic;
        MMUART_0_RXD_F2M : in  std_logic;
        MMUART_1_RXD     : in  std_logic;
        MMUART_4_RXD     : in  std_logic;
        Mikrobus_Miso    : in  std_logic;
        REFCLK           : in  std_logic;
        REFCLK_N         : in  std_logic;
        -- Outputs
        MMUART_0_TXD_M2F : out std_logic;
        MMUART_1_TXD     : out std_logic;
        MMUART_4_TXD     : out std_logic;
        Mikrobus_Cs      : out std_logic;
        Mikrobus_Mosi    : out std_logic;
        Mikrobus_Sck     : out std_logic
        );
end Top;
----------------------------------------------------------------------
-- Top architecture body
----------------------------------------------------------------------
architecture RTL of Top is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- CoreAPB3_C0
component CoreAPB3_C0
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
end component;
-- COREAXI4INTERCONNECT_C0
component COREAXI4INTERCONNECT_C0
    -- Port list
    port(
        -- Inputs
        ACLK             : in  std_logic;
        ARESETN          : in  std_logic;
        MASTER0_ARADDR   : in  std_logic_vector(31 downto 0);
        MASTER0_ARBURST  : in  std_logic_vector(1 downto 0);
        MASTER0_ARCACHE  : in  std_logic_vector(3 downto 0);
        MASTER0_ARID     : in  std_logic_vector(7 downto 0);
        MASTER0_ARLEN    : in  std_logic_vector(7 downto 0);
        MASTER0_ARLOCK   : in  std_logic_vector(1 downto 0);
        MASTER0_ARPROT   : in  std_logic_vector(2 downto 0);
        MASTER0_ARQOS    : in  std_logic_vector(3 downto 0);
        MASTER0_ARREGION : in  std_logic_vector(3 downto 0);
        MASTER0_ARSIZE   : in  std_logic_vector(2 downto 0);
        MASTER0_ARUSER   : in  std_logic_vector(0 to 0);
        MASTER0_ARVALID  : in  std_logic;
        MASTER0_AWADDR   : in  std_logic_vector(31 downto 0);
        MASTER0_AWBURST  : in  std_logic_vector(1 downto 0);
        MASTER0_AWCACHE  : in  std_logic_vector(3 downto 0);
        MASTER0_AWID     : in  std_logic_vector(7 downto 0);
        MASTER0_AWLEN    : in  std_logic_vector(7 downto 0);
        MASTER0_AWLOCK   : in  std_logic_vector(1 downto 0);
        MASTER0_AWPROT   : in  std_logic_vector(2 downto 0);
        MASTER0_AWQOS    : in  std_logic_vector(3 downto 0);
        MASTER0_AWREGION : in  std_logic_vector(3 downto 0);
        MASTER0_AWSIZE   : in  std_logic_vector(2 downto 0);
        MASTER0_AWUSER   : in  std_logic_vector(0 to 0);
        MASTER0_AWVALID  : in  std_logic;
        MASTER0_BREADY   : in  std_logic;
        MASTER0_RREADY   : in  std_logic;
        MASTER0_WDATA    : in  std_logic_vector(63 downto 0);
        MASTER0_WLAST    : in  std_logic;
        MASTER0_WSTRB    : in  std_logic_vector(7 downto 0);
        MASTER0_WUSER    : in  std_logic_vector(0 to 0);
        MASTER0_WVALID   : in  std_logic;
        SLAVE0_ARREADY   : in  std_logic;
        SLAVE0_AWREADY   : in  std_logic;
        SLAVE0_BID       : in  std_logic_vector(8 downto 0);
        SLAVE0_BRESP     : in  std_logic_vector(1 downto 0);
        SLAVE0_BUSER     : in  std_logic_vector(0 to 0);
        SLAVE0_BVALID    : in  std_logic;
        SLAVE0_RDATA     : in  std_logic_vector(63 downto 0);
        SLAVE0_RID       : in  std_logic_vector(8 downto 0);
        SLAVE0_RLAST     : in  std_logic;
        SLAVE0_RRESP     : in  std_logic_vector(1 downto 0);
        SLAVE0_RUSER     : in  std_logic_vector(0 to 0);
        SLAVE0_RVALID    : in  std_logic;
        SLAVE0_WREADY    : in  std_logic;
        -- Outputs
        MASTER0_ARREADY  : out std_logic;
        MASTER0_AWREADY  : out std_logic;
        MASTER0_BID      : out std_logic_vector(7 downto 0);
        MASTER0_BRESP    : out std_logic_vector(1 downto 0);
        MASTER0_BUSER    : out std_logic_vector(0 to 0);
        MASTER0_BVALID   : out std_logic;
        MASTER0_RDATA    : out std_logic_vector(63 downto 0);
        MASTER0_RID      : out std_logic_vector(7 downto 0);
        MASTER0_RLAST    : out std_logic;
        MASTER0_RRESP    : out std_logic_vector(1 downto 0);
        MASTER0_RUSER    : out std_logic_vector(0 to 0);
        MASTER0_RVALID   : out std_logic;
        MASTER0_WREADY   : out std_logic;
        SLAVE0_ARADDR    : out std_logic_vector(31 downto 0);
        SLAVE0_ARBURST   : out std_logic_vector(1 downto 0);
        SLAVE0_ARCACHE   : out std_logic_vector(3 downto 0);
        SLAVE0_ARID      : out std_logic_vector(8 downto 0);
        SLAVE0_ARLEN     : out std_logic_vector(7 downto 0);
        SLAVE0_ARLOCK    : out std_logic_vector(1 downto 0);
        SLAVE0_ARPROT    : out std_logic_vector(2 downto 0);
        SLAVE0_ARQOS     : out std_logic_vector(3 downto 0);
        SLAVE0_ARREGION  : out std_logic_vector(3 downto 0);
        SLAVE0_ARSIZE    : out std_logic_vector(2 downto 0);
        SLAVE0_ARUSER    : out std_logic_vector(0 to 0);
        SLAVE0_ARVALID   : out std_logic;
        SLAVE0_AWADDR    : out std_logic_vector(31 downto 0);
        SLAVE0_AWBURST   : out std_logic_vector(1 downto 0);
        SLAVE0_AWCACHE   : out std_logic_vector(3 downto 0);
        SLAVE0_AWID      : out std_logic_vector(8 downto 0);
        SLAVE0_AWLEN     : out std_logic_vector(7 downto 0);
        SLAVE0_AWLOCK    : out std_logic_vector(1 downto 0);
        SLAVE0_AWPROT    : out std_logic_vector(2 downto 0);
        SLAVE0_AWQOS     : out std_logic_vector(3 downto 0);
        SLAVE0_AWREGION  : out std_logic_vector(3 downto 0);
        SLAVE0_AWSIZE    : out std_logic_vector(2 downto 0);
        SLAVE0_AWUSER    : out std_logic_vector(0 to 0);
        SLAVE0_AWVALID   : out std_logic;
        SLAVE0_BREADY    : out std_logic;
        SLAVE0_RREADY    : out std_logic;
        SLAVE0_WDATA     : out std_logic_vector(63 downto 0);
        SLAVE0_WLAST     : out std_logic;
        SLAVE0_WSTRB     : out std_logic_vector(7 downto 0);
        SLAVE0_WUSER     : out std_logic_vector(0 to 0);
        SLAVE0_WVALID    : out std_logic
        );
end component;
-- CoreGPIO_C0
component CoreGPIO_C0
    -- Port list
    port(
        -- Inputs
        GPIO_IN  : in  std_logic_vector(12 downto 0);
        PADDR    : in  std_logic_vector(7 downto 0);
        PCLK     : in  std_logic;
        PENABLE  : in  std_logic;
        PRESETN  : in  std_logic;
        PSEL     : in  std_logic;
        PWDATA   : in  std_logic_vector(31 downto 0);
        PWRITE   : in  std_logic;
        -- Outputs
        GPIO_OE  : out std_logic_vector(12 downto 0);
        GPIO_OUT : out std_logic_vector(12 downto 0);
        INT      : out std_logic_vector(12 downto 0);
        INT_OR   : out std_logic;
        PRDATA   : out std_logic_vector(31 downto 0);
        PREADY   : out std_logic;
        PSLVERR  : out std_logic
        );
end component;
-- CORERESET_PF_C0
component CORERESET_PF_C0
    -- Port list
    port(
        -- Inputs
        BANK_x_VDDI_STATUS : in  std_logic;
        BANK_y_VDDI_STATUS : in  std_logic;
        CLK                : in  std_logic;
        EXT_RST_N          : in  std_logic;
        FF_US_RESTORE      : in  std_logic;
        FPGA_POR_N         : in  std_logic;
        INIT_DONE          : in  std_logic;
        PLL_LOCK           : in  std_logic;
        SS_BUSY            : in  std_logic;
        -- Outputs
        FABRIC_RESET_N     : out std_logic;
        PLL_POWERDOWN_B    : out std_logic
        );
end component;
-- PF_CCC_C1
component PF_CCC_C1
    -- Port list
    port(
        -- Inputs
        PLL_POWERDOWN_N_0 : in  std_logic;
        REF_CLK_0         : in  std_logic;
        -- Outputs
        OUT0_FABCLK_0     : out std_logic;
        OUT1_FABCLK_0     : out std_logic;
        PLL_LOCK_0        : out std_logic
        );
end component;
-- PF_OSC_C0
component PF_OSC_C0
    -- Port list
    port(
        -- Outputs
        RCOSC_160MHZ_GL : out std_logic
        );
end component;
-- PF_SRAM_AHBL_AXI_C0
component PF_SRAM_AHBL_AXI_C0
    -- Port list
    port(
        -- Inputs
        ACLK    : in  std_logic;
        ARADDR  : in  std_logic_vector(31 downto 0);
        ARBURST : in  std_logic_vector(1 downto 0);
        ARCACHE : in  std_logic_vector(3 downto 0);
        ARESETN : in  std_logic;
        ARID    : in  std_logic_vector(8 downto 0);
        ARLEN   : in  std_logic_vector(7 downto 0);
        ARLOCK  : in  std_logic_vector(1 downto 0);
        ARPROT  : in  std_logic_vector(2 downto 0);
        ARSIZE  : in  std_logic_vector(2 downto 0);
        ARVALID : in  std_logic;
        AWADDR  : in  std_logic_vector(31 downto 0);
        AWBURST : in  std_logic_vector(1 downto 0);
        AWCACHE : in  std_logic_vector(3 downto 0);
        AWID    : in  std_logic_vector(8 downto 0);
        AWLEN   : in  std_logic_vector(7 downto 0);
        AWLOCK  : in  std_logic_vector(1 downto 0);
        AWPROT  : in  std_logic_vector(2 downto 0);
        AWSIZE  : in  std_logic_vector(2 downto 0);
        AWVALID : in  std_logic;
        BREADY  : in  std_logic;
        RREADY  : in  std_logic;
        WDATA   : in  std_logic_vector(63 downto 0);
        WLAST   : in  std_logic;
        WSTRB   : in  std_logic_vector(7 downto 0);
        WVALID  : in  std_logic;
        -- Outputs
        ARREADY : out std_logic;
        AWREADY : out std_logic;
        BID     : out std_logic_vector(8 downto 0);
        BRESP   : out std_logic_vector(1 downto 0);
        BVALID  : out std_logic;
        RDATA   : out std_logic_vector(63 downto 0);
        RID     : out std_logic_vector(8 downto 0);
        RLAST   : out std_logic;
        RRESP   : out std_logic_vector(1 downto 0);
        RVALID  : out std_logic;
        WREADY  : out std_logic
        );
end component;
-- PFSOC_INIT_MONITOR_C0
component PFSOC_INIT_MONITOR_C0
    -- Port list
    port(
        -- Outputs
        AUTOCALIB_DONE             : out std_logic;
        BANK_0_VDDI_STATUS         : out std_logic;
        DEVICE_INIT_DONE           : out std_logic;
        FABRIC_POR_N               : out std_logic;
        PCIE_INIT_DONE             : out std_logic;
        SRAM_INIT_DONE             : out std_logic;
        SRAM_INIT_FROM_SNVM_DONE   : out std_logic;
        SRAM_INIT_FROM_SPI_DONE    : out std_logic;
        SRAM_INIT_FROM_UPROM_DONE  : out std_logic;
        USRAM_INIT_DONE            : out std_logic;
        USRAM_INIT_FROM_SNVM_DONE  : out std_logic;
        USRAM_INIT_FROM_SPI_DONE   : out std_logic;
        USRAM_INIT_FROM_UPROM_DONE : out std_logic;
        XCVR_INIT_DONE             : out std_logic
        );
end component;
-- PFSOC_MSS_C0
component PFSOC_MSS_C0
    -- Port list
    port(
        -- Inputs
        FIC_0_ACLK           : in  std_logic;
        FIC_0_AXI4_M_ARREADY : in  std_logic;
        FIC_0_AXI4_M_AWREADY : in  std_logic;
        FIC_0_AXI4_M_BID     : in  std_logic_vector(7 downto 0);
        FIC_0_AXI4_M_BRESP   : in  std_logic_vector(1 downto 0);
        FIC_0_AXI4_M_BVALID  : in  std_logic;
        FIC_0_AXI4_M_RDATA   : in  std_logic_vector(63 downto 0);
        FIC_0_AXI4_M_RID     : in  std_logic_vector(7 downto 0);
        FIC_0_AXI4_M_RLAST   : in  std_logic;
        FIC_0_AXI4_M_RRESP   : in  std_logic_vector(1 downto 0);
        FIC_0_AXI4_M_RVALID  : in  std_logic;
        FIC_0_AXI4_M_WREADY  : in  std_logic;
        FIC_3_APB_M_PRDATA   : in  std_logic_vector(31 downto 0);
        FIC_3_APB_M_PREADY   : in  std_logic;
        FIC_3_APB_M_PSLVERR  : in  std_logic;
        FIC_3_PCLK           : in  std_logic;
        MMUART_0_RXD_F2M     : in  std_logic;
        MMUART_1_RXD         : in  std_logic;
        MMUART_4_RXD         : in  std_logic;
        MSS_INT_F2M          : in  std_logic_vector(63 downto 0);
        MSS_RESET_N_F2M      : in  std_logic;
        REFCLK               : in  std_logic;
        REFCLK_N             : in  std_logic;
        -- Outputs
        FIC_0_AXI4_M_ARADDR  : out std_logic_vector(37 downto 0);
        FIC_0_AXI4_M_ARBURST : out std_logic_vector(1 downto 0);
        FIC_0_AXI4_M_ARCACHE : out std_logic_vector(3 downto 0);
        FIC_0_AXI4_M_ARID    : out std_logic_vector(7 downto 0);
        FIC_0_AXI4_M_ARLEN   : out std_logic_vector(7 downto 0);
        FIC_0_AXI4_M_ARLOCK  : out std_logic;
        FIC_0_AXI4_M_ARPROT  : out std_logic_vector(2 downto 0);
        FIC_0_AXI4_M_ARQOS   : out std_logic_vector(3 downto 0);
        FIC_0_AXI4_M_ARSIZE  : out std_logic_vector(2 downto 0);
        FIC_0_AXI4_M_ARVALID : out std_logic;
        FIC_0_AXI4_M_AWADDR  : out std_logic_vector(37 downto 0);
        FIC_0_AXI4_M_AWBURST : out std_logic_vector(1 downto 0);
        FIC_0_AXI4_M_AWCACHE : out std_logic_vector(3 downto 0);
        FIC_0_AXI4_M_AWID    : out std_logic_vector(7 downto 0);
        FIC_0_AXI4_M_AWLEN   : out std_logic_vector(7 downto 0);
        FIC_0_AXI4_M_AWLOCK  : out std_logic;
        FIC_0_AXI4_M_AWPROT  : out std_logic_vector(2 downto 0);
        FIC_0_AXI4_M_AWQOS   : out std_logic_vector(3 downto 0);
        FIC_0_AXI4_M_AWSIZE  : out std_logic_vector(2 downto 0);
        FIC_0_AXI4_M_AWVALID : out std_logic;
        FIC_0_AXI4_M_BREADY  : out std_logic;
        FIC_0_AXI4_M_RREADY  : out std_logic;
        FIC_0_AXI4_M_WDATA   : out std_logic_vector(63 downto 0);
        FIC_0_AXI4_M_WLAST   : out std_logic;
        FIC_0_AXI4_M_WSTRB   : out std_logic_vector(7 downto 0);
        FIC_0_AXI4_M_WVALID  : out std_logic;
        FIC_0_DLL_LOCK_M2F   : out std_logic;
        FIC_3_APB_M_PADDR    : out std_logic_vector(31 downto 0);
        FIC_3_APB_M_PENABLE  : out std_logic;
        FIC_3_APB_M_PSEL     : out std_logic;
        FIC_3_APB_M_PSTRB    : out std_logic_vector(3 downto 0);
        FIC_3_APB_M_PWDATA   : out std_logic_vector(31 downto 0);
        FIC_3_APB_M_PWRITE   : out std_logic;
        FIC_3_DLL_LOCK_M2F   : out std_logic;
        MMUART_0_TXD_M2F     : out std_logic;
        MMUART_0_TXD_OE_M2F  : out std_logic;
        MMUART_1_TXD         : out std_logic;
        MMUART_4_TXD         : out std_logic;
        MSS_INT_M2F          : out std_logic_vector(15 downto 0);
        MSS_RESET_N_M2F      : out std_logic;
        PLL_CPU_LOCK_M2F     : out std_logic
        );
end component;
-- SPI_Master_for_MCP3204
component SPI_Master_for_MCP3204
    -- Port list
    port(
        -- Inputs
        CLK        : in  std_logic;
        MISO       : in  std_logic;
        RESET_N    : in  std_logic;
        -- Outputs
        ADC_DATA   : out std_logic_vector(11 downto 0);
        BUSY       : out std_logic;
        CS_N       : out std_logic;
        DATA_VALID : out std_logic;
        MOSI       : out std_logic;
        SCK        : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal CoreAPB3_C0_0_APBmslave4_PENABLE               : std_logic;
signal CoreAPB3_C0_0_APBmslave4_PRDATA                : std_logic_vector(31 downto 0);
signal CoreAPB3_C0_0_APBmslave4_PREADY                : std_logic;
signal CoreAPB3_C0_0_APBmslave4_PSELx                 : std_logic;
signal CoreAPB3_C0_0_APBmslave4_PSLVERR               : std_logic;
signal CoreAPB3_C0_0_APBmslave4_PWDATA                : std_logic_vector(31 downto 0);
signal CoreAPB3_C0_0_APBmslave4_PWRITE                : std_logic;
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARADDR   : std_logic_vector(31 downto 0);
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARBURST  : std_logic_vector(1 downto 0);
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARCACHE  : std_logic_vector(3 downto 0);
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARID     : std_logic_vector(8 downto 0);
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARLEN    : std_logic_vector(7 downto 0);
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARLOCK   : std_logic_vector(1 downto 0);
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARPROT   : std_logic_vector(2 downto 0);
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARQOS    : std_logic_vector(3 downto 0);
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARREADY  : std_logic;
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARREGION : std_logic_vector(3 downto 0);
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARSIZE   : std_logic_vector(2 downto 0);
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARUSER   : std_logic_vector(0 to 0);
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARVALID  : std_logic;
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWADDR   : std_logic_vector(31 downto 0);
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWBURST  : std_logic_vector(1 downto 0);
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWCACHE  : std_logic_vector(3 downto 0);
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWID     : std_logic_vector(8 downto 0);
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWLEN    : std_logic_vector(7 downto 0);
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWLOCK   : std_logic_vector(1 downto 0);
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWPROT   : std_logic_vector(2 downto 0);
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWQOS    : std_logic_vector(3 downto 0);
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWREADY  : std_logic;
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWREGION : std_logic_vector(3 downto 0);
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWSIZE   : std_logic_vector(2 downto 0);
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWUSER   : std_logic_vector(0 to 0);
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWVALID  : std_logic;
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_BID      : std_logic_vector(8 downto 0);
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_BREADY   : std_logic;
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_BRESP    : std_logic_vector(1 downto 0);
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_BVALID   : std_logic;
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_RDATA    : std_logic_vector(63 downto 0);
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_RID      : std_logic_vector(8 downto 0);
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_RLAST    : std_logic;
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_RREADY   : std_logic;
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_RRESP    : std_logic_vector(1 downto 0);
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_RVALID   : std_logic;
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_WDATA    : std_logic_vector(63 downto 0);
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_WLAST    : std_logic;
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_WREADY   : std_logic;
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_WSTRB    : std_logic_vector(7 downto 0);
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_WUSER    : std_logic_vector(0 to 0);
signal COREAXI4INTERCONNECT_C0_0_AXI4mslave0_WVALID   : std_logic;
signal CoreGPIO_C0_0_INT_OR                           : std_logic;
signal CORERESET_PF_C0_0_FABRIC_RESET_N               : std_logic;
signal CORERESET_PF_C0_0_PLL_POWERDOWN_B              : std_logic;
signal Mikrobus_Cs_net_0                              : std_logic;
signal Mikrobus_Mosi_net_0                            : std_logic;
signal Mikrobus_Sck_net_0                             : std_logic;
signal MMUART_0_TXD_M2F_net_0                         : std_logic;
signal MMUART_1_TXD_net_0                             : std_logic;
signal MMUART_4_TXD_net_0                             : std_logic;
signal PF_CCC_C0_0_OUT0_FABCLK_0                      : std_logic;
signal PF_CCC_C1_0_PLL_LOCK_0                         : std_logic;
signal PF_OSC_C0_0_RCOSC_160MHZ_GL                    : std_logic;
signal PFSOC_INIT_MONITOR_C0_0_BANK_0_VDDI_STATUS     : std_logic;
signal PFSOC_INIT_MONITOR_C0_0_DEVICE_INIT_DONE       : std_logic;
signal PFSOC_INIT_MONITOR_C0_0_FABRIC_POR_N           : std_logic;
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARBURST    : std_logic_vector(1 downto 0);
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARCACHE    : std_logic_vector(3 downto 0);
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARID       : std_logic_vector(7 downto 0);
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARLEN      : std_logic_vector(7 downto 0);
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARPROT     : std_logic_vector(2 downto 0);
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARQOS      : std_logic_vector(3 downto 0);
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARREADY    : std_logic;
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARSIZE     : std_logic_vector(2 downto 0);
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARVALID    : std_logic;
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWBURST    : std_logic_vector(1 downto 0);
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWCACHE    : std_logic_vector(3 downto 0);
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWID       : std_logic_vector(7 downto 0);
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWLEN      : std_logic_vector(7 downto 0);
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWPROT     : std_logic_vector(2 downto 0);
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWQOS      : std_logic_vector(3 downto 0);
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWREADY    : std_logic;
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWSIZE     : std_logic_vector(2 downto 0);
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWVALID    : std_logic;
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_BID        : std_logic_vector(7 downto 0);
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_BREADY     : std_logic;
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_BRESP      : std_logic_vector(1 downto 0);
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_BUSER      : std_logic_vector(0 to 0);
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_BVALID     : std_logic;
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_RDATA      : std_logic_vector(63 downto 0);
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_RID        : std_logic_vector(7 downto 0);
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_RLAST      : std_logic;
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_RREADY     : std_logic;
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_RRESP      : std_logic_vector(1 downto 0);
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_RUSER      : std_logic_vector(0 to 0);
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_RVALID     : std_logic;
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_WDATA      : std_logic_vector(63 downto 0);
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_WLAST      : std_logic;
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_WREADY     : std_logic;
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_WSTRB      : std_logic_vector(7 downto 0);
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_WVALID     : std_logic;
signal PFSOC_MSS_C0_0_FIC_3_APB_INITIATOR_PADDR       : std_logic_vector(31 downto 0);
signal PFSOC_MSS_C0_0_FIC_3_APB_INITIATOR_PENABLE     : std_logic;
signal PFSOC_MSS_C0_0_FIC_3_APB_INITIATOR_PRDATA      : std_logic_vector(31 downto 0);
signal PFSOC_MSS_C0_0_FIC_3_APB_INITIATOR_PREADY      : std_logic;
signal PFSOC_MSS_C0_0_FIC_3_APB_INITIATOR_PSELx       : std_logic;
signal PFSOC_MSS_C0_0_FIC_3_APB_INITIATOR_PSLVERR     : std_logic;
signal PFSOC_MSS_C0_0_FIC_3_APB_INITIATOR_PWDATA      : std_logic_vector(31 downto 0);
signal PFSOC_MSS_C0_0_FIC_3_APB_INITIATOR_PWRITE      : std_logic;
signal SPI_Master_for_MCP3204_0_ADC_DATA              : std_logic_vector(11 downto 0);
signal SPI_Master_for_MCP3204_0_DATA_VALID            : std_logic;
signal MMUART_1_TXD_net_1                             : std_logic;
signal MMUART_4_TXD_net_1                             : std_logic;
signal MMUART_0_TXD_M2F_net_1                         : std_logic;
signal Mikrobus_Mosi_net_1                            : std_logic;
signal Mikrobus_Sck_net_1                             : std_logic;
signal Mikrobus_Cs_net_1                              : std_logic;
signal GPIO_IN_net_0                                  : std_logic_vector(12 downto 0);
signal MSS_INT_F2M_net_0                              : std_logic_vector(63 downto 0);
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal VCC_net                                        : std_logic;
signal GND_net                                        : std_logic;
signal MSS_INT_F2M_const_net_0                        : std_logic_vector(63 downto 1);
signal PRDATAS0_const_net_0                           : std_logic_vector(31 downto 0);
signal MASTER0_AWREGION_const_net_0                   : std_logic_vector(3 downto 0);
signal MASTER0_ARREGION_const_net_0                   : std_logic_vector(3 downto 0);
----------------------------------------------------------------------
-- Bus Interface Nets Declarations - Unequal Pin Widths
----------------------------------------------------------------------
signal CoreAPB3_C0_0_APBmslave4_PADDR                 : std_logic_vector(31 downto 0);
signal CoreAPB3_C0_0_APBmslave4_PADDR_0               : std_logic_vector(7 downto 0);
signal CoreAPB3_C0_0_APBmslave4_PADDR_0_7to0          : std_logic_vector(7 downto 0);

signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARADDR     : std_logic_vector(37 downto 0);
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARADDR_0   : std_logic_vector(31 downto 0);
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARADDR_0_31to0: std_logic_vector(31 downto 0);

signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARLOCK     : std_logic;
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARLOCK_0   : std_logic_vector(1 downto 0);
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARLOCK_0_0to0: std_logic_vector(0 to 0);
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARLOCK_0_1to1: std_logic_vector(1 to 1);

signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWADDR     : std_logic_vector(37 downto 0);
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWADDR_0   : std_logic_vector(31 downto 0);
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWADDR_0_31to0: std_logic_vector(31 downto 0);

signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWLOCK     : std_logic;
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWLOCK_0   : std_logic_vector(1 downto 0);
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWLOCK_0_0to0: std_logic_vector(0 to 0);
signal PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWLOCK_0_1to1: std_logic_vector(1 to 1);


begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 VCC_net                      <= '1';
 GND_net                      <= '0';
 MSS_INT_F2M_const_net_0      <= B"000000000000000000000000000000000000000000000000000000000000000";
 PRDATAS0_const_net_0         <= B"00000000000000000000000000000000";
 MASTER0_AWREGION_const_net_0 <= B"0000";
 MASTER0_ARREGION_const_net_0 <= B"0000";
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 MMUART_1_TXD_net_1     <= MMUART_1_TXD_net_0;
 MMUART_1_TXD           <= MMUART_1_TXD_net_1;
 MMUART_4_TXD_net_1     <= MMUART_4_TXD_net_0;
 MMUART_4_TXD           <= MMUART_4_TXD_net_1;
 MMUART_0_TXD_M2F_net_1 <= MMUART_0_TXD_M2F_net_0;
 MMUART_0_TXD_M2F       <= MMUART_0_TXD_M2F_net_1;
 Mikrobus_Mosi_net_1    <= Mikrobus_Mosi_net_0;
 Mikrobus_Mosi          <= Mikrobus_Mosi_net_1;
 Mikrobus_Sck_net_1     <= Mikrobus_Sck_net_0;
 Mikrobus_Sck           <= Mikrobus_Sck_net_1;
 Mikrobus_Cs_net_1      <= Mikrobus_Cs_net_0;
 Mikrobus_Cs            <= Mikrobus_Cs_net_1;
----------------------------------------------------------------------
-- Concatenation assignments
----------------------------------------------------------------------
 GPIO_IN_net_0     <= ( SPI_Master_for_MCP3204_0_DATA_VALID & SPI_Master_for_MCP3204_0_ADC_DATA );
 MSS_INT_F2M_net_0 <= ( B"000000000000000000000000000000000000000000000000000000000000000" & CoreGPIO_C0_0_INT_OR );
----------------------------------------------------------------------
-- Bus Interface Nets Assignments - Unequal Pin Widths
----------------------------------------------------------------------
 CoreAPB3_C0_0_APBmslave4_PADDR_0(7 downto 0) <= ( CoreAPB3_C0_0_APBmslave4_PADDR_0_7to0(7 downto 0) );
 CoreAPB3_C0_0_APBmslave4_PADDR_0_7to0(7 downto 0) <= CoreAPB3_C0_0_APBmslave4_PADDR(7 downto 0);

 PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARADDR_0(31 downto 0) <= ( PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARADDR_0_31to0(31 downto 0) );
 PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARADDR_0_31to0(31 downto 0) <= PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARADDR(31 downto 0);

 PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARLOCK_0(1 downto 0) <= ( PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARLOCK_0_1to1(1) & PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARLOCK_0_0to0(0) );
 PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARLOCK_0_0to0(0) <= PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARLOCK;
 PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARLOCK_0_1to1(1) <= '0';

 PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWADDR_0(31 downto 0) <= ( PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWADDR_0_31to0(31 downto 0) );
 PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWADDR_0_31to0(31 downto 0) <= PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWADDR(31 downto 0);

 PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWLOCK_0(1 downto 0) <= ( PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWLOCK_0_1to1(1) & PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWLOCK_0_0to0(0) );
 PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWLOCK_0_0to0(0) <= PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWLOCK;
 PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWLOCK_0_1to1(1) <= '0';

----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- CoreAPB3_C0_0
CoreAPB3_C0_0 : CoreAPB3_C0
    port map( 
        -- Inputs
        PSEL      => PFSOC_MSS_C0_0_FIC_3_APB_INITIATOR_PSELx,
        PENABLE   => PFSOC_MSS_C0_0_FIC_3_APB_INITIATOR_PENABLE,
        PWRITE    => PFSOC_MSS_C0_0_FIC_3_APB_INITIATOR_PWRITE,
        PREADYS0  => VCC_net, -- tied to '1' from definition
        PSLVERRS0 => GND_net, -- tied to '0' from definition
        PREADYS4  => CoreAPB3_C0_0_APBmslave4_PREADY,
        PSLVERRS4 => CoreAPB3_C0_0_APBmslave4_PSLVERR,
        PADDR     => PFSOC_MSS_C0_0_FIC_3_APB_INITIATOR_PADDR,
        PWDATA    => PFSOC_MSS_C0_0_FIC_3_APB_INITIATOR_PWDATA,
        PRDATAS0  => PRDATAS0_const_net_0, -- tied to X"0" from definition
        PRDATAS4  => CoreAPB3_C0_0_APBmslave4_PRDATA,
        -- Outputs
        PREADY    => PFSOC_MSS_C0_0_FIC_3_APB_INITIATOR_PREADY,
        PSLVERR   => PFSOC_MSS_C0_0_FIC_3_APB_INITIATOR_PSLVERR,
        PSELS0    => OPEN,
        PENABLES  => CoreAPB3_C0_0_APBmslave4_PENABLE,
        PWRITES   => CoreAPB3_C0_0_APBmslave4_PWRITE,
        PSELS4    => CoreAPB3_C0_0_APBmslave4_PSELx,
        PRDATA    => PFSOC_MSS_C0_0_FIC_3_APB_INITIATOR_PRDATA,
        PADDRS    => CoreAPB3_C0_0_APBmslave4_PADDR,
        PWDATAS   => CoreAPB3_C0_0_APBmslave4_PWDATA 
        );
-- COREAXI4INTERCONNECT_C0_0
COREAXI4INTERCONNECT_C0_0 : COREAXI4INTERCONNECT_C0
    port map( 
        -- Inputs
        ACLK                       => PF_CCC_C0_0_OUT0_FABCLK_0,
        ARESETN                    => CORERESET_PF_C0_0_FABRIC_RESET_N,
        SLAVE0_AWREADY             => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWREADY,
        SLAVE0_WREADY              => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_WREADY,
        SLAVE0_BVALID              => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_BVALID,
        SLAVE0_ARREADY             => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARREADY,
        SLAVE0_RLAST               => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_RLAST,
        SLAVE0_RVALID              => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_RVALID,
        MASTER0_AWVALID            => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWVALID,
        MASTER0_WLAST              => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_WLAST,
        MASTER0_WVALID             => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_WVALID,
        MASTER0_BREADY             => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_BREADY,
        MASTER0_ARVALID            => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARVALID,
        MASTER0_RREADY             => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_RREADY,
        SLAVE0_BID                 => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_BID,
        SLAVE0_BRESP               => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_BRESP,
        SLAVE0_RID                 => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_RID,
        SLAVE0_RDATA               => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_RDATA,
        SLAVE0_RRESP               => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_RRESP,
        SLAVE0_BUSER(0)            => GND_net, -- tied to '0' from definition
        SLAVE0_RUSER(0)            => GND_net, -- tied to '0' from definition
        MASTER0_AWID               => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWID,
        MASTER0_AWADDR             => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWADDR_0,
        MASTER0_AWLEN              => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWLEN,
        MASTER0_AWSIZE             => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWSIZE,
        MASTER0_AWBURST            => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWBURST,
        MASTER0_AWLOCK(1 downto 0) => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWLOCK_0,
        MASTER0_AWCACHE            => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWCACHE,
        MASTER0_AWPROT             => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWPROT,
        MASTER0_AWQOS              => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWQOS,
        MASTER0_AWREGION           => MASTER0_AWREGION_const_net_0, -- tied to X"0" from definition
        MASTER0_WDATA              => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_WDATA,
        MASTER0_WSTRB              => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_WSTRB,
        MASTER0_ARID               => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARID,
        MASTER0_ARADDR             => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARADDR_0,
        MASTER0_ARLEN              => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARLEN,
        MASTER0_ARSIZE             => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARSIZE,
        MASTER0_ARBURST            => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARBURST,
        MASTER0_ARLOCK(1 downto 0) => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARLOCK_0,
        MASTER0_ARCACHE            => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARCACHE,
        MASTER0_ARPROT             => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARPROT,
        MASTER0_ARQOS              => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARQOS,
        MASTER0_ARREGION           => MASTER0_ARREGION_const_net_0, -- tied to X"0" from definition
        MASTER0_AWUSER(0)          => GND_net, -- tied to '0' from definition
        MASTER0_WUSER(0)           => GND_net, -- tied to '0' from definition
        MASTER0_ARUSER(0)          => GND_net, -- tied to '0' from definition
        -- Outputs
        SLAVE0_AWVALID             => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWVALID,
        SLAVE0_WLAST               => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_WLAST,
        SLAVE0_WVALID              => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_WVALID,
        SLAVE0_BREADY              => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_BREADY,
        SLAVE0_ARVALID             => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARVALID,
        SLAVE0_RREADY              => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_RREADY,
        MASTER0_AWREADY            => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWREADY,
        MASTER0_WREADY             => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_WREADY,
        MASTER0_BVALID             => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_BVALID,
        MASTER0_ARREADY            => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARREADY,
        MASTER0_RLAST              => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_RLAST,
        MASTER0_RVALID             => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_RVALID,
        SLAVE0_AWID                => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWID,
        SLAVE0_AWADDR              => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWADDR,
        SLAVE0_AWLEN               => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWLEN,
        SLAVE0_AWSIZE              => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWSIZE,
        SLAVE0_AWBURST             => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWBURST,
        SLAVE0_AWLOCK              => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWLOCK,
        SLAVE0_AWCACHE             => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWCACHE,
        SLAVE0_AWPROT              => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWPROT,
        SLAVE0_AWQOS               => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWQOS,
        SLAVE0_AWREGION            => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWREGION,
        SLAVE0_WDATA               => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_WDATA,
        SLAVE0_WSTRB               => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_WSTRB,
        SLAVE0_ARID                => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARID,
        SLAVE0_ARADDR              => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARADDR,
        SLAVE0_ARLEN               => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARLEN,
        SLAVE0_ARSIZE              => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARSIZE,
        SLAVE0_ARBURST             => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARBURST,
        SLAVE0_ARLOCK              => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARLOCK,
        SLAVE0_ARCACHE             => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARCACHE,
        SLAVE0_ARPROT              => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARPROT,
        SLAVE0_ARQOS               => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARQOS,
        SLAVE0_ARREGION            => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARREGION,
        SLAVE0_AWUSER              => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWUSER,
        SLAVE0_WUSER               => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_WUSER,
        SLAVE0_ARUSER              => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARUSER,
        MASTER0_BID                => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_BID,
        MASTER0_BRESP              => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_BRESP,
        MASTER0_RID                => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_RID,
        MASTER0_RDATA              => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_RDATA,
        MASTER0_RRESP              => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_RRESP,
        MASTER0_BUSER              => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_BUSER,
        MASTER0_RUSER              => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_RUSER 
        );
-- CoreGPIO_C0_0
CoreGPIO_C0_0 : CoreGPIO_C0
    port map( 
        -- Inputs
        PRESETN  => CORERESET_PF_C0_0_FABRIC_RESET_N,
        PCLK     => PF_CCC_C0_0_OUT0_FABCLK_0,
        PSEL     => CoreAPB3_C0_0_APBmslave4_PSELx,
        PENABLE  => CoreAPB3_C0_0_APBmslave4_PENABLE,
        PWRITE   => CoreAPB3_C0_0_APBmslave4_PWRITE,
        GPIO_IN  => GPIO_IN_net_0,
        PADDR    => CoreAPB3_C0_0_APBmslave4_PADDR_0,
        PWDATA   => CoreAPB3_C0_0_APBmslave4_PWDATA,
        -- Outputs
        INT_OR   => CoreGPIO_C0_0_INT_OR,
        PREADY   => CoreAPB3_C0_0_APBmslave4_PREADY,
        PSLVERR  => CoreAPB3_C0_0_APBmslave4_PSLVERR,
        INT      => OPEN,
        GPIO_OUT => OPEN,
        GPIO_OE  => OPEN,
        PRDATA   => CoreAPB3_C0_0_APBmslave4_PRDATA 
        );
-- CORERESET_PF_C0_0
CORERESET_PF_C0_0 : CORERESET_PF_C0
    port map( 
        -- Inputs
        CLK                => PF_CCC_C0_0_OUT0_FABCLK_0,
        EXT_RST_N          => EXT_RST_N,
        BANK_x_VDDI_STATUS => PFSOC_INIT_MONITOR_C0_0_BANK_0_VDDI_STATUS,
        BANK_y_VDDI_STATUS => VCC_net,
        PLL_LOCK           => PF_CCC_C1_0_PLL_LOCK_0,
        SS_BUSY            => GND_net,
        INIT_DONE          => PFSOC_INIT_MONITOR_C0_0_DEVICE_INIT_DONE,
        FF_US_RESTORE      => GND_net,
        FPGA_POR_N         => PFSOC_INIT_MONITOR_C0_0_FABRIC_POR_N,
        -- Outputs
        PLL_POWERDOWN_B    => CORERESET_PF_C0_0_PLL_POWERDOWN_B,
        FABRIC_RESET_N     => CORERESET_PF_C0_0_FABRIC_RESET_N 
        );
-- PF_CCC_C0_0
PF_CCC_C0_0 : PF_CCC_C1
    port map( 
        -- Inputs
        REF_CLK_0         => PF_OSC_C0_0_RCOSC_160MHZ_GL,
        PLL_POWERDOWN_N_0 => CORERESET_PF_C0_0_PLL_POWERDOWN_B,
        -- Outputs
        OUT0_FABCLK_0     => PF_CCC_C0_0_OUT0_FABCLK_0,
        OUT1_FABCLK_0     => OPEN,
        PLL_LOCK_0        => PF_CCC_C1_0_PLL_LOCK_0 
        );
-- PF_OSC_C0_0
PF_OSC_C0_0 : PF_OSC_C0
    port map( 
        -- Outputs
        RCOSC_160MHZ_GL => PF_OSC_C0_0_RCOSC_160MHZ_GL 
        );
-- PF_SRAM_AHBL_AXI_C0_0
PF_SRAM_AHBL_AXI_C0_0 : PF_SRAM_AHBL_AXI_C0
    port map( 
        -- Inputs
        ACLK    => PF_CCC_C0_0_OUT0_FABCLK_0,
        ARESETN => CORERESET_PF_C0_0_FABRIC_RESET_N,
        AWVALID => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWVALID,
        WLAST   => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_WLAST,
        WVALID  => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_WVALID,
        BREADY  => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_BREADY,
        ARVALID => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARVALID,
        RREADY  => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_RREADY,
        AWADDR  => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWADDR,
        AWLEN   => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWLEN,
        AWSIZE  => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWSIZE,
        AWBURST => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWBURST,
        AWLOCK  => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWLOCK,
        AWCACHE => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWCACHE,
        AWPROT  => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWPROT,
        WDATA   => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_WDATA,
        WSTRB   => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_WSTRB,
        ARADDR  => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARADDR,
        ARLEN   => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARLEN,
        ARSIZE  => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARSIZE,
        ARBURST => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARBURST,
        ARLOCK  => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARLOCK,
        ARCACHE => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARCACHE,
        ARPROT  => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARPROT,
        AWID    => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWID,
        ARID    => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARID,
        -- Outputs
        AWREADY => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_AWREADY,
        WREADY  => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_WREADY,
        BVALID  => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_BVALID,
        ARREADY => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_ARREADY,
        RLAST   => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_RLAST,
        RVALID  => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_RVALID,
        RDATA   => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_RDATA,
        RRESP   => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_RRESP,
        BRESP   => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_BRESP,
        BID     => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_BID,
        RID     => COREAXI4INTERCONNECT_C0_0_AXI4mslave0_RID 
        );
-- PFSOC_INIT_MONITOR_C0_0
PFSOC_INIT_MONITOR_C0_0 : PFSOC_INIT_MONITOR_C0
    port map( 
        -- Outputs
        FABRIC_POR_N               => PFSOC_INIT_MONITOR_C0_0_FABRIC_POR_N,
        PCIE_INIT_DONE             => OPEN,
        USRAM_INIT_DONE            => OPEN,
        SRAM_INIT_DONE             => OPEN,
        DEVICE_INIT_DONE           => PFSOC_INIT_MONITOR_C0_0_DEVICE_INIT_DONE,
        BANK_0_VDDI_STATUS         => PFSOC_INIT_MONITOR_C0_0_BANK_0_VDDI_STATUS,
        XCVR_INIT_DONE             => OPEN,
        USRAM_INIT_FROM_SNVM_DONE  => OPEN,
        USRAM_INIT_FROM_UPROM_DONE => OPEN,
        USRAM_INIT_FROM_SPI_DONE   => OPEN,
        SRAM_INIT_FROM_SNVM_DONE   => OPEN,
        SRAM_INIT_FROM_UPROM_DONE  => OPEN,
        SRAM_INIT_FROM_SPI_DONE    => OPEN,
        AUTOCALIB_DONE             => OPEN 
        );
-- PFSOC_MSS_C0_0
PFSOC_MSS_C0_0 : PFSOC_MSS_C0
    port map( 
        -- Inputs
        FIC_0_ACLK           => PF_CCC_C0_0_OUT0_FABCLK_0,
        FIC_0_AXI4_M_AWREADY => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWREADY,
        FIC_0_AXI4_M_WREADY  => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_WREADY,
        FIC_0_AXI4_M_BVALID  => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_BVALID,
        FIC_0_AXI4_M_ARREADY => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARREADY,
        FIC_0_AXI4_M_RLAST   => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_RLAST,
        FIC_0_AXI4_M_RVALID  => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_RVALID,
        FIC_3_PCLK           => PF_CCC_C0_0_OUT0_FABCLK_0,
        FIC_3_APB_M_PREADY   => PFSOC_MSS_C0_0_FIC_3_APB_INITIATOR_PREADY,
        FIC_3_APB_M_PSLVERR  => PFSOC_MSS_C0_0_FIC_3_APB_INITIATOR_PSLVERR,
        MMUART_0_RXD_F2M     => MMUART_0_RXD_F2M,
        MSS_RESET_N_F2M      => CORERESET_PF_C0_0_FABRIC_RESET_N,
        MMUART_1_RXD         => MMUART_1_RXD,
        MMUART_4_RXD         => MMUART_4_RXD,
        REFCLK               => REFCLK,
        REFCLK_N             => REFCLK_N,
        FIC_0_AXI4_M_BID     => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_BID,
        FIC_0_AXI4_M_BRESP   => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_BRESP,
        FIC_0_AXI4_M_RID     => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_RID,
        FIC_0_AXI4_M_RDATA   => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_RDATA,
        FIC_0_AXI4_M_RRESP   => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_RRESP,
        FIC_3_APB_M_PRDATA   => PFSOC_MSS_C0_0_FIC_3_APB_INITIATOR_PRDATA,
        MSS_INT_F2M          => MSS_INT_F2M_net_0,
        -- Outputs
        FIC_0_DLL_LOCK_M2F   => OPEN,
        FIC_3_DLL_LOCK_M2F   => OPEN,
        FIC_0_AXI4_M_AWLOCK  => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWLOCK,
        FIC_0_AXI4_M_AWVALID => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWVALID,
        FIC_0_AXI4_M_WLAST   => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_WLAST,
        FIC_0_AXI4_M_WVALID  => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_WVALID,
        FIC_0_AXI4_M_BREADY  => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_BREADY,
        FIC_0_AXI4_M_ARLOCK  => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARLOCK,
        FIC_0_AXI4_M_ARVALID => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARVALID,
        FIC_0_AXI4_M_RREADY  => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_RREADY,
        FIC_3_APB_M_PSEL     => PFSOC_MSS_C0_0_FIC_3_APB_INITIATOR_PSELx,
        FIC_3_APB_M_PWRITE   => PFSOC_MSS_C0_0_FIC_3_APB_INITIATOR_PWRITE,
        FIC_3_APB_M_PENABLE  => PFSOC_MSS_C0_0_FIC_3_APB_INITIATOR_PENABLE,
        MMUART_0_TXD_M2F     => MMUART_0_TXD_M2F_net_0,
        MMUART_0_TXD_OE_M2F  => OPEN,
        PLL_CPU_LOCK_M2F     => OPEN,
        MSS_RESET_N_M2F      => OPEN,
        MMUART_1_TXD         => MMUART_1_TXD_net_0,
        MMUART_4_TXD         => MMUART_4_TXD_net_0,
        FIC_0_AXI4_M_AWID    => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWID,
        FIC_0_AXI4_M_AWADDR  => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWADDR,
        FIC_0_AXI4_M_AWLEN   => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWLEN,
        FIC_0_AXI4_M_AWSIZE  => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWSIZE,
        FIC_0_AXI4_M_AWBURST => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWBURST,
        FIC_0_AXI4_M_AWQOS   => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWQOS,
        FIC_0_AXI4_M_AWCACHE => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWCACHE,
        FIC_0_AXI4_M_AWPROT  => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_AWPROT,
        FIC_0_AXI4_M_WDATA   => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_WDATA,
        FIC_0_AXI4_M_WSTRB   => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_WSTRB,
        FIC_0_AXI4_M_ARID    => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARID,
        FIC_0_AXI4_M_ARADDR  => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARADDR,
        FIC_0_AXI4_M_ARLEN   => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARLEN,
        FIC_0_AXI4_M_ARSIZE  => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARSIZE,
        FIC_0_AXI4_M_ARBURST => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARBURST,
        FIC_0_AXI4_M_ARQOS   => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARQOS,
        FIC_0_AXI4_M_ARCACHE => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARCACHE,
        FIC_0_AXI4_M_ARPROT  => PFSOC_MSS_C0_0_FIC_0_AXI4_INITIATOR_ARPROT,
        FIC_3_APB_M_PADDR    => PFSOC_MSS_C0_0_FIC_3_APB_INITIATOR_PADDR,
        FIC_3_APB_M_PSTRB    => OPEN,
        FIC_3_APB_M_PWDATA   => PFSOC_MSS_C0_0_FIC_3_APB_INITIATOR_PWDATA,
        MSS_INT_M2F          => OPEN 
        );
-- SPI_Master_for_MCP3204_0
SPI_Master_for_MCP3204_0 : SPI_Master_for_MCP3204
    port map( 
        -- Inputs
        CLK        => PF_CCC_C0_0_OUT0_FABCLK_0,
        RESET_N    => CORERESET_PF_C0_0_FABRIC_RESET_N,
        MISO       => Mikrobus_Miso,
        -- Outputs
        SCK        => Mikrobus_Sck_net_0,
        CS_N       => Mikrobus_Cs_net_0,
        MOSI       => Mikrobus_Mosi_net_0,
        DATA_VALID => SPI_Master_for_MCP3204_0_DATA_VALID,
        BUSY       => OPEN,
        ADC_DATA   => SPI_Master_for_MCP3204_0_ADC_DATA 
        );

end RTL;
