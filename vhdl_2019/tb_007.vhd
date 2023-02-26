-- LCS-2016-007: Sequential Declaration Regions
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_007
entity e007 is
end entity ;

use std.textio.all;

architecture a of e007 is

  procedure write(variable l : inout line ; v : integer_vector) is
  begin
    for idx in v'range loop
      write(l, v(idx));
    end loop;
  end procedure ;

  function to_string (
    value      : in integer_vector
  ) return string is
    variable L : line;
  begin
    write(L, value) ;
    inner_blk : block
     variable result : string(L'range) ;
    begin
      result := L.all ;
      deallocate(L) ;
      return result ;
    end block ;
  end function to_string ;

  constant int_vec : integer_vector := ( 1, 2, 3, 4 ) ;

begin

  tb : process
  begin
    report to_string(int_vec) ;
    std.env.stop ;
  end process;

end architecture ;

--

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_sequential_declaration_regions is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_sequential_declaration_regions is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-007: Sequential Declaration Regions");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
