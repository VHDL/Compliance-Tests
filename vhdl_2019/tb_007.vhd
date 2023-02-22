-- LCS-2016-007: Sequential Declaration Regions
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_007
entity e is
end entity ;

architecture a of e is

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

begin

  tb : process
  begin
    std.env.stop ;
  end process;

end architecture ;
