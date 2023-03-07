-- LCS-2016-059: Array Type Generics
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_059
package P1_059 is
  generic (
    type element_type is private;                         -- any type
    type index_type is (<>);                              -- a discrete type
    type array_type is array(index_type) of element_type  -- an array type
  );
end package;

entity E_059 is
end entity;

architecture A1 of E_059 is
  package I1 is new work.P1_059
    generic map (
      element_type => bit,
      index_type =>   natural,
      array_type =>   bit_vector
    );
begin
end architecture;

package P2_059 is
  generic (
    -- type anonymous is (<>);              -- implicitly declared anonymous generic discrete type
    -- type anonymous is private;           -- implicitly declared anonymous unclassified generic type
    type array_type is array(type is (<>)) of type is private
  );
  -- example usage of type aliases to create shorter names
  alias index_type   is array_type'INDEX;    -- alias the implicit type with a name
  alias element_type is array_type'ELEMENT;  -- alias the implicit type with a name
end package;

architecture A2 of E_059 is
  package I2 is new work.P2_059
    generic map (
      -- anonymous => bit_vector'INDEX,   -- implicitly associated; see 6.5.7.2
      -- anonymous => bit_vector'ELEMENT, -- implicitly associated; see 6.5.7.2
      array_type =>   bit_vector
    );
begin
end architecture;

package P3_059 is
  generic (
    type designated_subtype;                       -- any type
    type access_type is access designated_subtype  -- an access type
  );
end package;

architecture A3 of E_059 is
  package I1 is new work.P3_059
    generic map (
      designated_subtype => string,
      access_type        => std.textio.line
    );
begin
end architecture;

package P4_059 is
  generic (
    -- type anonymous is private;                    -- implicitly declared unclassified generic type
    type access_type is access type is private
  );
  -- example usage of type aliases to create shorter names
  alias designated_subtype is access_type'DESIGNATED_SUBTYPE;  -- alias the implicit type with a name
end package;

architecture A4 of E_059 is
  package I2 is new work.P4_059
    generic map (
      -- anonymous => line'DESIGNATED_SUBTYPE, -- implicitly associated; see 6.5.7.2
      access_type => std.textio.line
    );
begin
end architecture;

package P5_059 is
  generic (
    type designated_subtype;                      -- any type
    type file_type is file of designated_subtype  -- an file type
  );
end package;

architecture A5 of E_059 is
  package I1 is new work.P5_059
    generic map (
      designated_subtype => string,
      file_type          =>  std.textio.line
    );
begin
end architecture;

package P6_059 is
  generic (
    -- type anonymous is private;                    -- implicitly declared unclassified generic type
    type file_type is file of type is private
  );
  -- example usage of type aliases to create shorter names
  alias designated_subtype is file_type'DESIGNATED_SUBTYPE;  -- alias the implicit type with a name
end package;

architecture A6 of E_059 is
  package I2 is new work.P6_059
    generic map (
      -- anonymous => line'DESIGNATED_SUBTYPE, -- implicitly associated; see 6.5.7.2
      file_type => std.textio.line
    );
begin
end architecture;

--

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_array_type_generics is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_array_type_generics is
begin
  U_e059a0 : entity work.e_059(a0) ;
  U_e059a1 : entity work.e_059(a1) ;
  U_e059a2 : entity work.e_059(a2) ;
  U_e059a3 : entity work.e_059(a3) ;
  U_e059a4 : entity work.e_059(a4) ;
  U_e059a5 : entity work.e_059(a5) ;
  U_e059a6 : entity work.e_059(a6) ;
  test_runner: process is
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-059: Array type generics");
    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
