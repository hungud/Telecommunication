CREATE OR REPLACE PROCEDURE SET_PHONE_STATUS_TEST_RESULT (pCLIENT_TYPE INTEGER DEFAULT -1) as
--
--#Version=1
--
--v.1 Афросин 12.11.2015 - Процедура для тестирования получения статусов телефонов
--                        pCLIENT_TYPE -  тип клиента:
--                                                       -1 - все клиенты
--                                                       0 - К7
--                                                       1 - коллеткор
--
  cK7_TEST_NAME CONSTANT varchar2(20 CHAR) := 'K7_PHONE_STATUS_LOAD';
  cCOLLECTOR_TEST_NAME CONSTANT varchar2(27 CHAR) := 'COLLECTOR_PHONE_STATUS_LOAD';
  cACCOUNT_LOAD_TYPE_ID CONSTANT INTEGER := 3;
  
  vCLIENT_TYPE INTEGER;
  
  procedure UPDATE_RESULT (pCLIENT_TYPE1 integer) as
    PRAGMA AUTONOMOUS_TRANSACTION;
  begin
    merge into RESULT_FOR_HOST_MONITOR_TEST tt
    using (
            select case pCLIENT_TYPE1
                    when 0 then
                      cK7_TEST_NAME
                    when 1 then
                      cCOLLECTOR_TEST_NAME
                    end TEST_NAME_ENG,
                      
                    case sysdate-max(load_date_time)
                      WHEN 0 then
                        0.00000001
                      ELSE
                        sysdate-max(load_date_time)
                    end res
            from
              ACCOUNT_LOAD_LOGS WW
            WHERE
              WW.ACCOUNT_LOAD_TYPE_ID = cACCOUNT_LOAD_TYPE_ID
              AND  (WW.ERROR_TEXT  like '%Ok!%' or WW.ERROR_TEXT is null)
              AND (
                    (WW.ACCOUNT_ID in (93, 99) and pCLIENT_TYPE1 = 1)
                    OR
                    (WW.ACCOUNT_ID not in (93, 99) and pCLIENT_TYPE1 = 0)
                  )
              and load_date_time >= sysdate -1
          )t
    on (tt.TEST_NAME_ENG = t.TEST_NAME_ENG)        
    when matched then
      update
        set
        tt.TEST_RESULT = t.res
    when not matched then
      insert (tt.TEST_NAME_ENG, tt.TEST_RESULT)
      values (t.TEST_NAME_ENG, t.RES);
    commit;                
  end;
  
begin
  vCLIENT_TYPE := nvl(pCLIENT_TYPE, -1);
  
  if vCLIENT_TYPE = -1 then
  begin
    UPDATE_RESULT (0);
    UPDATE_RESULT (1);  
  end;
  elsif vCLIENT_TYPE = 0 then
    UPDATE_RESULT (0);
  elsif vCLIENT_TYPE = 1 then
    UPDATE_RESULT (1);
  end if;
    
end;
