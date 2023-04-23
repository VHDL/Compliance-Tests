library ieee;
use ieee.std_logic_1164.all;

entity expression_port_maps is
    Port (
        ina        : in std_logic;
        outa       : out std_logic
    );
end expression_port_maps;
architecture dut_arch of expression_port_maps is
begin
    outa <= ina;
end dut_arch;

library vunit_lib ;
context vunit_lib.vunit_context;
library ieee;
use ieee.std_logic_1164.all;

entity tb_expression_port_maps is
  generic ( runner_cfg : string ) ;
end entity;
architecture arch of tb_expression_port_maps is

    signal ina          : std_logic;
    signal inb         : std_logic;
    signal outa         : std_logic;

begin
    dut_inst : entity work.expression_port_maps port map (ina => (ina or inb), outa => outa);

    test_runner : process begin
        ina <= '1';
        inb <= '0';
        test_runner_setup(runner, runner_cfg);
        test_runner_cleanup(runner);
        check_equal(outa,'1');
        ina <= '0';
        check_equal(outa,'0');
        std.env.stop ;
    end process;
end architecture;