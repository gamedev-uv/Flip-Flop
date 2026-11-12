library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ArithmeticUnit is
    Port ( A, B : in  STD_LOGIC_VECTOR (3 downto 0);
           S : in  STD_LOGIC;
           O : out  STD_LOGIC_VECTOR (3 downto 0));
end ArithmeticUnit;

architecture Dataflow of ArithmeticUnit is
begin
	with S select 
		O <= A + B when '0',
			  A - B when '1',
		     "0000" when others;
end Dataflow;