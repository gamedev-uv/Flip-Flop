library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DEMUX1x8 is
    Port ( I : in  STD_LOGIC;
           S : in  STD_LOGIC_VECTOR (2 downto 0);
           Y : out  STD_LOGIC_VECTOR (7 downto 0));
end DEMUX1x8;

architecture Structural of DEMUX1x8 is
SIGNAL I_0, I_1 : STD_LOGIC;
begin
	I_0 <= I AND NOT(S(2)); 
	I_1 <= I AND S(2); 
	
	DMUX0 : entity work.DEMUX1x4 Port Map(I => I_0, S => S(1 downto 0), Y => Y(3 downto 0));
	DMUX1 : entity work.DEMUX1x4 Port Map(I => I_1, S => S(1 downto 0), Y => Y(7 downto 4));
end Structural;