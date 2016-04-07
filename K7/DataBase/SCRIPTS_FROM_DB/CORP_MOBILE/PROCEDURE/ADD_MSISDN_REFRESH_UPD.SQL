
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."ADD_MSISDN_REFRESH_UPD" (pPHONE_NUMBER  IN VARCHAR2,
                                                   pLOADING_YEAR  in BINARY_INTEGER,
                                                   pLOADING_MONTH in BINARY_INTEGER,
                                                   pERROR         out varchar2) IS
  TYPE T_LOAD_SETTINGS IS RECORD(
    ACCOUNT_ID               ACCOUNTS.ACCOUNT_ID%TYPE,
    DO_AUTO_LOAD_DATA        NUMBER(1, 0),
    LOGIN                    ACCOUNTS.LOGIN%TYPE,
    PASSWORD                 ACCOUNTS.PASSWORD%TYPE,
    LOADING_YEAR             BINARY_INTEGER,
    LOADING_MONTH            BINARY_INTEGER,
    LOADER_SCRIPT_NAME       OPERATORS.LOADER_SCRIPT_NAME%TYPE,
    LOADER_DB_CONNECTION     LOADER_SETTINGS.LOADER_DB_CONNECTION%TYPE,
    LOADER_DB_USER_NAME      LOADER_SETTINGS.LOADER_DB_USER_NAME%TYPE,
    LOADER_DB_PASSWORD       LOADER_SETTINGS.LOADER_DB_PASSWORD%TYPE,
    LOAD_DETAIL_POOL_SIZE    ACCOUNTS.LOAD_DETAIL_POOL_SIZE%TYPE,
    LOAD_DETAIL_THREAD_COUNT ACCOUNTS.LOAD_DETAIL_THREAD_COUNT%TYPE,
    organization_id          db_loader_account_phones.organization_id%type);
  s           T_LOAD_SETTINGS;
  vLOAD_DATE  date;
  flag        number(1);
  vPHONES     DBMS_SQL.VARCHAR2_TABLE;
  vERROR_TEXT VARCHAR2(2000 CHAR);
  ttp TPHONE_LIST_ARRAY := TPHONE_LIST_ARRAY() ;
BEGIN
  flag := msisdn_refresh_upd(pPHONE_NUMBER, 1);
  if flag = 0 then
    begin
      select ac.login,
             ac.password,
             OP.LOADER_SCRIPT_NAME,
             AC.LOAD_DETAIL_THREAD_COUNT,
             dlp.organization_id
        into s.LOGIN,
             s.PASSWORD,
             s.LOADER_SCRIPT_NAME,
             s.LOAD_DETAIL_THREAD_COUNT,
             s.organization_id
        from ACCOUNTS ac, OPERATORS op, db_loader_account_phones dlp
       where dlp.account_id = ac.account_id
         and op.operator_id = ac.operator_id
         and dlp.phone_number = pPHONE_NUMBER
         and dlp.last_check_date_time =
             (select max(dlp1.last_check_date_time)
                from db_loader_account_phones dlp1
               where dlp1.phone_number = dlp.phone_number);
      vLOAD_DATE      := SYSDATE - 1;
      s.LOADING_YEAR  := TO_NUMBER(TO_CHAR(vLOAD_DATE, 'YYYY'));--pLOADING_YEAR; 
      s.LOADING_MONTH := TO_NUMBER(TO_CHAR(vLOAD_DATE, 'MM')); --pLOADING_MONTH; 
      vPHONES.DELETE;
      vPHONES(vPHONES.COUNT + 1) := pPHONE_NUMBER;
      SELECT LOADER_DB_CONNECTION, LOADER_DB_USER_NAME, LOADER_DB_PASSWORD
        INTO s.LOADER_DB_CONNECTION,
             s.LOADER_DB_USER_NAME,
             s.LOADER_DB_PASSWORD
        FROM LOADER_SETTINGS;
    exception
      when others then
        pERROR := 'Ошибка при запросе параметров';
    end;
    vERROR_TEXT := LOADER_CALL_PCKG.LOAD_PHONE_DETAIL_3(s.LOGIN,
                                                        s.PASSWORD,
                                                        s.LOADING_YEAR,
                                                        s.LOADING_MONTH,
                                                        s.LOADER_SCRIPT_NAME,
                                                        s.LOADER_DB_CONNECTION,
                                                        s.LOADER_DB_USER_NAME,
                                                        s.LOADER_DB_PASSWORD,
                                                        s.ORGANIZATION_ID,
                                                        s.LOAD_DETAIL_THREAD_COUNT,
                                                        vPHONES);
    if vERROR_TEXT is not null then
      pERROR := 'Ошибка при обновлении детализации с сайта: ' ||
                vERROR_TEXT;
    else
 --     if db_loader_pckg.GET_CONSTANT_VALUE('DB_DETAILS')='1' then
 --        ttp.extend();
 --        ttp(ttp.count) := PHONE_LIST_ARRAYT(pPHONE_NUMBER);
 --        hot_billing_pckg.SAVE_CALL_PHONE(ttp);
 --     end if;
      pError := 'Детализация успешно обновлена!';
    end if;
    flag := msisdn_refresh_upd(pPHONE_NUMBER, 3);
  else
    pERROR := 'Ошибка при добавлении номера в таблицу msisdn_refresh';
  end if;
END;
