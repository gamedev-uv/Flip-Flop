--------------------------------------------------------------------------------
-- Copyright (c) 1995-2003 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 8.1i
--  \   \         Application : ISE
--  /   /         Filename : ArithmeticWave.vhw
-- /___/   /\     Timestamp : Thu Nov 12 06:58:58 2026
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: ArithmeticWave
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY ArithmeticWave IS
END ArithmeticWave;

ARCHITECTURE testbench_arch OF ArithmeticWave IS
    FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";

    COMPONENT ArithmeticUnit4Bit
        PORT (
            A : In std_logic_vector (3 DownTo 0);
            B : In std_logic_vector (3 DownTo 0);
            S : In std_logic_vector (1 DownTo 0);
            C : In std_logic;
            VALUE : Out std_logic_vector (3 DownTo 0);
            CARRY : Out std_logic
        );
    END COMPONENT;

    SIGNAL A : std_logic_vector (3 DownTo 0) := "0000";
    SIGNAL B : std_logic_vector (3 DownTo 0) := "0000";
    SIGNAL S : std_logic_vector (1 DownTo 0) := "00";
    SIGNAL C : std_logic := '0';
    SIGNAL VALUE : std_logic_vector (3 DownTo 0) := "0000";
    SIGNAL CARRY : std_logic := '0';

    SHARED VARIABLE TX_ERROR : INTEGER := 0;
    SHARED VARIABLE TX_OUT : LINE;

    BEGIN
        UUT : ArithmeticUnit4Bit
        PORT MAP (
            A => A,
            B => B,
            S => S,
            C => C,
            VALUE => VALUE,
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
            PROCEDURE CHECK_VALUE(
                next_VALUE : std_logic_vector (3 DownTo 0);
                TX_TIME : INTEGER
            ) IS
                VARIABLE TX_STR : String(1 to 4096);
                VARIABLE TX_LOC : LINE;
                BEGIN
                IF (VALUE /= next_VALUE) THEN
                    STD.TEXTIO.write(TX_LOC, string'("Error at time="));
                    STD.TEXTIO.write(TX_LOC, TX_TIME);
                    STD.TEXTIO.write(TX_LOC, string'("ns VALUE="));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, VALUE);
                    STD.TEXTIO.write(TX_LOC, string'(", Expected = "));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, next_VALUE);
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
                B <= "0010";
                -- -------------------------------------
                -- -------------  Current Time:  150ns
                WAIT FOR 50 ns;
                CHECK_VALUE("0110", 150);
                -- -------------------------------------
                -- -------------  Current Time:  200ns
                WAIT FOR 50 ns;
                C <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  250ns
                WAIT FOR 50 ns;
                CHECK_VALUE("0111", 250);
                -- -------------------------------------
                -- -------------  Current Time:  300ns
                WAIT FOR 50 ns;
                C <= '0';
                S <= "01";
                -- -------------------------------------
                -- -------------  Current Time:  350ns
                WAIT FOR 50 ns;
                CHECK_CARRY('1', 350);
                CHECK_VALUE("0001", 350);
                -- -------------------------------------
                -- -------------  Current Time:  400ns
                WAIT FOR 50 ns;
                C <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  450ns
                WAIT FOR 50 ns;
                CHECK_VALUE("0010", 450);
                -- -------------------------------------
                -- -------------  Current Time:  500ns
                WAIT FOR 50 ns;
                C <= '0';
                S <= "10";
                -- -------------------------------------
                -- -------------  Current Time:  550ns
                WAIT FOR 50 ns;
                CHECK_VALUE("0011", 550);
                -- -------------------------------------
                -- -------------  Current Time:  600ns
                WAIT FOR 50 ns;
                C <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  650ns
                WAIT FOR 50 ns;
                CHECK_VALUE("0100", 650);
                -- -------------------------------------
                -- -------------  Current Time:  700ns
                WAIT FOR 50 ns;
                C <= '0';
                S <= "11";
                -- -------------------------------------
                -- -------------  Current Time:  750ns
                WAIT FOR 50 ns;
                CHECK_CARRY('0', 750);
                -- -------------------------------------
                -- -------------  Current Time:  800ns
                WAIT FOR 50 ns;
                C <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  850ns
                WAIT FOR 50 ns;
                CHECK_VALUE("0101", 850);
                -- -------------------------------------
                -- -------------  Current Time:  900ns
                WAIT FOR 50 ns;
                C <= '0';
                S <= "00";
                -- -------------------------------------
                -- -------------  Current Time:  950ns
                WAIT FOR 50 ns;
                CHECK_VALUE("0110", 950);
                WAIT FOR 50 ns;

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

