library ieee;
package my_fixed_pkg is new ieee.fixed_generic_pkg;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_fixed_generic_pkg is
  generic (
    runner_cfg : runner_cfg_t);
end entity;

architecture tb of tb_fixed_generic_pkg is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);

    check(work.my_fixed_pkg.CopyRightNotice = "Copyright 2008 by IEEE. All rights reserved.",
          "Invalid copyright notice");

    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
