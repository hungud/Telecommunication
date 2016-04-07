CREATE OR REPLACE FUNCTION clob_to_pipeHBNEW(
  year_T IN INTEGER,
  month_t IN INTEGER,
  phone_t IN VARCHAR2
  ) RETURN CALL_TEMP_TAB PIPELINED AS
 -- PRAGMA AUTONOMOUS_TRANSACTION;
--
--#Version=3
--
-- 3. 2014.12.02. Крайнов. Перенос разбора XML, во временную таблицу
-- v.2 Афросин - переделал жесткое указание ID файла, полученного по API на  TO_NUMBER(MS_CONSTANTS.GET_CONSTANT_VALUE ('API_DBF_ID')) DBF_ID
-- v.1 Афросин - поправил обработку строк полученныз их callDate
--
  line_t CALL_TEMP_TYPE:= CALL_TEMP_TYPE(NULL, NULL, NULL, NULL, NULL, NULL, 
                                         NULL, NULL, NULL, NULL, NULL, NULL);
  CURSOR curnm IS
    SELECT phone_t SUBSCR_NO,
           TO_CHAR(CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(UC.callDate), 'yyyymmddhh24miss') CH_SEIZ_DT,
           '' AT_FT_CODE,
           DECODE(REPLACE(UC.callAmt, '.', ','), '0,0', '0', REPLACE(UC.callAmt, '.', ',')) AT_CHG_AMT,
           UC.callNumber CALLING_NO,
           REGEXP_REPLACE(UC.callDuration, ':', '') DURATION,
           DECODE(REPLACE(UC.dataVolume, '.', ','), '0,0', '0', REPLACE(UC.dataVolume, '.', ',')) DATA_VOL,
           '' IMEI,
           '' CELL_ID,
           DECODE(UC.callToNumber, phone_t, '', UC.callToNumber) DIALED_DIG
           --,UC.serviceName serviceName
           ,UC.callType AT_FT_DESC,
           TO_NUMBER(MS_CONSTANTS.GET_CONSTANT_VALUE ('API_DBF_ID')) DBF_ID
      FROM API_GET_UNBILLED_CALLS_LIST UC
      ORDER BY TO_CHAR(CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(UC.callDate), 'yyyymmddhh24miss');
BEGIN
  --
  API_LOAD_UNBILLED_CALLS_LIST(phone_t);
  --
  OPEN curnm;
  LOOP
    FETCH curnm
      INTO line_t.subscr_no,
           line_t.ch_seiz_dt,
           line_t.at_ft_code,
           line_t.at_chg_amt,
           line_t.calling_no,
           line_t.duration,
           line_t.data_vol,
           line_t.imei,
           line_t.cell_id,
           line_t.dialed_dig,
           line_t.at_ft_desc,
           line_t.dbf_id;
    EXIT WHEN curnm%NOTFOUND;
    PIPE ROW (line_t);
  END LOOP;
  CLOSE curnm;
  --
  RETURN;
END;
/
