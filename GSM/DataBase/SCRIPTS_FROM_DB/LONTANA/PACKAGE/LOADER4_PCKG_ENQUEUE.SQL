
  CREATE OR REPLACE PACKAGE "LONTANA"."LOADER4_PCKG_ENQUEUE" IS 

  QUEUE_STATE_WAIT CONSTANT INTEGER := 1;   -- задание еще не выполнено, ожидает в очереди
  QUEUE_STATE_DONE CONSTANT INTEGER := 2;      -- задание выполнено успешно
  QUEUE_STATE_ERROR CONSTANT INTEGER := 3;     -- задание выполнено с ошибкой
  QUEUE_STATE_NOT_FOUND CONSTANT INTEGER := 4; -- задание стаким кодом не найдено
 
  -- ставит в очередь задание на выполнение функции LOADER4_PCKG.SEND_PAID_SMS, 
  --   возвращает код задания (по которому потом можно узнать состояние задания) 
  FUNCTION SEND_PAID_SMS_ENQUEUE(
    pPHONE_NUMBER IN VARCHAR2
    ) RETURN INTEGER;

  -- ставит в очередь задание на выполнение функции LOADER4_PCKG.GET_PHONE_STATUS, 
  --   возвращает код задания (по которому потом можно узнать состояние задания) 
  FUNCTION GET_PHONE_STATUS_ENQUEUE(
    pPHONE_NUMBER IN VARCHAR2,
    pFULL_CHECK IN INTEGER DEFAULT 0
    ) RETURN INTEGER;

  -- ставит в очередь задание на выполнение функции LOADER4_PCKG.SET_PHONE_OPTION_ON, 
  --   возвращает код задания (по которому потом можно узнать состояние задания) 
  FUNCTION SET_PHONE_OPTION_ON_ENQUEUE(
    pPHONE_NUMBER IN VARCHAR2,
    pOPTION_NAME IN VARCHAR2
    ) RETURN INTEGER;

  -- ставит в очередь задание на выполнение функции LOADER4_PCKG.SET_PHONE_OPTION_OFF, 
  --   возвращает код задания (по которому потом можно узнать состояние задания) 
  FUNCTION SET_PHONE_OPTION_OFF_ENQUEUE(
    pPHONE_NUMBER IN VARCHAR2,
    pOPTION_NAME IN VARCHAR2
    ) RETURN INTEGER; 

  -- ставит в очередь задание на выполнение функции LOADER4_PCKG.CP_TRANSFERS, 
  --   возвращает код задания (по которому потом можно узнать состояние задания) 
  FUNCTION CP_TRANSFERS_ENQUEUE(
    pACCOUNTS_FROM IN VARCHAR2,
    pACCOUNTS_TO IN VARCHAR2,
    pTRANSFER_SUM IN VARCHAR2
    ) RETURN INTEGER;
    
  -- возвращает статус задания по коду 
  -- (код получаем при постановке задания в очередь из функций SEND_PAID_SMS_ENQUEUE, GET_PHONE_STATUS_ENQUEUE, SET_PHONE_OPTION_ON_ENQUEUE, SET_PHONE_OPTION_OFF_ENQUEUE, CP_TRANSFERS_ENQUEUE)
  FUNCTION GET_STATE(pQUEUE_ITEM_ID IN INTEGER) RETURN INTEGER;

  -- возвращает текст ошибки по коду задания на обработку 
  -- (код получаем при постановке задания в очередь из функций SEND_PAID_SMS_ENQUEUE, GET_PHONE_STATUS_ENQUEUE, SET_PHONE_OPTION_ON_ENQUEUE, SET_PHONE_OPTION_OFF_ENQUEUE, CP_TRANSFERS_ENQUEUE)
  FUNCTION GET_ERROR_TXT(pQUEUE_ITEM_ID IN INTEGER) RETURN VARCHAR2;
  
  -- обрабатывает очередь заданий на выполнение функции LOADER4_PCKG.SEND_PAID_SMS
  --   результаты потом можно получить через GET_STATE 
  PROCEDURE WORK_SEND_PAID_SMS;

  -- обрабатывает очередь заданий на выполнение функции LOADER4_PCKG.GET_PHONE_STATUS 
  --   результаты потом можно получить через GET_STATE 
  PROCEDURE WORK_GET_PHONE_STATUS;

  -- обрабатывает очередь заданий на выполнение функции LOADER4_PCKG.SET_PHONE_OPTION_ON 
  --   результаты потом можно получить через GET_STATE 
  PROCEDURE WORK_SET_PHONE_OPTION_ON;

  -- обрабатывает очередь заданий на выполнение функции LOADER4_PCKG.SET_PHONE_OPTION_OFF 
  --   результаты потом можно получить через GET_STATE 
  PROCEDURE WORK_SET_PHONE_OPTION_OFF; 

  -- обрабатывает очередь заданий на выполнение функции LOADER4_PCKG.CP_TRANSFERS 
  --   результаты потом можно получить через GET_STATE 
  PROCEDURE WORK_CP_TRANSFERS;
      
END;
CREATE OR REPLACE PACKAGE BODY "LONTANA"."LOADER4_PCKG_ENQUEUE" IS 

  -- ставит в очередь задание на выполнение функции LOADER4_PCKG.SEND_PAID_SMS, 
  --   возвращает код задания (по которому потом можно узнать состояние задания) 
  FUNCTION SEND_PAID_SMS_ENQUEUE(
    pPHONE_NUMBER IN VARCHAR2
    ) RETURN INTEGER IS
    vRES INTEGER;
  BEGIN
    INSERT INTO QUEUE_ITEMS
    (QUEUE_TYPE, STATE, PARAM1)
    VALUES
    ('SEND_PAID_SMS', QUEUE_STATE_WAIT, SUBSTR(pPHONE_NUMBER, 1, 30))
    RETURNING QUEUE_ITEM_ID INTO vRES;
    RETURN vRES;
  END;

  -- ставит в очередь задание на выполнение функции LOADER4_PCKG.GET_PHONE_STATUS, 
  --   возвращает код задания (по которому потом можно узнать состояние задания) 
  FUNCTION GET_PHONE_STATUS_ENQUEUE(
    pPHONE_NUMBER IN VARCHAR2,
    pFULL_CHECK IN INTEGER DEFAULT 0
    ) RETURN INTEGER IS
    vRES INTEGER;
  BEGIN
    INSERT INTO QUEUE_ITEMS
    (QUEUE_TYPE, STATE, PARAM1, PARAM2)
    VALUES
    ('GET_PHONE_STATUS', QUEUE_STATE_WAIT, SUBSTR(pPHONE_NUMBER, 1, 30), TO_CHAR(pFULL_CHECK))
    RETURNING QUEUE_ITEM_ID INTO vRES;
    RETURN vRES;
  END;

  -- ставит в очередь задание на выполнение функции LOADER4_PCKG.SET_PHONE_OPTION_ON, 
  --   возвращает код задания (по которому потом можно узнать состояние задания) 
  FUNCTION SET_PHONE_OPTION_ON_ENQUEUE(
    pPHONE_NUMBER IN VARCHAR2,
    pOPTION_NAME IN VARCHAR2
    ) RETURN INTEGER IS
    vRES INTEGER;
  BEGIN
    INSERT INTO QUEUE_ITEMS
    (QUEUE_TYPE, STATE, PARAM1, PARAM2)
    VALUES
    ('SET_PHONE_OPTION_ON', QUEUE_STATE_WAIT, SUBSTR(pPHONE_NUMBER, 1, 30), SUBSTR(pOPTION_NAME, 1, 30))
    RETURNING QUEUE_ITEM_ID INTO vRES;
    RETURN vRES;
  END;

  -- ставит в очередь задание на выполнение функции LOADER4_PCKG.SET_PHONE_OPTION_OFF, 
  --   возвращает код задания (по которому потом можно узнать состояние задания) 
  FUNCTION SET_PHONE_OPTION_OFF_ENQUEUE(
    pPHONE_NUMBER IN VARCHAR2,
    pOPTION_NAME IN VARCHAR2
    ) RETURN INTEGER IS
    vRES INTEGER;
  BEGIN
    INSERT INTO QUEUE_ITEMS
    (QUEUE_TYPE, STATE, PARAM1, PARAM2)
    VALUES
    ('SET_PHONE_OPTION_OFF', QUEUE_STATE_WAIT, SUBSTR(pPHONE_NUMBER, 1, 30), SUBSTR(pOPTION_NAME, 1, 30))
    RETURNING QUEUE_ITEM_ID INTO vRES;
    RETURN vRES;
  END;

  -- ставит в очередь задание на выполнение функции LOADER4_PCKG.CP_TRANSFERS, 
  --   возвращает код задания (по которому потом можно узнать состояние задания) 
  FUNCTION CP_TRANSFERS_ENQUEUE(
    pACCOUNTS_FROM IN VARCHAR2,
    pACCOUNTS_TO IN VARCHAR2,
    pTRANSFER_SUM IN VARCHAR2
    ) RETURN INTEGER IS
    vRES INTEGER;
  BEGIN
    INSERT INTO QUEUE_ITEMS
    (QUEUE_TYPE, STATE, PARAM1, PARAM2, PARAM3)
    VALUES
    ('CP_TRANSFERS', QUEUE_STATE_WAIT, SUBSTR(pACCOUNTS_FROM, 1, 30), SUBSTR(pACCOUNTS_TO, 1, 30), SUBSTR(pTRANSFER_SUM, 1, 30))
    RETURNING QUEUE_ITEM_ID INTO vRES;
    RETURN vRES;
  END;
    
  -- возвращает статус задания по коду 
  -- (код получаем при постановке задания в очередь из функций SEND_PAID_SMS_ENQUEUE, GET_PHONE_STATUS_ENQUEUE, SET_PHONE_OPTION_ON_ENQUEUE, SET_PHONE_OPTION_OFF_ENQUEUE, CP_TRANSFERS_ENQUEUE)
  FUNCTION GET_STATE(pQUEUE_ITEM_ID IN INTEGER) RETURN INTEGER IS
    vRES INTEGER;
  BEGIN
    SELECT Q.STATE
    INTO vRES
    FROM QUEUE_ITEMS Q 
    WHERE Q.QUEUE_ITEM_ID = pQUEUE_ITEM_ID;
    RETURN vRES;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    RETURN QUEUE_STATE_NOT_FOUND; 
  END;

  -- возвращает текст ошибки по коду задания на обработку 
  -- (код получаем при постановке задания в очередь из функций SEND_PAID_SMS_ENQUEUE, GET_PHONE_STATUS_ENQUEUE, SET_PHONE_OPTION_ON_ENQUEUE, SET_PHONE_OPTION_OFF_ENQUEUE, CP_TRANSFERS_ENQUEUE)
  FUNCTION GET_ERROR_TXT(pQUEUE_ITEM_ID IN INTEGER) RETURN VARCHAR2 IS
    vRES QUEUE_ITEMS.ERROR_MESSAGE%TYPE;
  BEGIN
    SELECT Q.ERROR_MESSAGE
    INTO vRES
    FROM QUEUE_ITEMS Q 
    WHERE Q.QUEUE_ITEM_ID = pQUEUE_ITEM_ID;
    RETURN vRES;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    RETURN 'NOT_FOUND pQUEUE_ITEM_ID = "'||pQUEUE_ITEM_ID||'"'; 
  END;
  
  -- обрабатывает очередь заданий на выполнение функции LOADER4_PCKG.SEND_PAID_SMS
  --   результаты потом можно получить через GET_STATE 
  PROCEDURE WORK_SEND_PAID_SMS IS
    vRESULT VARCHAR2(250 CHAR);
  BEGIN
    FOR REC IN (SELECT Q.QUEUE_ITEM_ID, Q.PARAM1 
                  FROM QUEUE_ITEMS Q 
                 WHERE Q.QUEUE_TYPE = 'SEND_PAID_SMS' AND Q.STATE = QUEUE_STATE_WAIT
                 ORDER BY Q.QUEUE_ITEM_ID) 
    LOOP
      BEGIN
        vRESULT := SUBSTR(LOADER4_PCKG.SEND_PAID_SMS(REC.PARAM1), 1, 250);
        IF TRIM(vRESULT) IS NULL THEN
          UPDATE QUEUE_ITEMS Q
             SET Q.STATE = QUEUE_STATE_DONE
                ,Q.ERROR_MESSAGE = NULL
                ,Q.DATE_PROCESS = SYSDATE
           WHERE Q.QUEUE_ITEM_ID = REC.QUEUE_ITEM_ID; 
        ELSE
          UPDATE QUEUE_ITEMS Q
             SET Q.STATE = QUEUE_STATE_ERROR
                ,Q.ERROR_MESSAGE = vRESULT
                ,Q.DATE_PROCESS = SYSDATE
           WHERE Q.QUEUE_ITEM_ID = REC.QUEUE_ITEM_ID; 
        END IF; 
      EXCEPTION WHEN OTHERS THEN
        UPDATE QUEUE_ITEMS Q
           SET Q.STATE = QUEUE_STATE_ERROR
              ,Q.ERROR_MESSAGE = SUBSTR(dbms_utility.format_error_stack ||CHR(13)||CHR(10)||dbms_utility.format_error_backtrace, 1, 2000)
              ,Q.DATE_PROCESS = SYSDATE
         WHERE Q.QUEUE_ITEM_ID = REC.QUEUE_ITEM_ID; 
      END; 
    END LOOP;
  END;

  -- обрабатывает очередь заданий на выполнение функции LOADER4_PCKG.GET_PHONE_STATUS 
  --   результаты потом можно получить через GET_STATE 
  PROCEDURE WORK_GET_PHONE_STATUS IS
    vRESULT VARCHAR2(250 CHAR);
  BEGIN
    FOR REC IN (SELECT Q.QUEUE_ITEM_ID, Q.PARAM1, Q.PARAM2
                  FROM QUEUE_ITEMS Q 
                 WHERE Q.QUEUE_TYPE = 'GET_PHONE_STATUS' AND Q.STATE = QUEUE_STATE_WAIT
                 ORDER BY Q.QUEUE_ITEM_ID) 
    LOOP
      BEGIN
        vRESULT := SUBSTR(LOADER4_PCKG.GET_PHONE_STATUS(REC.PARAM1, TO_NUMBER(REC.PARAM2)), 1, 250);
        IF TRIM(vRESULT) IS NULL THEN
          UPDATE QUEUE_ITEMS Q
             SET Q.STATE = QUEUE_STATE_DONE
                ,Q.ERROR_MESSAGE = NULL
                ,Q.DATE_PROCESS = SYSDATE
           WHERE Q.QUEUE_ITEM_ID = REC.QUEUE_ITEM_ID; 
        ELSE
          UPDATE QUEUE_ITEMS Q
             SET Q.STATE = QUEUE_STATE_ERROR
                ,Q.ERROR_MESSAGE = vRESULT
                ,Q.DATE_PROCESS = SYSDATE
           WHERE Q.QUEUE_ITEM_ID = REC.QUEUE_ITEM_ID; 
        END IF; 
      EXCEPTION WHEN OTHERS THEN
        UPDATE QUEUE_ITEMS Q
           SET Q.STATE = QUEUE_STATE_ERROR
              ,Q.ERROR_MESSAGE = SUBSTR(dbms_utility.format_error_stack ||CHR(13)||CHR(10)||dbms_utility.format_error_backtrace, 1, 2000)
              ,Q.DATE_PROCESS = SYSDATE
         WHERE Q.QUEUE_ITEM_ID = REC.QUEUE_ITEM_ID; 
      END; 
    END LOOP;  
  END;

  -- обрабатывает очередь заданий на выполнение функции LOADER4_PCKG.SET_PHONE_OPTION_ON 
  --   результаты потом можно получить через GET_STATE 
  PROCEDURE WORK_SET_PHONE_OPTION_ON IS
    vRESULT VARCHAR2(250 CHAR);
  BEGIN
    FOR REC IN (SELECT Q.QUEUE_ITEM_ID, Q.PARAM1, Q.PARAM2
                  FROM QUEUE_ITEMS Q 
                 WHERE Q.QUEUE_TYPE = 'SET_PHONE_OPTION_ON' AND Q.STATE = QUEUE_STATE_WAIT
                 ORDER BY Q.QUEUE_ITEM_ID) 
    LOOP
      BEGIN
        vRESULT := SUBSTR(LOADER4_PCKG.SET_PHONE_OPTION_ON(REC.PARAM1, REC.PARAM2), 1, 250);
        IF TRIM(vRESULT) IS NULL THEN
          UPDATE QUEUE_ITEMS Q
             SET Q.STATE = QUEUE_STATE_DONE
                ,Q.ERROR_MESSAGE = NULL
                ,Q.DATE_PROCESS = SYSDATE
           WHERE Q.QUEUE_ITEM_ID = REC.QUEUE_ITEM_ID; 
        ELSE
          UPDATE QUEUE_ITEMS Q
             SET Q.STATE = QUEUE_STATE_ERROR
                ,Q.ERROR_MESSAGE = vRESULT
                ,Q.DATE_PROCESS = SYSDATE
           WHERE Q.QUEUE_ITEM_ID = REC.QUEUE_ITEM_ID; 
        END IF; 
      EXCEPTION WHEN OTHERS THEN
        UPDATE QUEUE_ITEMS Q
           SET Q.STATE = QUEUE_STATE_ERROR
              ,Q.ERROR_MESSAGE = SUBSTR(dbms_utility.format_error_stack ||CHR(13)||CHR(10)||dbms_utility.format_error_backtrace, 1, 2000)
              ,Q.DATE_PROCESS = SYSDATE
         WHERE Q.QUEUE_ITEM_ID = REC.QUEUE_ITEM_ID; 
      END; 
    END LOOP;  
  END;
 
  -- обрабатывает очередь заданий на выполнение функции LOADER4_PCKG.SET_PHONE_OPTION_OFF 
  --   результаты потом можно получить через GET_STATE 
  PROCEDURE WORK_SET_PHONE_OPTION_OFF IS
    vRESULT VARCHAR2(250 CHAR);
  BEGIN
    FOR REC IN (SELECT Q.QUEUE_ITEM_ID, Q.PARAM1, Q.PARAM2
                  FROM QUEUE_ITEMS Q 
                 WHERE Q.QUEUE_TYPE = 'SET_PHONE_OPTION_OFF' AND Q.STATE = QUEUE_STATE_WAIT
                 ORDER BY Q.QUEUE_ITEM_ID) 
    LOOP
      BEGIN
        vRESULT := SUBSTR(LOADER4_PCKG.SET_PHONE_OPTION_OFF(REC.PARAM1, REC.PARAM2), 1, 250);
        IF TRIM(vRESULT) IS NULL THEN
          UPDATE QUEUE_ITEMS Q
             SET Q.STATE = QUEUE_STATE_DONE
                ,Q.ERROR_MESSAGE = NULL
                ,Q.DATE_PROCESS = SYSDATE
           WHERE Q.QUEUE_ITEM_ID = REC.QUEUE_ITEM_ID; 
        ELSE
          UPDATE QUEUE_ITEMS Q
             SET Q.STATE = QUEUE_STATE_ERROR
                ,Q.ERROR_MESSAGE = vRESULT
                ,Q.DATE_PROCESS = SYSDATE
           WHERE Q.QUEUE_ITEM_ID = REC.QUEUE_ITEM_ID; 
        END IF; 
      EXCEPTION WHEN OTHERS THEN
        UPDATE QUEUE_ITEMS Q
           SET Q.STATE = QUEUE_STATE_ERROR
              ,Q.ERROR_MESSAGE = SUBSTR(dbms_utility.format_error_stack ||CHR(13)||CHR(10)||dbms_utility.format_error_backtrace, 1, 2000)
              ,Q.DATE_PROCESS = SYSDATE
         WHERE Q.QUEUE_ITEM_ID = REC.QUEUE_ITEM_ID; 
      END; 
    END LOOP;  
  END;

  -- обрабатывает очередь заданий на выполнение функции LOADER4_PCKG.CP_TRANSFERS 
  --   результаты потом можно получить через GET_STATE 
  PROCEDURE WORK_CP_TRANSFERS IS
    vRESULT VARCHAR2(250 CHAR);
  BEGIN
    FOR REC IN (SELECT Q.QUEUE_ITEM_ID, Q.PARAM1, Q.PARAM2, Q.PARAM3
                  FROM QUEUE_ITEMS Q 
                 WHERE Q.QUEUE_TYPE = 'CP_TRANSFERS' AND Q.STATE = QUEUE_STATE_WAIT
                 ORDER BY Q.QUEUE_ITEM_ID) 
    LOOP
      BEGIN
        vRESULT := SUBSTR(LOADER4_PCKG.CP_TRANSFERS(REC.PARAM1, REC.PARAM2, REC.PARAM3), 1, 250);
        IF TRIM(vRESULT) IS NULL THEN
          UPDATE QUEUE_ITEMS Q
             SET Q.STATE = QUEUE_STATE_DONE
                ,Q.ERROR_MESSAGE = NULL
                ,Q.DATE_PROCESS = SYSDATE
           WHERE Q.QUEUE_ITEM_ID = REC.QUEUE_ITEM_ID; 
        ELSE
          UPDATE QUEUE_ITEMS Q
             SET Q.STATE = QUEUE_STATE_ERROR
                ,Q.ERROR_MESSAGE = vRESULT
                ,Q.DATE_PROCESS = SYSDATE
           WHERE Q.QUEUE_ITEM_ID = REC.QUEUE_ITEM_ID; 
        END IF; 
      EXCEPTION WHEN OTHERS THEN
        UPDATE QUEUE_ITEMS Q
           SET Q.STATE = QUEUE_STATE_ERROR
              ,Q.ERROR_MESSAGE = SUBSTR(dbms_utility.format_error_stack ||CHR(13)||CHR(10)||dbms_utility.format_error_backtrace, 1, 2000)
              ,Q.DATE_PROCESS = SYSDATE
         WHERE Q.QUEUE_ITEM_ID = REC.QUEUE_ITEM_ID; 
      END; 
    END LOOP;  
  END;
      
END; 