-- LCS-2016-055a: Syntax regularization - component declarations
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_055a
package pack055a is

    component test is
      port (
        x   :   bit_vector ;
        y   :   integer ;
      ) ;
    end ;

end package ;
