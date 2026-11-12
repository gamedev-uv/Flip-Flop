library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LogicUnit is
    Port ( A, B : in  STD_LOGIC_VECTOR (3 downto 0);
           S : in  STD_LOGIC;
           O : out  STD_LOGIC_VECTOR (3 downto 0));
end LogicUnit;

architecture Dataflow of LogicUnit is
begin
	with S select 
		O <= A AND B when '0',
			  A OR B when '1',
		     "0000" when others;
end Dataflow;