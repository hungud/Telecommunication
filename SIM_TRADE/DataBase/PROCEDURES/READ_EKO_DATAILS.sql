CREATE OR REPLACE procedure read_eko_details is
url varchar2(500 char);
itog varchar2(500 char);
vYEAR_MONTH VARCHAR2(6 CHAR);
begin
  --select str1 into url from temp4 where id =3;
  vYEAR_MONTH:=TO_CHAR(SYSDATE, 'YYYYMM');
  url:='https://gsmcorporacia:sdv4f5gSDjh49ddsPFg@gt287.ekomobile.ru:9084/cgi-bin/iface.cgi?json=0ANDaction=getdetailANDphone=(PHONE_NUMBER)ANDperiod=(YEAR_MONTH)';
  url:=REPLACE(URL, '(YEAR_MONTH)', vYEAR_MONTH);
  for rec in(
    select *
      from db_loader_account_phones x
      where x.account_id = 225
        and x.year_month = TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMM'))
        and exists (select 1
                      from db_loader_account_phone_hists z   
                      where x.PHONE_NUMBER = z.PHONE_NUMBER
                        and z.PHONE_IS_ACTIVE = 1
                        and z.END_DATE >= sysdate - 5))
  loop
    select loader3_pckg.GET_PARTNER_URL(replace(url, '(PHONE_NUMBER)' , rec.phone_number)) into itog from dual;
  end loop;
  for rec in(
    select *
      from db_loader_account_phones x
      where x.account_id = 225
        and x.year_month = TO_NUMBER(vYEAR_MONTH)
        and exists (select 1
                      from db_loader_account_phone_hists z   
                      where x.PHONE_NUMBER = z.PHONE_NUMBER
                        and z.PHONE_IS_ACTIVE = 1
                        and z.END_DATE >= sysdate - 5)
        and not exists (select 1
                          FROM DB_LOADER_PHONE_STAT Z
                          WHERE z.ACCOUNT_ID = x.ACCOUNT_ID
                            and Z.PHONE_NUMBER = X.PHONE_NUMBER
                            AND Z.YEAR_MONTH = X.YEAR_MONTH) )
  loop
   INSERT INTO DB_LOADER_PHONE_STAT(ACCOUNT_ID, YEAR_MONTH, PHONE_NUMBER, ESTIMATE_SUM, 
                                    ZEROCOST_OUTCOME_MINUTES, ZEROCOST_OUTCOME_COUNT, CALLS_COUNT, CALLS_MINUTES, CALLS_COST, 
                                    SMS_COUNT, SMS_COST, MMS_COUNT, MMS_COST, 
                                    INTERNET_MB, INTERNET_COST, LAST_CHECK_DATE_TIME, COST_CHNG)
     VALUES(rec.ACCOUNT_ID, rec.YEAR_MONTH, rec.PHONE_NUMBER, 0,
            0, 0, 0, 0, 0, 
            0, 0, 0, 0,  
            0, 0, SYSDATE, 0);
  end loop;
  COMMIT;
end;
/
