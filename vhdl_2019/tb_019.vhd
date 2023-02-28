-- LCS-2016-019: Inferring Constraints from Initial Values for Signals and Variables
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_019

library ieee ;
use ieee.fixed_pkg.all ;

entity e019 is
end entity ;

architecture arch of e019 is

    constant a : sfixed(0 downto -15) := from_string("1001010010010101", 0, -15);
    constant b : sfixed(0 downto -15) := from_string("0010010101010011", 0, -15);

begin

    process
        variable prod : sfixed := a * b ;
    begin
        report to_string(to_real(a)) & "*" & to_string(to_real(b)) & " = " & to_string(to_real(prod)) ;
        std.env.stop ;
    end process ;

end architecture ;
