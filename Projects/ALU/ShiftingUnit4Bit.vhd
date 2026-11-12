library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftingUnit4Bit is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           S : in  STD_LOGIC; 
			  O : out STD_LOGIC_VECTOR(3 downto 0));
end ShiftingUnit4Bit;

architecture Dataflow of ShiftingUnit4Bit is
begin
	with S select
			O <= ('0' & A(3) & A(2) & A(1)) when '0',
				  (A(2) & A(1) & A(0) & '0') when '1',
				  "0000" when others;
end Dataflow;