
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."HISTORY_CLEAR_DESC" IS -- 
-- Version = 1  
BEGIN
  FOR rec IN (/*SELECT DISTINCT C.PHONE_NUMBER_FEDERAL 
                FROM CONTRACTS C,
                     CONTRACT_CANCELS CC
                WHERE C.CONTRACT_ID = CC.CONTRACT_ID(+)
                  AND CC.CONTRACT_CANCEL_DATE IS NULL*/
              select DISTINCT h.PHONE_NUMBER PHONE_NUMBER_FEDERAL
                from db_loader_account_phone_hists h
                order by h.PHONE_NUMBER desc
              )
  LOOP
    HISTORY_CLEAR_PHONE(rec.PHONE_NUMBER_FEDERAL);
  END LOOP;
END; 