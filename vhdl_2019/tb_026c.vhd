-- LCS-2016-026c: Long Integers
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_026c

package pack026c is

    constant a : integer := 89345897098345;
    constant b : integer := -892348978489894 ;

    constant c : natural := 723478927649492389 ;

end package;

--

library vunit_lib;
context vunit_lib.vunit_context;

use work.pack026c.all ;

entity tb_long_integers is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_long_integers is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-026c: Long Integers");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
