entity read_out_port is
    Port (
        ina        : in bit;
        outa       : out bit;
        outb       : out bit
    );
end read_out_port;
architecture dut_arch of read_out_port is
begin
    outa <= ina;
    outb <= outa;
end dut_arch;

library vunit_lib ;
context vunit_lib.vunit_context;

entity tb_read_out_port is
  generic ( runner_cfg : string ) ;
end entity;
architecture arch of tb_read_out_port is

    signal ina          : bit;
    signal outa         : bit;
    signal outb         : bit;

begin
    dut_inst : entity work.read_out_port port map (ina => ina, outa => outa, outb => outb);

    test_runner : process begin
        test_runner_setup(runner, runner_cfg);
        test_runner_cleanup(runner);
        std.env.stop ;
    end process;
end architecture;