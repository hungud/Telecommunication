CREATE OR REPLACE PROCEDURE WWW_GET_USER_PHONE(
  pUSER_ID IN INTEGER,
  pPHONE_NUMBER OUT VARCHAR2
  ) IS
--#Version=1 ���������� �.�. ������� � ����� �����������
BEGIN
  SELECT CONTRACTS.PHONE_NUMBER_FEDERAL INTO pPHONE_NUMBER 
    FROM CONTRACTS
    WHERE pUSER_ID=CONTRACTS.CONTRACT_ID;
END;
/
GRANT EXECUTE ON WWW_GET_USER_PHONE TO LONTANA_WWW;
/
CREATE SYNONYM WWW_GET_USER_PHONE FOR LONTANA.WWW_GET_USER_PHONE;
