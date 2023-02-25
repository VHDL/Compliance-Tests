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

