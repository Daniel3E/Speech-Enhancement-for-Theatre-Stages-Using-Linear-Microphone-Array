LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
LIBRARY work;
USE work.parameter.ALL;

ENTITY shiftregister_tb IS

  --CONSTANT SIGNAL_WIDTH_tb:INTEGER := 16;
  --CONSTANT REGISTER_LENGTH_tb:INTEGER := 1000;
  
END shiftregister_tb;

ARCHITECTURE arch_shiftregister_tb OF shiftregister_tb IS

SIGNAL din_tb:STD_LOGIC_VECTOR(SIGNAL_WIDTH-1 DOWNTO 0);
SIGNAL dout_tb: outputdata;
SIGNAL clk_tb: STD_LOGIC := '0';
signal counter: integer range 0 to REGISTER_LENGTH:= 0;
signal test_data_tb: outputdata := test_data;

  COMPONENT shiftregister IS
--  GENERIC(SIGNAL_WIDTH:INTEGER := 16;
--           REGISTER_LENGTH:INTEGER := 1000);
  PORT(clk: IN STD_LOGIC;
       din: IN STD_LOGIC_VECTOR(SIGNAL_WIDTH-1 DOWNTO 0);
       dout: OUT outputdata);
  END COMPONENT shiftregister;

BEGIN
  shiftregister_inst:
  COMPONENT shiftregister
--    GENERIC MAP(SIGNAL_WIDTH => SIGNAL_WIDTH_tb,
--                REGISTER_LENGTH => REGISTER_LENGTH_tb)
    PORT MAP(clk => clk_tb,
             din => din_tb,
             dout => dout_tb);

--din_tb <= "0000000000000001";
clk_proc:
PROCESS
BEGIN
  WAIT FOR 5 ns;
  clk_tb <= NOT(clk_tb);
END PROCESS clk_proc;

test_proc: process 
	begin
		wait for 9 ns;
		if counter < REGISTER_LENGTH then
			din_tb <= test_data(counter);
			counter <= counter +1;
		end if;
	end process test_proc;


END arch_shiftregister_tb;


