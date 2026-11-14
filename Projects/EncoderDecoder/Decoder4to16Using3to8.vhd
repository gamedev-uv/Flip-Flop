library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder4to16Using3to8 is
    Port ( I : in  STD_LOGIC_VECTOR (3 downto 0);
           E : in  STD_LOGIC;
           O : out  STD_LOGIC_VECTOR (15 downto 0));
end Decoder4to16Using3to8;

architecture Structural of Decoder4to16Using3to8 is

SIGNAL ENABLE0 : STD_LOGIC;
SIGNAL ENABLE1 : STD_LOGIC;

begin
	ENABLE0 <= E AND NOT(I(3));
	ENABLE1 <= E AND    (I(3));

	DEC0 : entity work.Decoder3to8Enable Port Map(I => I(2 downto 0), E => ENABLE0, O => O(7 downto 0));
	DEC1 : entity work.Decoder3to8Enable Port Map(I => I(2 downto 0), E => ENABLE1, O => O(15 downto 8));
end Structural;