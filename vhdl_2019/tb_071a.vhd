-- LCS-2016-071a: Extra optional semicolon at the end of interface_list
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_071a
entity e071a is
  generic ( g : in natural ; ) ;
  port (
    a   :   in  bit ;
    b   :   out integer ;
  ) ;
end entity ;

architecture test of e071a is
  component comp is
    port ( x : in bit ; ) ;
  end component;

  procedure proc ( p : in integer ; ) is
  begin
  end procedure ;
begin
end architecture;

--

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_extra_optional_semicolon_on_interface_list is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_extra_optional_semicolon_on_interface_list is
  signal a : bit ;
  signal b : integer ;
begin
  U_e071a : entity work.e071a
    port map (
      a => a,
      b => b
    ) ;
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-071a: Extra optional semicolon at the end of interface list");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
