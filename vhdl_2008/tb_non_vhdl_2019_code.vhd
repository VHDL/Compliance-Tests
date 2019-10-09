library vunit_lib;
context vunit_lib.vunit_context;

entity tb_non_vhdl_2019_code is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_non_vhdl_2019_code is
begin
  main : process
  begin
    test_runner_setup(runner, runner_cfg);

    report "This testbench should pass regardless of VHDL-2019 support";
    
    test_runner_cleanup(runner);
  end process;
end architecture;
