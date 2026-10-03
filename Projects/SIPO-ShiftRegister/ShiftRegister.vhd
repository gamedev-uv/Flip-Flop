library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftRegister is
    Port ( S_in, Reset, clock : in  STD_LOGIC;
           O : out  STD_LOGIC_VECTOR (3 downto 0));
end ShiftRegister;

architecture Behavioral of ShiftRegister is
SIGNAL temp : STD_LOGIC_VECTOR (3 downto 0) := "0000";
begin
	process(Reset, clock) 
	 begin 
		if Reset = '1' then
			temp <= "0000";
		elsif rising_edge(clock) then
			temp <= S_in & temp(3 downto 1);
		end if;
	 end process;
	 O <= temp;
end Behavioral;