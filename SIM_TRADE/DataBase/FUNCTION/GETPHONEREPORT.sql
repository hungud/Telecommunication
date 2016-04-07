CREATE OR REPLACE FUNCTION CORP_MOBILE.GETPHONEREPORT(PACCOUNTID IN VARCHAR2, PYEAR_MONTH IN VARCHAR2) RETURN TPHONEREPORTS IS
/******************************************************************************
   NAME:       GetPhoneReport
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        19.11.2014   Developer       1. Created this function.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     GetPhoneReport
      Sysdate:         19.11.2014
      Date and Time:   19.11.2014, 12:33:10, and 19.11.2014 12:33:10
      Username:        Developer (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
L_DATE         DBMS_SQL.DATE_TABLE;
L_COST         DBMS_SQL.NUMBER_TABLE;
L_DESC         DBMS_SQL.VARCHAR2_TABLE;
L_DATE2        T_TABLE_OF_DATE;
L_MAX_DATE     DATE;
L_PERIOD       DATE;
L_PHONE_REPORT TPHONEREPORTS; 
BEGIN
  L_DATE2 := T_TABLE_OF_DATE();
  
  L_PHONE_REPORT := TPHONEREPORTS();
    
  L_PERIOD := LAST_DAY(TO_DATE(PYEAR_MONTH||'01', 'yyyymmdd')); 
   
  FOR R IN (SELECT DISTINCT A.ACCOUNT_NUMBER, P.PHONE_NUMBER 
              FROM DB_LOADER_ACCOUNT_PHONES P,
                   ACCOUNTS A
             WHERE A.ACCOUNT_ID IN (PACCOUNTID)) 
  LOOP
    CALC_BALANCE_ROWS2(PPHONE_NUMBER => R.PHONE_NUMBER,
                       PDATE_ROWS => L_DATE,
                       PCOST_ROWS => L_COST,
                       PDESCRIPTION_ROWS   => L_DESC,
                       PFILL_DESCRIPTION => TRUE,
                       PBALANCE_DATE => L_PERIOD);
   
     FOR IDX IN 1 .. L_DATE.COUNT  
     LOOP
       L_DATE2.EXTEND;
       L_DATE2(L_DATE2.LAST) := L_DATE(IDX);
     END LOOP;
     
     SELECT MAX(COLUMN_VALUE)
       INTO L_MAX_DATE 
       FROM TABLE(CAST(L_DATE2 AS T_TABLE_OF_DATE));
     
     L_PHONE_REPORT.EXTEND;
     L_PHONE_REPORT(L_PHONE_REPORT.LAST) := TPHONEREPORT(R.ACCOUNT_NUMBER, PYEAR_MONTH, R.PHONE_NUMBER, L_MAX_DATE, 0, 0, 0, 0, 0, 0, 0, 0, 0);
     L_PHONE_REPORT(L_PHONE_REPORT.LAST).CALLS := 0;
     L_PHONE_REPORT(L_PHONE_REPORT.LAST).INTERCALL := 0;
     L_PHONE_REPORT(L_PHONE_REPORT.LAST).CITYCALL := 0;
     L_PHONE_REPORT(L_PHONE_REPORT.LAST).MEST  := 0;
     L_PHONE_REPORT(L_PHONE_REPORT.LAST).SMS  := 0;
     L_PHONE_REPORT(L_PHONE_REPORT.LAST).INTERNET := 0;
     L_PHONE_REPORT(L_PHONE_REPORT.LAST).ALLCALLS := 0;
     L_PHONE_REPORT(L_PHONE_REPORT.LAST).INTERROUMING := 0;
     L_PHONE_REPORT(L_PHONE_REPORT.LAST).NACROUMING := 0;
     
     FOR I IN 1 .. L_DATE.COUNT  
     LOOP
       IF L_DATE(I) = L_MAX_DATE THEN
         IF (INSTR(L_DESC(I), 'Звонки') > 0) THEN 
           L_PHONE_REPORT(L_PHONE_REPORT.LAST).CALLS := L_COST(I);
         END IF;
         IF (INSTR(L_DESC(I), 'М/н звонки') > 0) THEN 
           L_PHONE_REPORT(L_PHONE_REPORT.LAST).INTERCALL := L_COST(I);
         END IF;
         IF (INSTR(L_DESC(I), 'М/г звонки') > 0) THEN 
           L_PHONE_REPORT(L_PHONE_REPORT.LAST).CITYCALL := L_COST(I);
         END IF;
         IF (INSTR(L_DESC(I), 'Местные') > 0) THEN 
           L_PHONE_REPORT(L_PHONE_REPORT.LAST).MEST := L_COST(I);
         END IF;
         IF (INSTR(L_DESC(I), 'СМС и ММС') > 0) THEN 
           L_PHONE_REPORT(L_PHONE_REPORT.LAST).SMS := L_COST(I);
         END IF;
         IF (INSTR(L_DESC(I), 'Интернет') > 0) THEN 
           L_PHONE_REPORT(L_PHONE_REPORT.LAST).INTERNET := L_COST(I);
         END IF;
         IF (INSTR(L_DESC(I), 'Звонки(всего)') > 0) THEN 
           L_PHONE_REPORT(L_PHONE_REPORT.LAST).ALLCALLS := L_COST(I);
         END IF;
         IF (INSTR(L_DESC(I), 'Нац. роуминг') > 0) THEN 
           L_PHONE_REPORT(L_PHONE_REPORT.LAST).INTERROUMING := L_COST(I);
         END IF;
         IF (INSTR(L_DESC(I), 'М/н роуминг') > 0) THEN 
           L_PHONE_REPORT(L_PHONE_REPORT.LAST).NACROUMING := L_COST(I);
         END IF;
       END IF;
       
     END LOOP;
     
  END LOOP;
     
     /*open l_result for
       select *
         from table(cast(l_phone_report as TPhoneReports));*/ 
    RETURN L_PHONE_REPORT;
END GETPHONEREPORT;
/
