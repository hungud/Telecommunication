create or replace package USER_UTIL_PKG is

  -- # 1
  -- v.1, S.ISCHEYKIN, 15.02.2016, Пользовательские полезности
  
  --функция конвертации blob в clob  
  function blob_to_clob(blob_in in blob) return clob;

end USER_UTIL_PKG;
/
create or replace package body USER_UTIL_PKG is

  --функция конвертации blob в clob
  function blob_to_clob(blob_in in blob) return clob as
    v_clob    clob;
    v_varchar varchar2(32767);
    v_start   pls_integer := 1;
    v_buffer  pls_integer := 32767;
  begin
    dbms_lob.createtemporary(v_clob, true);
    for i in 1 .. ceil(dbms_lob.getlength(blob_in) / v_buffer) loop
      v_varchar := utl_raw.cast_to_varchar2(dbms_lob.substr(blob_in,
                                                            v_buffer,
                                                            v_start));
      dbms_lob.writeappend(v_clob, length(v_varchar), v_varchar);
      v_start := v_start + v_buffer;
    end loop;
    return v_clob;
  end blob_to_clob;

end USER_UTIL_PKG;
/
