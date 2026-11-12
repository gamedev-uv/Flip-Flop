library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ArithmeticUnit4Bit is
    Port ( A, B : in  STD_LOGIC_VECTOR (3 downto 0);
           S : in  STD_LOGIC_VECTOR (1 downto 0);
           C : in  STD_LOGIC;
			  VALUE : out STD_LOGIC_VECTOR (3 downto 0);
			  CARRY : out STD_LOGIC 
			);
end ArithmeticUnit4Bit;

architecture Structural of ArithmeticUnit4Bit is

SIGNAL IB0 : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL IB1 : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL IB2 : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL IB3 : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL OB : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL O  : STD_LOGIC_VECTOR (4 downto 0);

begin
	IB0 <= '0' & '1' & NOT(B(0)) & B(0);
	IB1 <= '0' & '1' & NOT(B(1)) & B(1);
	IB2 <= '0' & '1' & NOT(B(2)) & B(2);
	IB3 <= '0' & '1' & NOT(B(3)) & B(3);

	BMUX0 : entity work.MUX4x1 Port Map(I => IB0, S => S, O => OB(0)); 
	BMUX1 : entity work.MUX4x1 Port Map(I => IB1, S => S, O => OB(1)); 
	BMUX2 : entity work.MUX4x1 Port Map(I => IB2, S => S, O => OB(2)); 
	BMUX3 : entity work.MUX4x1 Port Map(I => IB3, S => S, O => OB(3)); 
	
	O <= ('0' & A) + ('0' & OB) + C;
	VALUE <= O (3 downto 0);
	CARRY <= O(4);
end Structural;