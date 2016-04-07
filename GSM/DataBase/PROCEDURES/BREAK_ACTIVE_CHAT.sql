CREATE OR REPLACE PROCEDURE BREAK_ACTIVE_CHAT IS

  --Version 2
  --
  --v.2 Алексеев. 12.11.2015 Добавил закрытие диалога на стороне оператора. Выполнение CLOSE_OPERATORS_CHAT
  --v.1 Алексеев. 11.11.2015 Функция разрыва активного диалога оператора с абонентом.
  --                                      Диалог разрывается если оператор вышел из сети или 
  --                                      последнее сообщение в диалоге было более 10 мин назад.
  --                                      После разрыва создается заявка, в которой сохраняется текущая переписка, а с оператора
  --                                      снимается признак заянтости (т.е. активного диалога).
  
   TYPE TUserID IS RECORD
   (
     USER_NAME_ID INTEGER,
     USER_NAME VARCHAR2(120 CHAR),
     CONTRACT_ID INTEGER
   ); 
   type TArrayUserID is table of TUserID index by pls_integer;   
   vListUserID TArrayUserID; 
   pREQUEST_ID INTEGER;
   pPHONE VARCHAR2(10 CHAR);
   pTxt VARCHAR2(20000 CHAR);
   pUser_Create varchar2(30);
   pUser_Chat varchar2(30);
   pCount INTEGER;
   pOperName Varchar2(2000 CHAR);
   pOperator Varchar2(30 CHAR);
BEGIN
  --отбираем все активные диалоги, которые необх. разорвать
  select US.USER_NAME_ID,
           US.USER_NAME,
           US.CONTRACT_ACTIVE_CHAT
  bulk collect into vListUserID
    from USER_NAMES us
  where nvl(US.CONTRACT_ACTIVE_CHAT, 0) <> 0 --берем все активные диалоги
      and nvl(US.IS_NOT_BREAK_CHAT, 0) = 0 --только те, по которым нет запрета разрыва
      and (
                (
                  LAST_ACTIVE is not null
                  AND 
                  (to_date(to_char(LAST_ACTIVE, 'DD.MM.YYYY HH24:MI:SS'), 'DD.MM.YYYY HH24:MI:SS') + (31/24/60/60)) < (sysdate+1/24)
                ) 
                OR
                (
                    (sysdate - 10/24/60) >=  (
                                                           SELECT MAX(MESSAGE_DATE_TIME)
                                                             FROM LONTANA_WWW.D_INSTANT_MESSAGES
                                                           WHERE ( 
                                                                          (nvl(SENDER_USER_ID, 0) = nvl(US.CONTRACT_ACTIVE_CHAT, 0))
                                                                          OR 
                                                                          (nvl(RECEIVER_USER_ID, 0) = nvl(US.CONTRACT_ACTIVE_CHAT, 0))
                                                                       )
                                                         )
                )
            );
  
  IF vListUserID.COUNT > 0 THEN
    FOR I IN 1..vListUserID.COUNT LOOP
      BEGIN
        --определяем номер по id контракта
        pPHONE := WWW_GET_PHONE_BY_CONTRACTID(vListUserID(I).CONTRACT_ID);
        
        --определение оператора по номеру
        pOperName := GET_OPERATOR_BY_PHONE(pPHONE);
        --определяем оператора для записи в заявке
        pOperator := '';
        SELECT count(*)
           INTO pCount
          FROM OPERATORS op
        WHERE OP.OPERATOR_NAME = pOperName;
        
        IF nvl(pCount, 0) <> 0 THEN
          SELECT OP.OPERATOR_FOR_CHAT
             INTO pOperator
            FROM OPERATORS op
          WHERE OP.OPERATOR_NAME = pOperName;
        END IF;
        
        --запоминаем всю переписку
        pTxt := 'Диалог абонента +7'||pPHONE||' с оператором '||vListUserID(I).USER_NAME||': '||chr(10);
        FOR rec IN (
                            SELECT MESSAGE_DATE_TIME,
                                        SENDER_USER_ID,
                                        TEXT
                              FROM LONTANA_WWW.D_INSTANT_MESSAGES
                            WHERE ( 
                                          (nvl(SENDER_USER_ID, 0) = vListUserID(I).CONTRACT_ID)
                                          OR 
                                          (nvl(RECEIVER_USER_ID, 0) = vListUserID(I).CONTRACT_ID)
                                        )
                                 AND nvl(REQUEST_ID, 0) = 0
                           ORDER BY MESSAGE_DATE_TIME DESC
                        )
        LOOP
          IF rec.SENDER_USER_ID = vListUserID(I).CONTRACT_ID THEN
            pUser_Chat := 'Абонент:';
          ELSE
            pUser_Chat := 'Оператор:';
          END IF;
          
          pTxt := pTxt||to_char(rec.MESSAGE_DATE_TIME, 'DD.MM.YYYY HH24:MI:SS')||' '||pUser_Chat||'   '||rec.TEXT||chr(10);
        END LOOP;
        
        --в качестве пользователя, создавшего заявку выбираем Admin
        pUser_Create := '';
        SELECT count(USER_FIO)
           INTO pCount
          FROM USER_NAMES
        WHERE USER_NAME_ID = 864;
        
        IF nvl(pCount, 0) = 1 THEN
          SELECT USER_FIO
             INTO pUser_Create
            FROM USER_NAMES
          WHERE USER_NAME_ID = 864;
        END IF;
        
        --определяем номер заявки
        pREQUEST_ID := S_NEW_REQUEST_ID.NEXTVAL;
        
        --создаем заявку
        INSERT INTO CRM_REQUESTS 
        (
           REQUEST_ID,
           PHONE_NUMBER, --НОМЕР ТЕЛЕФОНА
           ID_STATUS_REQUEST, --ID СТАТУСА ЗАПРОСА
           DATE_CREATED, --ДАТА СОЗДАНИЯ
           USER_CREATED, ---ПОЛЬЗОВАТЕЛЬ, СОЗДАВШИЙ 
           RESPONSIBLE_USER, --ОТВЕТСВЕННЫЙ ПОЛЬЗОВАТЕЛЬ
           TYPE_REQUEST_ID, --ID ТИПА ЗАПРОСА
           DEADLINE_DATE, --КРАЙНИЙ СРОК
           OPERATOR, --ОПЕРАТОР  
           TEXT_REQUEST --ТЕКСТ ЗАПРОСА(типа clob)
        ) 
        VALUES
        (
           pREQUEST_ID,
           pPHONE,
           1, --статус - новый 
           sysdate,
           pUser_Create, 
           vListUserID(I).USER_NAME, 
           121, --обращение в чат
           trunc(sysdate + 1), 
           pOperator, 
           to_clob(pTxt)
        ) ; 
        
        --обновляем заявки у сообщений
        UPDATE LONTANA_WWW.D_INSTANT_MESSAGES
              SET REQUEST_ID = pREQUEST_ID
         WHERE ( 
                       (nvl(SENDER_USER_ID, 0) = vListUserID(I).CONTRACT_ID)
                       OR 
                       (nvl(RECEIVER_USER_ID, 0) = vListUserID(I).CONTRACT_ID)
                     )
              AND nvl(REQUEST_ID, 0) = 0;
              
        --разрываем диалог (снимаем с оператора признак занятости)
        UPDATE USER_NAMES ns
              SET NS.CONTRACT_ACTIVE_CHAT = 0                 
        WHERE NS.USER_NAME_ID = vListUserID(I).USER_NAME_ID;
        
        --закрываем диалог у оператора
        CLOSE_OPERATORS_CHAT(vListUserID(I).USER_NAME_ID);
      EXCEPTION
        WHEN OTHERS THEN 
          NULL;
      END;
      COMMIT;
    END LOOP;   
  END IF;                                                        
END;