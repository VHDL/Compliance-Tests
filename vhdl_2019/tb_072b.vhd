-- LCS-2016-072b: Function knows return vector size
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_072b
library ieee ;
use ieee.std_logic_1164.all ;

package pack072b is

    function resize(x : std_logic_vector) return rv_t of std_logic_vector ;

end package ;

package body pack072b is

    function resize(x : std_logic_vector) return rv_t of std_logic_vector is
        alias xa : std_logic_vector(x'length - 1 downto 0) is x ;
        variable rv : rv_t  := (others => '0') ;
        alias ra : std_logic_vector(rv'length - 1 downto 0) is rv ;
    begin
        if rv'length < x'length then
            ra(ra'left downto 0) := xa(ra'left downto 0) ;
        else
            ra(ra'left downto xa'left + 1) := (others => '0') ;
            ra(xa'left downto 0) := x ;
        end if ;
        return rv ;
    end function ;

end package body ;

--

library vunit_lib;
context vunit_lib.vunit_context;

use work.pack072b.all ;

library ieee;
use ieee.std_logic_1164.all;

entity tb_function_knows_return_vector_size is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_function_knows_return_vector_size is
begin
  test_runner: process is
    variable v1 : std_logic_vector(1 to 3);
    variable v2 : std_logic_vector(1 to 0);
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-072b: Function knows return vector size");

    v1 := resize("1010101");
    check_equal(v1, std_logic_vector'("101"));
    v2 := resize("1111");
    check_equal(v2, std_logic_vector'(1 to 0 => '0'));
    v1 := resize("1");
    check_equal(v1, std_logic_vector'("001"));

    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
