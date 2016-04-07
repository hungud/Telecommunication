CREATE OR REPLACE PROCEDURE TURN_ON_OFF_TARIFF_OPTIONS IS
--
--#Version=1
--
--v.1 08.06.2015 Афросин - Добавил процедуру для подключения/отключения услуг будущей датой
--
  cursor c is
    SELECT 
      DELAYED_TURN_TO_ID,
      PHONE_NUMBER,
      OPTION_CODE,
      ACTION_TYPE,
      ACTION_DATE,
      DATE_CREATED,
      USER_CREATED,
      DATE_LAST_UPDATED,
      USER_LAST_UPDATED 
    FROM 
      DELAYED_ON_OFF_TARIFF_OPTIONS
    WHERE 
      ACTION_DATE <= SYSDATE;
  v_result_turn varchar2(3000);
  vExpDate DATE;--дата отключения
  vEffDate DATE; --дата подключения
  cv_result_turn        CLOB;  
BEGIN
  DBMS_LOB.CREATETEMPORARY (cv_result_turn, TRUE);
  FOR v IN c LOOP 
    v_result_turn := '';
    if nvl(v.ACTION_TYPE, 0) = 0 then
      -- отключаем услугу
      vExpDate := v.ACTION_DATE;
      vEffDate := null;
    else
      -- подключаем услугу
      vEffDate := v.ACTION_DATE;
      vExpDate := null;
    end if; 
    
    v_result_turn := beeline_api_pckg.TURN_TARIFF_OPTION(v.phone_number, v.option_code, v.ACTION_TYPE, vEffDate, vExpDate, substr('DELAYED_'||v.USER_CREATED,-10));
   
    
    --Вставляем записи в лог
    INSERT INTO DELAYED_ON_OFF_TARIFF_OPT_LOG 
                                             (
                                              PHONE_NUMBER,
                                              OPTION_CODE,
                                              ACTION_TYPE,
                                              ACTION_DATE,
                                              DATE_CREATED,  
                                              USER_CREATED,
                                              REQUEST_DATE_TIME,
                                              RESULT_TURN,
                                              DATE_LAST_UPDATED,
                                              USER_LAST_UPDATED
                                             )
    VALUES
                                            (
                                             v.PHONE_NUMBER,
                                             v.OPTION_CODE,
                                             v.ACTION_TYPE,
                                             v.ACTION_DATE,
                                             v.DATE_CREATED,  
                                             v.USER_CREATED,
                                             SYSDATE,
                                             'Result: '||v_result_turn,
                                             v.DATE_LAST_UPDATED,
                                             v.USER_LAST_UPDATED
                                            );
   
                                            
    
    -- удаляем отработанную запись из очереди
    DELETE FROM DELAYED_ON_OFF_TARIFF_OPTIONS
    WHERE 
      DELAYED_TURN_TO_ID = v.delayed_turn_to_id;

    if InStr(Upper(v_result_turn), 'ЗАЯВКА')  = 0 then
        v_result_turn := v.PHONE_NUMBER ||chr(9)||
                         v.OPTION_CODE||chr(9)||
                         case v.ACTION_TYPE
                           when 1 then 'Подключение'
                         else
                           'Отключиение'
                         end||chr(9)||
                         v_result_turn
                         ||'<br>';
                         
       DBMS_LOB.APPEND (cv_result_turn, v_result_turn);
    end if;
    
    COMMIT;  
    
  END LOOP;
  
  IF NVL (DBMS_LOB.getlength (cv_result_turn), 0) > 0 then
    send_sys_mail ('Ошибки при отправке заявок на отложенное подключение услуг', cv_result_turn, 'MAIL_ERROR_TURN_TARIFF_OPTIONS');
  end if;
end;
/

