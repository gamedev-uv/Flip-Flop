--------------------------------------------------------------------------------
-- Copyright (c) 1995-2003 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 8.1i
--  \   \         Application : ISE
--  /   /         Filename : ShiftRegisterDFFWave.vhw
-- /___/   /\     Timestamp : Sun Oct 04 03:41:46 2026
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: ShiftRegisterDFFWave
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE STD.TEXTIO.ALL;

ENTITY ShiftRegisterDFFWave IS
END ShiftRegisterDFFWave;

ARCHITECTURE testbench_arch OF ShiftRegisterDFFWave IS
    FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";

    COMPONENT ShiftRegisterUsingDFF
        PORT (
            S_in : In std_logic;
            Reset : In std_logic;
            Clk : In std_logic;
            O : Out std_logic_vector (3 DownTo 0)
        );
    END COMPONENT;

    SIGNAL S_in : std_logic := '0';
    SIGNAL Reset : std_logic := '0';
    SIGNAL Clk : std_logic := '0';
    SIGNAL O : std_logic_vector (3 DownTo 0) := "0000";

    SHARED VARIABLE TX_ERROR : INTEGER := 0;
    SHARED VARIABLE TX_OUT : LINE;

    constant PERIOD : time := 200 ns;
    constant DUTY_CYCLE : real := 0.5;
    constant OFFSET : time := 0 ns;

    BEGIN
        UUT : ShiftRegisterUsingDFF
        PORT MAP (
            S_in => S_in,
            Reset => Reset,
            Clk => Clk,
            O => O
        );

        PROCESS    -- clock process for Clk
        BEGIN
            WAIT for OFFSET;
            CLOCK_LOOP : LOOP
                Clk <= '0';
                WAIT FOR (PERIOD - (PERIOD * DUTY_CYCLE));
                Clk <= '1';
                WAIT FOR (PERIOD * DUTY_CYCLE);
            END LOOP CLOCK_LOOP;
        END PROCESS;

        PROCESS
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
                -- -------------  Current Time:  85ns
                WAIT FOR 85 ns;
                S_in <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  315ns
                WAIT FOR 230 ns;
                CHECK_O("1000", 315);
                -- -------------------------------------
                -- -------------  Current Time:  485ns
                WAIT FOR 170 ns;
                S_in <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  515ns
                WAIT FOR 30 ns;
                CHECK_O("1100", 515);
                -- -------------------------------------
                -- -------------  Current Time:  685ns
                WAIT FOR 170 ns;
                S_in <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  715ns
                WAIT FOR 30 ns;
                CHECK_O("0110", 715);
                -- -------------------------------------
                -- -------------  Current Time:  915ns
                WAIT FOR 200 ns;
                CHECK_O("1011", 915);
                -- -------------------------------------
                WAIT FOR 285 ns;

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

