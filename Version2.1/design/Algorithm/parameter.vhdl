LIBRARY ieee;
LIBRARY work;
USE ieee.std_logic_1164.ALL;

PACKAGE parameter IS
  CONSTANT SIGNAL_WIDTH :INTEGER := 16;
  CONSTANT REGISTER_LENGTH : INTEGER := 100;
  constant LEN_DATA: integer:=23;
  TYPE outputdata IS ARRAY(0 TO 99) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
END PACKAGE;

