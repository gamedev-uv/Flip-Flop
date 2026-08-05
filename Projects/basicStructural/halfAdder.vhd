library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity halfAdder is
    Port ( A, B : in  STD_LOGIC;
           SUM, CARRY : out  STD_LOGIC);
end halfAdder;

architecture Dataflow of halfAdder is
begin
	SUM <= A XOR B;
	CARRY <= A AND B;
end Dataflow;