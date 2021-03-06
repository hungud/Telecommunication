
  CREATE OR REPLACE PROCEDURE "SIM_TRADE"."COMPARE_BALANCES" 
(
  ID_DESTDATABASE IN NUMBER
)
IS
--cur1 sys_refcursor;
  vPHONES     DBMS_SQL.VARCHAR2_TABLE;
  bal1 NUMBER;
  bal2 NUMBER;
  DESTSCHEME VARCHAR2(30 BYTE);
BEGIN
   --open cur1 for 'select LP.PHONE_NUMBER, GET_ABONENT_BALANCE(LP.PHONE_NUMBER, sysdate) SOURCE_BAL, '||dest_SCHEME||'.GET_ABONENT_BALANCE(LP.PHONE_NUMBER, sysdate) DEST_BALANCE from DB_LOADER_PHONE_STAT LP WHERE' || 
   --              '           YEAR_MONTH=(SELECT max(DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH) FROM DB_LOADER_ACCOUNT_PHONES) AND GET_ABONENT_BALANCE(LP.PHONE_NUMBER, sysdate) <> '||DEST_SCHEME||'.GET_ABONENT_BALANCE(LP.PHONE_NUMBER, sysdate)';
   select SCHEMA_NAME INTO DESTSCHEME FROM DATABASE_COPIES WHERE ID_DATABASE=ID_DESTDATABASE;
   delete BALANCE_COMPARE_RESULT WHERE ID_DATABASE=ID_DESTDATABASE;
   COMMIT; 
   execute immediate 'SELECT DISTINCT PHONE_NUMBER FROM DB_LOADER_ACCOUNT_PHONES' BULK COLLECT INTO vPHONES;
   for II in 1..vPHONES.LAST loop
       bal1:=GET_ABONENT_BALANCE(vPHONES(II));    
       execute immediate 'select '||DESTSCHEME||'.GET_ABONENT_BALANCE('''||vPHONES(II)||''') from dual' into bal2;
       insert into BALANCE_COMPARE_RESULT VALUES (vPHONES(II), ID_DESTDATABASE, bal1,bal2,sysdate);
       commit;
   END LOOP;  
   --RETURN cur1;
   
END COMPARE_BALANCES;