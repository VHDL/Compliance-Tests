library vunit_lib;
context vunit_lib.vunit_context;

library ieee;
use ieee.numeric_std.all;

entity tb_reading_function_return_value is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_reading_function_return_value is
begin
  main: process
    function meaning_of_life return return_value of unsigned is
    begin
      return to_unsigned(42, return_value'length);
    end function;

    variable the_answer : unsigned(7 downto 0);
  begin
    test_runner_setup(runner, runner_cfg);

    the_answer := meaning_of_life;
    check_equal(the_answer, 42, result("for meaning of life"));
    
    test_runner_cleanup(runner);
  end process;
end architecture;
