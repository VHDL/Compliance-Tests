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
  generic ( runner_cfg : string := runner_cfg_default);
end entity;

architecture tb of tb_anonymous_types is

  signal e1_a : bit ;
  signal e1_b : natural range 10 to 20 ;

begin
  U_e1_016 : entity work.e1_016
    port map (
      A => e1_a,
      B => e1_b
    ) ;

  U_e2_016 : entity work.e2_016
    generic map (
      Anonymous1 => e1_a'subtype,
      Anonymous2 => e1_b'subtype
    ) port map (
        A => e1_a,
        B => e1_b
    ) ;
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-016: Anonymous Types");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
