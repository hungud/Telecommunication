CREATE OR REPLACE FUNCTION GetActivationDate( v_phone  IN  VARCHAR2, v_contracte_date IN DATE )  RETURN  DATE   IS

--
--Version = 2 
--
-- v2 - 27.10.2014 - Добавил параметр v_contracte_date
-- v1 - 23.10.2014 - Бакунов Константин
--

    v_calls_table_name  VARCHAR2(200);
    v_ussd_log_date  DATE;
    v_call_log_date  DATE;

BEGIN
    BEGIN
        SELECT  min( log.insert_date )  INTO  v_ussd_log_date  FROM  ussd_log  log
            WHERE  log.msisdn = v_phone and log.insert_date >= v_contracte_date;

        v_calls_table_name := 'call_' || to_char( sysdate, 'MM' ) || '_' || to_char( sysdate, 'YYYY' );

        EXECUTE IMMEDIATE
            ' SELECT  min( log.insert_date )  FROM   ' || v_calls_table_name || '  log  ' ||
            '    WHERE  log.subscr_no = ''' || v_phone || ''' and log.insert_date >=''' ||v_contracte_date|| ''''    INTO  v_call_log_date;



        IF   (v_call_log_date  IS  NOT NULL)  AND
             (v_ussd_log_date  IS  NOT NULL)  THEN
            IF   v_call_log_date < v_ussd_log_date   THEN
                RETURN  v_call_log_date;
            ELSE
                RETURN  v_ussd_log_date;
            END IF;
        ELSE
            IF   (v_call_log_date  IS  NULL)  AND
                 (v_ussd_log_date  IS  NULL)  THEN
                RETURN  NULL;
            ELSE
                RETURN  nvl( v_call_log_date, v_ussd_log_date );
            END IF;
        END IF;

        RETURN  NULL;

    EXCEPTION
        WHEN others THEN
            RAISE_APPLICATION_ERROR( -20001, 'CheckActivatedPhones: ' || SQLERRM );
        RETURN  NULL;
    END;
END;
/