
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."MNP_CUR_TO_HIST" is 
-- Процедура переносит записи из MNP_REMOVE в MNP_REMOVE_HISTORY
-- после того как основной номер активировался
-- и с момента активации прошло 3 дня
CURSOR c is 
select mnp.PHONE_NUMBER,
        MNP.TEMP_PHONE_NUMBER,
        MNP.DATE_ACTIVATE,
        MNP.DATE_CREATED,
        MNP.USER_CREATED
from MNP_REMOVE mnp
where MNP.IS_ACTIVE = 1
and trunc(MNP.DATE_ACTIVATE)  < = trunc(sysdate - 3)
;

rec C%ROWTYPE;

--
begin
    open c;
    
    loop--c
        fetch c into rec;
        exit when c%notfound;
        -- Перенос записи в историю
        INSERT INTO MNP_REMOVE_HISTORY(PHONE_NUMBER, TEMP_PHONE_NUMBER, DATE_ACTIVATE, USER_CREATED, DATE_CREATED, DATE_INSERTED) 
            VALUES (rec.PHONE_NUMBER, rec.TEMP_PHONE_NUMBER, rec.DATE_ACTIVATE, rec.USER_CREATED, rec.DATE_CREATED, sysdate);
        -- Удаление записи из текущей замены    
        DELETE FROM MNP_REMOVE WHERE PHONE_NUMBER = rec.PHONE_NUMBER;   
        commit;
        end 
    loop;--c
end;