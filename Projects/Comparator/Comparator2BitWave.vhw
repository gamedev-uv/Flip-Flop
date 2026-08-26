--------------------------------------------------------------------------------
-- Copyright (c) 1995-2003 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 8.1i
--  \   \         Application : ISE
--  /   /         Filename : Comparator2BitWave.vhw
-- /___/   /\     Timestamp : Thu Aug 20 17:25:48 2026
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: Comparator2BitWave
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE STD.TEXTIO.ALL;

ENTITY Comparator2BitWave IS
END Comparator2BitWave;

ARCHITECTURE testbench_arch OF Comparator2BitWave IS
    FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";

    COMPONENT Comparator2Bit
        PORT (
            A : In std_logic_vector (1 DownTo 0);
            B : In std_logic_vector (1 DownTo 0);
            BGREATER : Out std_logic;
            EQUAL : Out std_logic;
            AGREATER : Out std_logic
        );
    END COMPONENT;

    SIGNAL A : std_logic_vector (1 DownTo 0) := "00";
    SIGNAL B : std_logic_vector (1 DownTo 0) := "00";
    SIGNAL BGREATER : std_logic := '0';
    SIGNAL EQUAL : std_logic := '1';
    SIGNAL AGREATER : std_logic := '0';

    SHARED VARIABLE TX_ERROR : INTEGER := 0;
    SHARED VARIABLE TX_OUT : LINE;

    BEGIN
        UUT : Comparator2Bit
        PORT MAP (
            A => A,
            B => B,
            BGREATER => BGREATER,
            EQUAL => EQUAL,
            AGREATER => AGREATER
        );

        PROCESS
            PROCEDURE CHECK_AGREATER(
                next_AGREATER : std_logic;
                TX_TIME : INTEGER
            ) IS
                VARIABLE TX_STR : String(1 to 4096);
                VARIABLE TX_LOC : LINE;
                BEGIN
                IF (AGREATER /= next_AGREATER) THEN
                    STD.TEXTIO.write(TX_LOC, string'("Error at time="));
                    STD.TEXTIO.write(TX_LOC, TX_TIME);
                    STD.TEXTIO.write(TX_LOC, string'("ns AGREATER="));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, AGREATER);
                    STD.TEXTIO.write(TX_LOC, string'(", Expected = "));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, next_AGREATER);
                    STD.TEXTIO.write(TX_LOC, string'(" "));
                    TX_STR(TX_LOC.all'range) := TX_LOC.all;
                    STD.TEXTIO.writeline(RESULTS, TX_LOC);
                    STD.TEXTIO.Deallocate(TX_LOC);
                    ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
                    TX_ERROR := TX_ERROR + 1;
                END IF;
            END;
            PROCEDURE CHECK_BGREATER(
                next_BGREATER : std_logic;
                TX_TIME : INTEGER
            ) IS
                VARIABLE TX_STR : String(1 to 4096);
                VARIABLE TX_LOC : LINE;
                BEGIN
                IF (BGREATER /= next_BGREATER) THEN
                    STD.TEXTIO.write(TX_LOC, string'("Error at time="));
                    STD.TEXTIO.write(TX_LOC, TX_TIME);
                    STD.TEXTIO.write(TX_LOC, string'("ns BGREATER="));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, BGREATER);
                    STD.TEXTIO.write(TX_LOC, string'(", Expected = "));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, next_BGREATER);
                    STD.TEXTIO.write(TX_LOC, string'(" "));
                    TX_STR(TX_LOC.all'range) := TX_LOC.all;
                    STD.TEXTIO.writeline(RESULTS, TX_LOC);
                    STD.TEXTIO.Deallocate(TX_LOC);
                    ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
                    TX_ERROR := TX_ERROR + 1;
                END IF;
            END;
            PROCEDURE CHECK_EQUAL(
                next_EQUAL : std_logic;
                TX_TIME : INTEGER
            ) IS
                VARIABLE TX_STR : String(1 to 4096);
                VARIABLE TX_LOC : LINE;
                BEGIN
                IF (EQUAL /= next_EQUAL) THEN
                    STD.TEXTIO.write(TX_LOC, string'("Error at time="));
                    STD.TEXTIO.write(TX_LOC, TX_TIME);
                    STD.TEXTIO.write(TX_LOC, string'("ns EQUAL="));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, EQUAL);
                    STD.TEXTIO.write(TX_LOC, string'(", Expected = "));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, next_EQUAL);
                    STD.TEXTIO.write(TX_LOC, string'(" "));
                    TX_STR(TX_LOC.all'range) := TX_LOC.all;
                    STD.TEXTIO.writeline(RESULTS, TX_LOC);
                    STD.TEXTIO.Deallocate(TX_LOC);
                    ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
                    TX_ERROR := TX_ERROR + 1;
                END IF;
            END;
            BEGIN
                -- -------------  Current Time:  80ns
                WAIT FOR 80 ns;
                B <= "01";
                -- -------------------------------------
                -- -------------  Current Time:  100ns
                WAIT FOR 20 ns;
                CHECK_BGREATER('1', 100);
                CHECK_EQUAL('0', 100);
                -- -------------------------------------
                -- -------------  Current Time:  120ns
                WAIT FOR 20 ns;
                B <= "10";
                -- -------------------------------------
                -- -------------  Current Time:  160ns
                WAIT FOR 40 ns;
                B <= "11";
                -- -------------------------------------
                -- -------------  Current Time:  200ns
                WAIT FOR 40 ns;
                A <= "01";
                B <= "00";
                -- -------------------------------------
                -- -------------  Current Time:  220ns
                WAIT FOR 20 ns;
                CHECK_BGREATER('0', 220);
                CHECK_AGREATER('1', 220);
                -- -------------------------------------
                -- -------------  Current Time:  240ns
                WAIT FOR 20 ns;
                B <= "01";
                -- -------------------------------------
                -- -------------  Current Time:  260ns
                WAIT FOR 20 ns;
                CHECK_EQUAL('1', 260);
                CHECK_AGREATER('0', 260);
                -- -------------------------------------
                -- -------------  Current Time:  280ns
                WAIT FOR 20 ns;
                B <= "10";
                -- -------------------------------------
                -- -------------  Current Time:  300ns
                WAIT FOR 20 ns;
                CHECK_BGREATER('1', 300);
                CHECK_EQUAL('0', 300);
                -- -------------------------------------
                -- -------------  Current Time:  320ns
                WAIT FOR 20 ns;
                B <= "11";
                -- -------------------------------------
                -- -------------  Current Time:  360ns
                WAIT FOR 40 ns;
                A <= "10";
                B <= "00";
                -- -------------------------------------
                -- -------------  Current Time:  380ns
                WAIT FOR 20 ns;
                CHECK_BGREATER('0', 380);
                CHECK_AGREATER('1', 380);
                -- -------------------------------------
                -- -------------  Current Time:  400ns
                WAIT FOR 20 ns;
                B <= "01";
                -- -------------------------------------
                -- -------------  Current Time:  440ns
                WAIT FOR 40 ns;
                B <= "10";
                -- -------------------------------------
                -- -------------  Current Time:  460ns
                WAIT FOR 20 ns;
                CHECK_EQUAL('1', 460);
                CHECK_AGREATER('0', 460);
                -- -------------------------------------
                -- -------------  Current Time:  480ns
                WAIT FOR 20 ns;
                B <= "11";
                -- -------------------------------------
                -- -------------  Current Time:  500ns
                WAIT FOR 20 ns;
                CHECK_BGREATER('1', 500);
                CHECK_EQUAL('0', 500);
                -- -------------------------------------
                -- -------------  Current Time:  520ns
                WAIT FOR 20 ns;
                A <= "11";
                B <= "00";
                -- -------------------------------------
                -- -------------  Current Time:  540ns
                WAIT FOR 20 ns;
                CHECK_BGREATER('0', 540);
                CHECK_AGREATER('1', 540);
                -- -------------------------------------
                -- -------------  Current Time:  560ns
                WAIT FOR 20 ns;
                B <= "01";
                -- -------------------------------------
                -- -------------  Current Time:  600ns
                WAIT FOR 40 ns;
                B <= "10";
                -- -------------------------------------
                -- -------------  Current Time:  640ns
                WAIT FOR 40 ns;
                B <= "11";
                -- -------------------------------------
                -- -------------  Current Time:  660ns
                WAIT FOR 20 ns;
                CHECK_EQUAL('1', 660);
                CHECK_AGREATER('0', 660);
                -- -------------------------------------
                -- -------------  Current Time:  680ns
                WAIT FOR 20 ns;
                A <= "00";
                B <= "00";
                WAIT FOR 320 ns;

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

