CREATE OR REPLACE PROCEDURE P_LOAD_COLLECT_BANS AS
--
--Version=1
--
--v.1 Афросин 17.05.2015 Создал процедуру для получения всех подбанов для коллекторских счетов
--
  ERR VARCHAR2(1000);
BEGIN
  FOR  rec IN (SELECT ACCOUNT_ID    
                 FROM ACCOUNTS
                 WHERE IS_COLLECTOR=1) 
  LOOP
    
    ERR := BEELINE_API_PCKG.Collect_account_BANS(rec.ACCOUNT_ID);
  end loop;
END;