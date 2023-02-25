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
