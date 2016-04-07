CREATE OR REPLACE PROCEDURE GET_REQUESTS_CRM
(
  pPHONE varchar2,
  pDOP_PHONE varchar2 DEFAULT NULL
)
-- version 5
--
--v.5 Алексеев. 01.02.2016. Поправил алгоритм определения, операторов, находящихся в сети. Вместо 31 с установил 45.
--v4. Алексеев. Поправлен выбор ответственного по заявке при наличии пользователя, последним выполняющий заявку
--v3. Алексеев. Поправлен выбор пользователя последним выполняющий заявку на разблок (тип 8). Период проверки на залогиненность изменен с 30 с. до 31с.
--v2. Алексеев. Если в системе CRM отсутствуют залогиненные пользователи, то в заявке ответственный не указывается
-- v1. автор: Алексеев А.
-- процедура взаимодействия с IVR (голосовой робот). Дергается вот эта ссылка и возвращается результат постановки заявки в CRM на разблокировку пользователя
--в CRM ставится заявка на разблокировку номера (Ответ: Ваша заявка принята)
IS 
  vRES VARCHAR2(1000 CHAR);
  pTxt varchar2(100);
  pRESPONSIBLE_USER varchar2(30);
  pUser_Lust varchar2(30);
  pUser_Create varchar2(30);
  pOPERATOR varchar2(50);
  pCount INTEGER;
BEGIN
  BEGIN 
    --текст заявки на разблок
    pTxt := 'Срочно разблокировать номер '||pPHONE||'.'; 
    
    --поле OPERATOR
    pOPERATOR := '';
    SELECT count(op.LOADER_SCRIPT_NAME)
    INTO pCount
    FROM OPERATORS op
    WHERE op.OPERATOR_ID = 3; --Билайн
    
    IF pCount = 1 THEN
      SELECT LOADER_SCRIPT_NAME
      INTO pOPERATOR
      FROM OPERATORS
      WHERE OPERATOR_ID = 3; --Билайн
    END IF;
    
    --определяем пользователя, от которого создаем заявки (это пользователь 864 - Admin)
    pUser_Create := '';
    SELECT count(USER_FIO)
    INTO pCount
    FROM USER_NAMES
    WHERE USER_NAME_ID = 864;
    
    IF pCount = 1 THEN
        SELECT USER_FIO
        INTO pUser_Create
        FROM USER_NAMES
        WHERE USER_NAME_ID = 864;
    END IF;
    
    --определяем пользователя последним выполняющий заявку на разблок (тип 8)
    pUser_Lust := NVL(ms_constants.GET_CONSTANT_VALUE('USER_LAST_CRM_REQUEST_UNLOCK'), '');
    
    IF TRIM(pUser_Lust) = '' THEN
        select count(CR.RESPONSIBLE_USER)
        into pCount
        from CRM_REQUESTS cr
        where CR.REQUEST_ID = (
                                               select max(REQ.REQUEST_ID)
                                               from CRM_REQUESTS req
                                               where req.TYPE_REQUEST_ID = 8
                                               and REQ.USER_CREATED = pUser_Create
                                               and exists
                                                                (
                                                                    select 1
                                                                    from USER_NAMES us
                                                                    where US.USER_NAME = REQ.RESPONSIBLE_USER
                                                                    and NVL(us.work_with_ivr, 0) = 1
                                                                ) 
                                              );
        
        IF pCount = 1 THEN                                       
          select NVL(CR.RESPONSIBLE_USER, '')
          into pUser_Lust
          from CRM_REQUESTS cr
          where CR.REQUEST_ID = (
                                                 select max(REQ.REQUEST_ID)
                                                 from CRM_REQUESTS req
                                                 where req.TYPE_REQUEST_ID = 8
                                                 and REQ.USER_CREATED = pUser_Create
                                                 and exists
                                                                (
                                                                    select 1
                                                                    from USER_NAMES us
                                                                    where US.USER_NAME = REQ.RESPONSIBLE_USER
                                                                    and NVL(us.work_with_ivr, 0) = 1
                                                                ) 
                                                );
        END IF;   
    END IF;                                            
    
    --проверяем наличие залогиненных пользователей 
    --те, у которых за последние 30 секунд обновлен статус
    SELECT count(USER_NAME)
    INTO pCount
    FROM USER_NAMES
    WHERE NVL(work_with_ivr, 0) = 1
    AND LAST_ACTIVE is not null
    AND to_date(to_char(LAST_ACTIVE, 'DD.MM.YYYY HH24:MI:SS'), 'DD.MM.YYYY HH24:MI:SS') >= ((sysdate+1/24) - (45/24/60/60));
    
    pRESPONSIBLE_USER := ''; --ответственный
    --если имеются залогиненные пользователи
    IF pCount > 0 THEN
      --если pUser_Lust пустой, то берем максимального ID
      IF TRIM(pUser_Lust) = '' THEN
        BEGIN
          SELECT USER_NAME
          INTO pRESPONSIBLE_USER
          FROM USER_NAMES
          WHERE NVL(work_with_ivr, 0) = 1
          AND LAST_ACTIVE is not null
          AND to_date(to_char(LAST_ACTIVE, 'DD.MM.YYYY HH24:MI:SS'), 'DD.MM.YYYY HH24:MI:SS') >= ((sysdate+1/24) - (45/24/60/60))
          and USER_NAME_ID = (SELECT MAX(us.USER_NAME_ID)
                                            FROM USER_NAMES us
                                            WHERE NVL(us.work_with_ivr, 0) = 1
                                            AND us.LAST_ACTIVE is not null
                                            AND to_date(to_char(us.LAST_ACTIVE, 'DD.MM.YYYY HH24:MI:SS'), 'DD.MM.YYYY HH24:MI:SS') >= ((sysdate+1/24) - (45/24/60/60)));
        EXCEPTION
          WHEN OTHERS THEN
            HTP.PRINT('Error! При выполнении запроса возникла ошибка!');   
        END;                                    
      ELSE
        --проверяем наличие пользователей 
        SELECT count(USER_NAME)
        INTO pCount
        FROM USER_NAMES
        WHERE NVL(work_with_ivr, 0) = 1
        AND LAST_ACTIVE is not null
        AND to_date(to_char(LAST_ACTIVE, 'DD.MM.YYYY HH24:MI:SS'), 'DD.MM.YYYY HH24:MI:SS') >= ((sysdate+1/24) - (45/24/60/60))
        and USER_NAME_ID < (SELECT USER_NAME_ID
                                           FROM USER_NAMES
                                           WHERE USER_NAME = pUser_Lust)
        ORDER BY USER_NAME_ID desc;
        
        IF pCount > 0 THEN
          BEGIN
            SELECT USER_NAME
            INTO pRESPONSIBLE_USER
            FROM
            (SELECT USER_NAME
             FROM USER_NAMES
             WHERE NVL(work_with_ivr, 0) = 1
             AND LAST_ACTIVE is not null
             AND to_date(to_char(LAST_ACTIVE, 'DD.MM.YYYY HH24:MI:SS'), 'DD.MM.YYYY HH24:MI:SS') >= ((sysdate+1/24) - (45/24/60/60))
             and USER_NAME_ID < (SELECT USER_NAME_ID
                                                FROM USER_NAMES
                                                WHERE USER_NAME = pUser_Lust)
             ORDER BY USER_NAME_ID desc)
            WHERE ROWNUM = 1;
          EXCEPTION
            WHEN OTHERS THEN
              HTP.PRINT('Error! При выполнении запроса возникла ошибка!');  
          END;
        ELSE
          BEGIN
            --устанавливаем на максимального
            SELECT USER_NAME
            INTO pRESPONSIBLE_USER
            FROM USER_NAMES
            WHERE NVL(work_with_ivr, 0) = 1
            AND LAST_ACTIVE is not null
            AND to_date(to_char(LAST_ACTIVE, 'DD.MM.YYYY HH24:MI:SS'), 'DD.MM.YYYY HH24:MI:SS') >= ((sysdate+1/24) - (45/24/60/60))
            and USER_NAME_ID = (SELECT MAX(us.USER_NAME_ID)
                                               FROM USER_NAMES us
                                               WHERE NVL(us.work_with_ivr, 0) = 1
                                               AND us.LAST_ACTIVE is not null
                                               AND to_date(to_char(us.LAST_ACTIVE, 'DD.MM.YYYY HH24:MI:SS'), 'DD.MM.YYYY HH24:MI:SS') >= ((sysdate+1/24) - (45/24/60/60)));
          EXCEPTION
            WHEN OTHERS THEN
              HTP.PRINT('Error! При выполнении запроса возникла ошибка!');  
          END;
        END IF;
      END IF;
    END IF;
    
    --создаем заявку в CRM
    INSERT INTO CRM_REQUESTS 
    (
       PHONE_NUMBER, --НОМЕР ТЕЛЕФОНА
       ID_STATUS_REQUEST, --ID СТАТУСА ЗАПРОСА
       DATE_CREATED, --ДАТА СОЗДАНИЯ
       USER_CREATED, ---ПОЛЬЗОВАТЕЛЬ, СОЗДАВШИЙ 
       RESPONSIBLE_USER, --ОТВЕТСВЕННЫЙ ПОЛЬЗОВАТЕЛЬ
       TYPE_REQUEST_ID, --ID ТИПА ЗАПРОСА
       DOP_CONTACT, --ДОПОЛНИТЕЛЬНЫЙ КОНТАКТ
       DEADLINE_DATE, --КРАЙНИЙ СРОК
       OPERATOR, --ОПЕРАТОР  
       TEXT_REQUEST --ТЕКСТ ЗАПРОСА(типа clob)
    ) 
    VALUES
    (
       pPHONE, --номер на разблок
       1, --статус - новый 
       sysdate, 
       pUser_Create, 
       pRESPONSIBLE_USER, 
       8, --заявка на разблокировку
       pDOP_PHONE, 
       trunc(sysdate + 1), 
       pOPERATOR, 
       to_clob(pTxt)
    ) ;
    --обновляем пользователя в таблице констант
    vRes := ms_constants.SET_CONSTANT_VALUE('USER_LAST_CRM_REQUEST_UNLOCK', pRESPONSIBLE_USER);   
    COMMIT;
    --выводим ответ 
    HTP.PRINT('Ваша заявка принята.');   
  EXCEPTION 
    WHEN OTHERS THEN
      HTP.PRINT('Error! При выполнении запроса возникла ошибка!');    
  END;        
END;