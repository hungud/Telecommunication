CREATE OR REPLACE PROCEDURE SHOW_USER_CHAT_TXT(
   pABONENT_USER_ID VARCHAR2 DEFAULT NULL,
   pDATE_LAST_CHECK VARCHAR2 DEFAULT NULL-- дата время последней проверки сообщений (DD.MM.YYYY HH24:MI:SS)
  ) IS
  
  --Version 1
  --
  --v.1 Алексеев. Функция показа чата на стороне абонента.
  --                     возвращаем сообщения после указанной даты
  --                     если дата не указана, то возвращаем все сообщения
  --                     если новых сообщений нет, то ждем некоторое время пока сообщение не появится
  --                     как только сообщение появляяется - возвращаем его 
  --                     если сообщение не появилось, то возвращаем ничего
  --                     последние 19 символ - дата последнего сообщения в формате DD.MM.YYYY HH24:MI:SS
  --                     если pDATE_LAST_CHECK не было определено и сообщений не найдено, то может быть вЁрнуто пусто
  
  vMESSAGE_COUNT PLS_INTEGER := 0;
  vBOLD_BEGIN VARCHAR2(10 CHAR);
  vBOLD_END VARCHAR2(10 CHAR);
  vDATE_LAST_CHECK DATE; -- 
  vDATE_THIS_CHECK DATE; -- дата-время проверки сообщений, которая делается сейчас
  vERROR BOOLEAN := FALSE;
  vWAIT_TIME PLS_INTEGER;
  LONG_POLLING_TIME CONSTANT PLS_INTEGER := 20; 
  
  CURSOR CUR_MESSAGES(pUSER_ID INTEGER, pDATE_FROM DATE, pDATE_TO DATE) IS
    SELECT T.* FROM
    (  
      SELECT MS.ROWID R_ID, MS.*, 1 IS_SENDER
        FROM D_INSTANT_MESSAGES MS 
       WHERE MS.SENDER_USER_ID = pUSER_ID
       UNION ALL
      SELECT MS.ROWID R_ID, MS.*, 0 IS_SENDER
        FROM D_INSTANT_MESSAGES MS
       WHERE MS.RECEIVER_USER_ID = pUSER_ID
    ) T
    WHERE ((pDATE_FROM IS NULL) OR (T.MESSAGE_DATE_TIME > pDATE_FROM))
      AND (T.MESSAGE_DATE_TIME <= pDATE_TO) -- чтобы вручную доюавленные сообщения болими датами не портили нам малину 
    ORDER BY T.MESSAGE_DATE_TIME;

  -- не залокировано ли сообщение 
  FUNCTION CHECK_MESSAGE_LOCKED(pD_INSTANT_MESSAGE_ID INTEGER) RETURN INTEGER IS
    CURSOR CUR IS 
      SELECT D_INSTANT_MESSAGE_ID 
      FROM D_INSTANT_MESSAGES D
      WHERE D.D_INSTANT_MESSAGE_ID = pD_INSTANT_MESSAGE_ID
      FOR UPDATE NOWAIT;
    REC CUR%ROWTYPE;
  BEGIN   
    OPEN CUR;
    FETCH CUR INTO REC;
    CLOSE CUR;
    RETURN 0;
  EXCEPTION WHEN  OTHERS THEN
    RETURN 1; 
  END;
    
BEGIN
  IF pABONENT_USER_ID IS NULL THEN
    OUT_ERROR('Ошибка! Код контрагента не передан!');
  ELSE
    IF pDATE_LAST_CHECK IS NULL THEN
      vDATE_LAST_CHECK := NULL;
    ELSE      
      BEGIN
        vDATE_LAST_CHECK := TO_DATE(pDATE_LAST_CHECK, 'DD.MM.YYYY HH24:MI:SS'); 
      EXCEPTION WHEN OTHERS THEN
        OUT_ERROR('Ошибка получения сообщений! Дата последнего сообщения должна быть в формате DD.MM.YYYY HH24:MI:SS');
        vERROR := TRUE;
      END;
    END IF;
    
    IF NOT vERROR THEN
      vWAIT_TIME := LONG_POLLING_TIME;
      WHILE (vWAIT_TIME > 0) AND (vMESSAGE_COUNT = 0) LOOP
        -- если время не передано, то не ждем, возвращаем все что есть
        IF vDATE_LAST_CHECK IS NULL THEN
          vWAIT_TIME := 0;
        END IF;

        vDATE_THIS_CHECK := SYSDATE; -- дату текущей проверки запрашиваем прям перед выполнением запроса
        -- возможно новое сообщение будет добавлено в ту же секунду когда мы сделали запрос, но чут попозже
        -- пока не отрабатываем такие ситации
        FOR REC_MESSAGES IN CUR_MESSAGES(pABONENT_USER_ID, vDATE_LAST_CHECK, vDATE_THIS_CHECK) LOOP
          -- новые жирным показываем
          IF NVL(REC_MESSAGES.IS_READ_ABONENT, 0) = 0 THEN
            vBOLD_BEGIN := '<b>';        
            vBOLD_END := '</b>';        
          END IF;
          
          HTP.PRINT('<tr><td colspan="2" style="padding: 5px 0px 5px 0px; border-top: thin dashed"></td></tr>');
          IF REC_MESSAGES.IS_SENDER = 1 THEN
            HTP.PRINT('<tr><td width=150 style="vertical-align: top; text-align: center"><b>Я:</b><br/>'
              ||INITCAP(S_GET_DATE_TIME_TEXT(REC_MESSAGES.MESSAGE_DATE_TIME))||'</td>
              <td style="vertical-align: top; text-align: left">'||S_PRINT_TEXT(REC_MESSAGES.TEXT)||'</td></tr>');
          ELSE
            HTP.PRINT('<tr style="background-color: #CEF1F5;"><td width="150" style="vertical-align: top; text-align: center;"><b>Оператор:</b><br/>'
              ||vBOLD_BEGIN||INITCAP(S_GET_DATE_TIME_TEXT(REC_MESSAGES.MESSAGE_DATE_TIME))||vBOLD_END||'</td>
              <td style="vertical-align: top; text-align: left">'||vBOLD_BEGIN||S_PRINT_TEXT(REC_MESSAGES.TEXT)||vBOLD_END||'</td></tr>
              ');
          END IF;
          --#E4E4E4
          
          --если есть непрочитанные сообщения, то увеличиваем счетчик
          IF (NVL(REC_MESSAGES.IS_READ_ABONENT, 0) = 0) THEN
            vMESSAGE_COUNT := vMESSAGE_COUNT + 1;
          END IF;

          IF (NVL(REC_MESSAGES.IS_READ_ABONENT, 0) = 0) AND (CHECK_MESSAGE_LOCKED(REC_MESSAGES.D_INSTANT_MESSAGE_ID) <> 1) THEN
            UPDATE D_INSTANT_MESSAGES D 
            SET D.IS_READ_ABONENT = 1
            WHERE D.D_INSTANT_MESSAGE_ID = REC_MESSAGES.D_INSTANT_MESSAGE_ID;
            COMMIT;
          END IF;
          
          vDATE_LAST_CHECK := REC_MESSAGES.MESSAGE_DATE_TIME;          
        END LOOP;
        
        IF (vWAIT_TIME > 0) AND (vMESSAGE_COUNT = 0) THEN
          dbms_lock.sleep(1);
        END IF;
        vWAIT_TIME := vWAIT_TIME - 1;
      END LOOP;
    END IF;
  END IF;
  HTP.PRINT(TO_CHAR(vDATE_THIS_CHECK, 'DD.MM.YYYY HH24:MI:SS'));
END;