
  CREATE OR REPLACE PROCEDURE "LONTANA"."UPDATE_CALL_ISROAMING" (pPHONE_NUMBER IN VARCHAR2, pBeginDate IN DATE, pEndDate IN DATE) IS
--#Version=3
--
--v3 Афросин 30,01,2015 - Сделал пересчет не только нулевых звонков
--v2 Афросин 16,01,2015 - Добавил преобразование дат в char
--
  sCall varchar2(20);
  mB integer;
  yB integer;
  mE integer;
  yE integer;
  sB varchar2(2);
BEGIN
  --определяем таблицу CALL
  yB := to_number(to_char(pBeginDate, 'YYYY'));
  mB := to_number(to_char(pBeginDate, 'MM')); 
  
  yE := to_number(to_char(pEndDate, 'YYYY'));
  mE := to_number(to_char(pEndDate, 'MM')); 
  
  if (pBeginDate <= pEndDate) AND (pbegindate <= sysdate) AND (yB=yE) AND (mB=mE) then 
    IF mB<10 THEN
      sCall := 'CALL_0'||mB||'_'||yB;
      sB := '0'||to_char(mB);
    ELSE
      sCall := 'CALL_'||mB||'_'||yB;
      sB := to_char(mB);
    end if;
    --обновляем данные звонков, которые в роуминге и у которым билайн выставил 0
    EXECUTE IMMEDIATE 'UPDATE '||sCall||' SET CALL_COST = round(costnovat * 1.18, 2) , COST_CHNG = round(costnovat * 1.18, 2)   - costnovat * 1.18
                                    WHERE SUBSCR_NO = '''||pPHONE_NUMBER||'''
                                    AND ISROAMING = ''1''
                                    AND SERVICETYPE = ''C''
                                    AND CALL_COST > 0
                                    --AND COSTNOVAT = 0
                                    AND START_TIME >= to_date('''||to_char(pBeginDate,'DD.MM.YYYY HH24:MI:SS')||''', ''DD.MM.YYYY HH24:MI:SS'')
                                    AND START_TIME <= to_date('''||to_char(pEndDate,'DD.MM.YYYY HH24:MI:SS')||''', ''DD.MM.YYYY HH24:MI:SS'')';
     commit;
    --обновление статистики
    HOT_BILLING_PCKG.CalcDetailSumOpt(pPHONE_NUMBER, to_date('01.'||sB||'.'||yB, 'dd.mm.yyyy'));   
  end if;
END;