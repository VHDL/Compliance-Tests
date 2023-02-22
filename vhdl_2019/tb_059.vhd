-- LCS-2016-059: Array Type Generics
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_059
package P1 is
  generic (
    type element_type is private;                         -- any type
    type index_type is (<>);                              -- a discrete type
    type array_type is array(index_type) of element_type  -- an array type
  );
end package;

entity E is
end entity;

architecture A1 of E is
  package I1 is new work.P1
    generic map (
      element_type => bit,
      index_type =>   natural,
      array_type =>   bit_vector
    );
begin
end architecture;

package P2 is
  generic (
    -- type anonymous is (<>);              -- implicitly declared anonymous generic discrete type
    -- type anonymous is private;           -- implicitly declared anonymous unclassified generic type
    type array_type is array(type is (<>)) of type is private
  );
  -- example usage of type aliases to create shorter names
  alias index_type   is array_type'INDEX;    -- alias the implicit type with a name
  alias element_type is array_type'ELEMENT;  -- alias the implicit type with a name
end package;

architecture A2 of E is
  package I2 is new work.P2
    generic map (
      -- anonymous => bit_vector'INDEX,   -- implicitly associated; see 6.5.7.2
      -- anonymous => bit_vector'ELEMENT, -- implicitly associated; see 6.5.7.2
      array_type =>   bit_vector
    );
begin
end architecture;

package P3 is
  generic (
    type designated_subtype;                       -- any type
    type access_type is access designated_subtype  -- an access type
  );
end package;

architecture A3 of E is
  package I1 is new work.P3
    generic map (
      designated_subtype => string,
      access_type        => std.textio.line
    );
begin
end architecture;

package P4 is
  generic (
    -- type anonymous is private;                    -- implicitly declared unclassified generic type
    type access_type is access type is private
  );
  -- example usage of type aliases to create shorter names
  alias designated_subtype is access_type'DESIGNATED_SUBTYPE;  -- alias the implicit type with a name
end package;

architecture A4 of E is
  package I2 is new work.P4
    generic map (
      -- anonymous => line'DESIGNATED_SUBTYPE, -- implicitly associated; see 6.5.7.2
      access_type => std.textio.line
    );
begin
end architecture;

package P5 is
  generic (
    type designated_subtype;                      -- any type
    type file_type is file of designated_subtype  -- an file type
  );
end package;

architecture A5 of E is
  package I1 is new work.P5
    generic map (
      designated_subtype => string,
      file_type          =>  std.textio.line
    );
begin
end architecture;

package P6 is
  generic (
    -- type anonymous is private;                    -- implicitly declared unclassified generic type
    type file_type is file of type is private
  );
  -- example usage of type aliases to create shorter names
  alias designated_subtype is file_type'DESIGNATED_SUBTYPE;  -- alias the implicit type with a name
end package;

architecture A6 of E is
  package I2 is new work.P6
    generic map (
      -- anonymous => line'DESIGNATED_SUBTYPE, -- implicitly associated; see 6.5.7.2
      file_type => std.textio.line
    );
begin
end architecture;

