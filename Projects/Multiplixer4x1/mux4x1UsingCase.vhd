library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux4x1UsingCase is
    Port ( I : in  STD_LOGIC_VECTOR (3 downto 0);
           S : in  STD_LOGIC_VECTOR (1 downto 0);
           Y : out  STD_LOGIC);
end mux4x1UsingCase;

architecture Behavioral of mux4x1UsingCase is
begin
	process(I, S)
		begin
		
			case S is 
				when "00" =>
					Y <= I(0);
				when "01" => 
					Y <= I(1);
				when "10" => 
					Y <= I(2);
				when "11" =>
					Y <= I(3);
				when others => 
					Y <= '0';
					
			end case;
			
		end process;
end Behavioral;