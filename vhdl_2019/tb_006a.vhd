-- LCS-2016-006a: File IO/TextIO Updates
-- http://www.eda-twiki.org/cgi-bin/view.cgi/P1076/LCS2016_006a

use std.textio.all ;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_fileio_textio_updates is
  generic ( runner_cfg : string );
end entity;

architecture tb of tb_fileio_textio_updates is
begin
  test_runner: process is
    constant fname : string := join(tb_path(runner_cfg), "test006a.txt");
    constant fname2 : string := join(output_path(runner_cfg), "tmp.txt");
    variable status : file_open_status ;
    file f : text ;
  begin
    test_runner_setup(runner, runner_cfg);
    info("LCS-2016-006a: File IO/Text IO Updates");

    file_open(status, f, fname, READ_WRITE_MODE) ;
    assert status = OPEN_OK
      report "Couldn't open file: " & fname
      severity failure ;

    assert file_state(f) = STATE_OPEN
      severity failure ;

    assert file_mode(f) =  READ_WRITE_MODE
      severity failure ;

    assert file_size(f) =  22
      severity failure ;

    assert file_canseek(f) = true
      severity failure ;

    assert file_position(f) = 0
      severity failure ;

    file_seek(f, file_size(f)) ;

    assert file_position(f) = 22
      severity failure ;

    file_rewind(f) ;
    assert file_position(f) = 0
      severity failure ;

    file_close(f) ;

    assert file_state(f) = STATE_CLOSED
      severity failure ;

    file_open(f, fname2, WRITE_MODE);

    file_truncate(f, 20) ;
    assert file_size(f) = 20 severity failure ;

    file_truncate(f, 0) ;
    assert file_size(f) = 0 severity failure ;

    file_close(f);

    test_runner_cleanup(runner);
    wait;
  end process test_runner;
end architecture tb;
