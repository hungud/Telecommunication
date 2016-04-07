CREATE OR REPLACE PROCEDURE TARIFER_MONTH_BILL_CREATE IS
-- Version = 2.
--
-- 2. 2015.10.29. Крайнов. Создание файла.  
BEGIN
  -- Получение всех расшифровок баланса
  CALC_BALANCE_ROWS_ALL;
  -- Создание на основе выгрузки счетов Тарифера
  TARIFER_BILL_CREATE_ALL_BILLS(TO_NUMBER(TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'YYYYMM')));
  -- Сохраним детали счетов.
  insert into TARIFER_BILL_FOR_CLIENT_DET(YEAR_MONTH, PHONE_NUMBER, 
                                          ROW_DATE, ROW_COST, ROW_COMMENT, ROW_TYPE)
    select TO_NUMBER(TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'YYYYMM')), x.PHONE_NUMBER, 
           x.ROW_DATE, x.ROW_COST, x.ROW_COMMENT, x.ROW_TYPE
      from ABONENT_BALANCE_ROWS_ALL x
      where nvl(x.ROW_TYPE, 0) IN (1, 2, 3, 4, 5)
        and TO_CHAR(x.ROW_DATE, 'YYYYMM') = TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'YYYYMM');
  commit;
  insert into ACCOUNT_LOADED_BILLS(ACCOUNT_ID, YEAR_MONTH)
    select x.ACCOUNT_ID, TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'YYYYMM')
      from ACCOUNT_LOADED_BILLS x
      where x.YEAR_MONTH = TO_CHAR(ADD_MONTHS(SYSDATE, -2), 'YYYYMM')
        and not exists (select 1
                          from ACCOUNT_LOADED_BILLS y
                          where x.ACCOUNT_ID = y.ACCOUNT_ID
                            and y.YEAR_MONTH = TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'YYYYMM'));
  commit;
END;  