-- LCS-2016-033: Composition with Protected Types
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_033
package pack033 is

    type sometype_t is protected
        procedure write(x : string) ;
    end protected ;

    type test_t is protected
        private variable name : sometype_t ;
        alias write is name.write[string] ;
    end protected ;

end package ;

--

library vunit_lib;
context vunit_lib.vunit_context;

use work.pack033.all ;

entity tb_composition_with_protected_types is
  generic ( runner_cfg : string := runner_cfg_default);
end entity;

architecture tb of tb_composition_with_protected_types is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-033: Composition with Protected Types");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
