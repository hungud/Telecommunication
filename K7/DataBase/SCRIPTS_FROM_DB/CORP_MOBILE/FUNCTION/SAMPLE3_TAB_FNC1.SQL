
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."SAMPLE3_TAB_FNC1" (namef IN varchar2)
return sample3_typ_tab PIPELINED AS
 vSFile   utl_file.file_type;
 vNewLine VARCHAR2(4000);
 vNewLine1 VARCHAR2(4000);
BEGIN
  --351499854_20120829-061219.csv
  vSFile := utl_file.fopen('TEMPB', namef,'r');

  IF utl_file.is_open(vSFile) THEN
    LOOP
      BEGIN
        utl_file.get_line(vSFile, vNewLine);

        IF vNewLine IS NULL THEN
          EXIT;
        END IF;
select
to_char(to_date(rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,6),';'),'yyyymmddhh24miss'),'dd.mm.yyyy'||chr(9)||'hh24:mi:ss')||
chr(9)||to_char(to_date(substr(rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,46),';'),-6),'hh24miss'),'hh24:mi:ss')||
chr(9)||decode(rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,85),';'),rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,5),';'),'',rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,85),';'))||
chr(9)||nvl((select sv.feature_de from services sv
      where sv.feature_co=rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,13),';')),rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,141),';'))||
chr(9)||decode(nvl((select sv.descriptio from services sv
      where sv.feature_co=rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,13),';')),rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,141),';')),'GPRS internet','GPRS-Internet',
      'Звонок на спец номер (О)','исх/доп.сервис','MMS for HLR','MMS',nvl((select sv.descriptio from services sv
      where sv.feature_co=rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,13),';')),rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,141),';')))||
chr(9)||rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,32),';')||
chr(9)||substr(rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,27),';'),0,instr(rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,27),';'),',00')-1)||
chr(9)||rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,49),';')||
chr(9)||rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,74),';')||
chr(9)||nvl((select mn.mn_unlim_group from MN_UNLIM_SERVICES mn
      where mn.feature_co=rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,13),';')),0) into vNewLine1 from (
select vNewLine str
from dual);
PIPE ROW ( sample3_typ(vNewLine1));
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          EXIT;
      END;
    END LOOP;
    COMMIT;
  END IF;
  utl_file.fclose(vSFile);
--  utl_file.frename('TEMPB', '123.txt', 'TEMPB', 'x.txt', TRUE);
EXCEPTION
  WHEN utl_file.invalid_mode THEN
    RAISE_APPLICATION_ERROR (-20051, 'Invalid Mode Parameter');
  WHEN utl_file.invalid_path THEN
    RAISE_APPLICATION_ERROR (-20052, 'Invalid File Location');
  WHEN utl_file.invalid_filehandle THEN
    RAISE_APPLICATION_ERROR (-20053, 'Invalid Filehandle');
  WHEN utl_file.invalid_operation THEN
    RAISE_APPLICATION_ERROR (-20054, 'Invalid Operation');
  WHEN utl_file.read_error THEN
    RAISE_APPLICATION_ERROR (-20055, 'Read Error');
    utl_file.fclose(vSFile);
  WHEN utl_file.internal_error THEN
    RAISE_APPLICATION_ERROR (-20057, 'Internal Error');
  WHEN utl_file.charsetmismatch THEN
    RAISE_APPLICATION_ERROR (-20058, 'Opened With FOPEN_NCHAR
    But Later I/O Inconsistent');
  WHEN utl_file.file_open THEN
    RAISE_APPLICATION_ERROR (-20059, 'File Already Opened');
  WHEN utl_file.invalid_maxlinesize THEN
    RAISE_APPLICATION_ERROR(-20060,'Line Size Exceeds 32K');
  WHEN utl_file.invalid_filename THEN
    RAISE_APPLICATION_ERROR (-20061, 'Invalid File Name');
  WHEN utl_file.access_denied THEN
    RAISE_APPLICATION_ERROR (-20062, 'File Access Denied By');
  WHEN utl_file.invalid_offset THEN
    RAISE_APPLICATION_ERROR (-20063,'FSEEK Param Less Than 0');
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR (-20099, 'Unknown UTL_FILE Error');
END;
