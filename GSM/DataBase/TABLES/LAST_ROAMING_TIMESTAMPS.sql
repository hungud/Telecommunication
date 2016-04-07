--#if not TableExists("LAST_ROAMING_TIMESTAMPS") then
CREATE TABLE LAST_ROAMING_TIMESTAMPS
(
  PHONE_NUMBER            VARCHAR2(11) PRIMARY KEY,
  LAST_SERVICE_DATE_TIME  DATE,
  LAST_FULLCOST_CALL_DATE_TIME DATE
) ORGANIZATION INDEX;
--#end if

--#if GetTableComment("LAST_ROAMING_TIMESTAMPS")<>"Последнее время роуминга для телефонного номера" then
COMMENT ON TABLE LAST_ROAMING_TIMESTAMPS IS 'Последнее время роуминга для телефонного номера';
--#end if

--#if GetColumnComment("LAST_ROAMING_TIMESTAMPS.PHONE_NUMBER") <> "Номер телефона (Первичный ключ)" then
COMMENT ON COLUMN LAST_ROAMING_TIMESTAMPS.PHONE_NUMBER IS 'Номер телефона (Первичный ключ)';
--#end if

--#if GetColumnComment("LAST_ROAMING_TIMESTAMPS.LAST_SERVICE_DATE_TIME") <> "Дата/время последней услуги в роуминге" then
COMMENT ON COLUMN LAST_ROAMING_TIMESTAMPS.LAST_SERVICE_DATE_TIME IS 'Дата/время последней услуги в роуминге';
--#end if

--#if GetColumnComment("LAST_ROAMING_TIMESTAMPS.LAST_FULLCOST_CALL_DATE_TIME") <> "Дата/время последнего звонка в роуминге по полной стоимости" then
COMMENT ON COLUMN LAST_ROAMING_TIMESTAMPS.LAST_FULLCOST_CALL_DATE_TIME IS 'Дата/время последнего звонка в роуминге по полной стоимости';
--#end if
