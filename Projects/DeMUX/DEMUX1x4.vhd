library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DEMUX1x4 is
    Port ( I : in  STD_LOGIC;
           S : in  STD_LOGIC_VECTOR (1 downto 0);
           Y : out  STD_LOGIC_VECTOR (3 downto 0));
end DEMUX1x4;

architecture Behavioral of DEMUX1x4 is
begin
	process(I, S)
		begin
			Y <= "0000";
			case S is 
				when "00" =>
					Y(0) <= I;
				when "01" => 
					Y(1) <= I;
				when "10" =>
					Y(2) <= I;
				when "11" =>
					Y(3) <= I;
				when others =>
					Y <= "0000";
			end case;
		end process;
end Behavioral;