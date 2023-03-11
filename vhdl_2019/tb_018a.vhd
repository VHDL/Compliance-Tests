-- LCS-2016-018a: New Attribute - 'INDEX
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_018a
package pack018a is

    type bigarray_t is array(natural range <>, positive range <>, character range <>) of integer ;

    signal idx1 : bigarray_t'index(1) ;
    signal idx2 : bigarray_t'index(2) ;
    signal idx3 : bigarray_t'index(3) ;

end package ;

--

library vunit_lib;
context vunit_lib.vunit_context;

use work.pack018a.all ;

entity tb_new_attribute_index is
  generic ( runner_cfg : string := runner_cfg_default);
end entity;

architecture tb of tb_new_attribute_index is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-018a: New Attribute - 'INDEX");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
