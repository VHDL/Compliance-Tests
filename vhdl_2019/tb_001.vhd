-- LCS-2016-001: Partially Conneted Vectors on Port Map
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
