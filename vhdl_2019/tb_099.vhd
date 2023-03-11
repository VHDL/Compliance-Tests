-- LCS-2016-099: Extended Ranges
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_099
entity e099 is
end entity ;

architecture arch of e099 is

    subtype natural_range_record is natural'range'record ;

    signal a : bit_vector(7 downto 0) ;

    constant r : natural_range_record := a'range'value ;

    signal x : bit_vector(r) ;

    constant r2 : natural_range_record := (
        direction => descending,
        left => 30,
        right => 0
    ) ;

    signal y : bit_vector(r2) ;

begin

    tb : process
    begin
        wait ;
    end process ;

end architecture ;

--

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_extended_ranges is
  generic ( runner_cfg : string := runner_cfg_default);
end entity;

architecture tb of tb_extended_ranges is
begin
  U_e099 : entity work.e099 ;
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-099: Extended Ranges");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
