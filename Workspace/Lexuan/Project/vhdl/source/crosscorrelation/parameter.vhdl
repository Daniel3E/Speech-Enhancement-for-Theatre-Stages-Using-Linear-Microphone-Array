LIBRARY ieee;
LIBRARY work;
USE ieee.std_logic_1164.ALL;

PACKAGE parameter IS
  CONSTANT SIGNAL_WIDTH :INTEGER := 16;
  CONSTANT REGISTER_LENGTH : INTEGER := 100;
  CONSTANT xcorr_SIGNAL_WIDTH : INTEGER := 32;
  CONSTANT xcorr_REGISTER_LENGTH : INTEGER := 100;
  constant LEN_DATA: integer:=23;
  
  TYPE outputdata IS ARRAY (0 TO REGISTER_LENGTH-1) OF STD_LOGIC_VECTOR(SIGNAL_WIDTH-1 DOWNTO 0);
  TYPE xcorrdata IS ARRAY (0 TO xcorr_REGISTER_LENGTH-1) OF STD_LOGIC_VECTOR(xcorr_SIGNAL_WIDTH-1 DOWNTO 0);
  
END PACKAGE;

