-- LCS-2016-082: Empty Record
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_082

package pack082 is

    type rec is record
    end record ;

end package;

--

library vunit_lib;
context vunit_lib.vunit_context;

use work.pack082.all ;

entity tb_empty_record is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_empty_record is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-082: Empty Record");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
