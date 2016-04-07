--#if IsClient("SIM_TRADE") then
--#if GetVersion("SEND_SMS_NOTICE") < 14 then
CREATE OR REPLACE PROCEDURE SEND_SMS_NOTICE AS
--
--#Version=14
--
--09.09.2011 Крайнов. Вынесен во вьюшку отбор телефонов 
--
CURSOR C IS
  SELECT PHONE_NUMBER_FEDERAL,
         BALANCE,
         FIO,
         DISCONNECT_LIMIT,
         BALANCE_NOTICE_TEXT,
         ACCOUNT_ID
  FROM V_PHONE_NUMBERS_FOR_NOTICE_BAL;  
     
  vREC C%ROWTYPE;
--
CURSOR BL (ID INTEGER) IS
  SELECT 
    ACCOUNTS.DO_BALANCE_NOTICE
  FROM ACCOUNTS
  WHERE ID=ACCOUNTS.ACCOUNT_ID;
--
  vBL BL%ROWTYPE;
  v_d VARCHAR2(2000);
  v_t VARCHAR2(2000);
  SMS VARCHAR2(2000); 
  SMS_TXT VARCHAR2(2000);
--
BEGIN
 --  
   IF ((TO_NUMBER(TO_CHAR(SYSDATE,'D','NLS_DATE_LANGUAGE=RUSSIAN'))<6) AND (SYSDATE-TRUNC(SYSDATE)>9/24) AND (SYSDATE-TRUNC(SYSDATE)<18/24))
       OR((TO_NUMBER(TO_CHAR(SYSDATE,'D','NLS_DATE_LANGUAGE=RUSSIAN'))>5) AND (SYSDATE-TRUNC(SYSDATE)>12/24) AND (SYSDATE-TRUNC(SYSDATE)<18/24))  THEN 
     FOR vREC IN C  
     LOOP 
       OPEN BL(vREC.ACCOUNT_ID);
       FETCH BL INTO vBL;
       CLOSE BL;
          
       IF vBL.DO_BALANCE_NOTICE=1 THEN 
         v_d:=to_char(sysdate,'mm/dd/yyyy');
         v_t:=to_char(sysdate,'hh24:mi');
         SMS_TXT:=replace(vREC.BALANCE_NOTICE_TEXT,'%balance%',round(vRec.Balance));
         SMS_TXT:=replace(SMS_TXT,'%dolg%',round(-vRec.Balance)); 
         SMS:=LOADER3_pckg.SEND_SMS(
           vREC.PHONE_NUMBER_FEDERAL,
           'Смс-оповещение',
           SMS_TXT);
        
         IF (SMS IS NULL)or(SMS IS not NULL) THEN  
           INSERT INTO BLOCK_SEND_SMS  
            (phone_number,
             SEND_DATE_TIME,
             ABONENT_FIO,
             itog) 
           VALUES (vREC.PHONE_NUMBER_FEDERAL, sysdate, vREC.FIO, SMS);
         END IF;
         COMMIT;
       END IF;  
     END LOOP; 
   END IF;  
 END; 
--#end if;

--#Execute MAIN_SCHEMA=IsClient("")

--#if not GrantExists("SEND_SMS_NOTICE", "ROLE", "EXECUTE") then
begin EXECUTE IMMEDIATE 'GRANT EXECUTE ON SEND_SMS_NOTICE TO &MAIN_SCHEMA'||'_ROLE'; end;
--#end if

--#end if;	