-- LCS-2016-006f: Expose standard conditional analysis identifiers
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_006f
use std.env.all ;

entity tb006f is
end entity ;

architecture arch of tb006f is

begin

    tb : process
        report VHDL_VERSION ;
        report TOOL_TYPE ;
        report TOOL_VENDOR ;
        report TOOL_NAME ;
        report TOOL_EDITION ;
        report TOOL_VERSION ;
        std.env.stop ;
    end process ;

end architecture ;
