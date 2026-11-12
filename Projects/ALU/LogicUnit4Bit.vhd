library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity LogicUnit4Bit is
    Port ( A, B : in  STD_LOGIC_VECTOR (3 downto 0);
           S : in  STD_LOGIC_VECTOR (1 downto 0);
           O : out  STD_LOGIC_VECTOR (3 downto 0));
end LogicUnit4Bit;
architecture Structural of LogicUnit4Bit is

SIGNAL T_I0 : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL T_I1 : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL T_I2 : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL T_I3 : STD_LOGIC_VECTOR (3 downto 0);

SIGNAL T : STD_LOGIC_VECTOR (3 downto 0);

begin
	T_I0 <= (A(0) AND B(0)) & (A(0) OR B(0)) & (NOT(A(0))) & (A(0) XOR B(0));
	T_I1 <= (A(1) AND B(1)) & (A(1) OR B(1)) & (NOT(A(1))) & (A(1) XOR B(1));
	T_I2 <= (A(2) AND B(2)) & (A(2) OR B(2)) & (NOT(A(2))) & (A(2) XOR B(2));
	T_I3 <= (A(3) AND B(3)) & (A(3) OR B(3)) & (NOT(A(3))) & (A(3) XOR B(3));
	
	MUX0 : entity work.MUX4x1 Port Map(I => T_I0, S => S, O => T(0));
	MUX1 : entity work.MUX4x1 Port Map(I => T_I1, S => S, O => T(1));
	MUX2 : entity work.MUX4x1 Port Map(I => T_I2, S => S, O => T(2));
	MUX3 : entity work.MUX4x1 Port Map(I => T_I3, S => S, O => T(3));
	
	O <= T;
end Structural;