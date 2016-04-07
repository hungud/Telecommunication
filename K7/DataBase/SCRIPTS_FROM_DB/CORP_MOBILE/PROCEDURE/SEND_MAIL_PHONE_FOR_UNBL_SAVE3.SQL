
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."SEND_MAIL_PHONE_FOR_UNBL_SAVE3" IS
  --#Version=3
  TEXT          CLOB;
  pEMail        varchar2(32);
  pERROR_TEXT   varchar2(2000) := '';
  pLOAD_TYPE_ID number;
  IS_SUCCESS    number := -1;

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

  PROCEDURE prSEND_MAIL(pMAIL_ADRESS in varchar2,
                        pREPORT_NAME in varchar2,
                        pTEXT        in CLOB,
                        p_out        out number,
                        p_err        out varchar2) is
  
    verr varchar2(2000) := '-';
  begin
    --  verr:='-';
    begin
    
      IF pTEXT IS NOT NULL THEN
        --   SEND_MAIL(pMAIL_ADRESS,pREPORT_NAME || ' ' || TO_CHAR(SYSDATE, 'DD.MM.YYYY hh24:mi:ss'), pTEXT);
        TEST_SEND_MAIL(pMAIL_ADRESS,
                       pREPORT_NAME || ' ' ||
                       TO_CHAR(SYSDATE, 'DD.MM.YYYY hh24:mi:ss'),
                       pTEXT,
                       verr);
      ELSE
        --   SEND_MAIL(pMAIL_ADRESS,pREPORT_NAME || ' ' || TO_CHAR(SYSDATE, 'DD.MM.YYYY hh24:mi:ss'), 'blank report');
        TEST_SEND_MAIL(pMAIL_ADRESS,
                       pREPORT_NAME || ' ' ||
                       TO_CHAR(SYSDATE, 'DD.MM.YYYY hh24:mi:ss'),
                       'blank report',
                       verr);
      END IF;
    
      if verr = '-' then
        p_out := 1;
      end if;
      if verr <> '-' then
        p_out := 0;
        p_err := verr;
      end if;
    
    exception
      when others then
        p_out := 0;
        p_err := sqlerrm;
        if p_err is null and verr <> '-' then
          p_err := verr;
        end if;
    end;
    
    --if p_out<>0 then  p_out := 1; end if;
  p_out:=nvl(p_out,1);
  end;

BEGIN
  pLOAD_TYPE_ID := 80;
  --- отправка отчета на разблокироыку
  if MS_PARAMS.GET_PARAM_VALUE('SEND_MAIL_PHONE_FOR_UNBL') = 1 then
    -- отправляем отчет по настройке
    TEXT := GET_MAIL_PHONE_FOR_UNBL_SAVE3;
    FOR rec IN (SELECT REPORT_MAIL_RECIPIENTS.MAIL_ADRESS,
                       REPORT_TYPES.REPORT_NAME
                  FROM REPORT_MAIL_RECIPIENTS, REPORT_TYPES
                 WHERE REPORT_MAIL_RECIPIENTS.TYPE_REPORT =
                       'PHONE_FOR_UNBLOCK_SAVE_3'
                   AND REPORT_MAIL_RECIPIENTS.TYPE_REPORT =
                       REPORT_TYPES.TYPE_REPORT) LOOP
    
      --begin
      pEMail := rec.MAIL_ADRESS;
    
      prSEND_MAIL(rec.MAIL_ADRESS,
                  rec.REPORT_NAME,
                  TEXT,
                  IS_SUCCESS,
                  pERROR_TEXT);
    
      if IS_SUCCESS = 1 then
        pERROR_TEXT := 'Письмо отправлено';
      end if;
      if IS_SUCCESS = 0 then
        pERROR_TEXT := 'Error ! ' || pERROR_TEXT || ';' || sqlerrm;
      end if;
    
      ------------------------
      ins_log(pEMail, IS_SUCCESS, pERROR_TEXT, pLOAD_TYPE_ID);
    
      if IS_SUCCESS = 0 then
        -- вот тут еще две попытки отправки отчета с задержкой в 15 сек.
        pERROR_TEXT := 'Вторая попытка: ' || pERROR_TEXT;
        dbms_lock.sleep(15);
      
        --вторая попытка отправки
        prSEND_MAIL(rec.MAIL_ADRESS,
                    rec.REPORT_NAME,
                    TEXT,
                    IS_SUCCESS,
                    pERROR_TEXT);
      
        if IS_SUCCESS = 0 then
          pERROR_TEXT := 'Третья попытка: ' || pERROR_TEXT;
          dbms_lock.sleep(25);
          --Третья попытка отправки
          prSEND_MAIL(rec.MAIL_ADRESS,
                      rec.REPORT_NAME,
                      TEXT,
                      IS_SUCCESS,
                      pERROR_TEXT);
        end if;
      
        if nvl(IS_SUCCESS,1) = 1 then
          pERROR_TEXT := 'Письмо отправлено';
        end if;
      
        ins_log(pEMail, IS_SUCCESS, pERROR_TEXT, pLOAD_TYPE_ID);
      
      end if;
    
    END LOOP;
  
  END IF;

  if MS_PARAMS.GET_PARAM_VALUE('SEND_MAIL_PHONE_FOR_UNBL') = 0 then
    -- не отправляем отчет по настройке
    IS_SUCCESS  := 0;
    pERROR_TEXT := 'Отчет не отправлен по значению параметра - не отправлять отчет';
    ins_log(pEMail, IS_SUCCESS, pERROR_TEXT, pLOAD_TYPE_ID);
  
  end if;

END;
