library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BCDAdder is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           SUM : out  STD_LOGIC_VECTOR (3 downto 0);
           CARRY : out  STD_LOGIC);
end BCDAdder;

architecture Structural of BCDAdder is
SIGNAL TSUM   : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL TCARRY : STD_LOGIC;
SIGNAL EXTRA  : STD_LOGIC_VECTOR (3 downto 0);
begin
	RCA0 : entity work.RippleCarryAdder Port Map(A => A(3 downto 0), B => B(3 downto 0), SUM => TSUM, CARRY => TCARRY);
	
	EXTRA(3) <= '0';
	EXTRA(2) <= (TSUM(3) AND TSUM(2)) OR 
					(TSUM(3) AND TSUM(1)) OR
					 TCARRY;
	EXTRA(1) <= EXTRA(2);
	EXTRA(0) <= '0';
		
	RCA1 : entity work.RippleCarryAdder Port Map(A => TSUM(3 downto 0), B => EXTRA(3 downto 0), SUM => SUM);
	CARRY  <= EXTRA(1);
end Structural;