-- LCS-2016-094a: Conditional Return Statement
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_094a
package pack094a is

    function isone(x : integer) return boolean ;

end package ;

package body pack094a is

    function isone(x : integer) return boolean is
    begin
        return true when x = 1 else false ;
    end function ;

end package body ;

--

library vunit_lib;
context vunit_lib.vunit_context;

use work.pack094a.all ;

entity tb_conditional_return_statement is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_conditional_return_statement is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-094a: Conditional Return Statement");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
