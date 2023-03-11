package generic_pkg_2 is
  generic (
    value : integer);

  constant my_value : integer := value;

end package;

package my_pkg_2 is new work.generic_pkg_2
  generic map (
    value => 17);

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_generics_in_packages is
  generic ( runner_cfg : string := runner_cfg_default);
end entity;

architecture tb of tb_generics_in_packages is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);

    check_equal(work.my_pkg_2.my_value, 17);

    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
