--------------------------------------------------------------------------------
-- Copyright (c) 1995-2003 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 8.1i
--  \   \         Application : ISE
--  /   /         Filename : ALUBench.vhw
-- /___/   /\     Timestamp : Thu Nov 12 09:55:49 2026
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: ALUBench
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE STD.TEXTIO.ALL;

ENTITY ALUBench IS
END ALUBench;

ARCHITECTURE testbench_arch OF ALUBench IS
    FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";

    COMPONENT ALU
        PORT (
            A : In std_logic_vector (3 DownTo 0);
            B : In std_logic_vector (3 DownTo 0);
            S : In std_logic_vector (3 DownTo 0);
            C : In std_logic;
            O : Out std_logic_vector (3 DownTo 0);
            CARRY : Out std_logic
        );
    END COMPONENT;

    SIGNAL A : std_logic_vector (3 DownTo 0) := "0101";
    SIGNAL B : std_logic_vector (3 DownTo 0) := "0000";
    SIGNAL S : std_logic_vector (3 DownTo 0) := "0000";
    SIGNAL C : std_logic := '0';
    SIGNAL O : std_logic_vector (3 DownTo 0) := "0101";
    SIGNAL CARRY : std_logic := '0';

    SHARED VARIABLE TX_ERROR : INTEGER := 0;
    SHARED VARIABLE TX_OUT : LINE;

    BEGIN
        UUT : ALU
        PORT MAP (
            A => A,
            B => B,
            S => S,
            C => C,
            O => O,
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
            PROCEDURE CHECK_O(
                next_O : std_logic_vector (3 DownTo 0);
                TX_TIME : INTEGER
            ) IS
                VARIABLE TX_STR : String(1 to 4096);
                VARIABLE TX_LOC : LINE;
                BEGIN
                IF (O /= next_O) THEN
                    STD.TEXTIO.write(TX_LOC, string'("Error at time="));
                    STD.TEXTIO.write(TX_LOC, TX_TIME);
                    STD.TEXTIO.write(TX_LOC, string'("ns O="));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, O);
                    STD.TEXTIO.write(TX_LOC, string'(", Expected = "));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, next_O);
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
                A <= "1100";
                B <= "0011";
                -- -------------------------------------
                -- -------------  Current Time:  60ns
                WAIT FOR 20 ns;
                CHECK_O("1111", 60);
                -- -------------------------------------
                -- -------------  Current Time:  80ns
                WAIT FOR 20 ns;
                A <= "1001";
                B <= "0110";
                S <= "0001";
                -- -------------------------------------
                -- -------------  Current Time:  100ns
                WAIT FOR 20 ns;
                CHECK_CARRY('1', 100);
                CHECK_O("0010", 100);
                -- -------------------------------------
                -- -------------  Current Time:  120ns
                WAIT FOR 20 ns;
                A <= "0001";
                B <= "0000";
                S <= "0010";
                -- -------------------------------------
                -- -------------  Current Time:  140ns
                WAIT FOR 20 ns;
                CHECK_O("0000", 140);
                -- -------------------------------------
                -- -------------  Current Time:  160ns
                WAIT FOR 20 ns;
                A <= "1110";
                B <= "1000";
                S <= "0011";
                -- -------------------------------------
                -- -------------  Current Time:  180ns
                WAIT FOR 20 ns;
                CHECK_CARRY('0', 180);
                CHECK_O("1110", 180);
                -- -------------------------------------
                -- -------------  Current Time:  200ns
                WAIT FOR 20 ns;
                C <= '1';
                A <= "0111";
                B <= "1100";
                S <= "0100";
                -- -------------------------------------
                -- -------------  Current Time:  220ns
                WAIT FOR 20 ns;
                CHECK_O("1011", 220);
                -- -------------------------------------
                -- -------------  Current Time:  240ns
                WAIT FOR 20 ns;
                S <= "0101";
                -- -------------------------------------
                -- -------------  Current Time:  260ns
                WAIT FOR 20 ns;
                CHECK_O("1000", 260);
                -- -------------------------------------
                -- -------------  Current Time:  280ns
                WAIT FOR 20 ns;
                A <= "1010";
                B <= "1000";
                S <= "0110";
                -- -------------------------------------
                -- -------------  Current Time:  300ns
                WAIT FOR 20 ns;
                CHECK_O("1010", 300);
                -- -------------------------------------
                -- -------------  Current Time:  320ns
                WAIT FOR 20 ns;
                A <= "1110";
                B <= "1100";
                S <= "0111";
                -- -------------------------------------
                -- -------------  Current Time:  340ns
                WAIT FOR 20 ns;
                CHECK_O("1100", 340);
                -- -------------------------------------
                -- -------------  Current Time:  360ns
                WAIT FOR 20 ns;
                C <= '0';
                B <= "1110";
                S <= "1000";
                -- -------------------------------------
                -- -------------  Current Time:  380ns
                WAIT FOR 20 ns;
                CHECK_O("0111", 380);
                -- -------------------------------------
                -- -------------  Current Time:  400ns
                WAIT FOR 20 ns;
                B <= "1010";
                S <= "1001";
                -- -------------------------------------
                -- -------------  Current Time:  420ns
                WAIT FOR 20 ns;
                CHECK_O("1100", 420);
                -- -------------------------------------
                -- -------------  Current Time:  440ns
                WAIT FOR 20 ns;
                A <= "1011";
                B <= "1000";
                S <= "1010";
                -- -------------------------------------
                -- -------------  Current Time:  460ns
                WAIT FOR 20 ns;
                CHECK_O("0101", 460);
                -- -------------------------------------
                -- -------------  Current Time:  480ns
                WAIT FOR 20 ns;
                B <= "0000";
                S <= "1011";
                -- -------------------------------------
                -- -------------  Current Time:  500ns
                WAIT FOR 20 ns;
                CHECK_O("0110", 500);
                -- -------------------------------------
                -- -------------  Current Time:  520ns
                WAIT FOR 20 ns;
                C <= '1';
                A <= "1110";
                B <= "0100";
                S <= "1100";
                -- -------------------------------------
                -- -------------  Current Time:  540ns
                WAIT FOR 20 ns;
                CHECK_O("0000", 540);
                -- -------------------------------------
                -- -------------  Current Time:  560ns
                WAIT FOR 20 ns;
                A <= "1100";
                B <= "1110";
                S <= "1101";
                -- -------------------------------------
                -- -------------  Current Time:  600ns
                WAIT FOR 40 ns;
                A <= "1000";
                B <= "1010";
                S <= "1110";
                -- -------------------------------------
                -- -------------  Current Time:  640ns
                WAIT FOR 40 ns;
                A <= "1100";
                B <= "0010";
                S <= "1111";
                -- -------------------------------------
                -- -------------  Current Time:  680ns
                WAIT FOR 40 ns;
                C <= '0';
                A <= "0000";
                B <= "0000";
                S <= "0000";
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

