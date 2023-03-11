-- LCS-2016-045c: Interface - 'CONVERSE for a mode view
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_045c
package pack045c is

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

    alias slave is master'converse ;

end package ;

--

library vunit_lib;
context vunit_lib.vunit_context;

use work.pack045c.all ;

entity tb_interface_converse is
  generic ( runner_cfg : string := runner_cfg_default);
end entity;

architecture tb of tb_interface_converse is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-045c: Interface - 'CONVERSE");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
