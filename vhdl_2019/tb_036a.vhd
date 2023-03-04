-- LCS-2016-036a: Allow for conditional expressions in a declaration (baseline)
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_036a

package pack036a is
  generic (
    USE_LONG_DELAY : boolean ;
  ) ;

    constant delay : time := 1 ms when USE_LONG_DELAY = true else 1 ns ;

end package ;

--
package pack036a_true is new work.pack036a generic map ( USE_LONG_DELAY => true ) ;

library vunit_lib;
context vunit_lib.vunit_context;


entity tb_conditional_expressions_in_a_declaration is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_conditional_expressions_in_a_declaration is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-036a: Allow for conditional expressions in a declaration (baseline)");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
