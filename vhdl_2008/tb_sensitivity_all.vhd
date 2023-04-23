library ieee;
use ieee.std_logic_1164.all;

entity dut_sensitivity_all is
    Port (
        in_a        : in std_logic;
        in_b        : in std_logic;
        in_c        : in std_logic;
        out_a       : out std_logic
    );
end dut_sensitivity_all;
architecture dut_arch of dut_sensitivity_all is
    signal local_sig : std_logic;
begin
    proc: process(all) begin
        out_a <= in_a and in_b and in_c;
    end process;
end dut_arch;

library vunit_lib ;
context vunit_lib.vunit_context;
library ieee;
use ieee.std_logic_1164.all;

entity tb_sensitivity_all is
  generic ( runner_cfg : string ) ;
end entity;
architecture arch of tb_sensitivity_all is

    signal in_a         : std_logic;
    signal in_b         : std_logic;
    signal in_c         : std_logic;
    signal out_a        : std_logic;

begin
    dut_inst : entity work.dut_sensitivity_all port map (in_a => in_a, in_b => in_b, in_c => in_c, out_a => out_a);

    test_runner : process begin
        in_a <= '1';
        in_b <= '1';
        in_c <= '1';
        test_runner_setup(runner, runner_cfg);
        test_runner_cleanup(runner);
        check_equal(out_a, '1');
        in_c <= '0';
        check_equal(out_a, '0');
        std.env.stop ;
    end process;
end architecture;
