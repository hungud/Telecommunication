CREATE OR REPLACE FUNCTION GET_FILIAL_ID_BY_USER RETURN INTEGER IS
  CURSOR C IS 
    SELECT USER_NAMES.FILIAL_ID 
      FROM USER_NAMES
      WHERE USER_NAMES.USER_NAME = USER;
  ITOG INTEGER; 
  vDUMMY C%ROWTYPE;     
BEGIN
  OPEN C;
  FETCH C INTO vDUMMY;
  IF C%FOUND THEN
    IF vDUMMY.FILIAL_ID IS NOT NULL THEN
      ITOG:=vDUMMY.FILIAL_ID;
    ELSE
      ITOG:=-1;
    END IF;
  ELSE
    ITOG:=-1;
  END IF;
  RETURN ITOG;
END; 

--GRANT EXECUTE ON GET_FILIAL_ID_BY_USER TO SIM_TRADE_ROLE;

--GRANT EXECUTE ON GET_FILIAL_ID_BY_USER TO CORP_MOBILE_ROLE;

--GRANT EXECUTE ON GET_FILIAL_ID_BY_USER TO LONTANA_ROLE;