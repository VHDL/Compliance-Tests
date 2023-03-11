-- LCS-2016-034: Protected Types with Generic Clause
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_034
package pack034 is

    type test_t is protected
      generic (
        type expected_t ;
        type actual_t ;
        function check(a : actual_t ; e : expected_t) return boolean
      ) ;
    end protected ;

    type int_test_t is new test_t
      generic map (
        expected_t => integer,
        actual_t   => integer,
        check      => std.standard."="
      ) ;

end package;

--

library vunit_lib;
context vunit_lib.vunit_context;

use work.pack034.all ;

entity tb_protected_types_with_generic_clause is
  generic ( runner_cfg : string := runner_cfg_default);
end entity;

architecture tb of tb_protected_types_with_generic_clause is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-034: Protected Types with Generic Clause");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
