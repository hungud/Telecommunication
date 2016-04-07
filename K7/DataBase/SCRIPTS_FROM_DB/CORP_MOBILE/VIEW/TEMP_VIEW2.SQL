
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."TEMP_VIEW2" ("ACCOUNT_ID", "PHONE_NUMBER", "M201201") AS 
  SELECT t1.account_id, t1.phone_number,
          calc3 (t1.account_id, t1.phone_number, 201201) AS m201201
     FROM (SELECT   b.account_id, b.phone_number
               FROM db_loader_bills b
              WHERE b.account_id = 54
           GROUP BY b.account_id, b.phone_number) t1 