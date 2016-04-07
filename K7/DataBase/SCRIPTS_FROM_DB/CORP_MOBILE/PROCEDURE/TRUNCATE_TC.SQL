
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."TRUNCATE_TC" IS
BEGIN
 execute immediate 'truncate table temp_call';
END;
