-- LCS-2016-014a: Access Types to Protected Types and Composites of Protected Types
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_014a
-- TODO

--

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_access_types_to_protected_types_and_composites_of_protected_types is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_access_types_to_protected_types_and_composites_of_protected_types is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    error("LCS-2016-014a: Access Types to Protected Types and Composites of Protected Types");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
