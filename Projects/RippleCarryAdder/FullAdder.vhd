library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullAdder is
    Port ( A, B, C : in  STD_LOGIC;
           SUM : out  STD_LOGIC;
           CARRY : out  STD_LOGIC);
end FullAdder;

architecture Dataflow of FullAdder is

begin
	SUM <= A XOR B XOR C;
	CARRY <= (A AND B) OR (B AND C) OR (C AND A);
end Dataflow;