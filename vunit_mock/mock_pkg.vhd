library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package mock_pkg is
  signal runner : std_logic;
  subtype runner_cfg_t is string;
  constant runner_cfg_default : string := "";

  procedure test_runner_setup(
    signal runner : inout std_logic;
    constant runner_cfg : in string);

  impure function test_suite return boolean;

  impure function run(constant name : string) return boolean;

  procedure test_runner_cleanup(
    signal runner : inout std_logic;
    external_failure : boolean := false;
    allow_disabled_errors : boolean := false;
    allow_disabled_failures : boolean := false;
    fail_on_warning : boolean := false);

  procedure test_runner_watchdog(
    signal runner : inout std_logic;
    constant timeout : in time;
    constant do_runner_cleanup : boolean := true);

  procedure check(
    constant expr : in boolean;
    constant msg : in string := "");
  alias check_true is check[boolean, string];

  procedure check_false(
    constant expr : in boolean;
    constant msg : in string := "");

  procedure check_passed(constant msg : in string := "");
  procedure check_failed(constant msg : in string := "");

  procedure check_equal(
    constant got         : in unsigned;
    constant expected    : in std_logic_vector;
    constant msg         : in string := "");

  procedure check_equal(
    constant got         : in std_logic_vector;
    constant expected    : in unsigned;
    constant msg         : in string := "");

  procedure check_equal(
    constant got         : in std_logic;
    constant expected    : in boolean;
    constant msg         : in string := "");

  procedure check_equal(
    constant got         : in boolean;
    constant expected    : in std_logic;
    constant msg         : in string := "");

  procedure info(constant msg : in string);

  function result(msg : string) return string;

  type mock_state_t is protected
    procedure completed_test_case(name : string);
    impure function has_completed(name : string) return boolean;
    procedure set_test_suite_done(value : boolean);
    impure function get_test_suite_done return boolean;
  end protected;

end package;

package body mock_pkg is
  type mock_state_t is protected body
    variable signatures : integer_vector(0 to 100);
    variable n_signatures : natural := 0;
    variable test_suite_done : boolean := false;

    procedure set_test_suite_done(value : boolean) is
    begin
      test_suite_done := value;
    end;

    impure function get_test_suite_done return boolean is
    begin
      return test_suite_done;
    end;

    -- DJB2 hash
    impure function hash (
      str : string
    ) return natural is
      variable value : natural := 5381;
    begin
      for i in str'range loop
        value := (33*value + character'pos(str(i))) mod 2**(31-6);
      end loop;
      return value;
    end;

    procedure completed_test_case(name : string) is
    begin
      signatures(n_signatures) := hash(name);
      n_signatures := n_signatures + 1;
    end;

    impure function has_completed(name : string) return boolean is
      constant name_hash : natural := hash(name);
    begin
      for idx in 0 to n_signatures - 1 loop
        if signatures(idx) = name_hash then
          return true;
        end if;
      end loop;

      return false;
    end;
  end protected body;

  shared variable mock_state : mock_state_t;

  procedure test_runner_setup(
    signal runner : inout std_logic;
    constant runner_cfg : in string) is
  begin
    report "You're using a mock of VUnit that does not represent true VUnit behavior." severity warning;
  end;

  impure function test_suite return boolean is
  begin
    if mock_state.get_test_suite_done then
      return false;
    end if;

    mock_state.set_test_suite_done(true);
    return true;
  end;

  impure function run(constant name : string) return boolean is
  begin
    if mock_state.has_completed(name) then
      return false;
    end if;

    report "Running test case: " & name;
    mock_state.completed_test_case(name);
    mock_state.set_test_suite_done(false);
    return true;
  end;

  procedure test_runner_cleanup(
    signal runner : inout std_logic;
    external_failure : boolean := false;
    allow_disabled_errors : boolean := false;
    allow_disabled_failures : boolean := false;
    fail_on_warning : boolean := false) is
  begin
    report "Simulation ended. Inspect the log for any errors.";
    std.env.stop(0);
  end;

  procedure test_runner_watchdog(
    signal runner : inout std_logic;
    constant timeout : in time;
    constant do_runner_cleanup : boolean := true) is
  begin
    wait;
  end;

  procedure check(
    constant expr : in boolean;
    constant msg : in string := "") is
  begin
    assert expr report msg;
  end;

  procedure check_false(
    constant expr : in boolean;
    constant msg : in string := "") is
  begin
    assert not expr report msg;
  end;

  procedure check_passed(constant msg : in string := "") is
  begin
  end;

  procedure check_failed(constant msg : in string := "") is
  begin
    assert false report msg;
  end;

  procedure check_equal(
    constant got         : in unsigned;
    constant expected    : in std_logic_vector;
    constant msg         : in string := "") is
  begin
    assert std_logic_vector(got) = expected report msg;
  end;

  procedure check_equal(
    constant got         : in std_logic_vector;
    constant expected    : in unsigned;
    constant msg         : in string := "") is
  begin
    assert got = std_logic_vector(expected) report msg;
  end;

  procedure check_equal(
    constant got         : in std_logic;
    constant expected    : in boolean;
    constant msg         : in string := "") is
  begin
    assert (got = '1') = expected report msg;
  end;

  procedure check_equal(
    constant got         : in boolean;
    constant expected    : in std_logic;
    constant msg         : in string := "") is
  begin
    assert got = (expected = '1') report msg;
  end;

  procedure info(constant msg : in string) is
  begin
    report msg;
  end;

  function result(msg : string) return string is
  begin
    return msg;
  end;


end package body;