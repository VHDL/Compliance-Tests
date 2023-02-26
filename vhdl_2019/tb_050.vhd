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
        report "VHDL Is Assert Failed                               : " & to_string(IsVhdlAssertFailed) ;
        report "VHDL Is Assert Failed (WARNING)                     : " & to_string(IsVhdlAssertFailed(WARNING)) ;
        report "Assert Count                                        : " & to_string(GetVhdlAssertCount) ;
        report "Assert Count (WARNING)                              : " & to_string(GetVhdlAssertCount(WARNING)) ;
        report "Clearing Assert Count" ;
        ClearVhdlAssert ;
        report "Set VHDL Assert Enable(FALSE)" ;
        SetVhdlAssertEnable(FALSE) ;
        report "Set VHDL Assert Enable(FAILURE, FALSE)" ;
        SetVhdlAssertEnable(FAILURE, FALSE) ;
        report "Get VHDL Assert Enable (FAILURE)                    : " & to_string(GetVhdlAssertEnable(FAILURE)) ;
        report "Set VHDL Assert Format (FAILURE) 'Wacky Failure'    : " ;
        SetVhdlAssertFormat(FAILURE, "Wacky Failure") ;
        report "Get VHDL Assert Format (FAILURE)                    : " & to_string(GetVhdlAssertFormat(FAILURE)) ;
        SetVhdlAssertFormat(WARNING, "Wackier Warning", valid) ;
        report "Set VHDL Assert Format (WARNING) 'Wackier Warning'  : " & to_string(valid) ;
        report "Get VHDL Assert Format (WARNING)                    : " & GetVhdlAssertFormat(WARNING) ;
        SetVhdlReadSeverity(WARNING) ;
        report "Set VHDL Read Severity (WARNING)" ;
        report "Get VHDL Read Severity                              : " & to_string(GetVhdlReadSeverity) ;
        std.env.stop ;
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
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-050: API for Assert");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
