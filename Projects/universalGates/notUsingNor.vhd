library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity notUsingNor is
    Port ( A : in  STD_LOGIC;
           ANOT : out  STD_LOGIC);
end notUsingNor;

architecture Structural of notUsingNor is
begin
	NOR1 : entity work.norGate Port Map(A => A, B => A, Z => ANOT);
end Structural;