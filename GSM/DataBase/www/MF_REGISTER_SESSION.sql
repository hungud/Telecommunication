CREATE OR REPLACE PROCEDURE MF_REGISTER_SESSION(
  pPHONE_NUMBER IN VARCHAR2,
  pPASSWORD IN VARCHAR2,
  pSESSION_KEY OUT MF_SESSIONS.SESSION_KEY%TYPE,
  pUSER_ID OUT INTEGER
  ) IS
--
--#Version=3
--
  --vIS_LOCKED MF_USER_NAMES.IS_LOCKED%TYPE;
  vPASSWORD_HASH VARCHAR2(32);
  vTABLE_PASSWORD_HASH VARCHAR2(32);
  vCONNECTED BOOLEAN;
  --vFILIAL_ID MF_FILIALS.FILIAL_ID%TYPE;
--
/*
CURSOR cUSERS IS
  SELECT USER_ID, IS_LOCKED, IS_ADMIN, IS_ADMIN_USERS, PASSWORD_HASH
  FROM MF_USER_NAMES
  WHERE PHONE_NUMBER=pPHONE_NUMBER;*/
--
  FUNCTION GET_USER_LAST_ACCESS_DATE_TIME(pUSER_ID IN MF_SESSIONS.USER_ID%TYPE) RETURN DATE IS
    CURSOR CUR(pUSER_ID IN MF_SESSIONS.USER_ID%TYPE) IS
      SELECT MS.LAST_ACCESS_DATE_TIME
      FROM MF_SESSIONS MS
      WHERE MS.USER_ID = pUSER_ID
      ORDER BY MS.LAST_ACCESS_DATE_TIME DESC NULLS LAST;
    vRES DATE := NULL;
  BEGIN   
    OPEN CUR(pUSER_ID);
    FETCH CUR INTO vRES;
    CLOSE CUR;
    RETURN vRES;
  END;  
BEGIN
  pUSER_ID := SQL_GET_USER_ID(
    pPHONE_NUMBER=>pPHONE_NUMBER,
    pPASSWORD=>pPASSWORD
    );
  IF pUSER_ID IS NOT NULL THEN
    G_STATE.PREV_ACCESS_DATE_TIME := GET_USER_LAST_ACCESS_DATE_TIME(pUSER_ID);
    -- ������������� ������ ������� � GUID � ���������� ����� �� 00000 �� 99999
    pSESSION_KEY := SYS_GUID || SUBSTR('0000' || DBMS_UTILITY.GET_TIME, -5, 5);
    INSERT INTO MF_SESSIONS (
      SESSION_ID,
      SESSION_KEY,
      START_DATE_TIME,
      LAST_ACCESS_DATE_TIME,
      USER_ID,
      PREV_ACCESS_DATE_TIME
    ) VALUES (
      MF_S_NEW_SESSION_ID.NEXTVAL,
      pSESSION_KEY,
      SYSDATE,
      SYSDATE,
      pUSER_ID,
      G_STATE.PREV_ACCESS_DATE_TIME
    );
    COMMIT;
    -- ������������ ������� "�����������"
    --MF_STAT_HIT('1', pUSER_ID);
  END IF;
END MF_REGISTER_SESSION; 
/

