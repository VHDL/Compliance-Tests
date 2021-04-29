use std.textio.line;
library ieee;
context ieee.ieee_std_context;

entity tb_VHDPI_Test is
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

    VHDPI_Test(
      v_natural1D_int => (11, 22, 33, 44, 55)
    );

    wait;
  end process;
end;
