--create or replace directory HOT_BILL_LOG_DIR as 'D:\Tarifer\SiteRobotService\HotBilling\Logs';
--create or replace directory HOT_BILL_LOG_DIR as 'D:\Tarifer\Svc\HotBilling\Logs';--��� GSM;
 
--grant read on directory HOT_BILL_LOG_DIR to CORP_MOBILE_ROLE;
--grant read on directory HOT_BILL_LOG_DIR to CORP_MOBILE_ROLE_RO;

CREATE OR REPLACE FUNCTION read_log RETURN NUMBER IS
  f BFILE; 
  buffer BLOB;
  file_name VARCHAR2(100);
  pattern raw(200);
  v_amount binary_integer := 32767;
  v_pos integer := 1;  
BEGIN
  file_name:=REPLACE(MS_PARAMS.GET_PARAM_VALUE('HOT_BILL_LOG_FILE'),'%date%',TO_CHAR(SYSDATE,'YYYY-MM-DD'));
  IF file_name IS NULL THEN
   RETURN 0;
  END IF;
  f := bfilename('HOT_BILL_LOG_DIR', file_name);  
  IF dbms_lob.fileexists(f)<>1 THEN 
    RETURN -1;
  END IF;
  dbms_lob.fileopen(f);  
  WHILE v_pos < dbms_lob.getlength (f) LOOP
    dbms_lob.read (f, v_amount, v_pos, buffer);
    v_pos := v_pos + v_amount;
 
    pattern:=utl_raw.cast_to_raw(ms_params.GET_PARAM_VALUE('HOT_BILL_ERR'));    
    IF dbms_lob.instr(buffer,pattern) > 0 THEN
      dbms_lob.fileclose(f);    
      RETURN 1;
    END IF;
  END LOOP;
  dbms_lob.fileclose(f);
  RETURN 0;
EXCEPTION
  WHEN OTHERS THEN
    begin
     dbms_lob.fileclose(f);
    EXCEPTION
     WHEN OTHERS THEN NULL;
    END;
    RETURN -2;  
END;

--GRANT EXECUTE ON read_log TO CORP_MOBILE_ROLE;
--GRANT EXECUTE ON read_log TO CORP_MOBILE_ROLE_RO;  
--GRANT EXECUTE ON read_log TO LONTANA;
--GRANT EXECUTE ON read_log TO LONTANA_RO;  
--INSERT INTO params (param_id,name,value,type,descr) 
--  VALUES (s_new_param_id.nextval, 'LOAD_LOGS_TIME_ERR', '2', 'B', '����� ��� ����������� ��������������, ��� ��������� ���������(�)');  
--INSERT INTO params (param_id,name,value,type,descr) 
--   VALUES (s_new_param_id.nextval, 'HOT_BILL_ERR', 'CScript', 'B', '������ ������������ ������ ���. ��������');
--corp_mobile
--��� �7
--INSERT INTO params (param_id,name,value,type,descr) 
--  VALUES (s_new_param_id.nextval, 'HOT_BILL_LOG_FILE', '%date%-success-Tarifer Hot Billing NikolayK7.log', 'N', '��� log-����� ���.��������');
--��� GSM
--INSERT INTO params (param_id,name,value,type,descr) 
--  VALUES (s_new_param_id.nextval, 'HOT_BILL_LOG_FILE', '%date%-success-Tarifer Hot Billing gsmcorp.log', 'N', '��� log-����� ���.��������');

--gsmcorp
--INSERT INTO params (param_id,name,value,type,descr) 
--  VALUES (s_new_param_id.nextval, 'HOT_BILL_LOG_FILE', '%date%-success-Tarifer Hot Billing gsmcorp.log','N','��� log-����� ���.��������');