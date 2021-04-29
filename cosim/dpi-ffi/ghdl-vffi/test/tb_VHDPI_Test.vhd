use std.textio.line;
library ieee;
context ieee.ieee_std_context;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_VHDPI_Test is
  generic (
    runner_cfg : string;
    tb_path    : string
  );
end;

architecture arch of tb_VHDPI_Test is

  type int_natural1D_t is array (natural range <>) of integer;

begin

  process

    procedure VHDPI_Test(
      v_natural1D_int : int_natural1D_t
    ) is
    begin report "VHPIDIRECT VHDPI_Test" severity failure; end;
    attribute foreign of VHDPI_Test : procedure is "VHPIDIRECT VHDPI_Test";

  begin
    test_runner_setup(runner, runner_cfg);

    VHDPI_Test(
      v_natural1D_int => (11, 22, 33, 44, 55)
    );

    test_runner_cleanup(runner);
    wait;
  end process;
end;
