entity dut_sensitivity_all is
    Port (
        in_a        : in bit;
        in_b        : in bit;
        in_c        : in bit;
        out_a       : out bit
    );
end dut_sensitivity_all;
architecture dut_arch of dut_sensitivity_all is
    signal local_sig : bit;
begin
    proc: process(all) begin
        out_a <= in_a and in_b and in_c;
    end process;
end dut_arch;

library vunit_lib ;
context vunit_lib.vunit_context;

entity tb_sensitivity_all is
  generic ( runner_cfg : string ) ;
end entity;
architecture arch of tb_sensitivity_all is

    signal in_a         : bit;
    signal in_b         : bit;
    signal in_c         : bit;
    signal out_a        : bit;

begin
    dut_inst : entity work.dut_sensitivity_all port map (in_a => in_a, in_b => in_b, in_c => in_c, out_a => out_a);

    test_runner : process begin
        test_runner_setup(runner, runner_cfg);
        test_runner_cleanup(runner);
        std.env.stop ;
    end process;
end architecture;
