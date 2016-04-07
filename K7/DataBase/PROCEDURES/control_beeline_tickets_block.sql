CREATE OR REPLACE PROCEDURE control_beeline_tickets_block IS
--
--#Version=2
--
--v.2 Афросин 06.10.2015 - отбираем заявки только со статусом S1B
--v.1 Афросин 06.10.2015 - процедура для отслеживания заявок на блокировку с доп. статусом, инициированная программой.
--                        согласно задаче (http://redmine.tarifer.ru/issues/3318)  
--
  CURSOR c IS
    SELECT
      t.ticket_id,
      t.phone_number,
      p.phone_is_active,
      T.COMMENTS 
    FROM
      beeline_tickets t,
      db_loader_account_phones p,
      v_contracts c,
      beeline_status_code st,
      contract_dop_statuses ds
    WHERE
      t.phone_number = p.phone_number 
      AND p.year_month = (
                            SELECT
                              MAX(year_month)
                            FROM
                              db_loader_account_phones
                            WHERE
                              phone_number = p.phone_number
                         )
      AND t.phone_number = c.PHONE_NUMBER_FEDERAL
      AND p.status_id = st.status_id
      AND c.DOP_STATUS = ds.dop_status_id
      --   and p.phone_is_active = 1
      AND p.conservation <> 1
      AND c.CONTRACT_CANCEL_DATE IS NULL
      AND c.DOP_STATUS IS NOT NULL 
      AND p.system_block <> 1
      AND st.is_system_block <> 1
      AND nvl(ds.do_block_phone, 0) <> 0
      AND
        (
          (
            (st.IS_ACTIVE <> 1)
            AND
            (st.ACCESS_UNLOCK = 1)
          )
        OR
         (
          (st.IS_ACTIVE = 1)
          AND
          (st.ACCESS_BLOCK = 1)
         )
       )
      AND t.answer = 0
      AND t.ticket_type = 9
      and upper(T.COMMENTS) like '%: S1B%'
      AND t.date_create = (
                            SELECT
                              MAX(date_create)
                            FROM
                              beeline_tickets
                            WHERE
                              phone_number = t.phone_number
                          )
      AND NOT EXISTS (
                        SELECT 1
                        FROM
                          control_beeline_tickets_log
                        WHERE
                          ticket_id_error = t.ticket_id
                          AND control_type = 3
                      )
      AND NOT EXISTS (
                        SELECT 1
                        FROM
                          QUEUE_PHONE_REBLOCK
                        WHERE
                          phone_number = t.phone_number
                      );
  vSTR VARCHAR2(1000 CHAR);
  answer INTEGER;
  vMailText VARCHAR2 (3000);
BEGIN
  vMailText := '';
  FOR v IN c LOOP
  BEGIN
    SELECT NVL(answer, 1) + NVL(answer1, 1) + NVL(answer2, 1)
    INTO answer
    FROM (SELECT phone_number,
                 date_create,
                 answer, 
                 LAG(answer,1) OVER (PARTITION BY phone_number ORDER BY date_create) answer1,
                 LAG(answer,2) OVER (PARTITION BY phone_number ORDER BY date_create) answer2
          FROM beeline_tickets
          WHERE phone_number = v.phone_number AND ticket_type = 9) a
    WHERE
      a.date_create = (
                        select max(date_create)
                        from
                          beeline_tickets
                        where
                          phone_number = v.phone_number
                      );
    IF answer = 0 THEN
      --три подряд заявки на блокировку с ошибками (отправляем e-mail)
      vMailText := vMailText || '<tr><td>'||v.phone_number||'</td></tr>';
      INSERT INTO
        control_beeline_tickets_log (phone_number, control_type, ticket_id_error, date_created)
        VALUES (v.phone_number, 3, v.ticket_id, SYSDATE);      
      COMMIT;
    ELSE
      IF v.phone_is_active <> 1 THEN
        --переблокировка
        INSERT INTO
          queue_phone_reblock(phone_number)
          VALUES(v.phone_number);
        
        INSERT INTO
          control_beeline_tickets_log (phone_number, control_type, ticket_id_error, date_created)
          VALUES (v.phone_number, 2, v.ticket_id, SYSDATE);
        COMMIT;
      ELSE
        --блокировка на сохранение
        vSTR := beeline_api_pckg.LOCK_PHONE(v.phone_number, 1, ms_params.GET_PARAM_VALUE('BEELINE_BLOCK_CODE_FOR_BLOCK_SAVE'));
        
        INSERT INTO
          control_beeline_tickets_log (phone_number, control_type, ticket_id_error, date_created, result_str)
          VALUES(v.phone_number, 1, v.ticket_id, SYSDATE, vSTR);        
        
        COMMIT;
      END IF;  
    END IF;        
  EXCEPTION
    WHEN OTHERS THEN
      vSTR := SUBSTR(SQLERRM, 1, 1000);
      INSERT INTO
        control_beeline_tickets_log (phone_number, control_type, ticket_id_error, date_created, result_str)
        VALUES(v.phone_number, 0, v.ticket_id, SYSDATE, vSTR);              
      COMMIT;
  END;  
  END LOOP;
  
  IF LENGTH (TRIM (vMailText)) > 0 THEN
    vMailText :=
            '<table  border="1" cellspacing="0" cellpadding="8">'
         || vMailText
         || '</table>';
      vMailText :=
         'Заблокировать по сохранению:<br><br>' || vMailText;
    send_sys_mail ('Заблокировать по сохранению', vMailText, 'MAIL_BLOCK_ON_SAVE');
  end if;
  
END;
