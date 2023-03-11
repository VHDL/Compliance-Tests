library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all;

package check_equal_pkg is
  procedure check_equal(
    constant got         : in unsigned;
    constant expected    : in unsigned;
    constant msg         : in string := "");

  procedure check_equal(
    constant got         : in unsigned;
    constant expected    : in natural;
    constant msg         : in string := "");

  procedure check_equal(
    constant got         : in natural;
    constant expected    : in unsigned;
    constant msg         : in string := "");

  procedure check_equal(
    constant got         : in std_logic_vector;
    constant expected    : in std_logic_vector;
    constant msg         : in string := "");

  procedure check_equal(
    constant got         : in std_logic_vector;
    constant expected    : in natural;
    constant msg         : in string := "");

  procedure check_equal(
    constant got         : in natural;
    constant expected    : in std_logic_vector;
    constant msg         : in string := "");

  procedure check_equal(
    constant got         : in signed;
    constant expected    : in signed;
    constant msg         : in string := "");

  procedure check_equal(
    constant got         : in signed;
    constant expected    : in integer;
    constant msg         : in string := "");

  procedure check_equal(
    constant got         : in integer;
    constant expected    : in signed;
    constant msg         : in string := "");

  procedure check_equal(
    constant got         : in integer;
    constant expected    : in integer;
    constant msg         : in string := "");

  procedure check_equal(
    constant got         : in std_logic;
    constant expected    : in std_logic;
    constant msg         : in string := "");

  procedure check_equal(
    constant got         : in boolean;
    constant expected    : in boolean;
    constant msg         : in string := "");

  procedure check_equal(
    constant got         : in string;
    constant expected    : in string;
    constant msg         : in string := "");

  procedure check_equal(
    constant got         : in character;
    constant expected    : in character;
    constant msg         : in string := "");

  procedure check_equal(
    constant got         : in time;
    constant expected    : in time;
    constant msg         : in string := "");

end package;

package body check_equal_pkg is
  procedure check_equal(
    constant got         : in unsigned;
    constant expected    : in unsigned;
    constant msg         : in string := "") is
  begin
    assert got = expected report msg;
  end;

  procedure check_equal(
    constant got         : in unsigned;
    constant expected    : in natural;
    constant msg         : in string := "") is
  begin
    assert got = expected report msg;
  end;

  procedure check_equal(
    constant got         : in natural;
    constant expected    : in unsigned;
    constant msg         : in string := "") is
  begin
    assert got = expected report msg;
  end;

  procedure check_equal(
    constant got         : in std_logic_vector;
    constant expected    : in std_logic_vector;
    constant msg         : in string := "") is
  begin
    assert got = expected report msg;
  end;

  procedure check_equal(
    constant got         : in std_logic_vector;
    constant expected    : in natural;
    constant msg         : in string := "") is
  begin
    assert got = expected report msg;
  end;

  procedure check_equal(
    constant got         : in natural;
    constant expected    : in std_logic_vector;
    constant msg         : in string := "") is
  begin
    assert got = expected report msg;
  end;

  procedure check_equal(
    constant got         : in signed;
    constant expected    : in signed;
    constant msg         : in string := "") is
  begin
    assert got = expected report msg;
  end;

  procedure check_equal(
    constant got         : in signed;
    constant expected    : in integer;
    constant msg         : in string := "") is
  begin
    assert got = expected report msg;
  end;

  procedure check_equal(
    constant got         : in integer;
    constant expected    : in signed;
    constant msg         : in string := "") is
  begin
    assert got = expected report msg;
  end;

  procedure check_equal(
    constant got         : in integer;
    constant expected    : in integer;
    constant msg         : in string := "") is
  begin
    assert got = expected report msg;
  end;

  procedure check_equal(
    constant got         : in std_logic;
    constant expected    : in std_logic;
    constant msg         : in string := "") is
  begin
    assert got = expected report msg;
  end;

  procedure check_equal(
    constant got         : in boolean;
    constant expected    : in boolean;
    constant msg         : in string := "") is
  begin
    assert got = expected report msg;
  end;

  procedure check_equal(
    constant got         : in string;
    constant expected    : in string;
    constant msg         : in string := "") is
  begin
    assert got = expected report msg;
  end;

  procedure check_equal(
    constant got         : in character;
    constant expected    : in character;
    constant msg         : in string := "") is
  begin
    assert got = expected report msg;
  end;

  procedure check_equal(
    constant got         : in time;
    constant expected    : in time;
    constant msg         : in string := "") is
  begin
    assert got = expected report msg;
  end;

end package body;
