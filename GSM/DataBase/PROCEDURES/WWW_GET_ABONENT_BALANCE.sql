CREATE OR REPLACE PROCEDURE WWW_GET_ABONENT_BALANCE(
  pPHONE_NUMBER IN VARCHAR2,
  pBALANCE_VALUE OUT NUMBER
  ) IS
--#Version=1
--
BEGIN
  pBALANCE_VALUE := GET_ABONENT_BALANCE(pPHONE_NUMBER);
END;
/

GRANT EXECUTE ON WWW_GET_ABONENT_BALANCE TO LONTANA_WWW
/