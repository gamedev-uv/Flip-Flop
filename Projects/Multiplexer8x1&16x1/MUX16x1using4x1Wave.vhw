--------------------------------------------------------------------------------
-- Copyright (c) 1995-2003 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 8.1i
--  \   \         Application : ISE
--  /   /         Filename : MUX16x1using4x1Wave.vhw
-- /___/   /\     Timestamp : Mon Aug 03 10:43:17 2026
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: MUX16x1using4x1Wave
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE STD.TEXTIO.ALL;

ENTITY MUX16x1using4x1Wave IS
END MUX16x1using4x1Wave;

ARCHITECTURE testbench_arch OF MUX16x1using4x1Wave IS
    FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";

    COMPONENT MUX16x1using4x1
        PORT (
            I : In std_logic_vector (15 DownTo 0);
            S : In std_logic_vector (3 DownTo 0);
            Y : Out std_logic
        );
    END COMPONENT;

    SIGNAL I : std_logic_vector (15 DownTo 0) := "1010101010101010";
    SIGNAL S : std_logic_vector (3 DownTo 0) := "0000";
    SIGNAL Y : std_logic := '0';

    SHARED VARIABLE TX_ERROR : INTEGER := 0;
    SHARED VARIABLE TX_OUT : LINE;

    BEGIN
        UUT : MUX16x1using4x1
        PORT MAP (
            I => I,
            S => S,
            Y => Y
        );

        PROCESS
            PROCEDURE CHECK_Y(
                next_Y : std_logic;
                TX_TIME : INTEGER
            ) IS
                VARIABLE TX_STR : String(1 to 4096);
                VARIABLE TX_LOC : LINE;
                BEGIN
                IF (Y /= next_Y) THEN
                    STD.TEXTIO.write(TX_LOC, string'("Error at time="));
                    STD.TEXTIO.write(TX_LOC, TX_TIME);
                    STD.TEXTIO.write(TX_LOC, string'("ns Y="));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, Y);
                    STD.TEXTIO.write(TX_LOC, string'(", Expected = "));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, next_Y);
                    STD.TEXTIO.write(TX_LOC, string'(" "));
                    TX_STR(TX_LOC.all'range) := TX_LOC.all;
                    STD.TEXTIO.writeline(RESULTS, TX_LOC);
                    STD.TEXTIO.Deallocate(TX_LOC);
                    ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
                    TX_ERROR := TX_ERROR + 1;
                END IF;
            END;
            BEGIN
                -- -------------  Current Time:  40ns
                WAIT FOR 40 ns;
                S <= "0001";
                -- -------------------------------------
                -- -------------  Current Time:  50ns
                WAIT FOR 10 ns;
                CHECK_Y('1', 50);
                -- -------------------------------------
                -- -------------  Current Time:  60ns
                WAIT FOR 10 ns;
                S <= "0010";
                -- -------------------------------------
                -- -------------  Current Time:  70ns
                WAIT FOR 10 ns;
                CHECK_Y('0', 70);
                -- -------------------------------------
                -- -------------  Current Time:  80ns
                WAIT FOR 10 ns;
                S <= "0011";
                -- -------------------------------------
                -- -------------  Current Time:  90ns
                WAIT FOR 10 ns;
                CHECK_Y('1', 90);
                -- -------------------------------------
                -- -------------  Current Time:  100ns
                WAIT FOR 10 ns;
                S <= "0100";
                -- -------------------------------------
                -- -------------  Current Time:  110ns
                WAIT FOR 10 ns;
                CHECK_Y('0', 110);
                -- -------------------------------------
                -- -------------  Current Time:  120ns
                WAIT FOR 10 ns;
                S <= "0101";
                -- -------------------------------------
                -- -------------  Current Time:  130ns
                WAIT FOR 10 ns;
                CHECK_Y('1', 130);
                -- -------------------------------------
                -- -------------  Current Time:  140ns
                WAIT FOR 10 ns;
                S <= "0110";
                -- -------------------------------------
                -- -------------  Current Time:  150ns
                WAIT FOR 10 ns;
                CHECK_Y('0', 150);
                -- -------------------------------------
                -- -------------  Current Time:  160ns
                WAIT FOR 10 ns;
                S <= "0111";
                -- -------------------------------------
                -- -------------  Current Time:  170ns
                WAIT FOR 10 ns;
                CHECK_Y('1', 170);
                -- -------------------------------------
                -- -------------  Current Time:  180ns
                WAIT FOR 10 ns;
                S <= "1000";
                -- -------------------------------------
                -- -------------  Current Time:  190ns
                WAIT FOR 10 ns;
                CHECK_Y('0', 190);
                -- -------------------------------------
                -- -------------  Current Time:  200ns
                WAIT FOR 10 ns;
                S <= "1001";
                -- -------------------------------------
                -- -------------  Current Time:  210ns
                WAIT FOR 10 ns;
                CHECK_Y('1', 210);
                -- -------------------------------------
                -- -------------  Current Time:  220ns
                WAIT FOR 10 ns;
                S <= "1010";
                -- -------------------------------------
                -- -------------  Current Time:  230ns
                WAIT FOR 10 ns;
                CHECK_Y('0', 230);
                -- -------------------------------------
                -- -------------  Current Time:  240ns
                WAIT FOR 10 ns;
                S <= "1011";
                -- -------------------------------------
                -- -------------  Current Time:  250ns
                WAIT FOR 10 ns;
                CHECK_Y('1', 250);
                -- -------------------------------------
                -- -------------  Current Time:  260ns
                WAIT FOR 10 ns;
                S <= "1100";
                -- -------------------------------------
                -- -------------  Current Time:  270ns
                WAIT FOR 10 ns;
                CHECK_Y('0', 270);
                -- -------------------------------------
                -- -------------  Current Time:  280ns
                WAIT FOR 10 ns;
                S <= "1101";
                -- -------------------------------------
                -- -------------  Current Time:  290ns
                WAIT FOR 10 ns;
                CHECK_Y('1', 290);
                -- -------------------------------------
                -- -------------  Current Time:  300ns
                WAIT FOR 10 ns;
                S <= "1110";
                -- -------------------------------------
                -- -------------  Current Time:  310ns
                WAIT FOR 10 ns;
                CHECK_Y('0', 310);
                -- -------------------------------------
                -- -------------  Current Time:  320ns
                WAIT FOR 10 ns;
                S <= "1111";
                -- -------------------------------------
                -- -------------  Current Time:  330ns
                WAIT FOR 10 ns;
                CHECK_Y('1', 330);
                -- -------------------------------------
                -- -------------  Current Time:  340ns
                WAIT FOR 10 ns;
                S <= "0000";
                -- -------------------------------------
                -- -------------  Current Time:  350ns
                WAIT FOR 10 ns;
                CHECK_Y('0', 350);
                WAIT FOR 650 ns;

                IF (TX_ERROR = 0) THEN
                    STD.TEXTIO.write(TX_OUT, string'("No errors or warnings"));
                    STD.TEXTIO.writeline(RESULTS, TX_OUT);
                    ASSERT (FALSE) REPORT
                      "Simulation successful (not a failure).  No problems detected."
                      SEVERITY FAILURE;
                ELSE
                    STD.TEXTIO.write(TX_OUT, TX_ERROR);
                    STD.TEXTIO.write(TX_OUT,
                        string'(" errors found in simulation"));
                    STD.TEXTIO.writeline(RESULTS, TX_OUT);
                    ASSERT (FALSE) REPORT "Errors found during simulation"
                         SEVERITY FAILURE;
                END IF;
            END PROCESS;

    END testbench_arch;

