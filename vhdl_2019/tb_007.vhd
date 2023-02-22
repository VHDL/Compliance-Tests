-- LCS-2016-007: Sequential Declaration Regions
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_007
entity e007 is
end entity ;

architecture a of e007 is

  function to_string (
    value      : in integer_vector
  ) return string is
    variable L : line;
  begin
    write(L, value) ;
    inner_blk : block
     variable result : string(L'range) ;
    begin
      result := L.all ;
      deallocate(L) ;
      return result ;
    end block ;
  end function to_string ;

  constant int_vec : integer_vector := ( 1, 2, 3, 4 ) ;

begin

  tb : process
  begin
    report to_string(int_vec) ;
    std.env.stop ;
  end process;

end architecture ;
