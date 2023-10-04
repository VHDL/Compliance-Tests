-- LCS-2016-032: PATH_NAME and Shared Variables and Subprograms
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_032
-- REVIEW
package pack032 is

    type type_t is protected
        procedure increment ;
    end protected ;

end package ;

package body pack032 is

    type type_t is protected body
        variable value : natural ;
        procedure increment is
            constant vpath : string := value'path_name ;
            constant vinst : string := value'instance_name ;
        begin
            assert vpath = ":tb_path_name_and_shared_variables_and_subprograms:u_e032:tb:t:value" report vpath severity failure ;
            assert vinst = ":tb_path_name_and_shared_variables_and_subprograms(tb):u_e032@e032(arch):tb:t:value" report vinst severity failure ;
            value := value + 1 ;
        end procedure ;
    end protected body ;

end package body ;

entity e032 is
end entity ;

architecture arch of e032 is

begin

    tb : process
        variable t : work.pack032.type_t ;
    begin
        t.increment ;
        wait ;
    end process ;

end architecture ;

--

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_path_name_and_shared_variables_and_subprograms is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_path_name_and_shared_variables_and_subprograms is
begin
  U_e032 : entity work.e032 ;
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-032: PATH_NAME and Shared Variables and Subprograms");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
