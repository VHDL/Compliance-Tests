-- LCS-2016-061: Conditional Compilation
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_061
use std.env.all ;
package pack061 is

    `if TOOL_TYPE = "SIMULATION" then
        constant simulator : string := TOOL_NAME ;
    `elsif TOOL_TYPE = "SYNTHESIS" then
        constant synthesizer : string := TOOL_NAME ;
    `end

end package ;
