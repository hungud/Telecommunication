
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."GET_CALC_COEFF_DETAL" (
  pphonenum IN VARCHAR2
  ) RETURN number IS
--Vesion=1
CURSOR C IS
   select CALC_KOEFF_DETAL from tariffs a where a.tariff_id=GET_CURR_PHONE_TARIFF_ID(pphonenum);

Res1 NUMBER;
Res NUMBER;

BEGIN

  OPEN C;
  FETCH C INTO Res1;
  IF C%FOUND THEN
    Res:=nvl(Res1,1);
  ELSE
    Res:=1;
  END IF;
  CLOSE C;
  RETURN Res;

END;
