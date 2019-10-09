package generic_pkg is
  generic (
    function operation (value: integer) return integer);

  function repeat (
    constant value : integer;
    constant n_times : positive)
    return integer;
end package;

package body generic_pkg is
  function repeat (
    constant value : integer;
    constant n_times : positive)
    return integer is
    variable return_value : integer := value;
  begin
    for i in 1 to n_times loop
      return_value := operation(return_value);
    end loop;

    return return_value;
  end;
end package body generic_pkg;

package operations_pkg is
  function square (
    constant value : integer)
    return integer;
end package operations_pkg;

package body operations_pkg is
  function square (
    constant value : integer)
    return integer is
  begin
    return value * value;
  end;
end package body operations_pkg;

package my_pkg is new work.generic_pkg
  generic map (
    operation => work.operations_pkg.square);

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_function_generic_in_package is
  generic (
    runner_cfg : runner_cfg_t);
end entity;

architecture tb of tb_function_generic_in_package is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);

    check_equal(work.my_pkg.repeat(3, 2), 81);

    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
