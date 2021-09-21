package generic_pkg_3 is
  generic (
    type my_type);

  function echo (
    constant value : my_type)
    return my_type;

end package;

package body generic_pkg_3 is

  function echo (
    constant value : my_type)
    return my_type is
  begin
    return value;
  end function echo;

end package body generic_pkg_3;

package my_pkg_3 is new work.generic_pkg_3
  generic map (
    my_type => integer);

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_type_generics_in_packages is
  generic ( runner_cfg : runner_cfg_t );
end entity;

architecture tb of tb_type_generics_in_packages is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);

    check_equal(work.my_pkg_3.echo(17), 17);

    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
