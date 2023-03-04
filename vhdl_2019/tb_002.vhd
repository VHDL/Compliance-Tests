-- LCS-2016-002: Allow access and protected type parameters on function interfaces
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_002
package pack002 is

    type test_t is protected
        procedure increment ;
        impure function get return integer ;
    end protected ;

    impure function doit(variable x : inout test_t) return integer ;

end package ;

package body pack002 is

    impure function doit(variable x : inout test_t) return integer is
    begin
        x.increment ;
        return x.get ;
    end function ;

    type test_t is protected body
        variable val : integer ;
        procedure increment is
        begin
            val := val + 1 ;
        end procedure ;
        impure function get return integer is
        begin
            return val ;
        end function ;
    end protected body ;

end package body ;

--

library vunit_lib;
context vunit_lib.vunit_context;

use work.pack002.all ;

entity tb_allow_access_and_protected_type_params_on_func_interfaces is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_allow_access_and_protected_type_params_on_func_interfaces is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("Running a VUnit test for 'LCS-2016-002: Allow access and protected type parameters on function interfaces'.");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
