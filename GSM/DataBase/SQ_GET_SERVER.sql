-- Create sequence ѕо задаче по распределению нагрузки на сервера
create sequence SQ_GET_SERVER
minvalue 1
maxvalue 99999999
start with 1
increment by 1
cache 10
cycle;