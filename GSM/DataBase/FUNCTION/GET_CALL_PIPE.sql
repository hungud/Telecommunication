/* Formatted on 06.10.2014 15:46:11 (QP5 v5.227.12220.39754) */
CREATE OR REPLACE FUNCTION get_call_pipe (phone_t IN VARCHAR2)
   RETURN SYS.ku$_vcnt
   PIPELINED
--
--#Version= 1
--
-- v.1 Афросин - поправил обработку строк полученныз их callDate
--  
AS
   line_t     VARCHAR (4000);
   pbsal_id   VARCHAR2 (20);

   CURSOR curnm
   IS
      WITH xmltable1
           AS (SELECT t.soap_answer
                 FROM BEELINE_SOAP_API_LOG t
                WHERE t.bsal_id = TO_NUMBER (pbsal_id))
        SELECT    TO_CHAR (
                     CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(
                        EXTRACTVALUE (VALUE (d), 'UnbilledCallsList/callDate')),
                     'dd.mm.yyyy')
               || CHR (9)
               || TO_CHAR (
                     CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(
                        EXTRACTVALUE (VALUE (d), 'UnbilledCallsList/callDate')),
                     'hh24:mi:ss')
               || CHR (9)
               || EXTRACTVALUE (VALUE (d), 'UnbilledCallsList/callDuration')
               || CHR (9)
               || DECODE (
                     EXTRACTVALUE (VALUE (d), 'UnbilledCallsList/callToNumber'),
                     t2.phone, '',
                     EXTRACTVALUE (VALUE (d), 'UnbilledCallsList/callToNumber'))
               || CHR (9)
               || EXTRACTVALUE (VALUE (d), 'UnbilledCallsList/callType')
               || CHR (9)
               || EXTRACTVALUE (VALUE (d), 'UnbilledCallsList/serviceName')
               || CHR (9)
               || EXTRACTVALUE (VALUE (d), 'UnbilledCallsList/callNumber')
               || CHR (9)
               || DECODE (
                     REPLACE (
                        EXTRACTVALUE (VALUE (d), 'UnbilledCallsList/callAmt'),
                        '.',
                        ','),
                     '0,0', '0',
                     REPLACE (
                        EXTRACTVALUE (VALUE (d), 'UnbilledCallsList/callAmt'),
                        '.',
                        ','))
               || CHR (9)
               || DECODE (
                     REPLACE (
                        EXTRACTVALUE (VALUE (d),
                                      'UnbilledCallsList/dataVolume'),
                        '.',
                        ','),
                     '0,0', '0',
                     REPLACE (
                        EXTRACTVALUE (VALUE (d),
                                      'UnbilledCallsList/dataVolume'),
                        '.',
                        ','))
               || CHR (9)
                  AS call_t
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
      FETCH curnm INTO line_t;

      EXIT WHEN curnm%NOTFOUND;
      PIPE ROW (line_t);
   END LOOP;

   CLOSE curnm;

   RETURN;
END;
/
