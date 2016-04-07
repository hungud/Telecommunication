
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."MNP_MAIN_TO_TEMP" (P_number in varchar2) return varchar2 is
-- Подмена оснвоного номера временным
CURSOR C IS
    select MNP.TEMP_PHONE_NUMBER
        from MNP_REMOVE mnp
        where MNP.phone_number = P_number;
  Result varchar2(10);
  rec C%ROWTYPE;
begin
    OPEN C;
    FETCH C INTO rec;
    IF C%NOTFOUND THEN 
        Result:= P_number;
    ELSE
        Result:= rec.TEMP_PHONE_NUMBER;
    END IF; 
    CLOSE C;     
  return(Result);
end;