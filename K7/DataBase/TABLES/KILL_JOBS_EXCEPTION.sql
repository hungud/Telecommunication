create table KILL_JOBS_EXCEPTION (
  JOB_NAME         varchar2(30), 
  JOB_RUNNING_TIME Integer
);

comment on table KILL_JOBS_EXCEPTION is 'Таблица с исключениями для процедуры KILL_HANGED_JOBS';
comment on column KILL_JOBS_EXCEPTION.JOB_NAME is 'Имя задания (JOBS)';

comment on column KILL_JOBS_EXCEPTION.JOB_RUNNING_TIME is 'Время работы джоба через которое необходимо убить.(время в минутах, если занчение null, то работа джоба не прерывается)';
