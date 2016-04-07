
  CREATE OR REPLACE PROCEDURE "SIM_TRADE"."LOAD_DETAILS_FROM_API" (
  pSTREAM_ID IN INTEGER,
  pFULL_LOAD IN INTEGER DEFAULT 0
  ) IS
  vSTREAM_COUNT INTEGER := 5;
  vYEAR_MONTH INTEGER;
  vCOUNT INTEGER;
  vTEXT_ERROR VARCHAR2(500 CHAR);
  type TPhone is record(phone_number DB_LOADER_ACCOUNT_PHONES.phone_number%type);
  type vt_phone is table of TPhone index by pls_integer;
  v_rec vt_phone; 
BEGIN
  vYEAR_MONTH:=TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMM'));
  
   SELECT D.PHONE_NUMBER
     BULK COLLECT INTO v_rec
     FROM DB_LOADER_PHONE_PERIODS PER,
          DB_LOADER_ACCOUNT_PHONES D
    WHERE PER.YEAR_MONTH = vYEAR_MONTH
      AND PER.YEAR_MONTH = D.YEAR_MONTH(+)
      AND PER.PHONE_NUMBER = D.PHONE_NUMBER(+)
      AND MOD(TO_NUMBER(PER.PHONE_NUMBER), vSTREAM_COUNT) = pSTREAM_ID
      AND ((D.PHONE_IS_ACTIVE = 1)
          OR (NOT(NVL(D.CONSERVATION, 0)=1 
                  AND D.LAST_CHANGE_STATUS_DATE < TRUNC(SYSDATE) - 1)))
      AND D.PHONE_NUMBER IS NOT NULL;
  
  for i in 1..v_rec.count
  LOOP
    EXECUTE IMMEDIATE 'SELECT COUNT(*)
                         FROM CALL_' || SUBSTR(TO_CHAR(vYEAR_MONTH), 5, 2) || '_' || SUBSTR(TO_CHAR(vYEAR_MONTH), 1, 4) || ' C
                         WHERE C.SUBSCR_NO = ''' || v_rec(i).PHONE_NUMBER || '''
                           AND C.START_TIME > SYSDATE -3/24' INTO vCOUNT;
    IF  vCOUNT = 0 THEN
      begin
        --HOT_BILLING_PCKG.ADD_SITE_DETAIL_API(v_rec(i).PHONE_NUMBER, SUBSTR(TO_CHAR(vYEAR_MONTH), 1, 4), SUBSTR(TO_CHAR(vYEAR_MONTH), 5, 2));
        BEELINE_API_PCKG.LOAD_DETAIL_FROM_API(v_rec(i).PHONE_NUMBER);
      exception
        when others then
          vTEXT_ERROR:=SUBSTR(SQLERRM, 1, 500);
          insert into API_GET_UNBILLED_CALLS_LOG(PHONE_NUMBER, DATE_INSERT, ERROR_TEXT) 
            values(v_rec(i).phone_number, SYSDATE, vTEXT_ERROR);
          COMMIT;    
      end;  
    END IF; 
    commit;                         
  END LOOP;
END;