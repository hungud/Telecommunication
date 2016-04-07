--#if GetVersion("SEND_SMS_NOTICE_END_MONTH") < 1 then
CREATE OR REPLACE PROCEDURE SEND_SMS_NOTICE_END_MONTH AS
--
--#Version=1
--
DAY_NOTICE constant integer:=2;
CURSOR C IS
  SELECT v_abonent_balances.PHONE_NUMBER_FEDERAL,
         v_abonent_balances.BALANCE,
         v_abonent_balances.SURNAME || ' ' || v_abonent_balances.NAME || ' ' || v_abonent_balances.PATRONYMIC FIO,
         v_abonent_balances.DISCONNECT_LIMIT,
         ACCOUNTS.NEXT_MONTH_NOTICE_TEXT,
         ACCOUNTS.ACCOUNT_ID,
         100 - GET_ABONENT_BALANCE(PHONE_NUMBER_FEDERAL,SYSDATE+DAY_NOTICE) RECOMEND_SUMM
  FROM v_abonent_balances,ACCOUNTS
  WHERE loader_script_name is not null
        AND v_abonent_balanceS.ACCOUNT_ID=ACCOUNTS.ACCOUNT_ID
        and (GET_ABONENT_BALANCE(PHONE_NUMBER_FEDERAL,SYSDATE+DAY_NOTICE)-NVL(v_abonent_balances.DISCONNECT_LIMIT,0)<=ACCOUNTS.BALANCE_NOTICE_END_MONTH)  --баланс через 2 дн€ станет ниже порога отключени€
        and phone_is_active_code=1 
        AND NOT EXISTS (SELECT 1
                          FROM PHONE_NUMBER_WITH_DAILY_ABON PHA
                          WHERE PHA.PHONE_NUMBER=v_abonent_balances.PHONE_NUMBER_FEDERAL)
        AND NOT EXISTS (SELECT 1
                          FROM TARIFFS TAR
                          WHERE TAR.TARIFF_ID = v_abonent_balances.TARIFF_ID
                            AND NVL(TAR.TARIFF_ABON_DAILY_PAY, 0) = 1)                   
        AND NOT EXISTS (SELECT 1 
                          FROM SEND_SMS_NOTICE_END_MONTH_LOG 
                          WHERE v_abonent_balances.PHONE_NUMBER_FEDERAL=SEND_SMS_NOTICE_END_MONTH_LOG.PHONE_NUMBER
                            AND (SEND_SMS_NOTICE_END_MONTH_LOG.SEND_DATE_TIME>SYSDATE-23/24)
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
           WHEN '01' THEN '€нварь'
           WHEN '02' THEN 'февраль'
           WHEN '03' THEN 'март'
           WHEN '04' THEN 'апрель'
           WHEN '05' THEN 'май'
           WHEN '06' THEN 'июнь'
           WHEN '07' THEN 'июль'
           WHEN '08' THEN 'август'
           WHEN '09' THEN 'сент€брь'
           WHEN '10' THEN 'окт€брь'
           WHEN '11' THEN 'но€брь'
           WHEN '12' THEN 'декабрь'
         END;
         LAST_DAY_MONTH:=to_char(last_day(sysdate),'dd.mm.yy');
         SMS_TXT:=REPLACE(vREC.NEXT_MONTH_NOTICE_TEXT,'%month%',NEXT_MONTH_NAME);
         SMS_TXT:=REPLACE(sms_txt,'%date%',LAST_DAY_MONTH);
         SMS_TXT:=REPLACE(sms_txt,'%summ%',vREC.RECOMEND_SUMM);
         SMS:=LOADER3_pckg.SEND_SMS(
           vREC.PHONE_NUMBER_FEDERAL,
           '—ћ—-ќповещение',
           SMS_TXT);   --текст предупреждени€
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
         DBMS_LOCK.SLEEP(2);  
         COMMIT;
       END IF;  
     END LOOP; 
   END IF;  
 END IF;
 END;
--#end if
