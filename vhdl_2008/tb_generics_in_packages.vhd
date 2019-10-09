package generic_pkg is
  generic (
    value : integer);

  constant my_value : integer := value;

end package;

package my_pkg is new work.generic_pkg
  generic map (
    value => 17);

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_generics_in_packages is
  generic (
    runner_cfg : runner_cfg_t);
end entity;

architecture tb of tb_generics_in_packages is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);

    check_equal(work.my_pkg.my_value, 17);

    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
