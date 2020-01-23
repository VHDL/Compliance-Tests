library ieee;
  use ieee.std_logic_1164.all;

package generic_pkg_2 is
  generic (
    value : integer;
    bit_value : std_logic;
    vector_value : std_logic_vector);

  constant my_value : integer := value;
  constant my_bit_value : std_logic := bit_value;
  constant my_vector_value : std_logic_vector := vector_value;

end package;

library ieee;
  use ieee.std_logic_1164.all;

package my_pkg_2 is new work.generic_pkg_2
  generic map (
    value => 17,
    bit_value => '1',
    vector_value => "0000");

library ieee;
  use ieee.std_logic_1164.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_generics_in_packages is
  generic (
    runner_cfg : runner_cfg_t);
end entity;

architecture tb of tb_generics_in_packages is
begin
  test_runner: process is
    variable my_bit_value : std_logic := '1';
    variable my_vector_value : std_ulogic_vector := "0000";
  begin
    test_runner_setup(runner, runner_cfg);

    check_equal(work.my_pkg_2.my_value, 17);
    check_equal(work.my_pkg_2.my_bit_value, my_bit_value);
    check_equal(work.my_pkg_2.my_vector_value, my_vector_value);

    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
