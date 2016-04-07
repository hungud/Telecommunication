
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."SEND_MAIL_PHONE_FOR_BL_SAVE3" IS
--#Version=1
TEXT CLOB;
pIS_SUCCESS number:=-1;
pEMail varchar2(32);
pERROR_TEXT varchar2(2000):='';
pLOAD_TYPE_ID number;


PROCEDURE  ins_log(p_EMail      in varchar2,
                   p_IS_SUCCESS in number,
                   p_ERROR_TEXT in varchar2,
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
   (NEW_ACCOUNT_LOAD_LOG_ID, p_EMail, SYSDATE, p_IS_SUCCESS, p_ERROR_TEXT, p_LOAD_TYPE_ID, null);
 commit;
       end;

BEGIN
    ------------------ Отправка отчета на блокировку на сохранение
  pLOAD_TYPE_ID:=81;
     if MS_PARAMS.GET_PARAM_VALUE('SEND_MAIL_PHONE_FOR_BLOCK')=1 then
      -- отправляем отчет по настройке

  TEXT:=GET_MAIL_PHONE_FOR_BL_SAVE3;
  FOR rec IN(
    SELECT REPORT_MAIL_RECIPIENTS.MAIL_ADRESS,
           REPORT_TYPES.REPORT_NAME
      FROM REPORT_MAIL_RECIPIENTS, REPORT_TYPES
      WHERE REPORT_MAIL_RECIPIENTS.TYPE_REPORT='PHONE_FOR_BL_SAVE3'
         AND REPORT_MAIL_RECIPIENTS.TYPE_REPORT=REPORT_TYPES.TYPE_REPORT
  ) LOOP

  begin
    pEMail:=rec.MAIL_ADRESS;
    IF TEXT IS NOT NULL THEN
          SEND_MAIL(rec.MAIL_ADRESS,rec.REPORT_NAME || ' ' || TO_CHAR(SYSDATE, 'DD.MM.YYYY hh24:mi:ss'), TEXT);
      ELSE
        SEND_MAIL(rec.MAIL_ADRESS,rec.REPORT_NAME || ' ' || TO_CHAR(SYSDATE, 'DD.MM.YYYY hh24:mi:ss'), 'blank report');
    END IF;

    pIS_SUCCESS:=1;
    pERROR_TEXT:='Письмо отправлено';

     exception
      when others then
        pIS_SUCCESS:=0;
        pERROR_TEXT:='Error ! '||sqlerrm;
      end;

 ins_log(pEMail,pIS_SUCCESS,pERROR_TEXT,pLOAD_TYPE_ID);

  END LOOP;

  END IF;

  if MS_PARAMS.GET_PARAM_VALUE('SEND_MAIL_PHONE_FOR_BLOCK')=0 then  -- не отправляем отчет по настройке
  pIS_SUCCESS:=0;
 pERROR_TEXT:='Отчет не отправлен по значению параметра - не отправлять отчет';
  ins_log(pEMail,pIS_SUCCESS,pERROR_TEXT,pLOAD_TYPE_ID);

    end if ;

END;
