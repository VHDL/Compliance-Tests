library vunit_lib;
context vunit_lib.vunit_context;
library ieee;
use ieee.std_logic_1164.all;

entity tb_hex_code is
  generic ( runner_cfg : string );
end entity tb_hex_code;

architecture tb of tb_hex_code is
  function hex_code(x : std_logic_vector) return boolean is
  begin
    if x = 6x"3d" then
        return true;
    else
        return false;
    end if;
  end function;
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    check_equal( hex_code(6x"3d"), true ) ;
    check_equal( hex_code(x"3d"), false ) ;
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
