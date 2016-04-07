CREATE OR REPLACE PROCEDURE P_REPORT_PHONE_INACTIVE AS

    --version 1  
    --
    --version 1. Алексеев. Создана процедура получения номеров c отсутствующей активностью (для отчета номера отсутствующей активностью).

BEGIN
  --получение отчета производится за максимальный возможный период (за 2 месяца) каждые 4 часа, начиная с 00:03:00
  --если результат выполнения job отрицательный, то его перезапустит другой job, который следит за его проверкой
  --удаляенм данные из таблицы, т.к. они уже устарели
  DELETE FROM REPORT_PHONE_INACTIVE;
  commit; 
    
  --определяем даты периода, за который получаем отчет
  --от текущей даты вычитаем 2 месяца и берем дату начала полученного месяца
  --получаем данные и пишем их в таблицу
  INSERT INTO REPORT_PHONE_INACTIVE 
  (
    LOGIN, 
    PHONE_NUMBER_FEDERAL, 
    CONTRACT_DATE, 
    BALANCE, 
    PHONE_IS_ACTIVE, 
    DOP_STATUS_NAME, 
    LAST_CHECK_DATE_TIME, 
    DATE_CREATED, 
    CURR_TARIFF_ID, 
    TARIFF_NAME,
    INSERT_DATE
  ) 
  select 
    LOGIN, 
    PHONE_NUMBER_FEDERAL, 
    CONTRACT_DATE, 
    BALANCE, 
    PHONE_IS_ACTIVE, 
    DOP_STATUS_NAME, 
    LAST_CHECK_DATE_TIME, 
    DATE_CREATED, 
    CURR_TARIFF_ID, 
    TARIFF_NAME,
    sysdate
  from table(GET_PHONE_INACTIVE_TAB(trunc(add_months(sysdate, -2), 'MM'), trunc(sysdate)));

  --фиксируем
  commit;        
END;