-- LCS-2016-045a: Interface - defines new mode view construct for composite interface objects
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_045a
package pack045a is

    type rec_t is record
        a   :   integer ;
        b   :   string ;
        c   :   bit_vector(7 downto 0) ;
        d   :   bit_vector(0 to -1) ;
    end record ;

    view master of rec_t is
        a   :   in ;
        b   :   out ;
        c   :   out ;
        d   :   inout ;
    end view ;

end package ;

--

library vunit_lib;
context vunit_lib.vunit_context;

use work.pack045a.all ;

entity tb_interface_mode_view is
  generic ( runner_cfg : string := runner_cfg_default);
end entity;

architecture tb of tb_interface_mode_view is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-045a: Interface - defined a new mode view construct for composite interface objects");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
