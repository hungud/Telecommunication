CREATE OR REPLACE FUNCTION CHECK_DISCR_SPISANIE_ABON(pPHONE_NUMBER varchar2) RETURN INTEGER IS

  --Version 1
  --
  --v.1 Алексеев 30.10.2015 Функция проверки фиксации дискретного списания абон. платы по тарифу.
  
  vResult integer;
  v_cnt integer;
begin
  vResult := 0;
  BEGIN
    --проверяем наличие записи в логах дискретного списания абон. плат по тп.
    --в зависимости от номера, типа, месяца и тарифа 
    select count(*)
        into v_cnt
      from LOG_DISCR_SPISANIE_ABON lg
    where lg.PHONE_NUMBER = pPHONE_NUMBER
        and lg.CHARGES_TYPE_ID = 8
        and lg.YEAR_MONTH = to_number(to_char(sysdate, 'YYYYMM'))
        and lg.TARIFF_ID = GET_CURR_PHONE_TARIFF_ID(pPHONE_NUMBER);

    --если есть номера, подходящие под все условия, то абон. плата по тп была зафиксированна
    IF nvl(v_cnt, 0) <> 0 THEN
      vResult := 1;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      vResult := 0;  
  END;
  
  --выводим результат
  return vResult;
end;
