-------------------------------------------------------------------------------
-- Title      : Wrapper ---- ACFC-I2C 
-- Project    : 
-------------------------------------------------------------------------------
-- File       : Wrapper-ACFC_i2c.vhdl
-- Author     : weihanga@chalmers.se
-- Company    : 
-- Created    : 2023-02-08
-- Last update: 2023-02-09
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-02-08  1.0      ASUS	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Wrapper_ACFC_i2c is
  
  port (
    -- clk and rstn
    clk         : in    std_logic;
    rstn        : in    std_logic;
    -- control ready
    SW_vdd_ok   : in    std_logic;
    SHDNZ_ready : in    std_logic;
    
    -- FSNYC and BCLK
    FSYNC     : out   std_logic;
    BCLK      : out   std_logic;
    
    -- i2c communication
    SDA         : inout std_logic;
    SCL         : out   std_logic;
    -- PLL
    SHDNZ       : out   std_logic
    
    );

end entity Wrapper_ACFC_i2c;


architecture arch_Wrapper_ACFC_i2c of Wrapper_ACFC_i2c is
  -- component
  component adc_config is
    -- generic(
    --   -- MODE reg addr
    --   constant const_addr_sleep_reg         : std_logic_vector(7 downto 0) := x"02";
    --   constant const_addr_interrupt_reg     : std_logic_vector(7 downto 0) := x"28";
    --   constant const_addr_c1_reg            : std_logic_vector(7 downto 0) := x"3c";
    --   constant const_addr_c2_reg            : std_logic_vector(7 downto 0) := x"41";
    --   constant const_addr_c3_reg            : std_logic_vector(7 downto 0) := x"46";
    --   constant const_addr_c4_reg            : std_logic_vector(7 downto 0) := x"4b";
    --   constant const_addr_input_channel_reg : std_logic_vector(7 downto 0) := x"73";
    --   constant const_addr_8_reg             : std_logic_vector(7 downto 0) := x"74";
    --   constant const_addr_powerup_reg       : std_logic_vector(7 downto 0) := x"75";
    --   constant const_addr_10_reg            : std_logic_vector(7 downto 0) := x"64"
    --   );
    port (
      rstn         : in  std_logic;
      clk          : in  std_logic;
      done         : in  std_logic;
      start        : out std_logic;
      config_value : out std_logic_vector(7 downto 0);
      config_addr  : out std_logic_vector(7 downto 0);

      SHDNZ        : out std_logic;
      SHDNZ_ready  : in  std_logic;
      SW_vdd_ok    : in  std_logic
      );
  end component adc_config;
  
  component adc_i2c_controller is
    port (
      clk  : in std_logic;
      rstn : in std_logic;
      -- signals between i2c and ACFC
      start : in std_logic;
      done : out std_logic;
      config_addr : in  std_logic_vector(7 downto 0);
      config_value : in  std_logic_vector(7 downto 0);
      -- i2c communication
      SDA : inout std_logic;
      SCL : out std_logic
      );
  end component adc_i2c_controller;

--component design_1_PLL is
--  port (
--    BCLK : out STD_LOGIC;
--    FSYNC : out STD_LOGIC;
--    reset : in STD_LOGIC;
--    sys_clock : in STD_LOGIC
--  );
--  end component design_1_PLL;

  ------------------------------------------------------------
  -- signal between i2c and ACFC
  signal done : std_logic;
  signal start : std_logic;
  signal config_value : std_logic_vector(7 downto 0);
  signal config_addr  : std_logic_vector(7 downto 0);
  -- out signal for FSYNC and BCLK
  signal out_FSYNC : std_logic;
  signal out_BCLK : std_logic;

  signal out_n_clk : std_logic;
  signal out_p_clk : std_logic;

  
    
begin  -- architecture arch_Wrapper_ACFC_i2c
  
  --FSYNC <=  out_FSYNC;
  --BCLK <=  out_BCLK;

  out_p_clk <= not(out_n_clk);
  out_n_clk <= clk;
  
  ------------------------------------------------------------
  -- INSTANCE
  inst_ACFC: component adc_config
    port map (
      rstn         => rstn,
      clk          => clk,
      done         => done,
      start        => start,
      config_value => config_value,
      config_addr  => config_addr,
      SHDNZ        => SHDNZ,
      SHDNZ_ready  => SHDNZ_ready,
      SW_vdd_ok    => SW_vdd_ok);
  inst_i2c: component adc_i2c_controller
    port map (
      clk   => clk,
      rstn  => rstn,
      config_addr => config_addr,
      config_value => config_value,
      start => start,
      done  => done,
      SDA   => SDA,
      SCL   => SCL );
      
  ------------------------------------------------------------
  ----GENERATE the FSYNC and BCLK by PLL
--   pll_for_i2s_FSYNC_BCLK: component design_1_PLL
--   port map (
--      BCLK  => BCLK,
--      FSYNC  => FSYNC,
--      reset  => rstn,
--      sys_clock   => out_n_clk);
  ------------------------------------------------------------
  
  
end architecture arch_Wrapper_ACFC_i2c;
