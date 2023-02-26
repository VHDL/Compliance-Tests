-- LCS-2016-016: Anonymous Types
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_016

-- An entity whose type of the formal signal port A is defined by an anonymous type declaration.
entity E1_016 is
  port (
    A : type is private ;   -- any type
    B : type is <>          -- a scalar type
  ) ;
end entity ;

-- The equivalent entity with a formal generic type (here designated
-- as anonymous for clarity) and the signal port A whose type is designated
-- by the unnamed formal generic type.
entity E2_016 is
  generic (
    type Anonymous1 is private ;  -- any type
    type Anonymous2 is <>         -- a scalar type
  ) ;
  port (
    A : Anonymous1 ;
    B : Anonymous2
  ) ;
end entity ;

--

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_anonymous_types is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_anonymous_types is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-016: Anonymous Types");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
