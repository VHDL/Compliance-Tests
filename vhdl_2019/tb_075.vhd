-- LCS-2016-075: Closely related record types
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_075
entity test075 is
end entity ;

architecture arch of test075 is

    type a_t is record
        x   :   bit_vector(7 downto 0) ;
        y   :   bit_vector(10 downto 0) ;
        z   :   bit_vector(0 to 10) ;
    end record ;

    type b_t is record
        x   :   bit_vector(7 downto 0) ;
        y   :   bit_vector(10 downto 0) ;
        z   :   bit_vector(0 to 10) ;
    end record ;

    type c_t is record
        x   :   bit_vector(7 downto 0) ;
        y   :   bit_vector(9 downto 0) ;
        z   :   bit_vector(0 to 10) ;
    end record ;

    type d_t is record
        w   :   integer ;
        x   :   bit_vector(7 downto 0) ;
        y   :   bit_vector(10 downto 0) ;
        z   :   bit_vector(0 to 10) ;
    end record ;

    signal ab : a_t ;
    signal ac : a_t ;
    signal ad : a_t ;
    signal b : b_t ;
    signal c : c_t ;
    signal d : d_t ;

begin

    ab <= a_t(b) ; -- valid
    ac <= a_t(c) ; -- invalid - lengths
    --ad <= a_t(d) ; -- invalid - elements

end architecture ;

--

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_closely_related_record_types is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_closely_related_record_types is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-075: Closely Related Record Types");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
