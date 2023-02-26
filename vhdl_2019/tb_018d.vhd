-- LCS-2016-018d: New attribute - 'DESGINATED_TYPE
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_018d
package pack018d is

    subtype ac_type is std.textio.line'designated_subtype ;
    subtype ft_type is std.textio.text'designated_subtype ;

end package ;
