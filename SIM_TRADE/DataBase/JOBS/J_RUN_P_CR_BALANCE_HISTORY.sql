begin
  sys.dbms_scheduler.create_job(job_name            => 'J_RUN_P_CR_BALANCE_HISTORY',
                                job_type            => 'PLSQL_BLOCK',
                                job_action          => 'begin
															STOP_JOB_PCKG.CHECK_WORK_JOB;
															--ïåğåñ÷¸ò áàëàíñà
															p_cr_balance_hist;
														end;',
                                start_date          => to_date('22-02-2013 02:00:00', 'dd-mm-yyyy hh24:mi:ss'),
                                repeat_interval     => 'Freq=Daily;Interval=1',
                                end_date            => to_date(null),
                                enabled             => true,
                                auto_drop           => false,
                                comments            => '');
end;
/
