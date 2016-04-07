
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."CALCDETAILSUMHBSC" (ssubscr in varchar2,
                                                      smonth  in date) IS
  DetailSum              number := 0;
  ZeroCostOutcomeMinutes number := 0;
  ZeroCostOutcomeCount   number := 0;
  CallsCost              number := 0;
  CallsMinutes           number := 0;
  CallsCount             number := 0;
  SMSCount               number := 0;
  SMSCost                number := 0;
  MMSCount               number := 0;
  MMSCost                number := 0;
  InternetMB             number := 0;
  InternetCost           number := 0;
  sst                    varchar2(20);
  zf                     number;
  coun                   number;
  scost                  number;
  sdurcm                 number;
  sdurm                  number;
  curnm                  sys_refcursor;
BEGIN
  open curnm for 'select  c.type_call,decode(to_number(c.coast,''99999999D9999'','' NLS_NUMERIC_CHARACTERS = '''',.''''''),0,0,1),count(*),sum(to_number(c.coast,''99999999D9999'','' NLS_NUMERIC_CHARACTERS = '''',.'''''')),
sum(decode(c.type_call,''C'',ceil(c.dur/60),''G'',to_number(c.GPRS_MB,''99999999D9999'','' NLS_NUMERIC_CHARACTERS = '''',.''''''),''W'',to_number(c.GPRS_MB,''99999999D9999'','' NLS_NUMERIC_CHARACTERS = '''',.''''''),c.dur)),
sum(decode(c.type_call,''C'',c.dur/60,''G'',to_number(c.GPRS_MB,''99999999D9999'','' NLS_NUMERIC_CHARACTERS = '''',.''''''),''W'',to_number(c.GPRS_MB,''99999999D9999'','' NLS_NUMERIC_CHARACTERS = '''',.''''''),c.dur))
 from temp_call c
where to_date(c.date_call||c.time_call,''dd.mm.yyyyhh24:mi:ss'')>(SELECT nvl(DB_LOADER_PCKG.GET_PHONE_BALANCE_DATE(:phone_number),trunc(sysdate,''mm'')-1/86400) FROM DUAL)
and (c.type_call=''C''
or (c.type_call=''S'' and to_number(c.coast,''99999999D9999'','' NLS_NUMERIC_CHARACTERS = '''',.'''''')<>0)
or (c.type_call=''U'' and to_number(c.coast,''99999999D9999'','' NLS_NUMERIC_CHARACTERS = '''',.'''''')<>0)
or c.type_call=''G''
or c.type_call=''W'')
and c.phone=:phone_number
group by c.type_call,decode(to_number(c.coast,''99999999D9999'','' NLS_NUMERIC_CHARACTERS = '''',.''''''),0,0,1)' USING ssubscr, ssubscr;   
--and trunc(to_date(c.date_call||c.time_call,''dd.mm.yyyyhh24:mi:ss''),''mm'')=to_date('''||to_char(smonth,'dd.mm.yyyy')||''',''dd.mm.yyyy'')

  loop
    FETCH curnm
      into sst, zf, coun, scost, sdurcm, sdurm;
    EXIT WHEN curnm%NOTFOUND;
    case sst
      when 'C' then
        if zf = 0 then
          ZeroCostOutcomeMinutes := ZeroCostOutcomeMinutes + sdurcm;
          ZeroCostOutcomeCount   := ZeroCostOutcomeCount + coun;
        else
          CallsCost    := CallsCost + scost;
          CallsMinutes := CallsMinutes + sdurm;
          CallsCount   := CallsCount + coun;
        end if;
      when 'S' then
        SMSCount := SMSCount + coun;
        SMSCost  := SMSCost + scost;
      when 'U' then
        MMSCount := MMSCount + coun;
        MMSCost  := MMSCost + scost;
      when 'G' then
        InternetMB   := InternetMB + sdurcm;
        InternetCost := InternetCost + scost;
      when 'W' then
        InternetMB   := InternetMB + sdurcm;
        InternetCost := InternetCost + scost;
    end case;
    DetailSum := DetailSum + scost;
  end loop;
  close curnm;
  begin
  DB_LOADER_PCKG.SET_DB_LOADER_PHONE_STAT(to_number(to_char(smonth,'yyyy')),to_number(to_char(smonth,'mm')),
  GET_login_BY_PHONE(ssubscr),ssubscr,DetailSum,ZeroCostOutcomeMinutes,ZeroCostOutcomeCount,
  CallsCount,CallsMinutes,CallsCost,SMSCount,SMSCost,MMSCount,MMSCost,InternetMB,InternetCost,0);
  commit;
/*  SET_DB_LOADER_PHONE_STATHB(to_number(to_char(smonth,'yyyy')),to_number(to_char(smonth,'mm')),
  GET_login_BY_PHONE(ssubscr),ssubscr,DetailSum,ZeroCostOutcomeMinutes,ZeroCostOutcomeCount,
  CallsCount,CallsMinutes,CallsCost,SMSCount,SMSCost,MMSCount,MMSCost,InternetMB,InternetCost);*/
  exception when others then
    null;
  end;

end;