--connect corp_mobile/hivxHD2gpHJX@K7;
connect corp_mobile/hivxHD2gpHJX@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=K7)));
truncate table temp_loader_call_n_log;
insert into temp_loader_call_n_log (select * from loader_call_n_log t where t.load_date>sysdate-1/24);
commit;
exit;