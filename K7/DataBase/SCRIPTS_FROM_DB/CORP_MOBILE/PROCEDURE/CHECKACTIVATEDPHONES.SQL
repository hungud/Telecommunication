
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."CHECKACTIVATEDPHONES" ( p_check_single_phone  IN  INTEGER  DEFAULT  1 )  IS
--
--Version=2
--
--v2.27.10.2014 Афросин - Добавил параметр DATE_CREATED
--
--
-- v1 - 23.10.2014 - Бакунов Константин
--
-- PROCEDURE  CheckActivatedPhones( p_check_single_phone )
--     параметр (IN) : p_check_single_phone = 1 - проверять один номер
--                                            0 - проверять все номера из выборки
    CURSOR  curs_non_activated_phones  IS
        SELECT  contract_id, phone_number_federal, DATE_CREATED
            FROM  contracts
            WHERE  first_activated = 0
             and
             exists(select phone_number 
                        from DB_LOADER_ACCOUNT_PHONES
                        where phone_number = phone_number_federal
                        and account_id in (select account_id from accounts where is_collector =1)
                        )
            ;

    v_phone_number_federal  contracts.phone_number_federal%TYPE;
    v_contract_id  contracts.contract_id%TYPE;
    v_contracte_date contracts.CONTRACT_DATE%TYPE;
    v_activation_date  DATE  DEFAULT  NULL;

BEGIN
    BEGIN
        OPEN  curs_non_activated_phones;

        IF   p_check_single_phone = 1  THEN
            FETCH  curs_non_activated_phones  INTO  v_contract_id, v_phone_number_federal, v_contracte_date;
            v_activation_date := GetActivationDate( v_phone_number_federal, v_contracte_date );
            IF   v_activation_date  IS NOT NULL  THEN
                TELETIE_CONNECT_PCKG.CONNECT_AND_SAVE_LOG('', '', 1, v_phone_number_federal);
            
                UPDATE  contracts  SET  first_activated_date = v_activation_date,
                                        first_activated = 1
                    WHERE  contract_id = v_contract_id;
                COMMIT;
                
                --LOADER3_PCKG.SEND_SMS( v_phone_number_federal, 'text text text' );
            END IF;
        ELSE
            LOOP
                EXIT WHEN  curs_non_activated_phones%NOTFOUND;
                FETCH  curs_non_activated_phones  INTO  v_contract_id, v_phone_number_federal, v_contracte_date;
                v_activation_date := GetActivationDate( v_phone_number_federal, v_contracte_date );
                IF   v_activation_date  IS NOT NULL  THEN
                    TELETIE_CONNECT_PCKG.CONNECT_AND_SAVE_LOG('', '', 1, v_phone_number_federal);
                    UPDATE  contracts  SET  first_activated_date = v_activation_date,
                                            first_activated = 1
                         WHERE  contract_id = v_contract_id;
                    COMMIT;
                    
                     --LOADER3_PCKG.SEND_SMS( v_phone_number_federal, 'text text text' );
                END IF;
            END LOOP;
        END IF;

        CLOSE  curs_non_activated_phones;

    EXCEPTION
        WHEN others THEN
            RAISE_APPLICATION_ERROR( -20001, 'CheckActivatedPhones: ' || SQLERRM );
    END;

    RETURN;
END;