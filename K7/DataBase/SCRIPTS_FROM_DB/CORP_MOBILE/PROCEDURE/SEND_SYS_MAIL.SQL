
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."SEND_SYS_MAIL" (MESSAGE_TITLE IN VARCHAR2,
                                          MAIL_TEXT     IN CLOB,
                                          PARAM_NAME    in varchar2) is
  cursor curp is
    SELECT regexp_substr(str, '[^,]+', 1, level) str
      FROM (SELECT MS_params.GET_PARAM_VALUE(PARAM_NAME) str FROM dual) t
    CONNECT BY instr(str, ',', 1, level - 1) > 0;
  mail_ad varchar2(100);
begin
  open curp;
  loop
    FETCH curp
      into mail_ad;
    EXIT WHEN curp%NOTFOUND;
    send_mail1(mail_ad, MESSAGE_TITLE, MAIL_TEXT);
    DBMS_LOCK.SLEEP(5);
  end loop;
  close curp;
end;
