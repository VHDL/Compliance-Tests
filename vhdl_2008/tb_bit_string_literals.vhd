-- IEEE 1076-2008 15.8 - Bit string literals

library vunit_lib;
context vunit_lib.vunit_context;

library ieee;
use ieee.std_logic_1164.all;

entity tb_bit_string_literals is
   generic(
      runner_cfg : runner_cfg_t);
end entity tb_bit_string_literals;

architecture tb of tb_bit_string_literals is
begin
   test_runner : process is
      variable value : std_logic_vector(5 downto 0) := "000000";
   begin
      test_runner_setup(runner, runner_cfg);

      while test_suite loop
         if run("Literal downsize as hex width") then
            value := 6x"0f";
            check_equal(value, std_logic_vector'("001111"));
         elsif run("Literal upsize as hex width") then
            value := 6x"5";
            check_equal(value, std_logic_vector'("000101"));
         elsif run("Literal hex signed value extension") then
            value := 6Sx"a";
            check_equal(value, std_logic_vector'("111010"));
         elsif run("Literal hex unsigned extension") then
            value := 6Ux"a";
            check_equal(value, std_logic_vector'("001010"));

         elsif run("Literal downsize as binary width") then
            value := 6b"0000_0101";
            check_equal(value, std_logic_vector'("000101"));
         elsif run("Literal upsize as binary width") then
            value := 6b"0101";
            check_equal(value, std_logic_vector'("000101"));
         elsif run("Literal binary signed value extension") then
            value := 6Sb"101";
            check_equal(value, std_logic_vector'("111101"));
         elsif run("Literal binary unsigned extension") then
            value := 6Ub"101";
            check_equal(value, std_logic_vector'("000101"));

         elsif run("Literal downsize as octal width") then
            value := 6o"075";
            check_equal(value, std_logic_vector'("111101"));
         elsif run("Literal upsize as octal width") then
            value := 6o"5";
            check_equal(value, std_logic_vector'("000101"));
         elsif run("Literal octal signed value extension") then
            value := 6So"5";
            check_equal(value, std_logic_vector'("111101"));
         elsif run("Literal octal unsigned extension") then
            value := 6Uo"5";
            check_equal(value, std_logic_vector'("000101"));

         elsif run("Literal downsize as decimal width") then
            value := 6d"063";
            check_equal(value, std_logic_vector'("111111"));
         elsif run("Literal upsize as decimal width") then
            value := 6d"9";
            check_equal(value, std_logic_vector'("001001"));

         elsif run("Literal with meta value X") then
            value := 6b"XX0";
            check_equal(value, std_logic_vector'("000XX0"));
         elsif run("Literal with meta value U") then
            value := 6b"UU0";
            check_equal(value, std_logic_vector'("000UU0"));
         elsif run("Literal with meta value H") then
            value := 6b"HH0";
            check_equal(value, std_logic_vector'("000HH0"));
         elsif run("Literal with meta value L") then
            value := 6b"LL0";
            check_equal(value, std_logic_vector'("000LL0"));
         elsif run("Literal with meta value -") then
            value := 6b"--0";
            check_equal(value, std_logic_vector'("000--0"));
         elsif run("Literal with meta value Z") then
            value := 6b"ZZ0";
            check_equal(value, std_logic_vector'("000ZZ0"));
         elsif run("Literal with meta value W") then
            value := 6b"WW0";
            check_equal(value, std_logic_vector'("000WW0"));
         end if;

      end loop;

      test_runner_cleanup(runner);
      wait;
   end process test_runner;
end architecture tb;
