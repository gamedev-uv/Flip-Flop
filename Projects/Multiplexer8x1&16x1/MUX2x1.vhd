library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX2x1 is
    Port ( I : in  STD_LOGIC_VECTOR (1 downto 0);
           S : in  STD_LOGIC;
           Y : out  STD_LOGIC);
end MUX2x1;

architecture Behavioral of MUX2x1 is
begin
	with S select 
		Y <= I(0) when '0',
			  I(1) when '1',
			  '0'  when others;
end Behavioral;