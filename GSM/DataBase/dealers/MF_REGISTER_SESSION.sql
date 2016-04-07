CREATE OR REPLACE PROCEDURE MF_REGISTER_SESSION(
  pUSER_NAME IN VARCHAR2,
  pPASSWORD IN VARCHAR2,
  pSESSION_KEY OUT MF_SESSIONS.SESSION_KEY%TYPE,
  pERROR_CODE OUT INTEGER,
  pERROR_MESSAGE OUT VARCHAR2,
  pUSER_ID OUT INTEGER,
  pIS_ADMIN OUT BINARY_INTEGER
  ) IS
--
--#Version=3
--
--
CURSOR cUSERS IS
  SELECT USER_ID, IS_LOCKED, IS_ADMIN, PASSWORD_HASH
  FROM D_USER_NAMES
  WHERE USER_NAME=pUSER_NAME;
--
  vIS_LOCKED D_USER_NAMES.IS_LOCKED%TYPE;
  vPASSWORD_HASH VARCHAR2(32);
  vTABLE_PASSWORD_HASH VARCHAR2(32);
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
--
BEGIN
  OPEN cUSERS;
  FETCH cUSERS INTO pUSER_ID, vIS_LOCKED, pIS_ADMIN, vTABLE_PASSWORD_HASH;
  IF NOT cUSERS%FOUND THEN
    pERROR_CODE := 1; -- ������������ �� ������
  ELSIF vIS_LOCKED <> 0 THEN
    pERROR_CODE := 2; -- ������� ������ �������������
  ELSE
    vPASSWORD_HASH := TO_CHAR(UTL_RAW.CAST_TO_RAW(
      DBMS_OBFUSCATION_TOOLKIT.MD5(input_string=>'Adt36' || pPASSWORD)
    ));
    IF vPASSWORD_HASH = vTABLE_PASSWORD_HASH THEN
      -- ���� ���������, ������ ��������
      pERROR_CODE := 0; -- �� � �������
    ELSE
      pERROR_CODE := 1; -- �������� ��� ������������ ��� ������
    END IF;
  END IF;
  CLOSE cUSERS;
  IF pERROR_CODE = 1 THEN -- �������� ��� ������������ ��� ������
    pUSER_ID := NULL;
    pERROR_MESSAGE := '�������� ��� ������������ ��� ������';
  ELSIF pERROR_CODE = 2 THEN
    pUSER_ID := NULL;
    pERROR_MESSAGE := '������� ������ �������������, ���������� � ������ ���������';
  END IF;
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
      IS_ADMIN,
      PREV_ACCESS_DATE_TIME
    ) VALUES (
      MF_S_NEW_SESSION_ID.NEXTVAL,
      pSESSION_KEY,
      SYSDATE,
      SYSDATE,
      pUSER_ID,
      pIS_ADMIN,
      G_STATE.PREV_ACCESS_DATE_TIME
    );
    COMMIT;
    -- ������������ ������� "�����������"
    --MF_STAT_HIT('1', pUSER_ID);
  END IF;
END MF_REGISTER_SESSION; 
/
