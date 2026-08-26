library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder3to8 is
    Port ( I : in  STD_LOGIC_VECTOR (2 downto 0);
           O : out  STD_LOGIC_VECTOR (7 downto 0));
end Decoder3to8;

architecture Behavioural of Decoder3to8 is
begin
	process(I)
		begin
		O <= "00000000";
			case I is
				when "000" => O(0) <= '1';
				when "001" => O(1) <= '1';
				when "010" => O(2) <= '1';
				when "011" => O(3) <= '1';
				when "100" => O(4) <= '1';
				when "101" => O(5) <= '1';
				when "110" => O(6) <= '1';
				when "111" => O(7) <= '1';
				when others => O   <= "00000000";
			end case;
		end process;
end Behavioural;