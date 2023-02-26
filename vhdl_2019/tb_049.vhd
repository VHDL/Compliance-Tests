-- LCS-2016-049: Map Generics on Subprogram Call
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_049
package pack049 is
    function generic_mux4
      generic (
        type paramtype
      ) parameter (
        sel : natural range 0 to 3;
        a   : paramtype ;
        b, c, d : a'subtype ;
      ) return a'subtype ;
end package ;

package body pack049 is

    function generic_mux4
      generic (
        type paramtype
      ) parameter (
        sel : natural range 0 to 3;
        a   : paramtype ;
        b, c, d : a'subtype ;
      ) return a'subtype is
      variable rv : a'subtype ;
    begin
        case sel is
            when 0 => rv := a ;
            when 1 => rv := b ;
            when 2 => rv := c ;
            when 3 => rv := d ;
        end case ;
        return rv ;
    end function ;

end package body ;

use work.pack049.generic_mux4 ;

entity e049 is
end entity ;

architecture arch of e049 is

    signal sel : natural range 0 to 3 ;

    signal bv_a : bit_vector(7 downto 0) ;
    signal bv_b : bit_vector(7 downto 0) ;
    signal bv_c : bit_vector(7 downto 0) ;
    signal bv_d : bit_vector(7 downto 0) ;

    signal bv_sel : bit_vector(7 downto 0) ;

    signal int_a : integer ;
    signal int_b : integer ;
    signal int_c : integer ;
    signal int_d : integer ;

    signal int_sel : integer ;

begin

    process
    begin
        bv_sel <= generic_mux4 generic map(bv_sel'subtype)(sel, bv_a, bv_b, bv_c, bv_d) ;
        int_sel <= generic_mux4 generic map(int_sel'subtype)(sel, int_a, int_b, int_c, int_d) ;
        std.env.stop ;
    end process ;

end architecture ;

--

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_map_generics_on_subprogram_call is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_map_generics_on_subprogram_call is
begin
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-049: Map Generics on Subprogram Call");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
