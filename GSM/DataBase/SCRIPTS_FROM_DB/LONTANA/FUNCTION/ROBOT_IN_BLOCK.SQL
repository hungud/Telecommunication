
  CREATE OR REPLACE FUNCTION "LONTANA"."ROBOT_IN_BLOCK" (
  pPHONE_NUMBER IN VARCHAR2
  ) RETURN BOOLEAN IS
--
-- Version=1
--
CURSOR C IS
  SELECT CONTRACTS.HAND_BLOCK
    FROM CONTRACTS
    WHERE CONTRACTS.PHONE_NUMBER_FEDERAL=pPHONE_NUMBER
    ORDER BY CONTRACTS.CONTRACT_DATE DESC;
REC C%ROWTYPE;    
BEGIN
  IF MS_CONSTANTS.GET_CONSTANT_VALUE('HAND_BLOCK_IS_ROBOT_BLOCK')='1' THEN
    OPEN C;
    FETCH C INTO REC;
    IF C%NOTFOUND THEN
      RETURN FALSE;
    ELSE
      IF REC.HAND_BLOCK=1 THEN
        RETURN TRUE;
      ELSE
        RETURN FALSE;
      END IF;
    END IF;  
    CLOSE C;
  ELSE
    RETURN FALSE;
  END IF;
END; 