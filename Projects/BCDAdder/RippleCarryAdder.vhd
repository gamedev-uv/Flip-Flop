library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RippleCarryAdder is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           SUM : out  STD_LOGIC_VECTOR (3 downto 0);
           CARRY : out  STD_LOGIC);
end RippleCarryAdder;

architecture Behavioral of RippleCarryAdder is
SIGNAL T : STD_LOGIC_VECTOR(2 downto 0);
begin
	FA0 : entity work.FullAdder Port Map(A => A(0), B => B(0), C =>  '0', SUM => SUM(0), CARRY => T(0));
	FA1 : entity work.FullAdder Port Map(A => A(1), B => B(1), C => T(0), SUM => SUM(1), CARRY => T(1));
	FA2 : entity work.FullAdder Port Map(A => A(2), B => B(2), C => T(1), SUM => SUM(2), CARRY => T(2));
	FA3 : entity work.FullAdder Port Map(A => A(3), B => B(3), C => T(2), SUM => SUM(3), CARRY => CARRY);
end Behavioral;