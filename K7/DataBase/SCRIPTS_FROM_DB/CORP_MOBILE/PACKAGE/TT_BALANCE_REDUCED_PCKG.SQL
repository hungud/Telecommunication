
  CREATE OR REPLACE PACKAGE "CORP_MOBILE"."TT_BALANCE_REDUCED_PCKG" IS
--#Version=1
--
-- Отправка уведомление в Телетай при снижении баланса
--
-- Добавить номер телефона в очередь отправки
PROCEDURE ADD_PHONE_NUMBER(
  pPHONE_NUMBER VARCHAR2, 
  pBALANCE NUMBER
  );
-- Отправить все номера списком на HTTP
PROCEDURE SEND_NOTICES;
--
END; 
CREATE OR REPLACE PACKAGE BODY "CORP_MOBILE"."TT_BALANCE_REDUCED_PCKG" IS
--
/* JOB для запуска
    DBMS_SCHEDULER.CREATE_JOB(
      job_name   => 'J_TT_BALANCE_REDUCED_NOTICE',
      job_type   => 'PLSQL_BLOCK',
      job_action => 'BEGIN TT_BALANCE_REDUCED_PCKG.SEND_NOTICES; END;',
      start_date => SYSDATE+1/24/60,
      repeat_interval => 'FREQ = MINUTELY; INTERVAL = 1',
      enabled    => TRUE
      );
*/
--
-- Минимальный баланс, начиная с которого отправляем уведомления.
cMIN_BALANCE_LIMIT CONSTANT NUMBER := 1000;
--
-- Добавить номер телефона в очередь отправки
PROCEDURE ADD_PHONE_NUMBER(
  pPHONE_NUMBER VARCHAR2, 
  pBALANCE NUMBER
  ) IS
   enqueue_options     DBMS_AQ.enqueue_options_t;
   message_properties  DBMS_AQ.message_properties_t;
   message_handle      RAW(16);
   message             T_PHONE;
BEGIN
  IF pBALANCE <= cMIN_BALANCE_LIMIT THEN
    message := T_PHONE(pPHONE_NUMBER);
    DBMS_AQ.ENQUEUE(
      queue_name              => 'CORP_MOBILE.Q_TT_BALANCE_REDUCED',
      enqueue_options         => enqueue_options,
      message_properties      => message_properties,
      payload                 => message,
      msgid                   => message_handle);
  END IF;
END;
-- Отправить все номера списком на HTTP
PROCEDURE SEND_NOTICES IS
  dequeue_options     DBMS_AQ.dequeue_options_t;
  message_properties  DBMS_AQ.message_properties_t;
  message_handle      RAW(16);
  message             T_PHONE;
  no_messages           exception;
  PRAGMA EXCEPTION_INIT (no_messages, -25228);
  CNT INTEGER;
  TYPE T_BALANCES IS TABLE OF NUMBER INDEX BY VARCHAR2(11);
  vBALANCES T_BALANCES;
  vBALANCE number;
  vPHONE_NUMBER varchar2(11);
  --
  req utl_http.req;
  resp utl_http.resp;
  TYPE T_HTTP_BODY IS TABLE OF VARCHAR2(2000) INDEX BY BINARY_INTEGER;
  vHTTP_BODY T_HTTP_BODY;
  vHTTP_BODY_LENGTH NUMBER;
  http_data varchar2(1000);
  vURL VARCHAR2(1000);
  vHTTP_BODY_PART VARCHAR2(1000);
  --
BEGIN
  dequeue_options.navigation := DBMS_AQ.FIRST_MESSAGE;
  dequeue_options.wait := 5; -- Время ожидания
  -- Выбираем все сообщения
  LOOP
    DBMS_AQ.DEQUEUE(
      queue_name          =>     'CORP_MOBILE.Q_TT_BALANCE_REDUCED',
      dequeue_options     =>     dequeue_options,
      message_properties  =>     message_properties,
      payload             =>     message,
      msgid               =>     message_handle);
    -- Исключаем повторы
    IF NOT vBALANCES.EXISTS(message.PHONE_NUMBER) THEN
      -- Абонент принадлежит Телетай?
      SELECT COUNT(*)
        INTO CNT
        FROM DB_LOADER_ACCOUNT_PHONES, ACCOUNTS
        WHERE DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID=ACCOUNTS.ACCOUNT_ID
          AND DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER=message.PHONE_NUMBER
          AND ACCOUNTS.IS_COLLECTOR=1
          AND ROWNUM <= 1;
      IF CNT > 0 THEN
        -- Баланс ниже пороговой величины
        vBALANCE := GET_ABONENT_BALANCE(message.PHONE_NUMBER);
        IF vBALANCE < cMIN_BALANCE_LIMIT THEN
          -- Запомним
          vBALANCES(message.PHONE_NUMBER) := vBALANCE;
          --DBMS_OUTPUT.PUT_LINE('T_PHONE: '|| message.PHONE_NUMBER||', BALANCE: '||GET_ABONENT_BALANCE(message.PHONE_NUMBER));
        END IF;
      END IF;
    END IF;
  END LOOP;
EXCEPTION WHEN no_messages THEN
  -- Сообщения в очереди закончились. Отправим одной пачкой
  http_data := 'Unknown error'; 
  BEGIN
    -- Формируем текст сообщения и определяем его длину
    vHTTP_BODY_LENGTH := 0;
    vPHONE_NUMBER := vBALANCES.FIRST;
    WHILE vPHONE_NUMBER IS NOT NULL LOOP
      --DBMS_OUTPUT.PUT_LINE('T_PHONE: '|| vPHONE_NUMBER||', BALANCE: '||vBALANCES(vPHONE_NUMBER));
      vHTTP_BODY_PART := vPHONE_NUMBER || '=' || to_char(vBALANCES(vPHONE_NUMBER),'99999999999999D00', 'NLS_NUMERIC_CHARACTERS = ''.,''');
      vHTTP_BODY_LENGTH := vHTTP_BODY_LENGTH + LENGTHB(vHTTP_BODY_PART)+2; -- Дополнительно перевод строки
      vHTTP_BODY(vHTTP_BODY.COUNT+1) := vHTTP_BODY_PART;
      -- Следующий элемент списка телефонов
      vPHONE_NUMBER := vBALANCES.NEXT(vPHONE_NUMBER);
    END LOOP;
    -- отправляем
    vURL := MS_CONSTANTS.GET_CONSTANT_VALUE('TT_BALANCE_REDUCED_NOTICE_URL');
    req := UTL_HTTP.BEGIN_REQUEST(vURL, 'POST');
    UTL_HTTP.SET_HEADER(req, 'Content-Type', 'application/x-www-form-urlencoded');
    UTL_HTTP.SET_HEADER(req, 'Content-Length', vHTTP_BODY_LENGTH);
    IF vHTTP_BODY.COUNT > 0 THEN
      FOR I IN vHTTP_BODY.FIRST..vHTTP_BODY.LAST LOOP
        --DEBUG_OUT(vHTTP_BODY(I));
        UTL_HTTP.WRITE_LINE(req, vHTTP_BODY(I));
      END LOOP;
    END IF;
    resp := UTL_HTTP.GET_RESPONSE(req);
    UTL_HTTP.READ_TEXT(resp, http_data, 1000);
    UTL_HTTP.END_RESPONSE(resp);
  EXCEPTION WHEN UTL_HTTP.END_OF_BODY THEN
    UTL_HTTP.END_RESPONSE(resp);
  END;
  --DEBUG_OUT(http_data);
  IF http_data <> 'OK' THEN
    RAISE_APPLICATION_ERROR(-20001, 'Error send to HTTP. '||http_data);
  END IF;
  COMMIT; -- Сохраним обновления очереди
END;
--
END; 