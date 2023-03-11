library vunit_lib;
context vunit_lib.vunit_context;

entity tb_top_generic_subtype is
  generic ( runner_cfg : runner_cfg_t := runner_cfg_default);
end entity tb_top_generic_subtype;

architecture tb of tb_top_generic_subtype is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("Running a VUnit test with a top-level of a custom subtype");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;

end architecture tb;
