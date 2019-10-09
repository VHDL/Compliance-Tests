-- Generic types in entity
entity entity_generic_type is
    generic(
        type mytype;
        function is_good (x: mytype) return boolean
    );
    port(
        data : in  mytype;
        good : out boolean
    );
end entity;

architecture arch of entity_generic_type is
begin
    good <= is_good(data);
end architecture arch;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_entity_generic_type is
    generic(
        runner_cfg : runner_cfg_t
    );
end entity;

architecture tb of tb_entity_generic_type is

    function integer_good (x: integer) return boolean is
    begin
        if x /= 0 then
            return true;
        else
            return false;
        end if;
    end function integer_good;

    signal data : integer;
    signal good : boolean;
    
begin
    uut : entity work.entity_generic_type
        generic map(
            mytype  => integer,
            is_good => integer_good
        )
        port map(
            data => data,
            good => good
        );
        
    main : process
    begin
        test_runner_setup(runner, runner_cfg);
        
        data <= 10;
        wait for 1 ns;
        check_true(good, "Should be true");
        
        data <= 0;
        wait for 1 ns;
        check_false(good, "Should be false");
    
        test_runner_cleanup(runner);
        wait;
    end process main;
  
end architecture tb;
