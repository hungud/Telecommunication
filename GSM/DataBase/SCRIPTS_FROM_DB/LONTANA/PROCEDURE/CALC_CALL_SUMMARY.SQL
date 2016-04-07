
  CREATE OR REPLACE PROCEDURE "LONTANA"."CALC_CALL_SUMMARY" (
    pYEAR_MONTH NUMBER DEFAULT 0,  -- период, по которому будет произведен расчет статистики, если NULL - по всему периоду (начиная с 201308) 
    CALC_CUR_CALL NUMBER DEFAULT 0 -- пересчитывать или нет статистику по невыгруженным периодам 
) IS 
-- Процедура, которая считает сводную статистику по детализациям 
-- Для тех детализаций, которые уже выгружены во внешние таблицы EXT_CALL_MM_YYYY данные не пересчитываем
--
-- #Version=1  
  -- СПИСОК МЕСЯЦЕВ, ДЛЯ КОТОРЫХ ДЕТАЛИЗАЦИИ ХРАНЯТЬСЯ ВО ВНЕШНИХ ТАБЛИЦАХ 
  cursor CUR_IN_CALL (pYEAR_MONTH NUMBER default null) is     
    select distinct HBM.YEAR_MONTH
      from HOT_BILLING_MONTH hbm               
     where HBM.DB = 1               -- Считаем по тем данным, которые уже выгружены во внешние таблицы 
       and HBM.YEAR_MONTH >= 201308 -- так как выгрузка в EXT_CALL_MM_YYYY ранее не производилась
       and (
            HBM.YEAR_MONTH = pYEAR_MONTH 
          or 
            nvl(pYEAR_MONTH, 0) = 0 
           )                 
    order by HBM.YEAR_MONTH
   ; 
  
  -- СПИСОК МЕСЯЦЕВ, ДЛЯ КОТОРЫХ ДЕТАЛИЗАЦИИ ХРАНЯТЬСЯ ВО ВНЕШНИХ ТАБЛИЦАХ 
  cursor CUR_IN_EXT_TABLE (pYEAR_MONTH NUMBER default null) is     
    select distinct HBM.YEAR_MONTH
      from HOT_BILLING_MONTH hbm               
     where HBM.DB = 0               -- Считаем по тем данным, которые уже выгружены во внешние таблицы 
       and HBM.YEAR_MONTH >= 201308 -- так как выгрузка в EXT_CALL_MM_YYYY ранее не производилась
       and (
            HBM.YEAR_MONTH = pYEAR_MONTH 
          or 
            nvl(pYEAR_MONTH, 0) = 0 
           )                 
    order by HBM.YEAR_MONTH
   ; 

   
  PROCEDURE CLEAR_CALL_SUMMARY_MONTH (pYEAR_MONTH NUMBER) IS
  -- ПРОЦЕДУРА ЧИСТИТ ДАННЫЕ ЗА УКАЗАННЫЙ МЕСЯЦ ЕСЛИ ОН ПЕРЕДАН И ЗА ВСЕ ВРЕМЯ, ПО УМОЛЧАНИЮ
  BEGIN
    DELETE FROM CALL_SUMMARY CS
      WHERE (CS.YEAR_MONTH = pYEAR_MONTH OR NVL(pYEAR_MONTH, 0) = 0); 
  END;
       
begin
--  FOR REC IN CUR_IN_EXT_TABLE(pYEAR_MONTH) LOOP 
--    -- Зачищаем данные из таблицы за месяц, который будем пересчитывать
--    CLEAR_CALL_SUMMARY_MONTH(REC.YEAR_MONTH);    
--    
--    -- Рассчитываем показатели по внешним таблице(-ам)
--    EXECUTE IMMEDIATE 'INSERT INTO CALL_SUMMARY (SUBSCR_NO, ISROAMING, SERVICEDIRECTION, SERVICETYPE, CALL_COST, COUNT_CALL, AT_CHG_AMT, IS_BEELINE, COST_CHNG, COSTNOVAT, DUR, YEAR_MONTH)
--        SELECT C.SUBSCR_NO SUBSCR_NO,
--               C.ISROAMING ISROAMING, 
--               C.SERVICEDIRECTION SERVICEDIRECTION,
--               C.SERVICETYPE SERVICETYPE,      
--               sum(C.CALL_COST) CALL_COST, 
--               COUNT(C.CALL_COST) COUNT_CALL,
--               sum(to_number(replace(C.AT_CHG_AMT,'','',''.''))) AT_CHG_AMT,
--                as IS_BEELINE,            
--               sum(C.COST_CHNG) COST_CHNG,  
--               sum(C.COSTNOVAT) COSTNOVAT,   
--               sum(C.DUR) DUR, '||to_char(rec.YEAR_MONTH)||'
--          FROM EXT_CALL_'|| to_char(to_date(rec.YEAR_MONTH,'YYYYMM'), 'mm_yyyy') ||' c
--        group by C.SERVICEDIRECTION, C.ISROAMING, C.SERVICETYPE, C.SUBSCR_NO, decode()
--        ';
--    --DBMS_OUTPUT.PUT_LINE('Период ='||to_char(rec.YEAR_MONTH)||', закончен в '||to_char(sysdate, 'yyyy.mm.dd hh:mi:ss'));     
--    INSERT INTO temp_log (msg) values ('Период ='||to_char(rec.YEAR_MONTH)||', закончен в '||to_char(sysdate, 'yyyy.mm.dd hh:mi:ss'));
--    COMMIT;
--  END LOOP;
  
  IF (CALC_CUR_CALL <> 0) THEN 
    FOR REC IN CUR_IN_CALL(pYEAR_MONTH) LOOP
      -- Зачищаем данные из таблицы за месяц, который будем пересчитывать
      CLEAR_CALL_SUMMARY_MONTH(REC.YEAR_MONTH);
      
      --  Рассчитываем показатели по невыгруженной детализации
      EXECUTE IMMEDIATE  'INSERT INTO CALL_SUMMARY (SUBSCR_NO, ISROAMING, SERVICEDIRECTION, SERVICETYPE, CALL_COST, COUNT_CALL, IS_BEELINE, IS_PAID, AT_CHG_AMT, COST_CHNG, COSTNOVAT, DUR, YEAR_MONTH)
        SELECT 
               C.SUBSCR_NO    SUBSCR_NO, 
               C.ISROAMING    ISROAMING, 
               C.SERVICEDIRECTION    SERVICEDIRECTION, 
               C.SERVICETYPE    SERVICETYPE, 
               SUM(C.CALL_COST)    CALL_COST, 
               COUNT(*)       COUNT_CALL, 
               (case when C.AT_FT_DE like ''%Билайн%'' then 1 else 0 end) IS_BEELINE,
               (case when nvl(C.COSTNOVAT,0) = 0 then 0 else 1 end) IS_PAID,
               sum(to_number(replace(C.AT_CHG_AMT,'','',''.''))) AT_CHG_AMT, 
               SUM(C.COST_CHNG)    COST_CHNG, 
               SUM(C.COSTNOVAT)    COSTNOVAT, 
               SUM(C.DUR)    DUR, '||to_char(rec.YEAR_MONTH)||'
          FROM CALL_'|| to_char(to_date(rec.YEAR_MONTH,'YYYYMM'), 'mm_yyyy') ||' c
        group by C.SERVICEDIRECTION, C.ISROAMING, C.SERVICETYPE, C.SUBSCR_NO, (case when C.AT_FT_DE like ''%Билайн%'' then 1 else 0 end), (case when nvl(C.COSTNOVAT,0) = 0 then 0 else 1 end) 
        ';
      commit;
    END LOOP;
  END IF;
end;