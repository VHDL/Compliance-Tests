/*
This is a compliance test for block comments
This is only defined in starting in VHDL 2008
*/

library vunit_lib;
context vunit_lib.vunit_context;
library ieee;
use ieee.std_logic_1164.all;

entity tb_block_comments is
  generic ( runner_cfg : string );
end entity tb_block_comments;

architecture tb of tb_block_comments is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    check_equal( true, true ) ;
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;