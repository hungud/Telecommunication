
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_ACCOUNT_STAT_BY_STATUS_NOW" ("ACCLOGIN", "ACCNUMBER", "COMPANY_NAME", "SUMACTIVE", "SUMBLOCK", "SUMSOHR", "SUMMOSH", "COUNT_PHONES") AS 
  SELECT (SELECT login 
            FROM accounts ac
            WHERE hh.account_id = ac.account_id) AS acclogin,
         (SELECT account_number 
            FROM accounts ac
            WHERE hh.account_id = ac.account_id) AS accnumber,
         (SELECT ac.COMPANY_NAME
            FROM accounts ac
            WHERE hh.account_id = ac.account_id) AS COMPANY_NAME,
         SUM (hh.phone_is_active) AS sumactive,
         SUM (case when hh.phone_is_active=0 then 1 else 0 end) AS sumblock,
         SUM (hh.conservation) AS sumsohr,
         SUM (hh.system_block) AS summosh,
         COUNT(*) AS COUNT_PHONES
    FROM db_loader_account_phones hh
    WHERE year_month = (SELECT MAX (year_month)
                          FROM db_loader_account_phones)
    GROUP BY account_id 