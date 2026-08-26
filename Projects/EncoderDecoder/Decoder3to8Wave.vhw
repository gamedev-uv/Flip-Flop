--------------------------------------------------------------------------------
-- Copyright (c) 1995-2003 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 8.1i
--  \   \         Application : ISE
--  /   /         Filename : Decoder3to8Wave.vhw
-- /___/   /\     Timestamp : Thu Aug 20 17:00:41 2026
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: Decoder3to8Wave
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE STD.TEXTIO.ALL;

ENTITY Decoder3to8Wave IS
END Decoder3to8Wave;

ARCHITECTURE testbench_arch OF Decoder3to8Wave IS
    FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";

    COMPONENT Decoder3to8
        PORT (
            I : In std_logic_vector (2 DownTo 0);
            O : Out std_logic_vector (7 DownTo 0)
        );
    END COMPONENT;

    SIGNAL I : std_logic_vector (2 DownTo 0) := "000";
    SIGNAL O : std_logic_vector (7 DownTo 0) := "00000001";

    SHARED VARIABLE TX_ERROR : INTEGER := 0;
    SHARED VARIABLE TX_OUT : LINE;

    BEGIN
        UUT : Decoder3to8
        PORT MAP (
            I => I,
            O => O
        );

        PROCESS
            PROCEDURE CHECK_O(
                next_O : std_logic_vector (7 DownTo 0);
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
                I <= "001";
                -- -------------------------------------
                -- -------------  Current Time:  50ns
                WAIT FOR 10 ns;
                CHECK_O("00000010", 50);
                -- -------------------------------------
                -- -------------  Current Time:  60ns
                WAIT FOR 10 ns;
                I <= "010";
                -- -------------------------------------
                -- -------------  Current Time:  70ns
                WAIT FOR 10 ns;
                CHECK_O("00000100", 70);
                -- -------------------------------------
                -- -------------  Current Time:  80ns
                WAIT FOR 10 ns;
                I <= "011";
                -- -------------------------------------
                -- -------------  Current Time:  90ns
                WAIT FOR 10 ns;
                CHECK_O("00001000", 90);
                -- -------------------------------------
                -- -------------  Current Time:  100ns
                WAIT FOR 10 ns;
                I <= "100";
                -- -------------------------------------
                -- -------------  Current Time:  110ns
                WAIT FOR 10 ns;
                CHECK_O("00010000", 110);
                -- -------------------------------------
                -- -------------  Current Time:  120ns
                WAIT FOR 10 ns;
                I <= "101";
                -- -------------------------------------
                -- -------------  Current Time:  130ns
                WAIT FOR 10 ns;
                CHECK_O("00100000", 130);
                -- -------------------------------------
                -- -------------  Current Time:  140ns
                WAIT FOR 10 ns;
                I <= "110";
                -- -------------------------------------
                -- -------------  Current Time:  150ns
                WAIT FOR 10 ns;
                CHECK_O("01000000", 150);
                -- -------------------------------------
                -- -------------  Current Time:  160ns
                WAIT FOR 10 ns;
                I <= "111";
                -- -------------------------------------
                -- -------------  Current Time:  170ns
                WAIT FOR 10 ns;
                CHECK_O("10000000", 170);
                -- -------------------------------------
                -- -------------  Current Time:  180ns
                WAIT FOR 10 ns;
                I <= "000";
                -- -------------------------------------
                -- -------------  Current Time:  190ns
                WAIT FOR 10 ns;
                CHECK_O("00000001", 190);
                WAIT FOR 810 ns;

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

