CREATE OR REPLACE PROCEDURE AFFIX_RESPNSBL_CRM_CHAT IS

    --Version 2.
    --
    --v2. Алексеев. Добавил отпраку письма на почтуЮ если имеются неназначенные сообщения и/или
    --              отсутствуют операторы в сети.
    --v1. Алексеев. Процедура назначение ответственных по сообщениям абонента в CRM, 
    --              по которым ответственные назначены не были
    
    pRECEIVER_USER_ID integer;
    pUser_Lust_ID integer;
    pCount INTEGER;    
    vRes integer;
BEGIN   
    --проверяем наличие залогиненных пользователей 
    --те, у которых за последние 31 секунд обновлен статус
    --и на которых можно назначать сообщения
    SELECT count(USER_NAME_ID)
       INTO pCount
      FROM USER_NAMES
    WHERE NVL(WORK_WITH_CHAT, 0) = 1
         AND LAST_ACTIVE is not null
         AND to_date(to_char(LAST_ACTIVE, 'DD.MM.YYYY HH24:MI:SS'), 'DD.MM.YYYY HH24:MI:SS') >= ((sysdate+1/24) - (31/24/60/60));

    --если в системе имеются залогиненные пользователи, то тогда имеет смысл смотреть неназначенные сообщения
    IF nvl(pCount, 0) > 0 THEN
        --отбираем все сообщения абонентов, по которым ответственные проставлены не были 
        FOR vrec IN (
                             SELECT D_INSTANT_MESSAGE_ID,
                                         SENDER_USER_ID
                               FROM LONTANA_WWW.D_INSTANT_MESSAGES
                             WHERE RECEIVER_USER_ID IS NULL
                          )
        LOOP
            --повторно проверяем наличие залогиненных пользователей 
            --те, у которых за последние 31 секунд обновлен статус
            SELECT count(USER_NAME_ID)
                INTO pCount
              FROM USER_NAMES
            WHERE NVL(WORK_WITH_CHAT, 0) = 1
                 AND LAST_ACTIVE is not null
                 AND to_date(to_char(LAST_ACTIVE, 'DD.MM.YYYY HH24:MI:SS'), 'DD.MM.YYYY HH24:MI:SS') >= ((sysdate+1/24) - (31/24/60/60));

            --если имеются залогиненные пользователи
            IF nvl(pCount, 0) > 0 THEN               
                --оператор может уже вести с абонентом диалог, необходимо определить данного оператора.
                --определяем с помощью поля CONTRACT_ACTIVE_CHAT табл. USER_NAMES
                --важно, чтобы данный оператор в текущий момент был в сети
                SELECT count(USER_NAME_ID)
                   INTO pCount
                  FROM USER_NAMES
                WHERE NVL(WORK_WITH_CHAT, 0) = 1
                     AND NVL(CONTRACT_ACTIVE_CHAT, 0) = vrec.SENDER_USER_ID
                     AND LAST_ACTIVE is not null
                     AND to_date(to_char(LAST_ACTIVE, 'DD.MM.YYYY HH24:MI:SS'), 'DD.MM.YYYY HH24:MI:SS') >= ((sysdate+1/24) - (31/24/60/60));
                     
                --если есть оператор, который общается уже с данным абонентом
                IF nvl(pCount, 0) > 0 THEN
                      SELECT USER_NAME_ID
                       INTO pRECEIVER_USER_ID
                      FROM USER_NAMES
                    WHERE NVL(WORK_WITH_CHAT, 0) = 1
                         AND NVL(CONTRACT_ACTIVE_CHAT, 0) = vrec.SENDER_USER_ID
                         AND LAST_ACTIVE is not null
                         AND to_date(to_char(LAST_ACTIVE, 'DD.MM.YYYY HH24:MI:SS'), 'DD.MM.YYYY HH24:MI:SS') >= ((sysdate+1/24) - (31/24/60/60));
                ELSE  --если с данным абонентом активных диалогов нет              
                    --определяем оператора, с которым диалог открывался последним
                    pUser_Lust_ID := NVL(MS_PARAMS.GET_PARAM_VALUE('USER_LAST_CRM_CHAT'), '');
                    
                    --если pUser_Lust пустой, то берем максимального ID и у которого нет активного диалога
                    IF NVL(pUser_Lust_ID, 0) = 0 THEN
                        BEGIN
                            SELECT USER_NAME_ID
                               INTO pRECEIVER_USER_ID
                              FROM USER_NAMES
                            WHERE NVL(WORK_WITH_CHAT, 0) = 1
                                 AND NVL(CONTRACT_ACTIVE_CHAT, 0) = 0
                                 AND LAST_ACTIVE is not null
                                 AND to_date(to_char(LAST_ACTIVE, 'DD.MM.YYYY HH24:MI:SS'), 'DD.MM.YYYY HH24:MI:SS') >= ((sysdate+1/24) - (31/24/60/60))
                                 AND USER_NAME_ID = (
                                                                      SELECT MAX(us.USER_NAME_ID)
                                                                        FROM USER_NAMES us
                                                                      WHERE NVL(us.WORK_WITH_CHAT, 0) = 1
                                                                           AND NVL(CONTRACT_ACTIVE_CHAT, 0) = 0
                                                                           AND us.LAST_ACTIVE is not null
                                                                           AND to_date(to_char(us.LAST_ACTIVE, 'DD.MM.YYYY HH24:MI:SS'), 'DD.MM.YYYY HH24:MI:SS') >= ((sysdate+1/24) - (31/24/60/60))
                                                                  );
                        EXCEPTION
                            WHEN OTHERS THEN
                                NULL;   
                        END;                                    
                    ELSE
                        --проверяем наличие пользователей, на которых можно назначать диалоги и у которых нет активных диалогов
                         SELECT count(USER_NAME_ID)
                            INTO pCount
                           FROM USER_NAMES
                        WHERE NVL(WORK_WITH_CHAT, 0) = 1
                             AND NVL(CONTRACT_ACTIVE_CHAT, 0) = 0
                             AND LAST_ACTIVE is not null
                             AND to_date(to_char(LAST_ACTIVE, 'DD.MM.YYYY HH24:MI:SS'), 'DD.MM.YYYY HH24:MI:SS') >= ((sysdate+1/24) - (31/24/60/60))
                             AND USER_NAME_ID < (
                                                                  SELECT USER_NAME_ID
                                                                    FROM USER_NAMES
                                                                  WHERE USER_NAME_ID = pUser_Lust_ID
                                                               )
                        ORDER BY USER_NAME_ID desc;
                        
                        IF pCount > 0 THEN
                            BEGIN
                                SELECT USER_NAME_ID
                                   INTO pRECEIVER_USER_ID
                                  FROM
                                  (
                                     SELECT USER_NAME_ID
                                       FROM USER_NAMES
                                     WHERE NVL(WORK_WITH_CHAT, 0) = 1
                                         AND NVL(CONTRACT_ACTIVE_CHAT, 0) = 0 
                                         AND LAST_ACTIVE is not null
                                         AND to_date(to_char(LAST_ACTIVE, 'DD.MM.YYYY HH24:MI:SS'), 'DD.MM.YYYY HH24:MI:SS') >= ((sysdate+1/24) - (31/24/60/60))
                                         AND USER_NAME_ID < (
                                                                              SELECT USER_NAME_ID
                                                                                FROM USER_NAMES
                                                                              WHERE USER_NAME_ID = pUser_Lust_ID
                                                                           )
                                     ORDER BY USER_NAME_ID desc
                                  )
                                WHERE ROWNUM = 1;
                            EXCEPTION
                                WHEN OTHERS THEN
                                    NULL;  
                            END;
                        ELSE
                            BEGIN
                                --устанавливаем на максимального
                                 SELECT USER_NAME_ID
                                    INTO pRECEIVER_USER_ID
                                   FROM USER_NAMES
                                WHERE NVL(WORK_WITH_CHAT, 0) = 1
                                     AND NVL(CONTRACT_ACTIVE_CHAT, 0) = 0
                                     AND LAST_ACTIVE is not null
                                     AND to_date(to_char(LAST_ACTIVE, 'DD.MM.YYYY HH24:MI:SS'), 'DD.MM.YYYY HH24:MI:SS') >= ((sysdate+1/24) - (31/24/60/60))
                                     AND USER_NAME_ID = (
                                                                          SELECT MAX(us.USER_NAME_ID)
                                                                            FROM USER_NAMES us
                                                                          WHERE NVL(us.WORK_WITH_CHAT, 0) = 1
                                                                               AND NVL(CONTRACT_ACTIVE_CHAT, 0) = 0
                                                                               AND us.LAST_ACTIVE is not null
                                                                               AND to_date(to_char(us.LAST_ACTIVE, 'DD.MM.YYYY HH24:MI:SS'), 'DD.MM.YYYY HH24:MI:SS') >= ((sysdate+1/24) - (31/24/60/60))
                                                                       );
                            EXCEPTION
                                WHEN OTHERS THEN
                                    NULL;  
                            END;
                        END IF;
                    END IF;
                    
                    --обновляем пользователя в таблице констант
                    vRes := MS_PARAMS.SET_PARAM_VALUE('USER_LAST_CRM_CHAT', pRECEIVER_USER_ID);      
                END IF;
                
                --обновляем назначенного по сообщению
                UPDATE LONTANA_WWW.D_INSTANT_MESSAGES
                      SET RECEIVER_USER_ID  = pRECEIVER_USER_ID
                WHERE D_INSTANT_MESSAGE_ID = vrec.D_INSTANT_MESSAGE_ID;
                --устанавливаем оператору признак наличия активного диалога с указанным абонентом
                UPDATE USER_NAMES
                      SET CONTRACT_ACTIVE_CHAT  = vrec.SENDER_USER_ID
                WHERE USER_NAME_ID = pRECEIVER_USER_ID;
                COMMIT;
                --уведомляем оператора
                OPERATORS_MESS_NOTIFICATION(vrec.D_INSTANT_MESSAGE_ID);
            ELSE
              --информируем об отсутствии операторов в сети
              send_sys_mail('Отсутствие операторов в сети', 'Операторы, имеющие возможность работать с чатом, отсутствуют в сети!', 'EMAIL_SEND_INFO_NOT_OPER_CHAT');
            END IF;
        END LOOP;
    ELSE
      --информируем об отсутствии операторов в сети
      send_sys_mail('Отсутствие операторов в сети', 'Операторы, имеющие возможность работать с чатом, отсутствуют в сети!', 'EMAIL_SEND_INFO_NOT_OPER_CHAT');
    END IF;
END;