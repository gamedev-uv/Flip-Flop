library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullAdderUsingMUX is
    Port ( A, B, C : in  STD_LOGIC;
           SUM, CARRY : out  STD_LOGIC);
end FullAdderUsingMUX;

architecture Structural of FullAdderUsingMUX is

SIGNAL SI : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL CI : STD_LOGIC_VECTOR (3 downto 0);

SIGNAL SE : STD_LOGIC_VECTOR (1 downto 0);

begin
	SI <= A & NOT(A) & NOT(A) & A;
	CI <= '1' & A & A & '0';
	SE <= B & C;
	
	MUXSUM : entity work.MUX4x1 Port Map(I => SI, S => SE, O => SUM);
	MUXCAR : entity work.MUX4x1 Port Map(I => CI, S => SE, O => CARRY);
end Structural;