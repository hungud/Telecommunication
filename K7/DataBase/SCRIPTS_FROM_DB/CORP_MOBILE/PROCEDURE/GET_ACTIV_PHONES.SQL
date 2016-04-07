
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."GET_ACTIV_PHONES" (
  pYEAR_MONTH IN INTEGER
  ) IS
--
--#Version=3
--
--v.3 01.02.2016 Афросин - переделал цикл по запросу
--v.2 07.09.2015 Афросин - переделал запрос на параметры
--
  
  vMONTH VARCHAR2(10 CHAR);
  cMONTH VARCHAR2(10 CHAR);
  vAT_FT_DE varchar2(29 char);
  vPhone0611 varchar2(4 char);
  vPhone0622 varchar2(4 char);
  i integer;
  TYPE TPhoneNumber IS TABLE OF PHONE_ACTIV_LOG.PHONE_NUMBER%TYPE index by binary_integer;
  ARRPhoneNUmber TPhoneNumber;
  
  TYPE EmpCurTyp IS REF CURSOR;  -- define weak REF CURSOR type
  cur   EmpCurTyp;
  
BEGIN
  vMONTH:=TO_CHAR(pYEAR_MONTH);
  cMONTH:=SUBSTR(vMONTH, 5, 2) || '_' || SUBSTR(vMONTH, 1, 4);
  vAT_FT_DE := 'Тарификация услуг SMS/RBT_CPA';
  vPhone0611 := '0611';
  vPhone0622 := '0622';
  ARRPhoneNUmber.Delete;
  /*DELETE 
    FROM PHONE_ACTIV_LOG
    WHERE YEAR_MONTH=pYEAR_MONTH;*/
    OPEN cur FOR '
      select distinct V.PHONE_NUMBER
      from (select distinct ca.SUBSCR_NO AS PHONE_NUMBER
              from call_' || cMONTH || ' ca
              where ca.AT_FT_DE <> :pAT_FT_DE
                and nvl(ca.CALLING_NO, ca.SUBSCR_NO) not in (:pPhone0611, :vPhone0622)
                and nvl(ca.DIALED_DIG, ca.SUBSCR_NO) not in (:pPhone0611, :vPhone0622)
            union all
            select * 
              from (SELECT distinct H.PHONE_NUMBER
                      FROM V_HISTORY_ACTIV_PHONE h
                      WHERE H.BEGIN_YM <= :vMONTH
                        and h.END_YM >= :vMONTH) v
              where exists (select 1
                              from db_loader_payments p
                              where p.PHONE_NUMBER = v.PHONE_NUMBER  
                                and ( to_char(p.PAYMENT_DATE, ''yyyymm'') = :vMONTH
                                  or to_char(add_months(p.PAYMENT_DATE, 1), ''yyyymm'') = :vMONTH))
            ) V
      WHERE EXISTS (SELECT 1
                      FROM CONTRACTS C, CONTRACT_CANCELS CC
                      WHERE C.PHONE_NUMBER_FEDERAL = V.PHONE_NUMBER
                        AND C.CONTRACT_DATE <= LAST_DAY(TO_DATE(:vMONTH, ''YYYYMM''))
                        AND C.CONTRACT_ID = CC.CONTRACT_ID(+)
                        AND ((CC.CONTRACT_CANCEL_DATE IS NULL)
                              OR (CC.CONTRACT_CANCEL_DATE >= TO_DATE(:vMONTH, ''YYYYMM'')))
                        )  
        AND NOT EXISTS (SELECT 1
                          FROM PHONE_ACTIV_LOG L
                          WHERE L.YEAR_MONTH = :vMONTH
                            AND L.PHONE_NUMBER = V.PHONE_NUMBER)   ' USING vAT_FT_DE, vPhone0611, vPhone0622, vPhone0611, vPhone0622,  vMONTH, vMONTH, vMONTH, vMONTH, vMONTH, vMONTH, vMONTH; 
  
  
    loop
      ARRPhoneNUmber.Delete;
      
      FETCH cur BULK COLLECT INTO ARRPhoneNUmber limit 1000;
      EXIT WHEN ARRPhoneNUmber.count = 0 ;
      
      FORALL i in ARRPhoneNUmber.FIRST..ARRPhoneNUmber.LAST 
        INSERT INTO PHONE_ACTIV_LOG (YEAR_MONTH, PHONE_NUMBER) 
         values (vMONTH, ARRPhoneNUmber(i));
      
      COMMIT;
    end loop;
   CLOSE cur;
   
  
--  FORALL i in ARRPhoneNUmber.FIRST..ARRPhoneNUmber.LAST 
--    INSERT INTO PHONE_ACTIV_LOG (YEAR_MONTH, PHONE_NUMBER) 
--      values (vMONTH, ARRPhoneNUmber(i));
--  
--  
--  
  
end;