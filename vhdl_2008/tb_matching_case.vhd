library vunit_lib;
context vunit_lib.vunit_context;
library ieee;
use ieee.std_logic_1164.all;

entity tb_matching_case is
  generic ( runner_cfg : string );
end entity tb_matching_case;

architecture tb of tb_matching_case is
  function check_case(x : std_logic_vector) return boolean is
  begin
    case? x is
      when "1--" => return true ;
      when "01-" => return true ;
      when "001" => return true ;
      when others => return false ;
    end case? ;
  end function;
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    check_equal( check_case("110"), true ) ;
    check_equal( check_case("100"), true ) ;
    check_equal( check_case("101"), true ) ;
    check_equal( check_case("000"), false) ;
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
