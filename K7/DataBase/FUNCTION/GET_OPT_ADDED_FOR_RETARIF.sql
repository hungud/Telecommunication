CREATE OR REPLACE FUNCTION GET_OPT_ADDED_FOR_RETARIF(
  pACCOUNT_ID INTEGER,
  pPHONE_NUMBER IN VARCHAR2,
  pOPTION_CODE IN VARCHAR2
  ) RETURN INTEGER IS
--#Version=1
  ITOG INTEGER;
  CURSOR AC IS 
    SELECT ACCOUNTS.DO_ROAMING_RETARIFICATION
      FROM ACCOUNTS
      WHERE ACCOUNTS.ACCOUNT_ID = pACCOUNT_ID;
  AC_DUMMY AC%ROWTYPE;
  CURSOR TAR_O IS
    SELECT TARIFF_OPTIONS.DEFAULT_RETARIF_ROAM_DISCOUNT
      FROM TARIFF_OPTIONS
      WHERE TARIFF_OPTIONS.OPTION_CODE = pOPTION_CODE;
  TAR_O_DUMMY TAR_O%ROWTYPE;
  CURSOR ROU IS
    SELECT *
      FROM ROAMING_RETARIF_PHONES RRP
      WHERE RRP.PHONE_NUMBER = pPHONE_NUMBER
        AND RRP.OPTION_CODE = pOPTION_CODE
        AND RRP.BEGIN_DATE_TIME <= SYSDATE
        --AND NVL(RRP.END_DATE_TIME, SYSDATE + 1/24) >= SYSDATE;
        AND RRP.END_DATE_TIME is null;
  ROU_DUMMY ROU%ROWTYPE;        
BEGIN
  ITOG:=NULL;
  /*OPEN AC;
  FETCH AC INTO AC_DUMMY;
  IF (AC%FOUND) AND (NVL(AC_DUMMY.DO_ROAMING_RETARIFICATION, 0) = 1) THEN*
    OPEN TAR_O;
    FETCH TAR_O INTO TAR_O_DUMMY;
    IF (TAR_O%FOUND) AND (NVL(TAR_O_DUMMY.DEFAULT_RETARIF_ROAM_DISCOUNT, 0) = 1) THEN*/
      OPEN ROU;
      FETCH ROU INTO ROU_DUMMY;
      IF ROU%FOUND THEN        
        ITOG:=1;
      ELSE
        ITOG:=NULL;
      END IF;
      CLOSE ROU;
  /*  ELSE
      ITOG:=NULL;
    END IF;
    CLOSE TAR_O;
  ELSE
    ITOG:=NULL;
  END IF;
  CLOSE AC;*/
  RETURN ITOG;
END;  
/