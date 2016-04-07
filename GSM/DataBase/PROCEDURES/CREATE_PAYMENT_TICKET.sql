CREATE OR REPLACE PROCEDURE CREATE_PAYMENT_TICKET(
                                                pPhone_number_tarifer varchar2, 
                                                pPAYMENT_DATE         DATE,
                                                pPAYMENT_SUM          NUMBER,
                                                pPAYMENT_NUMBER       VARCHAR2
  ) IS

--
--#Version=3
--
--v.3 Матюнин 17.02.2016 - Добавил на всякий случай Exception внешний, ошибку пишем в лог с пришедщими параметрами.
--v.2 Афросин 12.02.2016 - Добавил номер телефона в текст сообщения
--v.1 Афросин 11.02.2016 - Процедура для зачисления платежа или создания заявки в CRM(http://redmine.tarifer.ru/issues/4276)
--                      - если в таблице соответствия (crm_beeline_conformity) нашли номер телефона слиента:
--                          из Тарифера, оператор билайна и у него есть действующий договор, то добавляем, на номер слиента платеж в received_payments
--                      -- если нашли номер и его нет в тарифере, то создаем заявку в crm на специально обученного опертора.
  
  PRAGMA AUTONOMOUS_TRANSACTION;
  
  cFilialID CONSTANT FILIALS.FILIAL_ID%TYPE := 16; --ИДЕНТИФИКАТОР ФИЛИАЛА ДЛЯ ПРИНЯТЫХ ПЛАТЕЖЕЙ
  cTicketTypeID CONSTANT CRM_REQUESTS.TYPE_REQUEST_ID%TYPE := 221; --ИДЕНТИФИКАТОР ДЛЯ ТИПА ЗАЯВКИ В CRM
  cTYPE_CRM_BEELINE_ID CONSTANT TYPES_CRM_BEELINE.ID%TYPE := 2; -- ДЕНТИФИКАТОР РУЧНОГО ПЛАТЕЖА
   
  CURSOR c IS
    SELECT
      pPAYMENT_DATE payment_date,
      pPAYMENT_SUM payment_sum,
      pPAYMENT_NUMBER payment_number,
      
      
      (select
        contract_id
       from
        v_contracts c
       where
        C.PHONE_NUMBER_FEDERAL = c.phone_number_client
        and C.CONTRACT_CANCEL_DATE is null
      ) Contract_id,
         
      2 AS payment_type,--платежи загруженные с сайта билайна
      c.phone_number_tarifer,
      c.phone_number_client,
      c.operator_client,
      c.TYPE_CRM_BEELINE_ID,
      (select OPERATOR_FOR_CHAT  from OPERATORS where upper(OPERATOR_NAME) = upper(c.operator_client) ) operator_client_en
    FROM
      crm_beeline_conformity c
    WHERE
      pPhone_number_tarifer = c.phone_number_tarifer
      AND NOT EXISTS (SELECT 1 FROM CRM_BEELINE_PAYMENT_LOG_TICKET j 
                      WHERE j.phone_number_tarifer = c.phone_number_tarifer
                        AND j.payment_date = pPAYMENT_DATE
                        AND j.payment_sum = pPAYMENT_SUM
                        AND NVL(j.payment_number,'0') = NVL(pPAYMENT_NUMBER,'0')
                      );

  vErrorText CRM_BEELINE_PAYMENT_LOG_TICKET.ERROR_TEXT%TYPE;
BEGIN
  BEGIN
    for v in c loop
      
      vErrorText := '';
      
      begin
        if v.TYPE_CRM_BEELINE_ID = cTYPE_CRM_BEELINE_ID then
          --создаем корректирующий платеж
          INSERT INTO received_payments(phone_number, payment_date_time, payment_sum, contract_id, filial_id, remark)
          VALUES (v.phone_number_client, v.payment_date, v.payment_sum, NVL(v.contract_id, 0), cFilialID, 'Корректировка для номера по оборудованию.');
          
        else
          --создаем CRM-заявку
          INSERT INTO crm_requests(phone_number, responsible_user, type_request_id, text_request, id_status_request, date_created, operator)
          VALUES (v.phone_number_client, ms_constants.GET_CONSTANT_VALUE('CRM_BEELINE_RESPONSIBLE_USER'), cTicketTypeID, 'Срочно пополнить номер '||v.phone_number_client||'. Сумма платежа в тарифере на номер '||v.phone_number_tarifer||': '||v.payment_sum||' руб.', 1, SYSDATE, v.operator_client_en);
          
        end if;
      exception
        when OTHERS then
          vErrorText := 'Ошибка! '||SQLERRM;  
      end;
      
      --заносим информацию в журнал      
      INSERT INTO CRM_BEELINE_PAYMENT_LOG_TICKET (phone_number_tarifer, phone_number_client, operator_client, payment_date, payment_sum, payment_type, payment_number, type_crm_beeline, ERROR_TEXT)
        VALUES (v.phone_number_tarifer, v.phone_number_client, v.operator_client, v.payment_date, v.payment_sum, v.payment_type, v.payment_number, v.TYPE_CRM_BEELINE_ID, vErrorText);
    end loop;

    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      vErrorText := 'Ошибка! '||SQLERRM;
      INSERT INTO CRM_BEELINE_PAYMENT_LOG_TICKET (phone_number_tarifer, phone_number_client, operator_client, payment_date, payment_sum, payment_type, payment_number, type_crm_beeline, ERROR_TEXT)
        VALUES (pPhone_number_tarifer, pPhone_number_tarifer, null, pPAYMENT_DATE, pPAYMENT_SUM, null, pPAYMENT_NUMBER, null, vErrorText);
    COMMIT;
  END;
END;
/
