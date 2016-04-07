CREATE OR REPLACE PROCEDURE UNLOCK_SAVE_PHONE IS
-- Version = 1
--
-- 1. 2015.11.10. �������. ��������.
  CURSOR C IS
    SELECT V.*, GET_ABONENT_BALANCE(V.PHONE_NUMBER_FEDERAL) BALANCE
      FROM V_PHONE_FOR_UNLOCK_SAVE V
      WHERE GET_ABONENT_BALANCE(V.PHONE_NUMBER_FEDERAL) >= V.UNBLOCK_LIMIT
        AND NOT EXISTS (SELECT 1
                          FROM AUTO_UNBLOCKED_PHONE AUP
                          WHERE AUP.PHONE_NUMBER = V.PHONE_NUMBER_FEDERAL
                            AND AUP.UNBLOCK_DATE_TIME > SYSDATE - 10/24/60); 
  vBAL NUMBER(15, 4);         
  ITOG VARCHAR2(2000 CHAR);    
  vTICKET_ID INTEGER;               
BEGIN
  FOR rec IN C 
  LOOP
    vBAL:=GET_ABONENT_BALANCE(rec.PHONE_NUMBER_FEDERAL);
    IF vBAL >= rec.UNBLOCK_LIMIT THEN
      ITOG:=BEELINE_API_PCKG.UNLOCK_PHONE(rec.PHONE_NUMBER_FEDERAL, 0);
      --DBMS_OUTPUT.PUT_LINE(ITOG);
      IF INSTR(ITOG, '������ �� ������� �') > 0 THEN  
        --DBMS_OUTPUT.PUT_LINE('YES');
        vTICKET_ID:=TO_NUMBER(REPLACE(ITOG, '������ �� ������� �', ''));
        INSERT INTO AUTO_UNBLOCKED_PHONE(
                 PHONE_NUMBER, BALLANCE, NOTE, UNBLOCK_DATE_TIME, 
                 MANUAL_BLOCK, USER_NAME, ABONENT_FIO, TICKET_ID)
          VALUES(rec.PHONE_NUMBER_FEDERAL, vBAL, '������� �� ����������', sysdate,
                 0, USER, rec.FIO, vTICKET_ID);
      ELSE
        --DBMS_OUTPUT.PUT_LINE('NO');
        INSERT INTO AUTO_UNBLOCKED_PHONE(PHONE_NUMBER, BALLANCE, NOTE, 
                 UNBLOCK_DATE_TIME, MANUAL_BLOCK, USER_NAME, ABONENT_FIO, TICKET_ID)
          VALUES(rec.PHONE_NUMBER_FEDERAL, vBAL, '������� �� ����������: ' || ITOG, 
                 sysdate, 0, USER, rec.FIO, NULL);
      END IF;
      COMMIT;
      --DBMS_OUTPUT.PUT_LINE('COMMIT');
    END IF; 
  END LOOP;  
END;