
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."SET_MN_UNLIM_VOLUMEHB" (
  pYEAR                     IN NUMBER,
  pMONTH                    IN NUMBER,
  pPHONE_NUMBER             IN VARCHAR2,
  pMnUnlimD                IN NUMBER,
  pMnUnlimT  IN NUMBER,
  pMnUnlimO   IN NUMBER
  ) IS
  vYEAR_MONTH BINARY_INTEGER;
  CURSOR C_FIND IS
    SELECT
      mv.ROWID,
      mv.*
    FROM MN_UNLIM_VOLUMEHB mv
    WHERE mv.YEAR_MONTH=vYEAR_MONTH
          AND mv.PHONE_NUMBER=pPHONE_NUMBER;
  C_REC C_FIND%ROWTYPE;
  cDUMMY_NUMBER CONSTANT NUMBER := -1234456.25847;
BEGIN
  vYEAR_MONTH := pYEAR*100+pMONTH;
  OPEN C_FIND;
  FETCH C_FIND INTO C_REC;
  IF C_FIND%FOUND THEN
--    IF NVL(C_REC.MnUnlimD, cDUMMY_NUMBER) <> NVL(pMnUnlimD, cDUMMY_NUMBER)
--      OR NVL(C_REC.MnUnlimT, cDUMMY_NUMBER)<> NVL(pMnUnlimT, cDUMMY_NUMBER)
 --     OR NVL(C_REC.MnUnlimO, cDUMMY_NUMBER) <> NVL(pMnUnlimO, cDUMMY_NUMBER)
 --   THEN
      UPDATE MN_UNLIM_VOLUMEHB mv
      SET MnUnlimD = pMnUnlimD,
        MnUnlimT = pMnUnlimT,
        MnUnlimO = pMnUnlimO
      WHERE
        mv.ROWID = C_REC.ROWID;
  --  END IF;
  ELSE
    INSERT INTO MN_UNLIM_VOLUMEHB (
      PHONE_NUMBER,
      YEAR_MONTH,
      MnUnlimD,
      MnUnlimT,
      MnUnlimO
    ) VALUES (
      pPHONE_NUMBER,
      vYEAR_MONTH,
      pMnUnlimD,
      pMnUnlimT,
      pMnUnlimO);
  END IF;
  CLOSE C_FIND;
END;
