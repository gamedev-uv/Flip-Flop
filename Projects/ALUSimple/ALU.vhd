library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
    Port ( A, B : in  STD_LOGIC_VECTOR (3 downto 0);
           S : in  STD_LOGIC_VECTOR (1 downto 0);
           O : out  STD_LOGIC_VECTOR (3 downto 0));
end ALU;

architecture Structural of ALU is

SIGNAL ARITHO : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL LOGICO : STD_LOGIC_VECTOR (3 downto 0);

begin
	ARITH : entity work.ArithmeticUnit Port Map(A => A, B => B, S => S(0), O => ARITHO);
	LOGIC : entity work.LogicUnit Port Map(A => A, B => B, S => S(0), O => LOGICO);
	with S(1) select 
		O <= ARITHO when '0',
		     LOGICO when '1',
			  "0000" when others;
end Structural;