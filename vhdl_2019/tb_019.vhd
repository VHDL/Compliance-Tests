-- LCS-2016-019: Inferring Constraints from Initial Values for Signals and Variables
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_019

library ieee ;
use ieee.fixed_pkg.all ;

entity e019 is
end entity ;

architecture arch of e019 is

    constant a : sfixed(0 downto -15) := from_string("1001010010010101", 0, -15);
    constant b : sfixed(0 downto -15) := from_string("0010010101010011", 0, -15);

begin

    process
        variable prod : sfixed := a * b ;
    begin
        report to_string(to_real(a)) & "*" & to_string(to_real(b)) & " = " & to_string(to_real(prod)) ;
        wait ;
    end process ;

end architecture ;

--

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_inferring_constraints_from_initial_values_for_signals_and_variables is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_inferring_constraints_from_initial_values_for_signals_and_variables is
begin
  U_e019 : entity work.e019 ;
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-019: Inferring Constraints from Initial Values for Signals and Variables");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
