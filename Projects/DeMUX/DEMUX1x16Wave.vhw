--------------------------------------------------------------------------------
-- Copyright (c) 1995-2003 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 8.1i
--  \   \         Application : ISE
--  /   /         Filename : DEMUX1x16Wave.vhw
-- /___/   /\     Timestamp : Thu Aug 13 17:18:14 2026
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: DEMUX1x16Wave
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE STD.TEXTIO.ALL;

ENTITY DEMUX1x16Wave IS
END DEMUX1x16Wave;

ARCHITECTURE testbench_arch OF DEMUX1x16Wave IS
    FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";

    COMPONENT DEMUX1x16
        PORT (
            I : In std_logic;
            S : In std_logic_vector (3 DownTo 0);
            Y : Out std_logic_vector (15 DownTo 0)
        );
    END COMPONENT;

    SIGNAL I : std_logic := '0';
    SIGNAL S : std_logic_vector (3 DownTo 0) := "0000";
    SIGNAL Y : std_logic_vector (15 DownTo 0) := "0000000000000000";

    SHARED VARIABLE TX_ERROR : INTEGER := 0;
    SHARED VARIABLE TX_OUT : LINE;

    BEGIN
        UUT : DEMUX1x16
        PORT MAP (
            I => I,
            S => S,
            Y => Y
        );

        PROCESS
            PROCEDURE CHECK_Y(
                next_Y : std_logic_vector (15 DownTo 0);
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
                -- -------------  Current Time:  20ns
                WAIT FOR 20 ns;
                I <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  30ns
                WAIT FOR 10 ns;
                CHECK_Y("0000000000000001", 30);
                -- -------------------------------------
                -- -------------  Current Time:  40ns
                WAIT FOR 10 ns;
                S <= "0001";
                -- -------------------------------------
                -- -------------  Current Time:  50ns
                WAIT FOR 10 ns;
                CHECK_Y("0000000000000010", 50);
                -- -------------------------------------
                -- -------------  Current Time:  60ns
                WAIT FOR 10 ns;
                S <= "0010";
                -- -------------------------------------
                -- -------------  Current Time:  70ns
                WAIT FOR 10 ns;
                CHECK_Y("0000000000000100", 70);
                -- -------------------------------------
                -- -------------  Current Time:  80ns
                WAIT FOR 10 ns;
                S <= "0011";
                -- -------------------------------------
                -- -------------  Current Time:  90ns
                WAIT FOR 10 ns;
                CHECK_Y("0000000000001000", 90);
                -- -------------------------------------
                -- -------------  Current Time:  100ns
                WAIT FOR 10 ns;
                S <= "0100";
                -- -------------------------------------
                -- -------------  Current Time:  110ns
                WAIT FOR 10 ns;
                CHECK_Y("0000000000010000", 110);
                -- -------------------------------------
                -- -------------  Current Time:  120ns
                WAIT FOR 10 ns;
                S <= "0101";
                -- -------------------------------------
                -- -------------  Current Time:  130ns
                WAIT FOR 10 ns;
                CHECK_Y("0000000000100000", 130);
                -- -------------------------------------
                -- -------------  Current Time:  140ns
                WAIT FOR 10 ns;
                S <= "0110";
                -- -------------------------------------
                -- -------------  Current Time:  150ns
                WAIT FOR 10 ns;
                CHECK_Y("0000000001000000", 150);
                -- -------------------------------------
                -- -------------  Current Time:  160ns
                WAIT FOR 10 ns;
                S <= "0111";
                -- -------------------------------------
                -- -------------  Current Time:  170ns
                WAIT FOR 10 ns;
                CHECK_Y("0000000010000000", 170);
                -- -------------------------------------
                -- -------------  Current Time:  180ns
                WAIT FOR 10 ns;
                S <= "1000";
                -- -------------------------------------
                -- -------------  Current Time:  190ns
                WAIT FOR 10 ns;
                CHECK_Y("0000000100000000", 190);
                -- -------------------------------------
                -- -------------  Current Time:  200ns
                WAIT FOR 10 ns;
                S <= "1001";
                -- -------------------------------------
                -- -------------  Current Time:  210ns
                WAIT FOR 10 ns;
                CHECK_Y("0000001000000000", 210);
                -- -------------------------------------
                -- -------------  Current Time:  220ns
                WAIT FOR 10 ns;
                S <= "1010";
                -- -------------------------------------
                -- -------------  Current Time:  230ns
                WAIT FOR 10 ns;
                CHECK_Y("0000010000000000", 230);
                -- -------------------------------------
                -- -------------  Current Time:  240ns
                WAIT FOR 10 ns;
                S <= "1011";
                -- -------------------------------------
                -- -------------  Current Time:  250ns
                WAIT FOR 10 ns;
                CHECK_Y("0000100000000000", 250);
                -- -------------------------------------
                -- -------------  Current Time:  260ns
                WAIT FOR 10 ns;
                S <= "1100";
                -- -------------------------------------
                -- -------------  Current Time:  270ns
                WAIT FOR 10 ns;
                CHECK_Y("0001000000000000", 270);
                -- -------------------------------------
                -- -------------  Current Time:  280ns
                WAIT FOR 10 ns;
                S <= "1101";
                -- -------------------------------------
                -- -------------  Current Time:  290ns
                WAIT FOR 10 ns;
                CHECK_Y("0010000000000000", 290);
                -- -------------------------------------
                -- -------------  Current Time:  300ns
                WAIT FOR 10 ns;
                S <= "1110";
                -- -------------------------------------
                -- -------------  Current Time:  310ns
                WAIT FOR 10 ns;
                CHECK_Y("0100000000000000", 310);
                -- -------------------------------------
                -- -------------  Current Time:  320ns
                WAIT FOR 10 ns;
                S <= "1111";
                -- -------------------------------------
                -- -------------  Current Time:  330ns
                WAIT FOR 10 ns;
                CHECK_Y("1000000000000000", 330);
                -- -------------------------------------
                -- -------------  Current Time:  340ns
                WAIT FOR 10 ns;
                I <= '0';
                S <= "0000";
                -- -------------------------------------
                -- -------------  Current Time:  350ns
                WAIT FOR 10 ns;
                CHECK_Y("0000000000000000", 350);
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

