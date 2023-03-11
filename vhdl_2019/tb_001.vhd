-- LCS-2016-001: Partially Connected Vectors on Port Map
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_001
entity e001 is
end entity ;

architecture a of e001 is
    signal not_so_long_vector : bit_vector(15 downto 0);

    component Some_Device is
        port (
            long_port : out bit_vector(31 downto 0)
        );
    end component Some_Device;

begin

    U1 : Some_Device port map(
        long_port(15 downto 0) => not_so_long_vector,
        long_port(31 downto 16) => open
    );

end architecture ;

--

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_partially_connected_vectors_on_port_map is
  generic ( runner_cfg : string := runner_cfg_default);
end entity;

architecture tb of tb_partially_connected_vectors_on_port_map is
begin
  U_e001 : entity work.e001 ;
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-001: Partially Conneted Vectors on Port Map.");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
