-- LCS-2016-055a: Syntax regularization - component declarations
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_055a
package pack055a is

    component test is
      port (
        x   :   bit_vector ;
        y   :   integer ;
      ) ;
    end ;

end package ;

--

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_syntax_regularization_components is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_syntax_regularization_components is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-055a: Syntax regularization - component declarations");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
