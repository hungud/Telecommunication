
  CREATE OR REPLACE TYPE "CORP_MOBILE"."SOAP_API_ANSWER_TYPE" AS OBJECT
(ANSWER XMLTYPE,
BSAL_ID INTEGER,
Err_text varchar2(1000)
)

