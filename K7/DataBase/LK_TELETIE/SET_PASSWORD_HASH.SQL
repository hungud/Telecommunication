GRANT UPDATE(USER_PASSWORD, USER_PASSWORD_HASH) ON CONTRACTS TO CORP_MOBILE_LK;

CREATE OR REPLACE FUNCTION CORP_MOBILE_LK.SET_PASSWORD_HASH(
  pLOGIN IN VARCHAR2,
  pPASSWORD_HASH IN VARCHAR2
  ) RETURN INTEGER IS
--
--#Version=1
--
-- ������� ���������� ��� ������ ��� ������.
-- ������������ ��������:
--  1: �������� ��������� ��������;
--  0: ����� �� ������;
--
vCONTRACT_ID INTEGER;
vRESULT INTEGER;
CURSOR C_CONTRACT IS
   SELECT
      CONTRACTS.CONTRACT_ID
   FROM CORP_MOBILE.CONTRACTS,
        CORP_MOBILE.CONTRACT_CANCELS CCS
   WHERE     CONTRACTS.PHONE_NUMBER_FEDERAL = pLOGIN
          AND CCS.CONTRACT_ID(+)=CONTRACTS.CONTRACT_ID
          AND CCS.CONTRACT_CANCEL_DATE IS NULL;
BEGIN
  IF PHONE_CAN_LOG_IN(pLOGIN) THEN
    OPEN C_CONTRACT;
    FETCH C_CONTRACT INTO vCONTRACT_ID;
    CLOSE C_CONTRACT;
    UPDATE CORP_MOBILE.CONTRACTS
      SET USER_PASSWORD_HASH=pPASSWORD_HASH,
      USER_PASSWORD=NULL
      WHERE CONTRACT_ID=vCONTRACT_ID;
    vRESULT := 1;
  ELSE
    vRESULT := 0;
  END IF;
  RETURN vRESULT;
END;
/

-- GRANT UPDATE ON CONTRACTS(USER_PASSWORD) TO CORP_MOBILE_LK;
-- grant execute on loader3_pckg to corp_mobile_lk;
