-- LCS-2016-086: All interface lists can be ordered
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_086

entity E086 is
    generic (G1: INTEGER; G2: INTEGER := G1; G3, G4, G5, G6: INTEGER);
    port (P1: STRING(G3 to G4); P2: STRING(P1'RANGE); P3: P1'SUBTYPE);
    procedure X (Y1, Y2: INTEGER; Y3: INTEGER range Y1 to Y2; Y4: Y1'SUBTYPE);
end E086;

--

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_all_interface_lists_can_be_ordered is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_all_interface_lists_can_be_ordered is
begin
  U_e086 : entity work.e086
    generic map (
        G1 => 1,
        G2 => 2,
        G3 => 3,
        G4 => 5,
        G5 => 6,
        G6 => 7
    ) port map (
        P1 => "ab",
        P2 => "cd",
        P3 => "ef"
    ) ;
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-086: All interface lists can be ordered");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
