-- LCS-2016-006e: Allow access to system environment variables (baseline)
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_006e
use std.env.all;
use std.textio.all;

impure function GetConfig return boolean is
    file config : text;
    variable home, data : line;
    variable result : boolean;
begin
    home := GETENV("HOME");
    assert home /= null report "No HOME environment variable";
    FILE_OPEN(config,
        home.all & DIR_SEPARATOR &
        ".config" & DIR_SEPARATOR &
        "myapp.txt",
        read_mode
    );
    READ_LINE(config, data);
    READ(data, result);
    FILE_CLOSE(config);
    return result;
end function GetConfig;
