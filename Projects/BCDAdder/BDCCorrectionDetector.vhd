library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BDCCorrectionDetector is
    Port ( A, B : in  STD_LOGIC_VECTOR (3 downto 0);
           O : out  STD_LOGIC);
end BDCCorrectionDetector;

architecture Structural of BDCCorrectionDetector is

SIGNAL SUM : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL CAR : STD_LOGIC;

begin
	RCA : entity work.RippleCarryAdder Port Map(A => A, B => B, SUM => SUM, CARRY => CAR);
	O <= (SUM(3) AND SUM(2)) OR 
        (SUM(3) AND SUM(1)) OR 
		  CAR;
end Structural;