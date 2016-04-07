CREATE OR REPLACE procedure DROP_SCHEMA(
  SCHEMA_NAME IN VARCHAR2--:='CORP_MOBILE_COPY1';
  ) IS

begin

SYS.DBMS_SCHEDULER.DROP_JOB('J_CS'||SCHEMA_NAME,true);
DELETE BALANCE_COMPARE_RESULT WHERE ID_DATABASE=(SELECT ID_DATABASE FROM DATABASE_COPIES WHERE DATABASE_COPIES.SCHEMA_NAME=DROP_SCHEMA.SCHEMA_NAME);
DELETE DATABASE_COPIES WHERE DATABASE_COPIES.SCHEMA_NAME=DROP_SCHEMA.SCHEMA_NAME;
COMMIT;
EXECUTE IMMEDIATE 'DROP USER '||SCHEMA_NAME||' CASCADE';
  
end;
/
GRANT EXECUTE ON DROP_SCHEMA TO CORP_MOBILE_ROLE;