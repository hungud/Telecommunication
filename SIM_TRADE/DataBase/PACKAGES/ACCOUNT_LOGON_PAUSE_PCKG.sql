CREATE OR REPLACE PACKAGE ACCOUNT_LOGON_PAUSE_PCKG IS
--
--#Version=1
--
-- ������������� ����� �� ���� � ������� ������ (����� �������� ���������� ��� ������������ ������)
PROCEDURE SET_ACCOUNT_LOGON_PAUSE(
  pACCOUNT_NAME IN VARCHAR2, 
  pPAUSED_MINUTES IN INTEGER
  );
--
-- ��������� ����� �� ���� � ������� ������ (����� �������� ���������� ��� ������������ ������)
FUNCTION IS_ACCOUNT_LOGON_PAUSED(
  pACCOUNT_NAME IN VARCHAR2
  ) RETURN INTEGER;
--
END;
/

CREATE OR REPLACE PACKAGE BODY ACCOUNT_LOGON_PAUSE_PCKG IS
--
PROCEDURE SET_ACCOUNT_LOGON_PAUSE(
  pACCOUNT_NAME IN VARCHAR2, 
  pPAUSED_MINUTES IN INTEGER
  ) IS
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  INSERT INTO ACCOUNT_LOGON_PAUSED (
    ACCOUNT_NAME,
    START_DATE_TIME,
    END_DATE_TIME
    ) VALUES (
    pACCOUNT_NAME,
    SYSDATE,
    SYSDATE + (pPAUSED_MINUTES / 60 / 24) -- ��������� � ���� �����
    );
  COMMIT;
END;
--
FUNCTION IS_ACCOUNT_LOGON_PAUSED(
  pACCOUNT_NAME IN VARCHAR2
  ) RETURN INTEGER IS
--
  CURSOR C IS 
    SELECT *
    FROM ACCOUNT_LOGON_PAUSED
    WHERE ACCOUNT_LOGON_PAUSED.ACCOUNT_NAME = pACCOUNT_NAME
    AND SYSDATE BETWEEN START_DATE_TIME AND END_DATE_TIME;
  C_REC C%ROWTYPE;
--
  vRESULT INTEGER;
--
BEGIN
  OPEN C;
  FETCH C INTO C_REC;
  IF C%FOUND THEN
    -- � ������ ������ ���������� ������� ����� ����� �� SYS.DBMS_LOCK
    DBMS_LOCK.SLEEP(30);
    vRESULT := 1;
  ELSE
    vRESULT := 0; -- �� � �������
  END IF;
  CLOSE C;
  RETURN vRESULT;
END;
--
END;
/

