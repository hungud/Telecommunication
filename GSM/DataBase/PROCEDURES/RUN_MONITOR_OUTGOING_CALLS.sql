CREATE OR REPLACE PROCEDURE RUN_MONITOR_OUTGOING_CALLS(
    pRUN_CURRENT_SESSION number default 0
) IS
  --V2
  -- 2. Матюнин - 30.04.2015 Добавлен параметр, запускать процедуру в текущей сессии или нет. Необходим для запроса
  
  -- 1. Матюнин - Проуедура запускает рассчет данных монитора исходящего голосового трафика для текущего периода
  -- В PARAMS обновляем значение для периода на текущий месяц.
  -- Запускаем джоб J_CALC_CALL_SUMMARY_STAT для обновления статистики
  -- Затем возвращаем смещение на прежнее.  
  
  vOLD_VALUE INTEGER;
  res integer;
BEGIN
  
  vOLD_VALUE := TO_NUMBER( MS_PARAMS.GET_PARAM_VALUE('MONTH_OFFSET_MONITOR_OUTGOING_CALLS') );
  res := MS_PARAMS.SET_PARAM_VALUE('MONTH_OFFSET_MONITOR_OUTGOING_CALLS','0');
  COMMIT;
  
  DBMS_LOCK.SLEEP(1);
  
  -- Если указано, запускать в текущей сесси, то передаем TRUE
  IF pRUN_CURRENT_SESSION = 0 then
    DBMS_SCHEDULER.RUN_JOB('J_CALC_CALL_SUMMARY_STAT', false);
  ELSE
    DBMS_SCHEDULER.RUN_JOB('J_CALC_CALL_SUMMARY_STAT');    
  END IF;

  -- Джоб не успевает стартануть с нужным параметром, атк что перд откатом значения сатвим задержку
  DBMS_LOCK.SLEEP(2); 
  res := MS_PARAMS.SET_PARAM_VALUE('MONTH_OFFSET_MONITOR_OUTGOING_CALLS', to_char(vOLD_VALUE) );
  COMMIT;
  
END;
/
