
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."SEND_SMS_NOTICE_END_MONTH" AS
--
--#Version=1
--
DAY_NOTICE constant integer:=2;
CURSOR C IS
  SELECT 
    v_abonent_balances.PHONE_NUMBER_FEDERAL,
    v_abonent_balances.BALANCE,
    v_abonent_balances.SURNAME || ' ' || v_abonent_balances.NAME || ' ' || v_abonent_balances.PATRONYMIC FIO,
    v_abonent_balances.DISCONNECT_LIMIT,
    ACCOUNTS.NEXT_MONTH_NOTICE_TEXT,
    ACCOUNTS.ACCOUNT_ID
  FROM v_abonent_balances,ACCOUNTS
  WHERE loader_script_name is not null
        AND v_abonent_balanceS.ACCOUNT_ID=ACCOUNTS.ACCOUNT_ID
        and (GET_ABONENT_BALANCE(PHONE_NUMBER_FEDERAL,SYSDATE+DAY_NOTICE)-NVL(v_abonent_balances.DISCONNECT_LIMIT,0)<=ACCOUNTS.BALANCE_NOTICE_END_MONTH)  --баланс через 2 дня станет ниже порога отключения
        and phone_is_active_code=1 
        AND NOT EXISTS( 
        SELECT 1 FROM SEND_SMS_NOTICE_END_MONTH_LOG WHERE 
          v_abonent_balances.PHONE_NUMBER_FEDERAL=SEND_SMS_NOTICE_END_MONTH_LOG.PHONE_NUMBER
          AND  (SEND_SMS_NOTICE_END_MONTH_LOG.SEND_DATE_TIME>SYSDATE-23/24)
          AND SEND_SMS_NOTICE_END_MONTH_LOG.ERROR_TEXT IS NULL)
        ;     
--
CURSOR BL (ID INTEGER) IS
  SELECT 
    ACCOUNTS.DO_BALANCE_NOTICE_MONTH
  FROM ACCOUNTS
  WHERE ID=ACCOUNTS.ACCOUNT_ID;
--
  vBL BL%ROWTYPE;
  SMS VARCHAR2(2000); 
  SMS_TXT VARCHAR2(500);
  MM INTEGER;
  MONTH_NAME VARCHAR2(20);
  NEXT_MONTH_NAME varchar2(20);
  LAST_DAY_MONTH varchar2(20);
--
BEGIN

IF TO_CHAR(SYSDATE+DAY_NOTICE, 'MM')<>TO_CHAR(SYSDATE, 'MM') 
  THEN 
 --  
   IF ((SYSDATE-TRUNC(SYSDATE) > 9/24) and (SYSDATE-TRUNC(SYSDATE) < 18/24))  THEN 
     FOR vREC IN C
     LOOP
       OPEN BL(vREC.ACCOUNT_ID);
       FETCH BL INTO vBL;
       CLOSE BL;       
        
       IF vBL.DO_BALANCE_NOTICE_MONTH=1 THEN
         NEXT_MONTH_NAME := CASE TO_CHAR(SYSDATE+DAY_NOTICE,'MM')
           WHEN '01' THEN 'январь'
           WHEN '02' THEN 'февраль'
           WHEN '03' THEN 'март'
           WHEN '04' THEN 'апрель'
           WHEN '05' THEN 'май'
           WHEN '06' THEN 'июнь'
           WHEN '07' THEN 'июль'
           WHEN '08' THEN 'август'
           WHEN '09' THEN 'сентябрь'
           WHEN '10' THEN 'октябрь'
           WHEN '11' THEN 'ноябрь'
           WHEN '12' THEN 'декабрь'
         END;
         LAST_DAY_MONTH:=to_char(last_day(sysdate),'dd.mm.yy');
         SMS_TXT:=REPLACE(vREC.NEXT_MONTH_NOTICE_TEXT,'%month%',NEXT_MONTH_NAME);
         SMS_TXT:=REPLACE(sms_txt,'%date%',LAST_DAY_MONTH);
         SMS:=LOADER3_pckg.SEND_SMS(
           vREC.PHONE_NUMBER_FEDERAL,
           'СМС-Оповещение',
           SMS_TXT);   --текст предупреждения
         INSERT INTO SEND_SMS_NOTICE_END_MONTH_LOG (
           phone_number,
           ABONENT_FIO,
           SEND_DATE_TIME,
           ERROR_TEXT
           ) VALUES (
           vREC.PHONE_NUMBER_FEDERAL,
           vREC.FIO,
           SYSDATE,
           SMS
           );
         COMMIT;
       END IF;  
     END LOOP; 
   END IF;  
 END IF;
 END; 