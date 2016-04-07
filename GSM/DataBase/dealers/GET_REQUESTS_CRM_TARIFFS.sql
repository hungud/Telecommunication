CREATE OR REPLACE PROCEDURE WWW_DEALER.GET_REQUESTS_CRM_TARIFFS
  (
    pPHONE VARCHAR2,
    pPARAM_TARIFFS INTEGER DEFAULT 0
  )
  IS
  
  -- version 2
  --
  -- v2. Алексеев А. Октел передает номер из 11 цифр, т.е. вместе с 7. Учел этот момент. Если 11 цифр отсекаю первую
  -- v1. Алексеев А. Процедура взаимодействия с IVR (голосовой робот). Дергается вот эта ссылка и возвращается результат постановки заявки в CRM на активацию номера
  --                         В CRM ставится заявка на активацию номера.
  --                         Коды ошибок описаны в таблице REQ_CRM_TARIFF_ERROR_TYPE. (0 - заявка поставленна успешно).
  
  vPHONE VARCHAR2(10 CHAR);
  vRES VARCHAR2(1000 CHAR);
  pTxt varchar2(100);
  pRESPONSIBLE_USER varchar2(30);
  pUser_Lust varchar2(30);
  pUser_Create varchar2(30);
  pOPERATOR varchar2(50);
  pCount INTEGER;
  pError_Code integer;
  pTariff_Name Varchar2(100 char);
  pOperName Varchar2(2000 CHAR);
BEGIN
  --устанавливаем код ошибки в 0, это означает что все хорошо
  pError_Code := 0; -- Ваша заявка принята.
  --проверяем корректность ввода номера
  IF (pPHONE IS NOT NULL) AND ((LENGTH(pPHONE) = 10) OR (LENGTH(pPHONE) = 11)) THEN
    --Берем всегда только последние 10 цифр
    vPHONE := SUBSTR (pPHONE, -10);
    
    --проверяем корректность ввода передаваемого параметра для определения тарифа
    IF (pPARAM_TARIFFS IS NOT NULL) THEN
      --определяем тариф по переданному параметру
      pCount := 0;
      select count(*)
         into pCount
        from TARIFFS tr
      where tr.NUMBER_TARIFF_IVR = NVL(pPARAM_TARIFFS, -1); --поставил -1, т.к. вдруг кто то установить в поле значение 0

      --определяем тариф
      IF nvl(pCount, 0) = 1 THEN
        BEGIN
          select TR.TARIFF_NAME
             into pTariff_Name
            from TARIFFS tr
          where tr.NUMBER_TARIFF_IVR = NVL(pPARAM_TARIFFS, -1);

          --текст заявки на разблок
          pTxt := 'Активировать номер +7'||vPHONE||' на тариф "'||pTariff_Name||'".';
             
          --определение оператора по номеру
          pOperName := GET_OPERATOR_BY_PHONE(vPHONE);
          --определяем оператора для записи в заявке
          pOPERATOR := '';
          SELECT count(*)
             INTO pCount
            FROM OPERATORS op
          WHERE OP.OPERATOR_NAME = pOperName;
           
          IF nvl(pCount, 0) <> 0 THEN
            SELECT OP.OPERATOR_FOR_CHAT
               INTO pOPERATOR
              FROM OPERATORS op
            WHERE OP.OPERATOR_NAME = pOperName;
          END IF;

          --определяем пользователя, от которого создаем заявки (это пользователь 864 - Admin)
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
           
          --определяем пользователя последним выполняющий заявку на активацию номера
          pUser_Lust := NVL(MS_PARAMS.GET_PARAM_VALUE('USER_LAST_CRM_REQUEST_ACT_TARIFFS'), '');

          IF TRIM(pUser_Lust) = '' THEN
            select count(CR.RESPONSIBLE_USER)
               into pCount
              from CRM_REQUESTS cr
            where CR.REQUEST_ID = (
                                                     select max(REQ.REQUEST_ID)
                                                       from CRM_REQUESTS req
                                                     where req.TYPE_REQUEST_ID = 162
                                                         and REQ.USER_CREATED = pUser_Create
                                                         and exists
                                                                        (
                                                                            select 1
                                                                              from USER_NAMES us
                                                                            where US.USER_NAME = REQ.RESPONSIBLE_USER
                                                                                and NVL(us.WORK_WITH_TARIFF_ACTIVATION, 0) = 1
                                                                        ) 
                                                  );
            
            IF nvl(pCount, 0) = 1 THEN                                       
              select NVL(CR.RESPONSIBLE_USER, '')
                 into pUser_Lust
                from CRM_REQUESTS cr
              where CR.REQUEST_ID = (
                                                       select max(REQ.REQUEST_ID)
                                                         from CRM_REQUESTS req
                                                       where req.TYPE_REQUEST_ID = 162
                                                           and REQ.USER_CREATED = pUser_Create
                                                           and exists
                                                                          (
                                                                              select 1
                                                                                from USER_NAMES us
                                                                              where US.USER_NAME = REQ.RESPONSIBLE_USER
                                                                                  and NVL(us.WORK_WITH_TARIFF_ACTIVATION, 0) = 1
                                                                          ) 
                                                    );
            END IF;   
          END IF;                                            

          --проверяем наличие залогиненных пользователей 
          --те, у которых за последние 40 секунд обновлен статус
          SELECT count(USER_NAME)
             INTO pCount
            FROM USER_NAMES
          WHERE NVL(WORK_WITH_TARIFF_ACTIVATION, 0) = 1
               AND LAST_ACTIVE is not null
               AND to_date(to_char(LAST_ACTIVE, 'DD.MM.YYYY HH24:MI:SS'), 'DD.MM.YYYY HH24:MI:SS') >= ((sysdate+1/24) - (40/24/60/60));
                
          pRESPONSIBLE_USER := ''; --ответственный
          --если имеются залогиненные пользователи
          --при отсутствии залогиненных пользователей, заявка будет создана, а ответственный назнчен позже другим механизмом
          IF pCount > 0 THEN
            --если pUser_Lust пустой, то берем максимального ID
            IF TRIM(pUser_Lust) = '' THEN
              BEGIN
                SELECT USER_NAME
                   INTO pRESPONSIBLE_USER
                  FROM USER_NAMES
                WHERE NVL(WORK_WITH_TARIFF_ACTIVATION, 0) = 1
                     AND LAST_ACTIVE is not null
                     AND to_date(to_char(LAST_ACTIVE, 'DD.MM.YYYY HH24:MI:SS'), 'DD.MM.YYYY HH24:MI:SS') >= ((sysdate+1/24) - (40/24/60/60))
                     AND USER_NAME_ID = (
                                                          SELECT MAX(us.USER_NAME_ID)
                                                            FROM USER_NAMES us
                                                          WHERE NVL(us.WORK_WITH_TARIFF_ACTIVATION, 0) = 1
                                                               AND us.LAST_ACTIVE is not null
                                                               AND to_date(to_char(us.LAST_ACTIVE, 'DD.MM.YYYY HH24:MI:SS'), 'DD.MM.YYYY HH24:MI:SS') >= ((sysdate+1/24) - (40/24/60/60))
                                                      );
              EXCEPTION
                WHEN OTHERS THEN
                  pError_Code := 5; --Ошибка определения ответственного по заявке (таблица ошибок REQ_CRM_TARIFF_ERROR_TYPE)     
              END;                                    
            ELSE
              --проверяем наличие пользователей 
              SELECT count(USER_NAME)
                 INTO pCount
                FROM USER_NAMES
              WHERE NVL(WORK_WITH_TARIFF_ACTIVATION, 0) = 1
                   AND LAST_ACTIVE is not null
                   AND to_date(to_char(LAST_ACTIVE, 'DD.MM.YYYY HH24:MI:SS'), 'DD.MM.YYYY HH24:MI:SS') >= ((sysdate+1/24) - (40/24/60/60))
                   AND USER_NAME_ID < (
                                                        SELECT USER_NAME_ID
                                                          FROM USER_NAMES
                                                        WHERE USER_NAME = pUser_Lust
                                                     )
              ORDER BY USER_NAME_ID desc;

              IF pCount > 0 THEN
                BEGIN
                  SELECT USER_NAME
                     INTO pRESPONSIBLE_USER
                    FROM
                    (SELECT USER_NAME
                       FROM USER_NAMES
                     WHERE NVL(WORK_WITH_TARIFF_ACTIVATION, 0) = 1
                          AND LAST_ACTIVE is not null
                          AND to_date(to_char(LAST_ACTIVE, 'DD.MM.YYYY HH24:MI:SS'), 'DD.MM.YYYY HH24:MI:SS') >= ((sysdate+1/24) - (40/24/60/60))
                          AND USER_NAME_ID < (
                                                               SELECT USER_NAME_ID
                                                                 FROM USER_NAMES
                                                               WHERE USER_NAME = pUser_Lust
                                                            )
                     ORDER BY USER_NAME_ID desc)
                  WHERE ROWNUM = 1;
                EXCEPTION
                  WHEN OTHERS THEN
                    pError_Code := 5; --Ошибка определения ответственного по заявке (таблица ошибок REQ_CRM_TARIFF_ERROR_TYPE)
                END;
              ELSE
                BEGIN
                  --устанавливаем на максимального
                  SELECT USER_NAME
                     INTO pRESPONSIBLE_USER
                    FROM USER_NAMES
                  WHERE NVL(WORK_WITH_TARIFF_ACTIVATION, 0) = 1
                      AND LAST_ACTIVE is not null
                      AND to_date(to_char(LAST_ACTIVE, 'DD.MM.YYYY HH24:MI:SS'), 'DD.MM.YYYY HH24:MI:SS') >= ((sysdate+1/24) - (40/24/60/60))
                      AND USER_NAME_ID = (
                                                           SELECT MAX(us.USER_NAME_ID)
                                                             FROM USER_NAMES us
                                                           WHERE NVL(us.WORK_WITH_TARIFF_ACTIVATION, 0) = 1
                                                               AND us.LAST_ACTIVE is not null
                                                               AND to_date(to_char(us.LAST_ACTIVE, 'DD.MM.YYYY HH24:MI:SS'), 'DD.MM.YYYY HH24:MI:SS') >= ((sysdate+1/24) - (40/24/60/60))
                                                       );
                EXCEPTION
                  WHEN OTHERS THEN
                    pError_Code := 5; --Ошибка определения ответственного по заявке (таблица ошибок REQ_CRM_TARIFF_ERROR_TYPE)  
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
             vPHONE, --номер на активацию
             1, --статус - новый 
             sysdate, 
             pUser_Create, 
             pRESPONSIBLE_USER, 
             162, --заявка на активацию
             NULL, 
             trunc(sysdate + 1), 
             pOPERATOR, 
             to_clob(pTxt)
          ) ;
           
          --обновляем пользователя в таблице параметров
          vRes := MS_PARAMS.SET_PARAM_VALUE('USER_LAST_CRM_REQUEST_ACT_TARIFFS', pRESPONSIBLE_USER);
          --фиксируем  
          COMMIT;
        EXCEPTION 
          WHEN OTHERS THEN
            pError_Code := 4; --Ошибка постановки заявки (таблица ошибок REQ_CRM_TARIFF_ERROR_TYPE)   
        END;
      ELSE
        pError_Code := 3; --Некорректно определен тариф для активации (таблица ошибок REQ_CRM_TARIFF_ERROR_TYPE)
      END IF;
    ELSE
      pError_Code := 2; --Некорректно задан параметр для тарифа (таблица ошибок REQ_CRM_TARIFF_ERROR_TYPE)
    END IF;
  ELSE
    pError_Code := 1; --некорректно задан номер телефона (таблица ошибок REQ_CRM_TARIFF_ERROR_TYPE)
  END IF; 
  
  --выводим ответ (таблица ошибок REQ_CRM_TARIFF_ERROR_TYPE)
  --для программистов октел приянты следующие коды ошибок
  --0 - Ваша заявка принята.
  --1 - Некорректно задан номер телефона.
  --2 - Некорректно задан параметр для тарифа.
  --3 - Некорректно определен тариф для активации
  --4 - Ошибка постановки заявки.
  --5 - Ошибка определения ответственного по заявке
  
  HTP.PRINT(to_char(pError_Code));         
END;