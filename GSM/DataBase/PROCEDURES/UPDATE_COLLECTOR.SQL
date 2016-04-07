--#if GetVersion("SMS_SYSTEM_ERROR_NOTICE") < 2 then
CREATE OR REPLACE PROCEDURE UPDATE_COLLECTOR
(
 PHONE_NUMBER IN VARCHAR2 DEFAULT NULL 
)
--#Version=2 Овсянников. Добавлени проверки по доступности API
IS 
 type tab1 is table of varchar2(10);
 tab2 tab1;
 login varchar2(50);
 pas varchar2(50);
 account_number varchar2(50);
 pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL);
 Respond  varchar2(5000); -- ответ
 status  varchar2(5000);
 pricePlan   varchar2(5000);
 err1 varchar2(5000);
 reasonStatus   varchar2(5000);
 tempSql varchar2(5000);
 token varchar2(128);
 STAT1 int; 
begin
 SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd, accounts.account_number
        into login,pas,account_number
 FROM ACCOUNTS
 WHERE ACCOUNTS.ACCOUNT_ID = 93;
 if PHONE_NUMBER IS NULL THEN 
    select distinct HH.PHONE_NUMBER_FEDERAL bulk collect into tab2 from contracts hh where HH.PHONE_NUMBER_FEDERAL like '968404%';
 ELSE 
    select distinct HH.PHONE_NUMBER_FEDERAL bulk collect into tab2 from contracts hh where HH.PHONE_NUMBER_FEDERAL=PHONE_NUMBER;
 END IF;
 token:=BEELINE_SOAP_API_PCKG.auth(login, pas);
 if instr(token,' ')>0 then 
      RAISE_APPLICATION_ERROR(-20540, 'Ошибка получения token: '|| token);
 end if;

 FOR i IN 1..tab2.COUNT LOOP
  --DBMS_OUTPUT.PUT_LINE(tab2(i));
   begin
      pANSWER:=BEELINE_SOAP_API_PCKG.getCTNInfoList(token, tab2(i),account_number, '');
      select extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:Fault/faultstring','xmlns:ns1="http://www.w3.org/2003/05/soap-envelope" xmlns:ns0="http://schemas.xmlsoap.org/soap/envelope/"') into err1 from dual;
      if err1 is not null then
        RAISE_APPLICATION_ERROR(-20540, 'Ошибка получения статуса: '|| err1);
      end if; 
      select extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:getCTNInfoListResponse/CTNInfoList/status','xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"') into status from dual;
      select extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:getCTNInfoListResponse/CTNInfoList/pricePlan','xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"') into Priceplan from dual;
      select extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:getCTNInfoListResponse/CTNInfoList/reasonStatus','xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"') into reasonStatus from dual;
      
      merge into db_loader_account_phones PH USING (
      select 93 ACCOUNT_ID, to_char(sysdate, 'YYYYMM') YEAR_MONTH, tab2(i) PHONE_NUMBER,  decode(status, 'ACTIVE', 1,'BLOCKED', 0, 0) STATUS, Priceplan PRICEPLAN, decode(reasonStatus, 'S1B', 1, 0) conservation, decode(reasonStatus, 'BSB', 1, 'DUF',1, 0) system_block from dual  ) TT 
      ON (PH.ACCOUNT_ID= TT.ACCOUNT_ID AND PH.YEAR_MONTH=TT.YEAR_MONTH AND PH.PHONE_NUMBER = TT.PHONE_NUMBER)
      WHEN MATCHED THEN UPDATE SET PH.CELL_PLAN_CODE=tt.Priceplan, PH.PHONE_IS_ACTIVE=tt.status, PH.CONSERVATION=tt.conservation, ph.system_block=tt.system_block, PH.LAST_CHECK_DATE_TIME=sysdate 
      WHEN NOT MATCHED THEN INSERT (ACCOUNT_ID,YEAR_MONTH,PHONE_NUMBER,PHONE_IS_ACTIVE,CELL_PLAN_CODE,LAST_CHECK_DATE_TIME,ORGANIZATION_ID,CONSERVATION,SYSTEM_BLOCK)
      VALUES (TT.ACCOUNT_ID,TT.YEAR_MONTH,TT.PHONE_NUMBER,TT.STATUS,TT.Priceplan,sysdate, 1, TT.CONSERVATION,TT.SYSTEM_BLOCK);
      select decode(status, 'ACTIVE', 1,'BLOCKED', 0, 0) INTO STAT1 from dual;
      TEMP_ADD_ACCOUNT_PHONE_HISTORY(tab2(i), Priceplan, STAT1, SYSDATE);
       
      DBMS_OUTPUT.PUT_LINE(tab2(i)||';'||status||';'||Priceplan||';'||reasonStatus);
      commit;
   EXCEPTION
    WHEN OTHERS THEN 
        IF PHONE_NUMBER IS NULL THEN 
            UPDATE_COLLECTOR(tab2(i));
        END IF; 
        DBMS_OUTPUT.PUT_LINE('Ошибка вставки номера '||tab2(i)||':'||sqlerrm);
        token:=BEELINE_SOAP_API_PCKG.auth(login, pas);
   END;  
    
 END LOOP; 
end;

--#end if
