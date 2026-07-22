library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity norGate is
    Port ( A, B : in  STD_LOGIC;
           Z : out  STD_LOGIC);
end norGate;

architecture Behavioral of norGate is
begin
	Z <= A NOR B;
end Behavioral;