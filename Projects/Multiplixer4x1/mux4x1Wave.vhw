--------------------------------------------------------------------------------
-- Copyright (c) 1995-2003 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 8.1i
--  \   \         Application : ISE
--  /   /         Filename : mux4x1Wave.vhw
-- /___/   /\     Timestamp : Sun Aug 02 14:46:19 2026
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: mux4x1Wave
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE STD.TEXTIO.ALL;

ENTITY mux4x1Wave IS
END mux4x1Wave;

ARCHITECTURE testbench_arch OF mux4x1Wave IS
    FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";

    COMPONENT mux4x1
        PORT (
            I : In std_logic_vector (3 DownTo 0);
            S : In std_logic_vector (1 DownTo 0);
            Y : Out std_logic
        );
    END COMPONENT;

    SIGNAL I : std_logic_vector (3 DownTo 0) := "1010";
    SIGNAL S : std_logic_vector (1 DownTo 0) := "00";
    SIGNAL Y : std_logic := '0';

    SHARED VARIABLE TX_ERROR : INTEGER := 0;
    SHARED VARIABLE TX_OUT : LINE;

    BEGIN
        UUT : mux4x1
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
                S <= "01";
                -- -------------------------------------
                -- -------------  Current Time:  50ns
                WAIT FOR 10 ns;
                CHECK_Y('1', 50);
                -- -------------------------------------
                -- -------------  Current Time:  60ns
                WAIT FOR 10 ns;
                S <= "10";
                -- -------------------------------------
                -- -------------  Current Time:  70ns
                WAIT FOR 10 ns;
                CHECK_Y('0', 70);
                -- -------------------------------------
                -- -------------  Current Time:  80ns
                WAIT FOR 10 ns;
                S <= "11";
                -- -------------------------------------
                -- -------------  Current Time:  90ns
                WAIT FOR 10 ns;
                CHECK_Y('1', 90);
                -- -------------------------------------
                -- -------------  Current Time:  100ns
                WAIT FOR 10 ns;
                S <= "00";
                -- -------------------------------------
                -- -------------  Current Time:  110ns
                WAIT FOR 10 ns;
                CHECK_Y('0', 110);
                WAIT FOR 390 ns;

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

