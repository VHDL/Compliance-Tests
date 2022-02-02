use std.textio.line;
library IEEE;
context IEEE.IEEE_std_context;

library vunit_lib;
context vunit_lib.vunit_context;

entity Tb_AccessesFromCToVhdl is
  generic (
    runner_cfg : string;
    tb_path    : string
  );
end;

architecture arch of Tb_AccessesFromCToVhdl is

  type int_natural1D_t is array (natural range <>) of integer;

begin

  process

    impure function getLine return line is
    begin report "VHPIDIRECT getLine" severity failure; end;
    attribute foreign of getLine : function is "VHPIDIRECT getLine";

--    procedure passAccessesFromCToVhdl(
--    ) is
--    begin report "VHPIDIRECT passAccessesFromCToVhdl" severity failure; end;
--    attribute foreign of passAccessesFromCToVhdl : procedure is "VHPIDIRECT passAccessesFromCToVhdl";

  begin
    test_runner_setup(runner, runner_cfg);

    report "getLine: " & getLine.all severity note;
    assert getLine.all = "HELLO WORLD" severity failure;

--    passAccessesFromCToVhdl(
--    );

    test_runner_cleanup(runner);
    wait;
  end process;
end;
