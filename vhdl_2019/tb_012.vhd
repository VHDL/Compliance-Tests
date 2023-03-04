-- LCS-2016-012: 'IMAGE and TO_STRING for composite types
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_012
entity e012 is
end entity ;

architecture arch of e012 is

    type rec_t is record
        a : integer ;
        b : bit_vector(7 downto 0) ;
        c : time ;
        d : integer_vector(0 to 4) ;
    end record ;

    signal rec : rec_t ;

begin

    tb : process
    begin
        assert rec'image      /= "" severity failure ;
        assert to_string(rec) /= "" severity failure ;
        wait ;
    end process ;

end architecture ;

--

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_image_and_to_string_for_composite_types is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_image_and_to_string_for_composite_types is
begin
  U_e012 : entity work.e012 ;
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-012: 'IMAGE and TO_STRING for composite types");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
