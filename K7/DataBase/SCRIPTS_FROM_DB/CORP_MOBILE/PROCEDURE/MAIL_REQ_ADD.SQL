
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."MAIL_REQ_ADD" (MESSAGE_TITLE IN VARCHAR2,
                                         MAIL_TEXT     IN CLOB,
                                         PARAM_NAME    in varchar2) IS

  --#Version=1
BEGIN
  insert into MAIL_REQUEST
  values
    (MESSAGE_TITLE, MAIL_TEXT, PARAM_NAME, null, null, null);
   commit;
EXCEPTION
  WHEN others THEN
    null;
END;
