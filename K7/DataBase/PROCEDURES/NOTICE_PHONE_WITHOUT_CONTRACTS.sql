CREATE OR REPLACE PROCEDURE  NOTICE_PHONE_WITHOUT_CONTRACTS  IS
  -- Version= 8
  -- v 8. 07.07.2015 - Афросин вернул FETCH  v_phones  INTO  v_phone;
  -- v 7. 03.07.2015 - Афросин поправил цикл OPEN  v_phones  FOR  перенес закрытие курсора после проверки на %notfound
  -- v 6. 07.11.2014 - Бакунов Константин
  v_setting  BLOCK_NO_CONTRACTS_SETTINGS%ROWTYPE;
  v_phone  NOTICE_PHONE_NO_CONTRACT%ROWTYPE;

  v_settings  SYS_REFCURSOR;
  v_phones  SYS_REFCURSOR;

  v_access_denied_list  CLOB;
  v_isDaytime  INTEGER  DEFAULT  1;
  v_result_clob  CLOB;
  v_line  CLOB;
  v_sms_line  CLOB;
  v_counter  INTEGER := 0;
  v_tmp  VARCHAR2(20);

BEGIN
  OPEN  v_settings  FOR  'SELECT * FROM  BLOCK_NO_CONTRACTS_SETTINGS';
  FETCH  v_settings  INTO  v_setting;
  CLOSE  v_settings;

  v_access_denied_list := '';
  v_access_denied_list := GET_LIST_PHONE_NO_BL_FROM_SYTE;
  v_sms_line := '';
  v_counter := 0;

  IF   (v_setting.check_time = 0)  THEN
    v_result_clob := 'Номера телефонов' || CHR( 10 );

    IF sysdate BETWEEN  trunc( sysdate ) + 9 / 24 AND  trunc( sysdate ) + 21 / 24  THEN
      v_isDaytime := 1;
    ELSE
      v_isDaytime := 0;
    END IF;


    FOR  v_rec IN  (
                    SELECT 
                      V_ACTIVE_NUMBERS_OUT_CONTRACTS.PHONE_NUMBER,
                      ACCOUNTS.ACCOUNT_NUMBER

                    FROM
                      V_ACTIVE_NUMBERS_OUT_CONTRACTS,
                      ACCOUNTS
                    WHERE
                      V_ACTIVE_NUMBERS_OUT_CONTRACTS.ACCOUNT_ID = ACCOUNTS.ACCOUNT_ID(+)
                      AND  NVL( ACCOUNTS.DO_AUTO_BLOCK, 0 ) = 1
                      AND  NOT EXISTS
                                    (
                                      SELECT 1
                                      FROM
                                        AUTO_BLOCKED_PHONE_NO_CONTRACT
                                      WHERE
                                        AUTO_BLOCKED_PHONE_NO_CONTRACT.PHONE_NUMBER = V_ACTIVE_NUMBERS_OUT_CONTRACTS.PHONE_NUMBER
                                        AND AUTO_BLOCKED_PHONE_NO_CONTRACT.BLOCK_DATE_TIME > SYSDATE - 7 / 24 / 60
                                   )
                    AND NOT EXISTS
                                  (
                                    SELECT 1
                                    FROM
                                      QUEUE_PHONE_REBLOCK
                                    WHERE
                                      QUEUE_PHONE_REBLOCK.PHONE_NUMBER = V_ACTIVE_NUMBERS_OUT_CONTRACTS.PHONE_NUMBER
                                  )
                    AND NOT EXISTS
                                (
                                  SELECT 1
                                  FROM
                                    PHONE_NUMBER_BLOCK_DENIED
                                  WHERE
                                    PHONE_NUMBER_BLOCK_DENIED.PHONE_NUMBER = V_ACTIVE_NUMBERS_OUT_CONTRACTS.PHONE_NUMBER
                                )
                   )
    LOOP
      IF   DBMS_LOB.INSTR( v_access_denied_list, v_rec.phone_number ) = 0  THEN
        OPEN  v_phones  FOR  'SELECT  *  FROM  NOTICE_PHONE_NO_CONTRACT
                              WHERE
                                NOTICE_PHONE_NO_CONTRACT.PHONE_NUMBER = :PHONE
                                AND  NOTICE_PHONE_NO_CONTRACT.DATE_NOTICE > SYSDATE - 15 / 24 / 60'  
                             USING  v_rec.phone_number;
        FETCH  v_phones  INTO  v_phone;
        

        IF v_phones%NOTFOUND  THEN

          v_counter := v_counter + 1;
          
          IF   v_isDaytime = 1  THEN
            v_line := '<br>' || CHR( 10 ) || v_rec.phone_number;
            DBMS_LOB.APPEND( v_result_clob, v_line );
          ELSE
            v_sms_line := v_sms_line || ' ' || v_rec.phone_number;
          END IF;

          INSERT INTO  NOTICE_PHONE_NO_CONTRACT  (PHONE_NUMBER, DATE_NOTICE)  VALUES  (v_rec.phone_number, sysdate);

          IF   v_isDaytime = 0  THEN
            IF   MOD( v_counter, 6 ) = 0  THEN
              v_tmp := loader3_pckg.send_sms( v_setting.phone_for_notice, 'AgSv', v_sms_line );
              v_sms_line := '';
            END IF;
          END IF;
        END IF;
        CLOSE  v_phones;
      END IF;
    END LOOP;

    IF   v_counter > 0  THEN
      IF   v_isDaytime = 1  THEN
        send_sys_mail_multi( 'Активные номера без контрактов', v_result_clob, 'MAIL_BLOCK_NO_CONTRACTS', 83 );
      ELSE
        IF   v_sms_line <> ''  THEN
          v_tmp := loader3_pckg.send_sms( v_setting.phone_for_notice, 'AgSv', v_sms_line );
        END IF;
      END IF;
    END IF;
  END IF;
        
  commit;
END;
/

GRANT EXECUTE ON NOTICE_PHONE_WITHOUT_CONTRACTS TO CORP_MOBILE_ROLE;
