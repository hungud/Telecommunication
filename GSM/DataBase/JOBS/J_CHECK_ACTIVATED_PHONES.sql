
-- v1 - 23.10.2014 - Бакунов Константин

BEGIN
    sys.dbms_scheduler.create_job(
        job_name            => 'J_CHECK_ACTIVATED_PHONES',
        job_type            => 'PLSQL_BLOCK',
        job_action          => '
BEGIN
    CheckActivatedPhones( p_check_single_phone => 0 );
END;
',
        start_date          => sysdate,
        repeat_interval     => 'FREQ=MINUTELY; INTERVAL=5',
        end_date            => to_date( null ),
        enabled             => false,
        auto_drop           => false,
        comments            => 'Проверяет активацию номера (первые действия: вызовы, USSD-запросы и т.п.) и в случае обнаружения событий отправляет SMS'
    );
END;
/
show errors
exit
