library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DEMUX1x16 is
    Port ( I : in  STD_LOGIC;
           S : in  STD_LOGIC_VECTOR (3 downto 0);
           Y : out  STD_LOGIC_VECTOR (15 downto 0));
end DEMUX1x16;

architecture Structural of DEMUX1x16 is
SIGNAL I_N : STD_LOGIC_VECTOR (3 downto 0);
begin
	I_N(0) <= I AND NOT(S(3)) AND NOT(S(2));
	I_N(1) <= I AND NOT(S(3)) AND    (S(2));
	I_N(2) <= I AND    (S(3)) AND NOT(S(2));
	I_N(3) <= I AND    (S(3)) AND    (S(2));
	
	DMUX0 : entity work.DEMUX1x4 Port Map(I => I_N(0), S => S(1 downto 0), Y => Y( 3 downto 0));
	DMUX1 : entity work.DEMUX1x4 Port Map(I => I_N(1), S => S(1 downto 0), Y => Y( 7 downto 4));
	DMUX2 : entity work.DEMUX1x4 Port Map(I => I_N(2), S => S(1 downto 0), Y => Y(11 downto 8));
	DMUX3 : entity work.DEMUX1x4 Port Map(I => I_N(3), S => S(1 downto 0), Y => Y(15 downto 12));
end Structural;