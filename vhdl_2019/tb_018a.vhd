-- LCS-2016-018a: New Attribute - 'INDEX
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_018a
package pack018a is

    type bigarray_t is array(natural range <>, positive range <>, character range <>) of integer ;

    signal idx1 : bigarray_t'index(1) ;
    signal idx2 : bigarray_t'index(2) ;
    signal idx3 : bigarray_t'index(3) ;

end package ;
