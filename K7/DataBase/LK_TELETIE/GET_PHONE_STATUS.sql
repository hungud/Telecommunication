GRANT SELECT ON DB_LOADER_ACCOUNT_PHONES TO CORP_MOBILE_LK;

CREATE OR REPLACE FUNCTION CORP_MOBILE_LK.GET_PHONE_STATUS(pPHONE_NUMBER IN VARCHAR2) RETURN NUMBER IS
--#Version=2
--
-- ���������� ������ �������� (1-�������, 0-����������)
CURSOR C IS
  SELECT PHONE_IS_ACTIVE
  FROM 
    CORP_MOBILE.DB_LOADER_ACCOUNT_PHONES
  WHERE PHONE_NUMBER=pPHONE_NUMBER
  ORDER BY LAST_CHECK_DATE_TIME DESC;
--
  RESULT NUMBER(1);
BEGIN
  OPEN C;
  FETCH C INTO RESULT;
  CLOSE C;
  RETURN RESULT;
END;
/

