library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftRegisterUsingDFF is
    Port ( S_in, Reset, Clk : in  STD_LOGIC;
           O : out  STD_LOGIC_VECTOR (3 downto 0));
end ShiftRegisterUsingDFF;

architecture Structural of ShiftRegisterUsingDFF is
SIGNAL t : STD_LOGIC_VECTOR(3 downto 0) := "0000";
begin
	DFF0 : entity work.DFlipFlop Port Map(D => S_in, Clk => Clk, Reset => Reset, Q => t(3));
	DFF1 : entity work.DFlipFlop Port Map(D => t(3), Clk => Clk, Reset => Reset, Q => t(2));
	DFF2 : entity work.DFlipFlop Port Map(D => t(2), Clk => Clk, Reset => Reset, Q => t(1));
	DFF3 : entity work.DFlipFlop Port Map(D => t(1), Clk => Clk, Reset => Reset, Q => t(0));
	O <= t;
end Structural;