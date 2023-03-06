entity dut is
    Port (
        clk        : in bit
    );
end dut;
architecture dut_arch of dut is
    signal local_sig : bit;
begin
    proc: process begin
        local_sig <= '0';
        wait for 50 ns;
        local_sig <= '1';
    end process;
end dut_arch;

library vunit_lib ;
context vunit_lib.vunit_context;

entity tb_external_names is
  generic ( runner_cfg : string ) ;
end entity;
architecture arch of tb_external_names is

    signal clk        : bit;
    signal tb_sig     : bit;

begin
    dut_inst : entity work.dut port map (clk => clk);

    test_runner : process begin
        test_runner_setup(runner, runner_cfg);
        tb_sig <= << signal .tb_external_names.dut_inst.local_sig : bit >>;
        test_runner_cleanup(runner);
        std.env.stop ;
    end process;
end architecture;

