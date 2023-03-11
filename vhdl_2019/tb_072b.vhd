-- LCS-2016-072b: Function knows return vector size
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_072b
package pack072b is

    function resize(x : bit_vector) return rv_t of bit_vector ;

end package ;

package body pack072b is

    function resize(x : bit_vector) return rv_t of bit_vector is
        alias xa : bit_vector(x'high downto 0) is x ;
        variable rv : rv_t ;
    begin
        if x'length > rv'length then
            for idx in rv'range loop
                rv(idx) := x(idx) ;
            end loop ;
        else
            for idx in x'range loop
                rv(idx) := x(idx) ;
            end loop ;
        end if ;
        return rv ;
    end function ;

end package body ;

--

library vunit_lib;
context vunit_lib.vunit_context;

use work.pack072b.all ;

entity tb_function_knows_return_vector_size is
  generic ( runner_cfg : string := runner_cfg_default);
end entity;

architecture tb of tb_function_knows_return_vector_size is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-072b: Function knows return vector size");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
