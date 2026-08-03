library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux4x1 is
    Port ( I : in  STD_LOGIC_VECTOR (03 downto 0);
           S : in  STD_LOGIC_VECTOR (01 downto 0);
           Y : out  STD_LOGIC);
end mux4x1;

architecture Behavioral of mux4x1 is
begin
	Y <= ((I(0) AND (NOT S(1)) AND (NOT S(0))) OR
		   (I(1) AND (NOT S(1)) AND (    S(0))) OR
		   (I(2) AND (    S(1)) AND (NOT S(0))) OR
		   (I(3) AND (    S(1)) AND (    S(0))));
end Behavioral;