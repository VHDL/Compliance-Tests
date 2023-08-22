-- LCS-2016-041: Record Introspection / Type Reflection
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_041

library std ;
use     std.reflection.all ;

package pack041 is
    impure function to_string(variable value : value_mirror) return string ;
end package;

package body pack041 is

    -- can create a string for any value
    impure function to_string(variable value : VALUE_MIRROR) return STRING is
        -- string-ify array elements
        impure function to_string(variable value : ARRAY_VALUE_MIRROR;
                                  element_idx, array_length : INDEX;
                                  prefix : STRING ) return STRING is
        begin
            assert element_idx < array_length
                report "Illegal state : index out of bounds" severity FAILURE;
            block
                variable sub : ARRAY_SUBTYPE_MIRROR := value.get_subtype_mirror;
                variable left : INDEX := sub.left;
                variable adj : INDEX :=
                    left + element_idx when sub.ascending else left - element_idx;
                variable elt : VALUE_MIRROR := value.get(adj);
                constant element_str : STRING := to_string(elt);
            begin
                if element_idx < array_length - 1 then
                    return to_string(value, element_idx + 1, array_length,
                                     prefix & element_str & ", ");
                elsif element_idx = array_length - 1 then
                    return prefix & element_str;
                else
                    -- return if continue from out-of-bounds FAILURE
                    return prefix;
                end if;
            end block;
        end function;

        -- string-ify arrays
        impure function to_string(variable value : ARRAY_VALUE_MIRROR) return STRING is
            variable array_type : ARRAY_SUBTYPE_MIRROR;
            variable length : INDEX;
        begin
            array_type := value.get_subtype_mirror;
            length := array_type.length(1);

            if array_type.dimensions /= 1 then
                -- not supported in this example
                report "only 1D arrays are supported" severity FAILURE;
                return INDEX'image(array_type.dimensions) & "D array";
            end if;
            return "(" & to_string(value, 0, length, "") & ")";
        end function;

        -- string-ify record elements
        impure function to_string(variable value : RECORD_VALUE_MIRROR; element_idx : INDEX; prefix : STRING) return STRING is
            variable record_type : RECORD_SUBTYPE_MIRROR;
        begin
            record_type := value.get_subtype_mirror;
            block
                variable element : value_mirror := value.get(element_idx) ;
                constant element_str : STRING := record_type.element_name(element_idx) & " => " & to_string(element);
            begin
                if element_idx < record_type.length - 1 then
                    return to_string(value, element_idx + 1, prefix & element_str & ", ");
                elsif element_idx = record_type.length - 1 then
                    return prefix & element_str;
                end if;
                return element_str ;
            end block;
        end function;

        -- string-ify records
        impure function to_string(variable value : RECORD_VALUE_MIRROR) return STRING is
        begin
            return "(" & to_string(value, 0, "") & ")";
        end function;

        impure function to_string(variable x : enumeration_value_mirror) return string is
        begin
            return x.image ;
        end function ;

        constant class : VALUE_CLASS := value.get_value_class;
    begin
        case class is
            when CLASS_ENUMERATION =>
                block
                    variable enum : enumeration_value_mirror := value.to_enumeration ;
                    variable senum : string := to_string(enum) ;
                begin
                    return senum;
                end block ;
            when CLASS_INTEGER =>
                block
                    variable int : integer_value_mirror := value.to_integer ;
                    variable sint : string := to_string(int.value) ;
                begin
                    return sint;
                end block ;
            when CLASS_FLOATING =>
                block
                    variable float : floating_value_mirror := value.to_floating ;
                begin
                    return to_string(float.value);
                end block ;
            when CLASS_PHYSICAL =>
                block
                    variable phy : physical_value_mirror := value.to_physical ;
                begin
                    return phy.image;
                end block ;
            when CLASS_RECORD =>
                block
                    variable rec : record_value_mirror := value.to_record ;
                begin
                    return to_string(rec);
                end block ;
            when CLASS_ARRAY =>
                block
                    variable arr : array_value_mirror := value.to_array ;
                begin
                    return to_string(arr);
                end block ;
            when CLASS_ACCESS =>
                block
                    variable acc : access_value_mirror := value.to_access ;
                    variable acc_subtype : access_subtype_mirror := acc.get_subtype_mirror ;
                begin
                    return "access type: " & acc_subtype.simple_name;
                end block ;
            when CLASS_FILE =>
                return "file type";
            when CLASS_PROTECTED =>
                return "protected type";
        end case;
    end function;

end package body ;

--

library vunit_lib;
context vunit_lib.vunit_context;

use work.pack041.all ;
use std.reflection.all ;

entity tb_record_introspection_type_reflection is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_record_introspection_type_reflection is
  type rec is record
    x, y : natural;
  end record;

  function to_upper (s : string) return string is
    variable r : string(s'range);
    variable p : integer;
  begin
    for i in s'range loop
      p := character'pos(s(i));
      if p >= 97 and p <= 122 then
        r(i) := character'val(p - 32);
      else
        r(i) := s(i);
      end if;
    end loop;
    return r;
  end function;
begin
  test_runner: process is
    variable n : natural := 42;
    variable r : rec := (1, 2);
    variable a : integer_vector(1 to 3) := (1, 2, 3);
    variable vm : value_mirror;
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-041: Record Introspection/Type Reflection");

    check_equal(to_upper("hEllo"), "HELLO");

    vm := n'reflect;
    check_equal(to_string(vm), "42");

    vm := r'reflect;
    check_equal(to_upper(to_string(vm)), "(X => 1, Y => 2)");

    vm := a'reflect;
    check_equal(to_string(vm), "(1, 2, 3)");

    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
