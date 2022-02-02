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

--    -- int setenv(
--    --   const char *name,
--    --   const char *value,
--    --   int overwrite
--    -- );
--    function c_setenv(
--      name      : string;
--      value     : string;
--      overwrite : integer
--    ) return integer is
--    begin report "VHPIDIRECT c_setenv" severity failure; end;
--    attribute foreign of c_setenv : function is "VHPIDIRECT c_setenv";

    impure function c_getenv(
       name : string
    ) return line is
    begin report "VHPIDIRECT c_getenv" severity failure; end;
    attribute foreign of c_getenv : function is "VHPIDIRECT c_getenv";

  begin
    test_runner_setup(runner, runner_cfg);

    report c_getenv("PATH").all severity note;

    --report to_string(c_setenv("MYKEY", "somevalue", 1)) severity note;

    --report c_getenv("MYKEY") severity note;

    test_runner_cleanup(runner);
    wait;
  end process;
end;
