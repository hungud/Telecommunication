
  CREATE OR REPLACE PROCEDURE "SIM_TRADE"."GET_ACTIV_PHONES" (pYEAR_MONTH IN INTEGER)
IS
   vMONTH   VARCHAR2 (10 CHAR);
   cMONTH   VARCHAR2 (10 CHAR);
BEGIN
   vMONTH := TO_CHAR (pYEAR_MONTH);
   cMONTH := SUBSTR (vMONTH, 5, 2) || '_' || SUBSTR (vMONTH, 1, 4);

   /*DELETE
     FROM PHONE_ACTIV_LOG
     WHERE YEAR_MONTH=pYEAR_MONTH;*/
   EXECUTE IMMEDIATE
         '
  INSERT INTO PHONE_ACTIV_LOG(YEAR_MONTH, PHONE_NUMBER)
  select distinct '
      || vMONTH
      || ', V.PHONE_NUMBER
      from (select distinct ca.SUBSCR_NO AS PHONE_NUMBER
              from call_'
      || cMONTH
      || ' ca
              where ca.AT_FT_DE <> ''Тарификация услуг SMS/RBT_CPA''
                and nvl(ca.CALLING_NO, ca.SUBSCR_NO) <> ''0611''
                and nvl(ca.CALLING_NO, ca.SUBSCR_NO) <> ''0622''
                and nvl(ca.DIALED_DIG, ca.SUBSCR_NO) <> ''0611''
                and nvl(ca.DIALED_DIG, ca.SUBSCR_NO) <> ''0622''              
            union all
            select * 
              from (SELECT distinct H.PHONE_NUMBER
                      FROM V_HISTORY_ACTIV_PHONE h
                      WHERE H.BEGIN_YM <='
      || vMONTH
      || '
                        and h.END_YM >= '
      || vMONTH
      || ') v
              where exists (select 1
                              from db_loader_payments p
                              where p.PHONE_NUMBER = v.PHONE_NUMBER  
                                and ( to_char(p.PAYMENT_DATE, ''yyyymm'') = '
      || vMONTH
      || '
                                  or to_char(add_months(p.PAYMENT_DATE, 1), ''yyyymm'') = '
      || vMONTH
      || '))
            ) V
      WHERE EXISTS (SELECT 1
                      FROM CONTRACTS C, CONTRACT_CANCELS CC
                      WHERE C.PHONE_NUMBER_FEDERAL = V.PHONE_NUMBER
                        AND C.CONTRACT_DATE <= LAST_DAY(TO_DATE('
      || vMONTH
      || ', ''YYYYMM''))
                        AND C.CONTRACT_ID = CC.CONTRACT_ID(+)
                        AND ((CC.CONTRACT_CANCEL_DATE IS NULL)
                              OR (CC.CONTRACT_CANCEL_DATE >= TO_DATE('
      || vMONTH
      || ', ''YYYYMM'')))
                        )  
        AND NOT EXISTS (SELECT 1
                          FROM PHONE_ACTIV_LOG L
                          WHERE L.YEAR_MONTH = '
      || vMONTH
      || '
                            AND L.PHONE_NUMBER = V.PHONE_NUMBER)   ';

   COMMIT;
END;