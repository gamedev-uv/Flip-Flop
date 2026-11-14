library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder3to8Enable is
    Port ( I : in  STD_LOGIC_VECTOR (2 downto 0);
           E : in  STD_LOGIC;
           O : out  STD_LOGIC_VECTOR (7 downto 0));
end Decoder3to8Enable;

architecture Behavioral of Decoder3to8Enable is
begin
	process(I, E)
		begin 
			O <= "00000000";
			case I is 
				when "000" => O(0) <= E;
				when "001" => O(1) <= E;
				when "010" => O(2) <= E;
				when "011" => O(3) <= E;
				when "100" => O(4) <= E;
				when "101" => O(5) <= E;
				when "110" => O(6) <= E;
				when "111" => O(7) <= E;
				when others => O <= "00000000";
			end case;
		end process; 
end Behavioral;