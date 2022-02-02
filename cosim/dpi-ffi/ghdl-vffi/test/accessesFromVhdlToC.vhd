use std.textio.line;
library IEEE;
context IEEE.IEEE_std_context;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_AccessesFromVhdlToC is
  generic (
    runner_cfg : string;
    tb_path    : string
  );
end;

architecture arch of tb_AccessesFromVhdlToC is

  type int_natural1D_t is array (natural range <>) of integer;

begin

  process

    procedure passAccessesFromVhdlToC(
      v_natural1D_int  : int_natural1D_t
    ) is
    begin report "VHPIDIRECT passAccessesFromVhdlToC" severity failure; end;
    attribute foreign of passAccessesFromVhdlToC : procedure is "VHPIDIRECT passAccessesFromVhdlToC";

  begin
    test_runner_setup(runner, runner_cfg);

    passAccessesFromVhdlToC(
      v_natural1D_int  => (11, 22, 33, 44, 55)
    );

    test_runner_cleanup(runner);
    wait;
  end process;
end;
