-- LCS-2016-004: Allow protected type method parameters to be access types, protected types (functions), and file types
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_004
use std.textio.all ;

package pack004 is

    type test_t is protected
        impure function something(variable x : inout text) return integer ;
    end protected ;

end package ;

package body pack004 is

    type test_t is protected body
        impure function something(variable x : inout text) return integer is
        begin
            return 0;
        end function ;
    end protected body ;

end package body ;

--

library vunit_lib;
context vunit_lib.vunit_context;

use work.pack004.all ;

entity tb_allow_protected_type_method_params_to_be_access_protected_file is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_allow_protected_type_method_params_to_be_access_protected_file is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-004: Allow protected type method parameters to be access types, protected types (functions), and file types.");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
