-- LCS-2016-030: Garbage Collection
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_030
-- REVIEW
entity e030 is
end entity ;

architecture arch of e030 is

    impure function bigstring return std.textio.line is
    begin
        return new string(1 to 1000000) ;
    end function ;

begin

    tb : process
        variable l : std.textio.line ;
    begin
        for i in 1 to 10000 loop
            l := bigstring ;
        end loop ;
        wait ;
    end process ;

end architecture ;

--

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_garbage_collection is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_garbage_collection is
begin
  U_e030 : entity work.e030 ;
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-030: Garbage Collection");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
