library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Comparator2Bit is
    Port ( A : in  STD_LOGIC_VECTOR (1 downto 0);
           B : in  STD_LOGIC_VECTOR (1 downto 0);
           BGREATER : out  STD_LOGIC;
           EQUAL : out  STD_LOGIC;
           AGREATER : out  STD_LOGIC);
end Comparator2Bit;

architecture Behavioral of Comparator2Bit is
SIGNAL O : STD_LOGIC_VECTOR (2 downto 0);
begin
	O(0) <= (NOT(A(1)) AND     B(1))           OR 
			  (NOT(A(1)) AND NOT(A(0)) AND B(0)) OR
			  (NOT(A(0)) AND     B(1)  AND B(0));
					
	O(2) <= (A(1) AND NOT(B(1))) OR
			  (A(1) AND A(0) AND NOT(B(0))) OR
			  (A(0) AND NOT(B(1)) AND NOT(B(0)));
					
	O(1)    <=  NOT(O(0)) AND NOT(O(2));
	
	BGREATER <= O(0);
	EQUAL    <= O(1);
	AGREATER <= O(2);
end Behavioral;