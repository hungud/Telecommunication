
  CREATE OR REPLACE FUNCTION "SIM_TRADE"."MNP_TEMP_TO_MAIN" (P_number IN VARCHAR2)
   RETURN VARCHAR2
IS
   -- Подмена временного номера основным
   CURSOR C
   IS
      SELECT MNP.phone_number
        FROM MNP_REMOVE mnp
       WHERE MNP.TEMP_PHONE_NUMBER = P_number;

   Result   VARCHAR2 (10);
   rec      C%ROWTYPE;
BEGIN
   OPEN C;

   FETCH C INTO rec;

   IF C%NOTFOUND
   THEN
      Result := P_number;
   ELSE
      Result := rec.phone_number;
   END IF;

   CLOSE C;

   RETURN (Result);
END;