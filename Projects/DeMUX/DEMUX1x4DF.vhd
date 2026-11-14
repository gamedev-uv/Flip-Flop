library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DEMUX1x4DF is
    Port ( I : in  STD_LOGIC;
           S : in  STD_LOGIC_VECTOR (1 downto 0);
           O : out  STD_LOGIC_VECTOR (3 downto 0));
end DEMUX1x4DF;

architecture Dataflow of DEMUX1x4DF is
begin
	O(0) <= I AND NOT(S(1)) AND NOT(S(0));
	O(1) <= I AND NOT(S(1)) AND    (S(0));
	O(2) <= I AND    (S(1)) AND NOT(S(0));
	O(3) <= I AND    (S(1)) AND    (S(0));
end Dataflow;