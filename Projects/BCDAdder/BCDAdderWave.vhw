--------------------------------------------------------------------------------
-- Copyright (c) 1995-2003 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 8.1i
--  \   \         Application : ISE
--  /   /         Filename : BCDAdderWave.vhw
-- /___/   /\     Timestamp : Thu Aug 27 14:41:33 2026
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: BCDAdderWave
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE STD.TEXTIO.ALL;

ENTITY BCDAdderWave IS
END BCDAdderWave;

ARCHITECTURE testbench_arch OF BCDAdderWave IS
    FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";

    COMPONENT BCDAdder
        PORT (
            A : In std_logic_vector (3 DownTo 0);
            B : In std_logic_vector (3 DownTo 0);
            SUM : Out std_logic_vector (3 DownTo 0);
            CARRY : Out std_logic
        );
    END COMPONENT;

    SIGNAL A : std_logic_vector (3 DownTo 0) := "0000";
    SIGNAL B : std_logic_vector (3 DownTo 0) := "0000";
    SIGNAL SUM : std_logic_vector (3 DownTo 0) := "0000";
    SIGNAL CARRY : std_logic := '0';

    SHARED VARIABLE TX_ERROR : INTEGER := 0;
    SHARED VARIABLE TX_OUT : LINE;

    BEGIN
        UUT : BCDAdder
        PORT MAP (
            A => A,
            B => B,
            SUM => SUM,
            CARRY => CARRY
        );

        PROCESS
            PROCEDURE CHECK_CARRY(
                next_CARRY : std_logic;
                TX_TIME : INTEGER
            ) IS
                VARIABLE TX_STR : String(1 to 4096);
                VARIABLE TX_LOC : LINE;
                BEGIN
                IF (CARRY /= next_CARRY) THEN
                    STD.TEXTIO.write(TX_LOC, string'("Error at time="));
                    STD.TEXTIO.write(TX_LOC, TX_TIME);
                    STD.TEXTIO.write(TX_LOC, string'("ns CARRY="));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, CARRY);
                    STD.TEXTIO.write(TX_LOC, string'(", Expected = "));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, next_CARRY);
                    STD.TEXTIO.write(TX_LOC, string'(" "));
                    TX_STR(TX_LOC.all'range) := TX_LOC.all;
                    STD.TEXTIO.writeline(RESULTS, TX_LOC);
                    STD.TEXTIO.Deallocate(TX_LOC);
                    ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
                    TX_ERROR := TX_ERROR + 1;
                END IF;
            END;
            PROCEDURE CHECK_SUM(
                next_SUM : std_logic_vector (3 DownTo 0);
                TX_TIME : INTEGER
            ) IS
                VARIABLE TX_STR : String(1 to 4096);
                VARIABLE TX_LOC : LINE;
                BEGIN
                IF (SUM /= next_SUM) THEN
                    STD.TEXTIO.write(TX_LOC, string'("Error at time="));
                    STD.TEXTIO.write(TX_LOC, TX_TIME);
                    STD.TEXTIO.write(TX_LOC, string'("ns SUM="));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, SUM);
                    STD.TEXTIO.write(TX_LOC, string'(", Expected = "));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, next_SUM);
                    STD.TEXTIO.write(TX_LOC, string'(" "));
                    TX_STR(TX_LOC.all'range) := TX_LOC.all;
                    STD.TEXTIO.writeline(RESULTS, TX_LOC);
                    STD.TEXTIO.Deallocate(TX_LOC);
                    ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
                    TX_ERROR := TX_ERROR + 1;
                END IF;
            END;
            BEGIN
                -- -------------  Current Time:  100ns
                WAIT FOR 100 ns;
                A <= "0100";
                B <= "0011";
                -- -------------------------------------
                -- -------------  Current Time:  150ns
                WAIT FOR 50 ns;
                CHECK_SUM("0111", 150);
                -- -------------------------------------
                -- -------------  Current Time:  200ns
                WAIT FOR 50 ns;
                A <= "0101";
                B <= "0101";
                -- -------------------------------------
                -- -------------  Current Time:  250ns
                WAIT FOR 50 ns;
                CHECK_CARRY('1', 250);
                CHECK_SUM("0000", 250);
                -- -------------------------------------
                -- -------------  Current Time:  300ns
                WAIT FOR 50 ns;
                A <= "1001";
                B <= "1001";
                -- -------------------------------------
                -- -------------  Current Time:  350ns
                WAIT FOR 50 ns;
                CHECK_SUM("1000", 350);
                -- -------------------------------------
                -- -------------  Current Time:  400ns
                WAIT FOR 50 ns;
                A <= "0000";
                B <= "0000";
                -- -------------------------------------
                -- -------------  Current Time:  450ns
                WAIT FOR 50 ns;
                CHECK_CARRY('0', 450);
                CHECK_SUM("0000", 450);
                WAIT FOR 550 ns;

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

