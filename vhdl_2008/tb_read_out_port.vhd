library ieee;
use ieee.std_logic_1164.all;

entity read_out_port is
    Port (
        ina        : in std_logic;
        outa       : out std_logic;
        outb       : out std_logic
    );
end read_out_port;
architecture dut_arch of read_out_port is
begin
    outa <= ina;
    outb <= not outa;
end dut_arch;

library vunit_lib ;
context vunit_lib.vunit_context;
library ieee;
use ieee.std_logic_1164.all;

entity tb_read_out_port is
  generic ( runner_cfg : string ) ;
end entity;
architecture arch of tb_read_out_port is

    signal ina          : std_logic;
    signal outa         : std_logic;
    signal outb         : std_logic;

begin
    dut_inst : entity work.read_out_port port map (ina => ina, outa => outa, outb => outb);

    test_runner : process begin
        ina <= '1';
        test_runner_setup(runner, runner_cfg);
        test_runner_cleanup(runner);
        check_equal(outa, '1');
        check_equal(outb, '0');
        std.env.stop ;
    end process;
end architecture;