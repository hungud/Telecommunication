
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."GET_LAST_ACC_LOAD_LOGS_ERRORS" (
  pACCOUNT_ID IN INTEGER,
  pACCOUNT_LOAD_TYPE_ID INTEGER
  ) RETURN VARCHAR2 IS
--
--#Version=1
--
-- Клеит одну строку из последних ошибок загрузок для лицевого счета и типа загрузки
--
  CURSOR C IS
    SELECT * FROM (
      select /*+ FIRST_ROWS */
        to_char(load_date_time, 'dd.mm hh24:mi') || ' '||NVL(error_text, 'OK') AS ERROR_TEXT
      from account_load_logs
      where account_id=pACCOUNT_ID
      and account_load_type_id=pACCOUNT_LOAD_TYPE_ID
      and load_date_time > sysdate-1
      ORDER BY load_date_time DESC
    )
    WHERE ROWNUM < 10;
  vRESULT VARCHAR2(32000);
BEGIN
  FOR REC IN C LOOP
    vRESULT := vRESULT || REC.ERROR_TEXT || '   '; 
  END LOOP;
  RETURN SUBSTR(NVL(vRESULT, '---'), 1, 2000);
END; 