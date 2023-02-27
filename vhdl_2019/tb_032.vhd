-- LCS-2016-032: PATH_NAME and Shared Variables and Subprograms
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_032
-- REVIEW
package pack032 is

    type type_t is protected
        procedure increment ;
    end protected ;

end package ;

package body pack032 is

    type type_t is protected body
        variable value : natural ;
        procedure increment is
            constant vpath : string := value'path_name ;
            constant vinst : string := value'instance_name ;
        begin
            report "vpath: " & vpath ;
            report "vinst: " & vinst ;
            value := value + 1 ;
        end procedure ;
    end protected body ;

end package body ;

entity e032 is
end entity ;

architecture arch of e032 is

begin

    tb : process
        variable t : work.pack032.type_t ;
    begin
        t.increment ;
        std.env.stop ;
    end process ;

end architecture ;
