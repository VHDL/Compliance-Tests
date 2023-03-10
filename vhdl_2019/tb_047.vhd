-- LCS-2016-047: Protected Type: Shared Variables on Entity Interface
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_047
package pack047 is

    type prot_t is protected
        impure function status return integer ;
    end protected ;

end package ;

package body pack047 is

    type prot_t is protected body
        variable count : integer ;
        impure function status return integer is
        begin
            count := count + 1 ;
            return count ;
        end function ;
    end protected body ;

end package body ;

entity e047a is
  port (
    variable x : inout work.pack047.prot_t
  ) ;
end entity ;

architecture arch of e047a is

begin

    stuff : process
    begin
        assert to_string(x.status) /= "" severity failure ;
        wait ;
    end process ;

end architecture ;

entity e047b is
  port (
    variable y : inout work.pack047.prot_t
  ) ;
end entity ;

architecture arch of e047b is

begin

    stuff : process
    begin
        assert to_string(y.status) /= "" severity failure ;
        wait ;
    end process ;

end architecture ;

entity test047 is
end entity ;

architecture arch of test047 is

    shared variable var : work.pack047.prot_t ;

begin

    U_e047a : entity work.e047a port map ( x => var ) ;
    U_e047b : entity work.e047b port map ( y => var ) ;

end architecture ;

--

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_protected_type_shared_variables_on_entity_interface is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_protected_type_shared_variables_on_entity_interface is
begin
  U_test047 : entity work.test047 ;
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-047: Protected Type Shared Variables on Entity Interface");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
