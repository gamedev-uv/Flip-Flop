library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Encoder8to3 is
    Port ( I : in  STD_LOGIC_VECTOR (7 downto 0);
           O : out  STD_LOGIC_VECTOR (2 downto 0));
end Encoder8to3;

architecture Dataflow of Encoder8to3 is
begin
	O(0) <= I(1) OR I(3) OR I(5) OR I(7);
	O(1) <= I(2) OR I(3) OR I(6) OR I(7);
	O(2) <= I(4) OR I(5) OR I(6) OR I(7);
end Dataflow;