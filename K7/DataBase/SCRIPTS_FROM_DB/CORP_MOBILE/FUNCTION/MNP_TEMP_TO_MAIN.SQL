
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."MNP_TEMP_TO_MAIN" (P_number in varchar2) return varchar2 is
-- Подмена временного номера основным
CURSOR C IS
        select MNP.phone_number
        from MNP_REMOVE mnp
        where MNP.TEMP_PHONE_NUMBER = P_number;
  Result varchar2(10);
  rec C%ROWTYPE;
begin
    OPEN C;
    FETCH C INTO rec;
    IF C%NOTFOUND THEN 
        Result:= P_number;
    ELSE    
        Result:= rec.phone_number;
    END IF; 
    CLOSE C;     
  return(Result);
end;