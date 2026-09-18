library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AdderSubtractor is
    Port ( A, B : in  STD_LOGIC_VECTOR (3 downto 0);
           SUB : in  STD_LOGIC;
           SUM : out  STD_LOGIC_VECTOR (3 downto 0);
           CARRY : out  STD_LOGIC);
end AdderSubtractor;

architecture Behavioral of AdderSubtractor is
SIGNAL C_O : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL B_C : STD_LOGIC_VECTOR (3 downto 0);
begin
	B_C(0) <= B(0) XOR SUB;
	B_C(1) <= B(1) XOR SUB;
	B_C(2) <= B(2) XOR SUB;
	B_C(3) <= B(3) XOR SUB;

	FA0 : entity work.FullAdder Port Map(A => A(0), B => B_C(0), C =>    SUB, CARRY => C_O(0), SUM => SUM(0));
	FA1 : entity work.FullAdder Port Map(A => A(1), B => B_C(1), C => C_O(0), CARRY => C_O(1), SUM => SUM(1));
	FA2 : entity work.FullAdder Port Map(A => A(2), B => B_C(2), C => C_O(1), CARRY => C_O(2), SUM => SUM(2));
	FA3 : entity work.FullAdder Port Map(A => A(3), B => B_C(3), C => C_O(2), CARRY => C_O(3), SUM => SUM(3));
	
	CARRY <= NOT(SUB) AND C_O(3); --Optional to prevent carry bit appearing when subtracting
end Behavioral;