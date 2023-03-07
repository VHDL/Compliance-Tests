-- LCS-2016-018d: New attribute - 'DESGINATED_TYPE
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_018d
package pack018d is

    subtype ac_type is std.textio.line'designated_subtype ;
    subtype ft_type is std.textio.text'designated_subtype ;

end package ;

--

library vunit_lib;
context vunit_lib.vunit_context;

use work.pack018d.all ;

entity tb_new_attribute_designated_type is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_new_attribute_designated_type is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-018d: New Attribute - 'DESIGNATED_TYPE");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
