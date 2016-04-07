--connect corp_mobile/hivxHD2gpHJX@K7;
connect corp_mobile/hivxHD2gpHJX@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=K7)));
drop table EXT_BEELINE_SOAP_API_LOG cascade constraints;
drop table EXT_LOADER_CALL_N_LOG cascade constraints;

declare
ssql varchar2(1000);
begin
	ssql:='CREATE TABLE ext_loader_call_n_log
		ORGANIZATION EXTERNAL
		(
		TYPE ORACLE_DATAPUMP
		DEFAULT DIRECTORY e_care_backup
		LOCATION (''ext_loader_call_n_log'/*||to_char(sysdate,'dd.mm.yyyy')*/||'.dmp'')
		)
		AS SELECT * FROM loader_call_n_log';
	execute immediate ssql;	
	ssql:='	CREATE TABLE ext_beeline_soap_api_log
		ORGANIZATION EXTERNAL
		(
		TYPE ORACLE_DATAPUMP
		DEFAULT DIRECTORY soapapi_backup
		LOCATION (''ext_beeline_soap_api_log'/*||to_char(sysdate,'dd.mm.yyyy')*/||'.dmp'')
		)
		AS SELECT bsal_id, soap_request, t.soap_answer.getclobval() soap_answer, insert_date, phone, account_id, load_type FROM beeline_soap_api_log t';
	execute immediate ssql;	
end;
/
exit;
