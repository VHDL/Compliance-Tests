-- LCS-2016-041: Record Introspection / Type Reflection
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_041

library std ;
use     std.reflection.all ;

package pack is
    impure function to_string(variable value : value_mirror) return string ;
end package;

package body pack is

    -- can create a string for any value
    impure function to_string(variable value : VALUE_MIRROR) return STRING is
        -- string-ify array elements
        impure function to_string(variable value : ARRAY_VALUE_MIRROR; field_idx, length : INDEX; prefix : STRING) return STRING is
            variable index : index_vector(1 to length);
        begin
            index := (1 => field_idx);
            block
                variable element : value_mirror := value.get(index) ;
                constant element_str : STRING := to_string(element);
             begin
                if field_idx < length - 1 then
                    return to_string(value, field_idx + 1, length, prefix & element_str & ", ");
                elsif field_idx = length - 1 then
                    return prefix & element_str;
                end if;
            end block;
        end function;

        -- string-ify arrays
        impure function to_string(variable value : ARRAY_VALUE_MIRROR) return STRING is
            variable array_type : ARRAY_SUBTYPE_MIRROR;
            variable sm : SUBTYPE_MIRROR ;
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
