-- LCS-2016-071a: Extra optional semicolon at the end of interface_list
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_071a
entity e071a is
  port (
    a   :   in  bit ;
    b   :   out integer ;
  ) ;
end entity ;
