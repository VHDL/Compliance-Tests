use std.textio.line;
library IEEE;
context IEEE.IEEE_std_context;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_EnvironmentVariables is
  generic (
    runner_cfg : string;
    tb_path    : string
  );
end;

architecture arch of tb_EnvironmentVariables is

begin

  process

    impure function c_getenv(
       name : string
    ) return line is
    begin report "VHPIDIRECT c_getenv" severity failure; end;
    attribute foreign of c_getenv : function is "VHPIDIRECT c_getenv";

  begin
    test_runner_setup(runner, runner_cfg);

    report c_getenv("PATH").all severity note;

    test_runner_cleanup(runner);
    wait;
  end process;
end;
