-- LCS-2016-019: Inferring Constraints from Initial Values for Signals and Variables
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_019

library ieee ;
use ieee.fixed_pkg.all ;

entity e019 is
  port (
    a   : in  sfixed ;
    b   : in  sfixed ;
    c   : out sfixed
  ) ;
end entity ;

architecture arch of e019 is

begin

    process
        variable prod : sfixed := a * b ;
    begin
        c <= resize(prod,a) ;
    end process ;

end architecture ;
