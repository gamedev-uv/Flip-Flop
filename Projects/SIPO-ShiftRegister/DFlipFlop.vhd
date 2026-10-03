library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DFlipFlop is
    Port ( D, Clk, Reset : in  STD_LOGIC;
           Q : out  STD_LOGIC);
end DFlipFlop;

architecture Behavioral of DFlipFlop is
SIGNAL t : STD_LOGIC := '0';
begin
	process(Clk, Reset)
		begin 
			if Reset = '1' then 
				t <= '0';
			elsif rising_edge(Clk) then
				t <= D;
			end if;
			Q <= t;
		end process;
end Behavioral;