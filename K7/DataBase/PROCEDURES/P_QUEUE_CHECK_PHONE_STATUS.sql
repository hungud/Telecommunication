CREATE OR REPLACE PROCEDURE P_QUEUE_CHECK_PHONE_STATUS
AS
--
--Version=1
--
--v.1 Афросин 07.05.2015 -Добавил процедуру получения/обновления статусов номеров,
--                       находящихся в очереди
--
  cUPPER_SEARCH_WORD   CONSTANT VARCHAR2 (16) := 'СТАТУС:';
  cUPPER_ERROR_WORD   CONSTANT VARCHAR2 (3) := 'ORA';
     
  vAnswer VARCHAR2 (250);
  vIsError LOG_CHECK_PHONE_STATUS.IS_ERROR%TYPE;
  vErrorText LOG_CHECK_PHONE_STATUS.ERROR_TEXT%TYPE;
   
  procedure SET_CHECK_RESULT (pIsError out LOG_CHECK_PHONE_STATUS.IS_ERROR%TYPE,
                              pErrorText out LOG_CHECK_PHONE_STATUS.ERROR_TEXT%TYPE,
                              pSQLERRM in varchar2 default null,
                              pAnswer  in varchar2 default 'x'
                              
                              ) as
  begin
    pIsError := 0;
    pErrorText := null;
    if (pSQLERRM is not null) OR (INSTR(UPPER(NVL(pAnswer, 'x')), cUPPER_ERROR_WORD) > 0) THEN
      pIsError := 1;
      
      if pSQLERRM is not null then
        pErrorText := pSQLERRM;
      else
        pErrorText := pAnswer;
      end if;
    end if;      
  end;
BEGIN
   --BEGIN
     
     FOR c IN (SELECT 
                    phone_number, DATE_CREATED 
              FROM
                QUEUE_FOR_CHECK_PHONE_STATUS
              )
     LOOP

        vIsError := 0;

        BEGIN
          vAnswer := beeline_api_pckg.phone_status (TO_NUMBER (c.phone_number));
        EXCEPTION
          WHEN OTHERS THEN
            vIsError := 1;
            SET_CHECK_RESULT (vIsError, vErrorText, SQLERRM);
        end;
        
        --если ошибки не было,то проверяем на ошибку возвращенный результат
        if nvl(vIsError, 0) = 0 then
          SET_CHECK_RESULT (vIsError, vErrorText, null, vAnswer);
        end if;
        
        INSERT INTO LOG_CHECK_PHONE_STATUS 
                  (
                    PHONE_NUMBER,
                    DATE_CREATED,
                    INSERT_DATE,
                    IS_ERROR,
                    ERROR_TEXT
                  )
        VALUES
              (
                c.phone_number,
                c.DATE_CREATED,
                SYSDATE,
                vIsError,
                vErrorText
              );
           
         DELETE FROM QUEUE_FOR_CHECK_PHONE_STATUS
                 WHERE phone_number = c.phone_number;
           
         COMMIT;
     END LOOP;

--     COMMIT;
   /*
   EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      RAISE_APPLICATION_ERROR (-20000, 'ERROR! '||SQLERRM||' vAnsver= '||vAnswer);
   end;
   */
END;
/
