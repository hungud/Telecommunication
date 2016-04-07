CREATE OR REPLACE PROCEDURE IVIDEON.BLOCK_CLIENT_WTH_0_BAL AS
--
--#Version=2
--
--v.2 - Соколов. Добавил баланс в историю
--v.1 - Соколов Процедура блока
--
  --
  CURSOR ABONENTS IS
    SELECT IA.ABONENT_ID 
      FROM IVIDEON_ABONENTS IA,
           ABONENT_BLOCK_UNLOCK ABU
      WHERE IA.ABONENT_ID = ABU.ABONENT_ID
        AND ABU.ABONENT_IS_ACTIVE = 1;
    
  CURSOR BALANCE (pABONENT_ID INTEGER) IS
    SELECT BALANCE
      FROM ABONENT_BALANCE AB       
      WHERE AB.ABONENT_ID = pABONENT_ID;  
  --
  vBL BALANCE%ROWTYPE;
  LOCK_PH VARCHAR2(2000);
BEGIN
  --
  FOR vREC IN ABONENTS LOOP
    OPEN BALANCE (vREC.ABONENT_ID);
    FETCH BALANCE INTO vBL;
    CLOSE BALANCE;
    IF vBL.BALANCE < 0 THEN
    
    -- LOCK_PH := LOCK_PHONE (vREC.ABONENT_ID); -- Фукция отправки блока 
     
     UPDATE ABONENT_BLOCK_UNLOCK
     SET ABONENT_IS_ACTIVE = 0,
         BALANCE = vBL.BALANCE
     WHERE ABONENT_ID = vREC.ABONENT_ID; 
     
     INSERT INTO ABONENT_BLOCK_UNLOCK_HISTORY(
                                              ABONENT_ID,
                                              ACTION_TYPE_ID,
                                              HISTORY_DATE,
                                              ANSWER,
                                              BALANCE
                                             )
                                       VALUES(       
                                              vREC.ABONENT_ID,
                                              0,
                                              SYSDATE,
                                              NULL,
                                              vBL.BALANCE
                                              );
     
     COMMIT;
    END IF;      
  END LOOP;
END;
/
