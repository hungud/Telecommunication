CREATE OR REPLACE FUNCTION USSD_ADD_PROMISED_PAYMENT (
   pPHONE_NUMBER   IN VARCHAR2,
   pPROMISED_SUM   IN NUMBER)
RETURN VARCHAR2 AS
--   
--#Version=1
--
--v.1 Афросин 08.06.2015 - Функция добавления обещанного платежа по USSD
--   
   cPAYMENT_DATE CONSTANT DATE := TRUNC (SYSDATE) + 4;
   vRESULT   VARCHAR2 (2000);
   
BEGIN
  vRESULT :=
        ADD_PROMISED_PAYMENT (pPHONE_NUMBER,
                                        pPROMISED_SUM,
                                        cPAYMENT_DATE);
  IF INSTR(Upper(vRESULT), 'ДОБАВЛЕН') > 0 then
    vRESULT := pPROMISED_SUM||'р. зачислено до '||to_char(cPAYMENT_DATE, 'dd.mm.yyyy');
  ELSE
    vRESULT := 'Ошибка. Есть действующий платеж.';
  END IF;
    
  RETURN TRIM(vRESULT);
END;
/
