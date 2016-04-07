CREATE OR REPLACE PROCEDURE WWW_DEALER.DO_LOAD_FROM_1C(pRESOURCE_TYPE VARCHAR2 DEFAULT NULL) IS
--#VERSION=2. 
--v2 - 04.08.2015 - Матюнин И. Добавлены загрузки для новых таблиц
BEGIN
  IF pRESOURCE_TYPE = 'PHONE_NUMBERS' THEN
    LOAD_1C.RELOAD_PHONE_NUMBERS;
    HTP.PRINT('Номера телефонов на центральном складе загружены успешно.');
  ELSIF pRESOURCE_TYPE = 'CONTRAGENTS' THEN
    LOAD_1C.RELOAD_CONTRAGENTS;
    HTP.PRINT('Список контрагентов загружен успешно.');
  ELSIF pRESOURCE_TYPE = 'ACTIVATIONS' THEN
    LOAD_1C.RELOAD_ACTIVATIONS;
    HTP.PRINT('Активированные номера загружены успешно.');
  ELSIF pRESOURCE_TYPE = 'BONUSES' THEN
    LOAD_1C.RELOAD_BONUSES;
    HTP.PRINT('Бонусы загружены успешно.');
  ELSIF pRESOURCE_TYPE = 'CONTRAGENT_RESTS' THEN
    LOAD_1C.RELOAD_CONTRAGENT_RESTS;
    HTP.PRINT('Остатки на складах контрагентов загружены успешно.');
  ELSIF pRESOURCE_TYPE = 'BALANCE_CHANGES' THEN
    LOAD_1C.RELOAD_BALANCE_CHANGES;
    HTP.PRINT('Изменения баланса контрагентов загружены успешно.');
  ELSIF pRESOURCE_TYPE = 'PHONE_RETURNS' THEN
    LOAD_1C.RELOAD_PHONE_RETURNS;
    HTP.PRINT('Остатки на складах контрагентов успешно загружены.');
  ELSIF pRESOURCE_TYPE = 'TARIFF_CHANGE_RULES' THEN 
    LOAD_1C.RELOAD_TARIFF_CHANGE_RULES;
    HTP.PRINT('Правила изменения тарифов успешно загружены.');
  ELSIF pRESOURCE_TYPE = 'CONTRAGENT_PERCENTS' THEN
    LOAD_1C.RELOAD_CONTRAGENT_PERCENTS;
    HTP.PRINT('Проценты контрагентов успешно загружены.');
  ELSIF pRESOURCE_TYPE = 'TARIFF_PERCENTS' THEN 
    LOAD_1C.RELOAD_CONTR_TARIFF_PERCENTS;
    HTP.PRINT('Проценты по тарифам успешно загружены.');
  ELSIF pRESOURCE_TYPE = 'CONTR_TARIFF_PERCENTS' THEN 
    LOAD_1C.RELOAD_CONTR_TARIFF_PERCENTS;
    HTP.PRINT('Проценты контрагентов по тарифам успешно загружены.');    
  ELSE
    HTP.PRINT('Загрузка из 1С не удалась. Вид загрузки не поддерживается "'||pRESOURCE_TYPE||'".');
  END IF;
EXCEPTION WHEN OTHERS THEN
  HTP.PRINT('Ошибка загрузки из 1С.'||CHR(13)||CHR(10)||dbms_utility.format_error_stack ||CHR(13)||CHR(10)|| dbms_utility.format_error_backtrace);
END;
/
