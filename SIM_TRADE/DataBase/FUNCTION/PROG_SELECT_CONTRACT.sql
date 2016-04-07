CREATE OR REPLACE FUNCTION PROG_SELECT_CONTRACT(
  pPHONE_NUMBER IN VARCHAR2
  ) RETURN INTEGER IS
  CURSOR C IS 
    SELECT C1.CONTRACT_ID,
           CC1.CONTRACT_CANCEL_DATE
      FROM CONTRACTS C1,
           CONTRACT_CANCELS CC1
      WHERE C1.PHONE_NUMBER_FEDERAL=pPHONE_NUMBER
        AND C1.CONTRACT_ID=CC1.CONTRACT_ID(+)
      ORDER BY C1.CONTRACT_DATE DESC, CC1.CONTRACT_CANCEL_DATE DESC;
  C_DUMMY C%ROWTYPE;   
  CURSOR PH IS
    SELECT PH1.PHONE_NUMBER
      FROM DB_LOADER_ACCOUNT_PHONES PH1
      WHERE PH1.PHONE_NUMBER=pPHONE_NUMBER
        AND PH1.YEAR_MONTH=(SELECT MAX(PH2.YEAR_MONTH)
                              FROM DB_LOADER_ACCOUNT_PHONES PH2);
  CURSOR BA(pFILIAL IN INTEGER) IS
    SELECT DB_LOADER_ACCOUNT_PHONES.*
      FROM DB_LOADER_ACCOUNT_PHONES,
           ACCOUNTS
      WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER = pPHONE_NUMBER
        AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH=(SELECT MAX(PH2.YEAR_MONTH)
                                                   FROM DB_LOADER_ACCOUNT_PHONES PH2)
        AND DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID = ACCOUNTS.ACCOUNT_ID
        AND ACCOUNTS.FILIAL_ID = pFILIAL;                                                                            
  PH_DUMMY PH%ROWTYPE;   
  vCONTRACT_ID INTEGER; 
  vCHECK_FILIAL_BLOCK INTEGER;   
  vFILIAL INTEGER;
  BA_DUMMY BA%ROWTYPE;
BEGIN 
  vCHECK_FILIAL_BLOCK:=0;
  vFILIAL:=GET_FILIAL_ID_BY_USER;
  IF (MS_CONSTANTS.GET_CONSTANT_VALUE('USE_FILIAL_BLOCK_ACCESS')='1') 
      AND (TO_NUMBER(MS_CONSTANTS.GET_CONSTANT_VALUE('HEAD_OFFICE'))<>vFILIAL) THEN
    vCHECK_FILIAL_BLOCK:=1;
   /* OPEN BA(vFILIAL);
    FETCH BA INTO BA_DUMMY;
    IF BA%FOUND THEN
      vCHECK_FILIAL_BLOCK:=0;
    END IF;
    CLOSE BA;*/
  END IF;
  IF vCHECK_FILIAL_BLOCK=0 THEN
    OPEN C;
    FETCH C INTO C_DUMMY;
    IF C%FOUND THEN
      IF C_DUMMY.CONTRACT_CANCEL_DATE IS NULL THEN
        vCONTRACT_ID:=C_DUMMY.CONTRACT_ID;
      END IF;
    ELSE
      OPEN PH;
      FETCH PH INTO PH_DUMMY;
      IF PH%FOUND THEN
        vCONTRACT_ID:=0;
      ELSE
        vCONTRACT_ID:=-1;
      END IF;
      CLOSE PH;
    END IF;
    CLOSE C;
  END IF;
  RETURN vCONTRACT_ID;
END;
/
--grant execute on PROG_SELECT_CONTRACT to corp_mobile_role;

--grant execute on PROG_SELECT_CONTRACT to corp_mobile_role_ro;