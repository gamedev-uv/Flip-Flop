library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux4x1UsingConditional is
    Port ( I : in  STD_LOGIC_VECTOR (3 downto 0);
           S : in  STD_LOGIC_VECTOR (1 downto 0);
           Y : out  STD_LOGIC);
end mux4x1UsingConditional;

architecture Behavioral of mux4x1UsingConditional is
begin
	process(I, S)
		begin
			if S = "00" then
				Y <= I(0);
			elsif S = "01" then
				Y <= I(1);
			elsif S = "10" then 
				Y <= I(2);
			elsif S = "11" then 
				Y <= I(3);
			else
				Y <= '0';
			end if;
		end process;
end Behavioral;