library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX16x1using2x1 is
    Port ( I : in  STD_LOGIC_VECTOR (15 downto 0);
           S : in  STD_LOGIC_VECTOR (3 downto 0);
           Y : out  STD_LOGIC);
end MUX16x1using2x1;

architecture Structural of MUX16x1using2x1 is
SIGNAL L0Y : STD_LOGIC_VECTOR (7 downto 0);
SIGNAL L1Y : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL L2Y : STD_LOGIC_VECTOR (1 downto 0);
begin
	L0MUX0 : entity work.MUX2x1 Port Map(I => I( 1 downto 0),  S => S(0), Y => L0Y(0));
	L0MUX1 : entity work.MUX2x1 Port Map(I => I( 3 downto 2),  S => S(0), Y => L0Y(1));
	L0MUX2 : entity work.MUX2x1 Port Map(I => I( 5 downto 4),  S => S(0), Y => L0Y(2));
	L0MUX3 : entity work.MUX2x1 Port Map(I => I( 7 downto 6),  S => S(0), Y => L0Y(3));
	L0MUX4 : entity work.MUX2x1 Port Map(I => I( 9 downto 8),  S => S(0), Y => L0Y(4));
	L0MUX5 : entity work.MUX2x1 Port Map(I => I(11 downto 10), S => S(0), Y => L0Y(5));
	L0MUX6 : entity work.MUX2x1 Port Map(I => I(13 downto 12), S => S(0), Y => L0Y(6));
	L0MUX7 : entity work.MUX2x1 Port Map(I => I(15 downto 14), S => S(0), Y => L0Y(7));
	
	L1MUX0 : entity work.MUX2x1 Port Map(I => L0Y(1 downto 0), S => S(1), Y => L1Y(0));
	L1MUX1 : entity work.MUX2x1 Port Map(I => L0Y(3 downto 2), S => S(1), Y => L1Y(1));
	L1MUX2 : entity work.MUX2x1 Port Map(I => L0Y(5 downto 4), S => S(1), Y => L1Y(2));
	L1MUX3 : entity work.MUX2x1 Port Map(I => L0Y(7 downto 6), S => S(1), Y => L1Y(3));
	
	L2MUX0 : entity work.MUX2x1 Port Map(I => L1Y(1 downto 0), S => S(2), Y => L2Y(0));
	L2MUX1 : entity work.MUX2x1 Port Map(I => L1Y(3 downto 2), S => S(2), Y => L2Y(1));
	
	L3MUX1 : entity work.MUX2x1 Port Map(I => L2Y(1 downto 0), S => S(3), Y => Y);
end Structural;