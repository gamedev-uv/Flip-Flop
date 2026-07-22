library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nandGate is
    Port ( A, B : in  STD_LOGIC;
           Z : out  STD_LOGIC);
end nandGate;

architecture Behavioral of nandGate is
begin
	Z <= A NAND B;
end Behavioral;