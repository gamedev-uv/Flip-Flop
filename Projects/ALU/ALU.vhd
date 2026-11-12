library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
    Port ( A, B : in  STD_LOGIC_VECTOR (3 downto 0);
           S : in  STD_LOGIC_VECTOR (3 downto 0);
			  C : in STD_LOGIC;
           O : out  STD_LOGIC_VECTOR (3 downto 0);
           CARRY : out  STD_LOGIC);
end ALU;

architecture Structural of ALU is

SIGNAL ARITHO : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL ARITHC : STD_LOGIC;

SIGNAL LOGICO : STD_LOGIC_VECTOR (3 downto 0);

SIGNAL SHIFTO : STD_LOGIC_VECTOR (3 downto 0);

begin
	ARITH : entity work.ArithmeticUnit4Bit Port Map(A => A, B => B, S => S(1 downto 0), C => C, VALUE => ARITHO(3 downto 0), CARRY => ARITHC);
	LOGIC : entity work.LogicUnit4Bit Port Map(A => A, B => B, S => S(1 downto 0), O => LOGICO);
	SHIFT : entity work.ShiftingUnit4Bit Port Map(A => A, S => S(0), O => SHIFTO);
	
	with S(3 downto 2) select 
		O <= ARITHO when "00",
			  LOGICO when "01",
			  SHIFTO when "10",
			  "0000" when others;
			  
	CARRY <= ARITHC AND NOT(S(3)) AND NOT(S(2));
end Structural;