-- LCS-2016-045a: Interface - defines new mode view construct for composite interface objects
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_045a
package pack045a is

    type rec_t is record
        a   :   integer ;
        b   :   string ;
        c   :   bit_vector(7 downto 0) ;
        d   :   bit_vector(0 to -1) ;
    end record ;

    view master of rec_t is
        a   :   in ;
        b   :   out ;
        c   :   out ;
        d   :   inout ;
    end view ;

end package ;
