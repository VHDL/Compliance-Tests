-- LCS-2016-036a: Allow for conditional expressions in a declaration (baseline)
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_036a

package pack036a is
  generic (
    USE_LONG_DELAY : boolean ;
  ) ;

    constant delay : time := 1 ms when USE_LONG_DELAY = true else 1 ns ;

end package ;
