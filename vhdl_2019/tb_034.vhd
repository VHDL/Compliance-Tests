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

