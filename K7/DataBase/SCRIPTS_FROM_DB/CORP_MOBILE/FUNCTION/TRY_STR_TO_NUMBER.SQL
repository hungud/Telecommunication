
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."TRY_STR_TO_NUMBER" (S IN VARCHAR2) RETURN NUMBER IS
--#Version=1
-- Преобразует строку в число.
-- Если преобразование не удалось (строка не является числом), то возвращает NULL
BEGIN
  RETURN TO_NUMBER(S);
EXCEPTION WHEN OTHERS THEN
  RETURN NULL;
END; 