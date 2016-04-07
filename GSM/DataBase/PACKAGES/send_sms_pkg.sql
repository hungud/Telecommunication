create or replace package send_sms_pkg is

  ---------------------------------------------------------------------------------------------
  
  function is_worket_out(v_sma_id in sms_attempts.sms_id%type) return pls_integer;
  function is_ready_to_be_sent(v_sma_id in sms_attempts.sms_id%type) return varchar2;
  procedure sms_to_archive(v_sma_id in sms_archive.id%type);
  
  ---------------------------------------------------------------------------------------------

end send_sms_pkg;


create or replace package body send_sms_pkg is

  ---------------------------------------------------------------------------------------------

  function is_worket_out(v_sma_id in sms_attempts.sms_id%type) return pls_integer
  as

    l_i_attempts_count pls_integer := 0;
    l_i_temp pls_integer := 0;
    l_d_temp date := null;

  begin

    with attempts as (
      select 1 result from sms_attempts where sms_id = v_sma_id group by attempt_id
    )
    select count(*) into l_i_attempts_count from attempts; 

    if (l_i_attempts_count = 0) then
      return 0;
    elsif (l_i_attempts_count >= 3) then
      return 1;
    end if;  
  
    with attempts as (
      select sum(result) result from sms_attempts where sms_id = v_sma_id group by attempt_id
    )
    select count(*) into l_i_temp from attempts where result = 0; 

    if (l_i_temp > 0) then
      return 1;
    end if;  

    select max(start_date) into l_d_temp from sms_attempts where sms_id = v_sma_id;

    if (sysdate - l_d_temp > 1) then
      return 1;
    end if;  

    return 0;
  end;

  ---------------------------------------------------------------------------------------------

  function is_ready_to_be_sent(v_sma_id in sms_attempts.sms_id%type) return varchar2
  as

    l_i_temp pls_integer := 0;
    l_last_sstart_date date := null;
  
  begin
    select max(start_date) into l_last_sstart_date from sms_attempts where sms_id = v_sma_id;

    if (l_last_sstart_date is null) then
      return 1;
    end if;  

    if (sysdate - l_last_sstart_date < (3 / 24)) then
      return 0;
    end if;  

    with attempts as (
      select sum(result) result from sms_attempts where sms_id = v_sma_id group by attempt_id
    )
    select count(*) into l_i_temp from attempts where result = 0; 

    if (l_i_temp = 0) then
      return 1;
    end if;  

    return 0;
  end;
    
  ---------------------------------------------------------------------------------------------

  procedure sms_to_archive(v_sma_id in sms_archive.id%type)
  as
  begin
    insert into sms_archive (id, phone, message) select id, phone, message from sms_current where id = v_sma_id;
				
				INSERT INTO SMS_LOG
						(SMS_ID, PHONE, MESSAGE, REQ_COUNT, DATE_START, STATUS_CODE)

		WITH ATTEMPTS_C AS
			(SELECT SMS_ID, ATTEMPT_ID
						FROM SMS_ATTEMPTS
					WHERE SMS_ID = v_sma_id
					GROUP BY SMS_ID, ATTEMPT_ID)
		
		SELECT ID,
									PHONE,
									MESSAGE,
									(SELECT COUNT(*) FROM ATTEMPTS_C WHERE SMS_ID = ID) ATTEMPTS_COUNT,
									(SELECT MIN(SUBMIT_DATE) FROM SMS_ATTEMPTS WHERE SMS_ID = ID) ATTEMPT_DATE,
									(SELECT MIN(RESULT) FROM SMS_ATTEMPTS WHERE SMS_ID = ID) RESULT
				FROM SMS_ARCHIVE
			WHERE ID = v_sma_id;
		
    delete from sms_current where id = v_sma_id;
  end;

  ---------------------------------------------------------------------------------------------
    
end send_sms_pkg;

create index sms_attempts_SMS_ID_IDX on sms_attempts(SMS_ID);