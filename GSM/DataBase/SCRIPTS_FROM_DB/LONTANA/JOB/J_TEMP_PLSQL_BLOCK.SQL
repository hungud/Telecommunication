
  
BEGIN 
dbms_scheduler.create_job('"J_TEMP_PLSQL_BLOCK"',
job_type=>'PLSQL_BLOCK', job_action=>
'declare
 res varchar2(100);
begin
--  STOP_JOB_PCKG.CHECK_WORK_JOB;
  /*
  for rec in (select * from temp17)
  loop
    DELETE FROM call_11_2014 td
      WHERE
       --td.CALL_COST <> 0 and
            td.dbf_id = 4339
        and td.subscr_no = rec.str1
        AND EXISTS (SELECT 1
                      FROM call_11_2014 td1
                      WHERE td.start_time = td1.start_time
                        AND td.subscr_no = td1.subscr_no
                        AND td.call_cost = td1.call_cost
                        AND td1.dbf_id <>4339);
    delete from temp17
      where temp17.str1 = rec.str1;
    commit;                        
  end loop;  
  */
  
-- res := pack7z(''B:\ora_back\loader_call_n\EXT_LOADER_CALL_N_LOG_2015_02_21.DMP'',
--                    ''B:\ora_back\loader_call_n\EXT_LOADER_CALL_N_LOG_2015_02_21.DMP.7z'');
 p_test_afr;        
 --SAVE_BILL_FINANCE_FOR_CLIENTS(201506);
end;                 '
, number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('07-OCT-2014 12.19.12.000000000 PM +04:00','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), repeat_interval=> 
'FREQ=MONTHLY; INTERVAL=20'
, end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', enabled=>FALSE, auto_drop=>FALSE,comments=>
'Джоб для запуска фоновых заданий'
);
COMMIT; 
END; 
