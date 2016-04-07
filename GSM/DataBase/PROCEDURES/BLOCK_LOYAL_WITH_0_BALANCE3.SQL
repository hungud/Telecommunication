CREATE OR REPLACE PROCEDURE BLOCK_LOYAL_WITH_0_BALANCE3 (
  pDIV IN INTEGER,
  pMOD IN INTEGER
  ) IS
  
-- Version 4
-- v.4 02.10.2014 - Соколов. Изменил удалание очереди. Чтобы удалялись еще и полностья блокированные.
-- v.3 21.08.2015 - Афросин добавил отсылку смс если баланс изменился хоть на 1 копейку
-- v.2 02.07.2015 - Матюнин И. - реализовано сначала удаление тех номеров из очереди, которые уже ушли в плюс, 
                         -- чтобы при возмодных зависаниях АПИ (когда до них не доходила очередь по причине остановки джоба) они не оставались в очереди  
  CURSOR C IS
    SELECT *
      FROM LOYAL_PHONE_FOR_BLOCK 
      WHERE mod(PHONE_NUMBER, pDIV) = pMOD 
        and ACCOUNT_ID <> 225
      ORDER BY GET_ABONENT_BALANCE(LOYAL_PHONE_FOR_BLOCK.PHONE_NUMBER) ASC;
  
  CURSOR BL (ID INTEGER) IS
    SELECT 
      ACCOUNTS.DO_AUTO_BLOCK
    FROM ACCOUNTS
    WHERE ID=ACCOUNTS.ACCOUNT_ID;  
  vBL BL%ROWTYPE;    
  LOCK_PH VARCHAR2(300 CHAR);  
  vBALANCE NUMBER(13, 2);
  vROUND_BALANCE  NUMBER(13, 2);      
  ERROR_COL INTEGER;
  nMethod number:=0;
  SMS VARCHAR2(2000);
BEGIN
  
  -- удаляем все те номера, что уже в плюсе
  delete from LOYAL_PHONE_FOR_BLOCK LOYAL
   where ((GET_ABONENT_BALANCE(LOYAL.PHONE_NUMBER) > LOYAL.BALANCE_BLOCK) OR 
            exists (select 1 from DB_LOADER_ACCOUNT_PHONES DB 
                              WHERE DB.PHONE_NUMBER = LOYAL.PHONE_NUMBER 
                                AND DB.PHONE_IS_ACTIVE = 0
                                AND DB.YEAR_MONTH = TO_NUMBER(TO_CHAR(SYSDATE,'yyyymm')))) 
     and ACCOUNT_ID <> 225
     and mod(PHONE_NUMBER, pDIV) = pMOD;    
  commit;
  
  --
  FOR rec IN C LOOP
      --определяем каким способом выполнять
      begin
        select strinlike('9',t.n_method,';','()') into nMethod
        from
          accounts t
        where
          t.account_id= rec.ACCOUNT_ID;
      exception
        when others then
          nMethod:=0;
      end;
      
    vBALANCE := GET_ABONENT_BALANCE(REC.PHONE_NUMBER);
    vROUND_BALANCE := round(vBALANCE, 2);
    --если баланс отличается от того сто в базе, то  обновляем баланс, шлем смс
    
    if rec.balance > vROUND_BALANCE then
      update LOYAL_PHONE_FOR_BLOCK l
        set l.BALANCE = vROUND_BALANCE
      where
        l.PHONE_NUMBER = rec.PHONE_NUMBER
        and nvl(l.BALANCE, 0) <> vROUND_BALANCE;
      commit;
      
      SMS := REPLACE(rec.SMS_TEMPLATE, '%balance%', vROUND_BALANCE);
      SMS := REPLACE(SMS, '%dolg%', - vROUND_BALANCE);
      SMS := LOADER3_pckg.SEND_SMS(REC.PHONE_NUMBER, 'Смс-оповещение', trim(SMS));
      
    end if;
    
    OPEN BL(REC.ACCOUNT_ID);
      FETCH BL INTO vBL;
    CLOSE BL;    

    IF (vBL.DO_AUTO_BLOCK=1) THEN
      IF ((SYSDATE>REC.DATE_FUTURE_BLOCK)and(vBALANCE < REC.BALANCE_BLOCK)) OR (vBALANCE < REC.BALANCE_BLOCK-500) THEN
        --LOCK_PH:=LOADER3_pckg.LOCK_PHONE(REC.PHONE_NUMBER,0,nMethod);        
        LOCK_PH := LOADER_CALL_PCKG_N.lock_phone( rec.ACCOUNT_ID, rec.PHONE_NUMBER );
        if instr(LOCK_PH, 'Заявка') > 0 then
          LOCK_PH := null;
        end if; 
        
--        IF LOCK_PH IS NOT NULL THEN
--          LOOP
--            ERROR_COL:=ERROR_COL+1;
--            LOCK_PH:=LOADER3_pckg.LOCK_PHONE(REC.PHONE_NUMBER,0,nMethod); 
--            EXIT WHEN (LOCK_PH IS NULL) OR (ERROR_COL=2); 
--          END LOOP;
--        END IF;     
        IF LOCK_PH IS NOT NULL THEN
          INSERT INTO AUTO_BLOCKED_PHONE(PHONE_NUMBER, BALLANCE, NOTE, BLOCK_DATE_TIME, ABONENT_FIO) 
            VALUES (REC.PHONE_NUMBER, vBALANCE, SUBSTR('Ошибка. '||LOCK_PH, 300), SYSDATE, rec.FIO);
          COMMIT;
        ELSE 
          UPDATE DB_LOADER_ACCOUNT_PHONES
            SET DB_LOADER_ACCOUNT_PHONES.PHONE_IS_ACTIVE=0
            WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER=REC.PHONE_NUMBER
              AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH=(SELECT * 
                                                         FROM (SELECT DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH 
                                                                 FROM DB_LOADER_ACCOUNT_PHONES 
                                                                 WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER=REC.PHONE_NUMBER
                                                                 ORDER BY YEAR_MONTH DESC)
                                                         WHERE ROWNUM=1);
          DELETE FROM LOYAL_PHONE_FOR_BLOCK
            WHERE LOYAL_PHONE_FOR_BLOCK.PHONE_NUMBER=rec.PHONE_NUMBER;   
          COMMIT;                                            
        END IF;
      ELSE
        IF vBALANCE > REC.BALANCE_BLOCK THEN  
          DELETE FROM LOYAL_PHONE_FOR_BLOCK
            WHERE LOYAL_PHONE_FOR_BLOCK.PHONE_NUMBER=rec.PHONE_NUMBER;   
          COMMIT;  
        END IF;
      END IF;
    END IF; 
  END LOOP;
END;

--GRANT EXECUTE ON BLOCK_LOYAL_WITH_0_BALANCE TO LONTANA ROLE;