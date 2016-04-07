CREATE OR REPLACE FUNCTION CRM_UNBLOCK_PHONE
(PHONE_NUMBER VARCHAR2)
RETURN VARCHAR2 IS
tmpVar NUMBER;
UNLOCK_PH VARCHAR2(2000);

BEGIN
   tmpVar := 0;
   SELECT COUNT (1) into tmpVar  
                     FROM V_PHONE_NUMBERS_FOR_UNLOCK vv
                     WHERE vv.PHONE_NUMBER_FEDERAL = PHONE_NUMBER;
   
   IF tmpVar=1 THEN 
      --UNLOCK_PH:=LOADER3_pckg.UNLOCK_PHONE(PHONE_NUMBER, 0);
      UNLOCK_PH:=beeline_api_pckg.UNLOCK_PHONE(PHONE_NUMBER,0);
      if regexp_instr(UNLOCK_PH,'Заявка на разблок №\d+')<=0 then
        INSERT INTO AUTO_UNBLOCKED_PHONE  
              (phone_number,
              Ballance,
              Note,
              unblock_date_time,
              ABONENT_FIO) 
            VALUES (PHONE_NUMBER, GET_ABONENT_BALANCE (PHONE_NUMBER), SUBSTR('Ошибка. '||UNLOCK_PH, 1, 300), sysdate,'Разблокировка через CRM');
            COMMIT;
        RETURN 'Ошибка при разблокировке номера.' ||UNLOCK_PH;
      ELSE 
        RETURN 'Номер успешно отправлен на разблокировку.';
      END IF;  
   ELSE 
      RETURN 'Номер не может быть разблокирован.';
   END IF;                  
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
        RETURN 'Ошибка при разблокировке номера.';
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RETURN 'Ошибка при разблокировке номера. ';
       RAISE;
END CRM_UNBLOCK_PHONE;

/

CREATE OR REPLACE SYNONYM CRM_USER.CRM_UNBLOCK_PHONE FOR CRM_UNBLOCK_PHONE;


GRANT EXECUTE ON CRM_UNBLOCK_PHONE TO CRM_USER;
