library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX8x1using2x1 is
    Port ( I : in  STD_LOGIC_VECTOR (7 downto 0);
           S : in  STD_LOGIC_VECTOR (2 downto 0);
           Y : out  STD_LOGIC);
end MUX8x1using2x1;

architecture Behavioral of MUX8x1using2x1 is

SIGNAL L0Y : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL L1Y : STD_LOGIC_VECTOR (1 downto 0);

begin
	L0MUX0 : entity work.MUX2x1 Port Map(I => I(1 downto 0), S => S(0), Y => L0Y(0));
	L0MUX1 : entity work.MUX2x1 Port Map(I => I(3 downto 2), S => S(0), Y => L0Y(1));
	L0MUX2 : entity work.MUX2x1 Port Map(I => I(5 downto 4), S => S(0), Y => L0Y(2));
	L0MUX3 : entity work.MUX2x1 Port Map(I => I(7 downto 6), S => S(0), Y => L0Y(3));
	
	L1MUX0 : entity work.MUX2x1 Port Map(I => L0Y(1 downto 0), S => S(1), Y => L1Y(0));
	L1MUX1 : entity work.MUX2x1 Port Map(I => L0Y(3 downto 2), S => S(1), Y => L1Y(1));
	
	L2MUX0 : entity work.MUX2x1 Port Map(I => L1Y(1 downto 0), S => S(2), Y => Y);
end Behavioral;