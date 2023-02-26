-- LCS-2016-033: Composition with Protected Types
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_033
package pack033 is

    type sometype_t is protected
        procedure write(x : string) ;
    end protected ;

    type test_t is protected
        private variable name : sometype_t ;
        alias write is name.write[string] ;
    end protected ;

end package ;
