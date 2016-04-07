--#if GetVersion("SEND_MAIL_PHONE_FOR_UNBL_SAVE3") < 2 then
CREATE OR REPLACE PROCEDURE SEND_MAIL_PHONE_FOR_UNBL_SAVE3 IS
--#Version=2
TEXT CLOB;
pIS_SUCCESS number:=-1;
pEMail varchar2(32);
pERROR_TEXT varchar2(2000):='';
BEGIN

  if MS_PARAMS.GET_PARAM_VALUE('SEND_MAIL_PHONE_FOR_UNBL')=1 then
      -- отправляем отчет по настройке
      
  TEXT:=GET_MAIL_PHONE_FOR_UNBL_SAVE3;
  FOR rec IN(
    SELECT REPORT_MAIL_RECIPIENTS.MAIL_ADRESS,
           REPORT_TYPES.REPORT_NAME
      FROM REPORT_MAIL_RECIPIENTS, REPORT_TYPES
      WHERE REPORT_MAIL_RECIPIENTS.TYPE_REPORT='PHONE_FOR_UNBLOCK_SAVE_3'
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
    
INSERT INTO ALL_LOAD_LOGS
   (LOAD_LOG_ID,
    EMAIL,
    LOAD_DATE_TIME,
    IS_SUCCESS,
    ERROR_TEXT,
    ACCOUNT_LOAD_TYPE_ID,
    BEELINE_RN)
 VALUES
   (NEW_ACCOUNT_LOAD_LOG_ID, pEMail, SYSDATE, pIS_SUCCESS, pERROR_TEXT, 80, null);
 commit;
    
  END LOOP;
  
  END IF;
  
  if MS_PARAMS.GET_PARAM_VALUE('SEND_MAIL_PHONE_FOR_UNBL')=0 then  -- не отправляем отчет по настройке
  INSERT INTO ALL_LOAD_LOGS
   (LOAD_LOG_ID,
    EMAIL,
    LOAD_DATE_TIME,
    IS_SUCCESS,
    ERROR_TEXT,
    ACCOUNT_LOAD_TYPE_ID,
    BEELINE_RN)
 VALUES
   (NEW_ACCOUNT_LOAD_LOG_ID, pEMail, SYSDATE, 0, 'Отчет не отправлен по значению параметра - не отправлять отчет', 80, null);
 commit;
 
    end if ;

END;
/
--#end if