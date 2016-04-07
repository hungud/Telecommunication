--#if not TableExists("LOG_SPR_WORK_SERVICE") then
--drop table LOG_SPR_WORK_SERVICE;  
create table LOG_SPR_WORK_SERVICE
(
  REPORT_TYPE        NUMBER,
  SERVER_TYPE    VARCHAR2(20),
  REPORT_TYPE_NAME   VARCHAR2(64),
  REPORT_TYPE_STR    VARCHAR2(512)
);  
--#end if

--#if GetTableComment("LOG_SPR_WORK_SERVICE")<>"Справочник по типам загрузки" then
-- Add comments to the table 
comment on table LOG_SPR_WORK_SERVICE
  is 'Справочник по типам загрузки';
--#end if

--#if GetColumnComment("LOG_SPR_WORK_SERVICE.REPORT_TYPE") <> "Тип загрузки" then
-- Add comments to the columns 
comment on column LOG_SPR_WORK_SERVICE.REPORT_TYPE
  is 'Тип загрузки';
--#end if

--#if GetColumnComment("LOG_SPR_WORK_SERVICE.SERVER_TYPE") <> "Тип сервиса" then
comment on column LOG_SPR_WORK_SERVICE.SERVER_TYPE
  is 'Тип сервиса';  
--#end if

--#if GetColumnComment("LOG_SPR_WORK_SERVICE.REPORT_TYPE_NAME") <> "Наименование типа загрузки" then
comment on column LOG_SPR_WORK_SERVICE.REPORT_TYPE_NAME
  is 'Наименование типа загрузки';
--#end if

--#if GetColumnComment("LOG_SPR_WORK_SERVICE.REPORT_TYPE_STR") <> "Строка загрузки" then
comment on column LOG_SPR_WORK_SERVICE.REPORT_TYPE_STR
  is 'Строка загрузки';
--#end if

--#if not ConstraintExists("FK_LOG_SPR_WORK_SERVICE") then
alter table LOG_SPR_WORK_SERVICE
  add constraint FK_LOG_SPR_WORK_SERVICE foreign key (REPORT_TYPE)
  references ACCOUNT_LOAD_TYPES (ACCOUNT_LOAD_TYPE_ID) on delete set null; 
--#end if

--#if not RecordExists("SELECT * FROM LOG_SPR_WORK_SERVICE WHERE LOG_SPR_ID=1") then
insert into LOG_SPR_WORK_SERVICE (log_spr_id, report_type, server_type,report_type_name, report_type_str)
values (1,3,'NEW_CAB','Phone_states','/phone_states?bill=lgn&pas=newpswd&num_rep=Snum_rep');
--#end if

--#if not RecordExists("SELECT * FROM LOG_SPR_WORK_SERVICE WHERE LOG_SPR_ID=2") then
insert into LOG_SPR_WORK_SERVICE (log_spr_id, report_type, server_type,report_type_name, report_type_str)
values (2,6,'NEW_CAB','Проверка отчета по текущим нач.','/order?bill=lgn&pas=newpswd&test');
--#end if

--#if not RecordExists("SELECT * FROM LOG_SPR_WORK_SERVICE WHERE LOG_SPR_ID=3") then
insert into LOG_SPR_WORK_SERVICE (log_spr_id, report_type, server_type,report_type_name, report_type_str)
values (3,null,'API','AUTH',null);
--#end if

--#if not RecordExists("SELECT * FROM LOG_SPR_WORK_SERVICE WHERE LOG_SPR_ID=4") then
insert into LOG_SPR_WORK_SERVICE (log_spr_id, report_type, server_type,report_type_name, report_type_str)
values (4,null,'OLD_CAB',null,'http://cabinet.beeline.ru/');
--#end if

--#if not ColumnExists("LOG_SPR_WORK_SERVICE.LOG_SPR_ID") then
ALTER TABLE LOG_SPR_WORK_SERVICE ADD LOG_SPR_ID NUMBER NOT NULL;
--#end if

--#if not ConstraintExists("PK_WLOG_SPR_ID") then
alter table LOG_SPR_WORK_SERVICE
  add constraint PK_WLOG_SPR_ID primary key (LOG_SPR_ID);
--#end if

--#if not ColumnExists("LOG_SPR_WORK_SERVICE.IS_COLLECTOR") then
ALTER TABLE LOG_SPR_WORK_SERVICE ADD IS_COLLECTOR NUMBER;
--#end if

--#if not RecordExists("SELECT * FROM LOG_SPR_WORK_SERVICE WHERE LOG_SPR_ID=5") then
insert into LOG_SPR_WORK_SERVICE (log_spr_id, report_type, server_type,report_type_name, report_type_str,IS_COLLECTOR)
values (5,3,'NEW_CAB','Phone_states','/phone_states?bill=lgn&pas=newpswd&num_rep=Snum_rep',93);
--#end if

--#if not RecordExists("SELECT * FROM LOG_SPR_WORK_SERVICE WHERE LOG_SPR_ID=6") then
insert into LOG_SPR_WORK_SERVICE (log_spr_id, report_type, server_type,report_type_name, report_type_str,IS_COLLECTOR)
values (6,6,'NEW_CAB','Проверка отчета по текущим нач.','/order?bill=lgn&pas=newpswd&test',93);
--#end if
