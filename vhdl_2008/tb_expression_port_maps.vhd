entity expression_port_maps is
    Port (
        ina        : in bit;
        outa       : out bit
    );
end expression_port_maps;
architecture dut_arch of expression_port_maps is
begin
    outa <= ina;
end dut_arch;

library vunit_lib ;
context vunit_lib.vunit_context;

entity tb_expression_port_maps is
  generic ( runner_cfg : string ) ;
end entity;
architecture arch of tb_expression_port_maps is

    signal ina          : bit;
    signal inb         : bit;
    signal outa         : bit;

begin
    dut_inst : entity work.expression_port_maps port map (ina => (ina or inb), outa => outa);

    test_runner : process begin
        test_runner_setup(runner, runner_cfg);
        test_runner_cleanup(runner);
        std.env.stop ;
    end process;
end architecture;