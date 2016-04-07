CREATE OR REPLACE function CHECK_SEND_SMS_NOTICE(pPHONE_NUMBER varchar2) RETURN INTEGER IS

  --Version 1
  --
  --v.1 Алексеев 30.10.2015 Функция проверки возможности отправки смс о балансе близком к 0.
  --                        Смс о приближении баланса к 0 не отправляем если одновременно выполняются следующие условия:
  --                        1. номер коллекторский
  --                        2. на номере тп с дискретным списанием абон. платы
  --                        3. отсекаем номера, у которых имеется сдвиг дискретного списания и в теущем месяце идет посуточное списание.
  --                        4. была списана абонка по тп
  --                        5. после списания абонки по тп не было списаний абонок по услугам
  --                        6. после списания абонки по тп не было звонков, смс, трафика, ммс (детализации)
  --                        Текущий алгоритм начнет работу с 01.11.2015.
  
  vResult integer;
  v_cnt integer;
begin
  vResult := 1;
  --проверяем номер на принадлежность к коллекторам
  --если коллекторский, то проверяем далее, иначе выходим с положительным ответом по отправке
  IF (GET_IS_COLLECTOR_BY_PHONE(pPHONE_NUMBER) = 1) AND (trunc(sysdate) >= to_date('01.11.2015', 'DD.MM.YYYY')) THEN
    --проверяем выплнение условий
    EXECUTE IMMEDIATE '
     select count(*)
      from v_contracts v,
              tariffs tr
    where V.PHONE_NUMBER_FEDERAL = :pPHONE_NUMBER
        and V.CONTRACT_CANCEL_DATE is null
        and V.TARIFF_ID = TR.TARIFF_ID
        and nvl(TR.DISCR_SPISANIE, 0) = 1
        and to_number(to_char(sysdate, ''YYYYMM'')) >= to_number(to_char(add_months(V.CONTRACT_DATE, nvl(TR.SDVIG_DISCR_SPISANIE, 0)), ''YYYYMM''))
        and exists (
                          select 1
                            from LOG_DISCR_SPISANIE_ABON lg
                          where lg.PHONE_NUMBER = V.PHONE_NUMBER_FEDERAL
                              and lg.CHARGES_TYPE_ID = 8
                              and lg.YEAR_MONTH = to_number(to_char(sysdate, ''YYYYMM''))
                              and lg.TARIFF_ID = V.TARIFF_ID
                       )
        and not exists (
                               select 1
                                 from LOG_DISCR_SPISANIE_ABON lg
                              where lg.PHONE_NUMBER = V.PHONE_NUMBER_FEDERAL
                                  and lg.CHARGES_TYPE_ID = 9
                                  and lg.YEAR_MONTH = to_number(to_char(sysdate, ''YYYYMM''))
                                  and lg.TARIFF_ID = V.TARIFF_ID
                                  and lg.DATE_INSERT >= (
                                                                          select MAX(lg2.DATE_INSERT)
                                                                            from LOG_DISCR_SPISANIE_ABON lg2
                                                                          where lg2.PHONE_NUMBER = V.PHONE_NUMBER_FEDERAL
                                                                              and lg2.CHARGES_TYPE_ID = 8
                                                                              and lg2.YEAR_MONTH = to_number(to_char(sysdate, ''YYYYMM''))
                                                                              and lg2.TARIFF_ID = V.TARIFF_ID
                                                                       )
                            )
        and not exists (
                               select 1
                                 from call_'||to_char(sysdate, 'mm_yyyy')||' c
                               where C.SUBSCR_NO = V.PHONE_NUMBER_FEDERAL 
                                   and nvl(C.CALL_COST, 0) <> 0  
                                   and C.START_TIME >= (
                                                                          select MAX(lg2.DATE_INSERT)
                                                                            from LOG_DISCR_SPISANIE_ABON lg2
                                                                          where lg2.PHONE_NUMBER = V.PHONE_NUMBER_FEDERAL
                                                                              and lg2.CHARGES_TYPE_ID = 8
                                                                              and lg2.YEAR_MONTH = to_number(to_char(sysdate, ''YYYYMM''))
                                                                              and lg2.TARIFF_ID = V.TARIFF_ID
                                                                       )
                            )' 
    INTO v_cnt USING pPHONE_NUMBER; 
    
    --если есть номера, подходящие под все условия, то смс не отправляем
    IF nvl(v_cnt, 0) <> 0 THEN
      vResult := 0;
    END IF;
  END IF;
  
  --выводим результат
  return vResult;
end;