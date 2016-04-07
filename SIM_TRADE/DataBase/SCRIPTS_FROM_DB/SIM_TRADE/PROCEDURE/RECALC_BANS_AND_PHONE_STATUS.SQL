
  CREATE OR REPLACE PROCEDURE "SIM_TRADE"."RECALC_BANS_AND_PHONE_STATUS" IS
--
--VERSION=1
--Загружаем ПОДБАНЫ дял коллекуторских счетов

   ERR VARCHAR2(1000);
BEGIN
  FOR  rec IN (SELECT ACCOUNT_ID    
                 FROM ACCOUNTS
                 WHERE IS_COLLECTOR=1) 
  LOOP
    
    ERR := BEELINE_API_PCKG.Collect_account_BANS(rec.ACCOUNT_ID);
    
    IF ERR='' THEN        
      ERR := BEELINE_API_PCKG.Collect_account_phone_status(rec.ACCOUNT_ID);
    END IF;
    
  END LOOP;
END;