--------------------------------------------------------------------------------
-- Copyright (c) 1995-2003 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 8.1i
--  \   \         Application : ISE
--  /   /         Filename : fullAdderComponentsWave.vhw
-- /___/   /\     Timestamp : Thu Jul 16 22:28:47 2026
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: fullAdderComponentsWave
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE STD.TEXTIO.ALL;

ENTITY fullAdderComponentsWave IS
END fullAdderComponentsWave;

ARCHITECTURE testbench_arch OF fullAdderComponentsWave IS
    COMPONENT fullAdderComponents
        PORT (
            A : In std_logic;
            B : In std_logic;
            C : In std_logic;
            SUM : Out std_logic;
            CARRY : Out std_logic
        );
    END COMPONENT;

    SIGNAL A : std_logic := '0';
    SIGNAL B : std_logic := '0';
    SIGNAL C : std_logic := '0';
    SIGNAL SUM : std_logic := '0';
    SIGNAL CARRY : std_logic := '0';

    SHARED VARIABLE TX_ERROR : INTEGER := 0;
    SHARED VARIABLE TX_OUT : LINE;

    BEGIN
        UUT : fullAdderComponents
        PORT MAP (
            A => A,
            B => B,
            C => C,
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
                    STD.TEXTIO.Deallocate(TX_LOC);
                    ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
                    TX_ERROR := TX_ERROR + 1;
                END IF;
            END;
            PROCEDURE CHECK_SUM(
                next_SUM : std_logic;
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
                    STD.TEXTIO.Deallocate(TX_LOC);
                    ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
                    TX_ERROR := TX_ERROR + 1;
                END IF;
            END;
            BEGIN
                -- -------------  Current Time:  40ns
                WAIT FOR 40 ns;
                C <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  50ns
                WAIT FOR 10 ns;
                CHECK_SUM('1', 50);
                -- -------------------------------------
                -- -------------  Current Time:  60ns
                WAIT FOR 10 ns;
                B <= '1';
                C <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  80ns
                WAIT FOR 20 ns;
                C <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  90ns
                WAIT FOR 10 ns;
                CHECK_SUM('0', 90);
                CHECK_CARRY('1', 90);
                -- -------------------------------------
                -- -------------  Current Time:  100ns
                WAIT FOR 10 ns;
                A <= '1';
                B <= '0';
                C <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  110ns
                WAIT FOR 10 ns;
                CHECK_SUM('1', 110);
                CHECK_CARRY('0', 110);
                -- -------------------------------------
                -- -------------  Current Time:  120ns
                WAIT FOR 10 ns;
                C <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  130ns
                WAIT FOR 10 ns;
                CHECK_SUM('0', 130);
                CHECK_CARRY('1', 130);
                -- -------------------------------------
                -- -------------  Current Time:  140ns
                WAIT FOR 10 ns;
                B <= '1';
                C <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  160ns
                WAIT FOR 20 ns;
                C <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  170ns
                WAIT FOR 10 ns;
                CHECK_SUM('1', 170);
                -- -------------------------------------
                -- -------------  Current Time:  180ns
                WAIT FOR 10 ns;
                A <= '0';
                B <= '0';
                C <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  190ns
                WAIT FOR 10 ns;
                CHECK_SUM('0', 190);
                CHECK_CARRY('0', 190);
                WAIT FOR 810 ns;

                IF (TX_ERROR = 0) THEN
                    STD.TEXTIO.write(TX_OUT, string'("No errors or warnings"));
                    ASSERT (FALSE) REPORT
                      "Simulation successful (not a failure).  No problems detected."
                      SEVERITY FAILURE;
                ELSE
                    STD.TEXTIO.write(TX_OUT, TX_ERROR);
                    STD.TEXTIO.write(TX_OUT,
                        string'(" errors found in simulation"));
                    ASSERT (FALSE) REPORT "Errors found during simulation"
                         SEVERITY FAILURE;
                END IF;
            END PROCESS;

    END testbench_arch;

