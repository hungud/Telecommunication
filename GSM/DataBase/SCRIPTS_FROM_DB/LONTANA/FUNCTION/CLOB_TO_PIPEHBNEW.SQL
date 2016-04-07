
  CREATE OR REPLACE FUNCTION "LONTANA"."CLOB_TO_PIPEHBNEW" (year_T    IN INTEGER,
                                              month_t   IN INTEGER,
                                              phone_t   IN VARCHAR2)
   RETURN CALL_TEMP_TAB
   PIPELINED
AS
--
--#Version= 2
--
-- v.2 Афросин - переделал жесткое указание ID файла, полученного по API на  TO_NUMBER(MS_CONSTANTS.GET_CONSTANT_VALUE ('API_DBF_ID')) DBF_ID
--
-- v.1 Афросин - поправил обработку строк полученныз их callDate
--
   line_t     CALL_TEMP_TYPE
                 := CALL_TEMP_TYPE (NULL,
                                    NULL,
                                    NULL,
                                    NULL,
                                    NULL,
                                    NULL,
                                    NULL,
                                    NULL,
                                    NULL,
                                    NULL,
                                    NULL,
                                    NULL);
   pbsal_id   VARCHAR2 (20);

   CURSOR curnm
   IS
      WITH xmltable1
           AS (SELECT t.soap_answer
                 FROM BEELINE_SOAP_API_LOG t
                WHERE t.bsal_id = TO_NUMBER (pbsal_id))
        SELECT t2.phone SUBSCR_NO,
               TO_CHAR (
                  CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(
                     EXTRACTVALUE (VALUE (d), 'UnbilledCallsList/callDate')),
                  'yyyymmddhh24miss')
                  CH_SEIZ_DT,
               '' AT_FT_CODE,
               DECODE (
                  REPLACE (
                     EXTRACTVALUE (VALUE (d), 'UnbilledCallsList/callAmt'),
                     '.',
                     ','),
                  '0,0', '0',
                  REPLACE (
                     EXTRACTVALUE (VALUE (d), 'UnbilledCallsList/callAmt'),
                     '.',
                     ','))
                  AT_CHG_AMT,
               EXTRACTVALUE (VALUE (d), 'UnbilledCallsList/callNumber')
                  CALLING_NO,
               REGEXP_REPLACE (
                  EXTRACTVALUE (VALUE (d), 'UnbilledCallsList/callDuration'),
                  ':',
                  '')
                  DURATION,
               DECODE (
                  REPLACE (
                     EXTRACTVALUE (VALUE (d), 'UnbilledCallsList/dataVolume'),
                     '.',
                     ','),
                  '0,0', '0',
                  REPLACE (
                     EXTRACTVALUE (VALUE (d), 'UnbilledCallsList/dataVolume'),
                     '.',
                     ','))
                  DATA_VOL,
               '' IMEI,
               '' CELL_ID,
               DECODE (
                  EXTRACTVALUE (VALUE (d), 'UnbilledCallsList/callToNumber'),
                  t2.phone, '',
                  EXTRACTVALUE (VALUE (d), 'UnbilledCallsList/callToNumber'))
                  DIALED_DIG--,extractvalue (value(d) ,'UnbilledCallsList/serviceName') serviceName
               ,
               EXTRACTVALUE (VALUE (d), 'UnbilledCallsList/callType')
                  AT_FT_DESC,
               TO_NUMBER(MS_CONSTANTS.GET_CONSTANT_VALUE ('API_DBF_ID')) DBF_ID
          FROM xmltable1 t1,
               TABLE (
                  XMLSEQUENCE (
                     t1.soap_answer.EXTRACT (
                        'S:Envelope/S:Body/ns0:getUnbilledCallsListResponse/UnbilledCallsList',
                        'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"'))) d,
               BEELINE_SOAP_API_LOG t2
         WHERE t2.bsal_id = TO_NUMBER (pbsal_id)
      ORDER BY TO_CHAR (
                  CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(
                     EXTRACTVALUE (VALUE (d), 'UnbilledCallsList/callDate')),
                  'yyyymmddhh24miss');

BEGIN
   pbsal_id := beeline_api_pckg.phone_detail_call (phone_t);

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

   RETURN;
END;