library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX8x1using4x1 is
    Port ( I : in  STD_LOGIC_VECTOR (7 downto 0);
           S : in  STD_LOGIC_VECTOR (2 downto 0);
           Y : out  STD_LOGIC);
end MUX8x1using4x1;

architecture Structural of MUX8x1using4x1 is
SIGNAL L0Y : STD_LOGIC_VECTOR (1 downto 0);

begin
	L0M0 : entity work.MUX4x1 Port Map(I => I(3 downto 0), S => S(1 downto 0), Y => L0Y(0));
	L0M1 : entity work.MUX4x1 Port Map(I => I(7 downto 4), S => S(1 downto 0), Y => L0Y(1));
	L1M1 : entity work.MUX4x1 Port Map(I(0) => L0Y(0), I(1) =>  L0Y(1), I(2) => '0', I(3) => '0',
												  S(0) => S(2), S(1) => '0', Y => Y);
end Structural;