CREATE OR REPLACE PROCEDURE REBUILD_INDEX_TABLE_CALL (pCURMONTH INTEGER default 1) IS
    
    --
    --#Version=1
    -- #2890 Kochnev E 25.05.2015 (Алексеев - внес правки)
    --перестройка индексов для таблиц CALL_MM_YYYY,где MM - месяц, YYYY- год.
    --Ребилдить индексы на таблицах CALL за текущий и предыдущий месяца.
    --
    
    USED_SCHEMA_NAME VARCHAR2(100); --имя схемы
    pNameCall VARCHAR2(100);                 --имя таблицы
    vRes VARCHAR2(50);
BEGIN
    --определяем схему
    SELECT sys_context('userenv', 'CURRENT_SCHEMA') 
       INTO USED_SCHEMA_NAME 
      FROM dual;
      
    --определяем имя таблицы
    --1 - текущий месяц, иначе - предыдущий месяц
    pNameCall := '';
    IF pCURMONTH = 1 THEN
        pNameCall := 'CALL_'||to_char(sysdate,'MM')||'_'||to_char(sysdate,'YYYY');
    ELSE
        pNameCall := 'CALL_'||to_char(add_months(sysdate,-1),'MM')||'_'||to_char(add_months(sysdate,-1),'YYYY');
    END IF;
    
    --первоначальная остановка job на 6 минут (последующие по 5 минут на каждом индексе) 
    STOP_JOB_PCKG.STOP_JOB(6);
    --заснем на 5 секунды, пусть job точно остановяться
    DBMS_LOCK.SLEEP(5);
    --отбираем индексы и rebuild их
    for cur in ( 
                        SELECT i.index_name
                          FROM SYS.ALL_INDEXES i 
                          where i.owner = Upper(USED_SCHEMA_NAME) 
                              and i.table_name like pNameCall
                  ) 
    loop
        --rebuild index
        EXECUTE IMMEDIATE 'ALTER INDEX ' ||cur.index_name|| ' REBUILD';
        --проверяем время, если время меньше 5 минут, то останавливаем на 5 минут
        IF to_date(NVL(ms_constants.GET_CONSTANT_VALUE('START_TIME_JOB_AFTER_STOP'), to_char(sysdate-1, 'DD.MM.YYYY HH24:MI:SS')), 'DD.MM.YYYY HH24:MI:SS') < sysdate+5/24/60 THEN
            STOP_JOB_PCKG.STOP_JOB(5); 
        END IF;
    end loop;
    
    --после всех ребилдов индексов, проверяем дату запуска job
    --если дата запуска job больше текущей даты, то обновляем ее на текущую
    IF to_date(NVL(ms_constants.GET_CONSTANT_VALUE('START_TIME_JOB_AFTER_STOP'), to_char(sysdate-1, 'DD.MM.YYYY HH24:MI:SS')), 'DD.MM.YYYY HH24:MI:SS') > sysdate THEN
        --обновляем значение времени в таблице констант
        vRes := ms_constants.SET_CONSTANT_VALUE('START_TIME_JOB_AFTER_STOP', to_char(sysdate, 'DD.MM.YYYY HH24:MI:SS'));
        commit;
    END IF;
END;
