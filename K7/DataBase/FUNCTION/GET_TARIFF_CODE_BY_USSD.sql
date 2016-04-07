CREATE OR REPLACE function GET_TARIFF_CODE_BY_USSD(pUSSD_CODE varchar2, pERROR_MESSAGE out varchar2, pTariffID out INTEGER) Return varchar is
--#Version =1
--
--v.1 13.07.2015 Афросин Добавил функцию получения ID тарифа из USSD. USSD КОДМАНДА ИМЕЕТ СЛЕДУЮЩИЙ ШАБЛОН:*132*100TARIFF_ID#  
--  
  
  cUSSD_POSTFIX CONSTANT CHAR(1) := '#'; --ЗАВЕРШАЮЩИЙ СИМВОЛ USSD КОМАНДЫ
  cUSSD_DELIM CONSTANT CHAR(1) := '%'; --ЗАВЕРШАЮЩИЙ СИМВОЛ USSD КОМАНДЫ
    
  res TARIFFS.TARIFF_CODE%TYPE;
  vUSSD_PREFIX ussd_leafs.ussd%TYPE;
begin
  pERROR_MESSAGE := null;
  begin
  select ul.ussd
   INTO vUSSD_PREFIX
   FROM ussd_leafs ul
  WHERE pUSSD_CODE LIKE ul.ussd
    and UPPER(UL.USE_FOR_COLUMN) = 'TARIFFS.TARIFF_ID';
  exception
    when OTHERS then
      pERROR_MESSAGE := 'USSD команда не найдена!!!';
  end;
    
  --Получаем тариф ID
  vUSSD_PREFIX := REPLACE(vUSSD_PREFIX, cUSSD_DELIM, '');
  vUSSD_PREFIX := REPLACE(vUSSD_PREFIX, cUSSD_POSTFIX, '');
  res := REPLACE(pUSSD_CODE, vUSSD_PREFIX, '');
  res := REPLACE(res, cUSSD_POSTFIX, '');
  pTariffID := res;
  begin
    select TARIFF_CODE into res
    from
      tariffs
    where 
      tariff_id = to_number(res);
  exception
    when OTHERS then
      pERROR_MESSAGE := 'Код тарифа не найден!!!';
  end;
    
  RETURN res;  
end;
