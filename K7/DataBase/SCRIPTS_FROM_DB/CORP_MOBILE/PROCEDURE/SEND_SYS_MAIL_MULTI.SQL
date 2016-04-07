
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."SEND_SYS_MAIL_MULTI" (MESSAGE_TITLE IN VARCHAR2,
                                          MAIL_TEXT     IN CLOB,
                                          PARAM_NAME    in varchar2,
                                          LOAD_TYPE in integer) is
  pemail varchar2(130);
  pdate clob;
  pMAIL_TEXT   CLOB;
  pERROR_TEXT   varchar2(2000) := '';
   PROCEDURE ins_log(p_EMail        in varchar2,
                    p_IS_SUCCESS   in number,
                    p_ERROR_TEXT   in varchar2,
                    p_LOAD_TYPE_ID in number) is
  begin
    INSERT INTO ALL_LOAD_LOGS
      (LOAD_LOG_ID,
       EMAIL,
       LOAD_DATE_TIME,
       IS_SUCCESS,
       ERROR_TEXT,
       LOAD_TYPE_ID,
       BEELINE_RN)
    VALUES
      (NEW_ACCOUNT_LOAD_LOG_ID,
       p_EMail,
       SYSDATE,
       p_IS_SUCCESS,
       p_ERROR_TEXT,
       p_LOAD_TYPE_ID,
       null);
    commit;
  end;
begin
  pMAIL_TEXT:=MAIL_TEXT;
    pdate := '<br>'||chr(10)||to_char(sysdate,'dd.mm.yyyy hh24:mi:ss');
    DBMS_LOB.APPEND(pMAIL_TEXT, pdate);
    pemail:=MS_params.GET_PARAM_VALUE(PARAM_NAME);
    SEND_MAIL_MULTI_RCPT(pemail, MESSAGE_TITLE||' '||to_char(sysdate,'dd.mm.yyyy hh24:mi:ss'), pMAIL_TEXT);
    ins_log(pemail,1,'Письмо отправлено',LOAD_TYPE);
exception
  when others then
       if LOAD_TYPE<>84 then
        pERROR_TEXT := 'Ошибка отправки! ' || sqlerrm;
        ins_log(pemail,0,pERROR_TEXT,LOAD_TYPE);
      end if;
end;
