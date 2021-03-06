CREATE OR REPLACE FUNCTION CORP_MOBILE_LK.SET_USER_PARAMS(
  pCONTRACT_ID IN INTEGER,
  pEMAIL IN VARCHAR2,
  pCONTACT_PHONE IN VARCHAR2,
  pPASSWORD IN VARCHAR2
  ) RETURN INTEGER IS
--
--#Version=2
--
  vABONENT_ID INTEGER;
  CURSOR cFIND IS
    SELECT CONTRACT_ID
    FROM ABONENT_ADD_INFO
    WHERE ABONENT_ADD_INFO.CONTRACT_ID=pCONTRACT_ID;
  vDUMMY INTEGER;
BEGIN
  SELECT ABONENT_ID
  INTO vABONENT_ID
  FROM CORP_MOBILE.CONTRACTS
  WHERE CONTRACTS.CONTRACT_ID=pCONTRACT_ID;
  --
  IF pPASSWORD IS NOT NULL THEN
    UPDATE CORP_MOBILE.CONTRACTS
    SET USER_PASSWORD=pPASSWORD
    WHERE CONTRACT_ID=pCONTRACT_ID;
  END IF;
  --
  OPEN cFIND;
  FETCH cFIND INTO vDUMMY;
  IF cFIND%FOUND THEN
    UPDATE ABONENT_ADD_INFO
    SET 
      EMAIL=SUBSTRB(pEMAIL, 1, 100), 
      CONTACT_PHONE=SUBSTR(pCONTACT_PHONE, 1, 10)
    WHERE 
      ABONENT_ADD_INFO.CONTRACT_ID=pCONTRACT_ID;
  ELSE
    INSERT INTO ABONENT_ADD_INFO (
      CONTRACT_ID, 
      EMAIL, 
      CONTACT_PHONE
      ) VALUES (
      pCONTRACT_ID, 
      SUBSTRB(pEMAIL, 1, 100), 
      SUBSTR(pCONTACT_PHONE, 1, 10)
      );
  END IF;
  CLOSE cFIND;
  RETURN 1;
EXCEPTION WHEN NO_DATA_FOUND THEN
  RETURN 0;
END;
/

--GRANT UPDATE (EMAIL, CONTACT_INFO) ON ABONENTS TO CORP_MOBILE_LK;  

/*

begin
  dbms_output.put_line(corp_mobile_lk.set_user_params(31688, 'uu@mail.ru', '333', null));
end;

*/
