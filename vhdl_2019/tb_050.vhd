-- LCS-2016-050: API for Assert
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_050
use std.env.all ;

entity e050 is
end entity ;

architecture arch of e050 is

begin

    tb : process
        variable valid : boolean ;
    begin
        assert IsVhdlAssertFailed = false severity failure ;
        assert IsVhdlAssertFailed(WARNING) = false severity failure ;
        assert GetVhdlAssertCount = 0 severity failure ;
        assert GetVhdlAssertCount(WARNING) = 0 severity failure ;
        ClearVhdlAssert ;
        SetVhdlAssertEnable(FALSE) ;
        SetVhdlAssertEnable(FAILURE, FALSE) ;
        assert GetVhdlAssertEnable(FAILURE) = false severity failure ;
        SetVhdlAssertFormat(FAILURE, "Wacky Failure") ;
        assert GetVhdlAssertFormat(FAILURE) /= "" severity failure ;
        SetVhdlAssertFormat(WARNING, "Wackier Warning", valid) ;
        assert valid = false severity failure ;
        assert GetVhdlAssertFormat(WARNING) /= "" severity failure ;
        SetVhdlReadSeverity(WARNING) ;
        assert GetVhdlReadSeverity = failure severity failure ;
        wait ;
    end process ;

end architecture ;

--

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_api_for_assert is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_api_for_assert is
begin
  U_e050 : entity work.e050 ;
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-050: API for Assert");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
