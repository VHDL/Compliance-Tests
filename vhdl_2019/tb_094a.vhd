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
