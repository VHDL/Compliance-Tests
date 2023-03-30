library vunit_lib;
context vunit_lib.vunit_context;
library ieee;
use ieee.std_logic_1164.all;

entity tb_unary_operators is
  generic ( runner_cfg : string );
end entity tb_unary_operators;

architecture tb of tb_unary_operators is
  function check_unary(x : std_logic_vector(2 downto 0)) return std_logic is
      variable vec : std_logic_vector(1 downto 0) := "11";
  begin
    case x is
      when "000" => return or(vec) ;
      when "001" => return and(vec) ;
      when "010" => return nor(vec) ;
      when "011" => return nand(vec) ;
      when "100" => return xor(vec) ;
      when "101" => return xnor(vec) ;
      when others => return 'X' ;
    end case ;
  end function;
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    check_equal( check_unary("000"), '1' ) ;
    check_equal( check_unary("001"), '1' ) ;
    check_equal( check_unary("010"), '0' ) ;
    check_equal( check_unary("011"), '0' ) ;
    check_equal( check_unary("100"), '0' ) ;
    check_equal( check_unary("101"), '1' ) ;
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
