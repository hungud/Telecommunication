CREATE OR REPLACE PROCEDURE SQL_GET_ABONENT_BALANCE(
  pPHONE_NUMBER IN VARCHAR2,
  pBALANCE_VALUE OUT NUMBER
  ) IS
--#Version=1
--
BEGIN
  LONTANA.WWW_GET_ABONENT_BALANCE(pPHONE_NUMBER, pBALANCE_VALUE);
END;
/
