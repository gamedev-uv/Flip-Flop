library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullAdder is
    Port ( A, B, C : in  STD_LOGIC;
           SUM, CARRY : out  STD_LOGIC);
end FullAdder;

architecture Behavioral of FullAdder is

SIGNAL I : STD_LOGIC_VECTOR (2 downto 0);

begin
	I <= A & B & C;
	process(I)
		begin 
			if I = "000" then 
				SUM   <= '0';
				CARRY <= '0';
				
			elsif I = "001" then 
				SUM   <= '1';
				CARRY <= '0';
				
			elsif I = "010" then 
				SUM   <= '1';
				CARRY <= '0';
				
			elsif I = "011" then 
				SUM   <= '0';
				CARRY <= '1';
				
			elsif I = "100" then 
				SUM   <= '1';
				CARRY <= '0';
				
			elsif I = "101" then 
				SUM   <= '0';
				CARRY <= '1';
				
			elsif I = "110" then 
				SUM   <= '0';
				CARRY <= '1';
				
			elsif I = "111" then 
				SUM   <= '1';
				CARRY <= '1';
				
			else 
				SUM <= '0';
				CARRY <= '0';
			end if;
		end process;
end Behavioral;
