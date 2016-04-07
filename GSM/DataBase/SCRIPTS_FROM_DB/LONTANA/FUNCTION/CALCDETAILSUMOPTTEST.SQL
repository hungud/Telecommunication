
  CREATE OR REPLACE FUNCTION "LONTANA"."CALCDETAILSUMOPTTEST" (ssubscr in varchar2, smonth in date) return varchar2 IS

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
    MnUnlimD               number := 0;
    MnUnlimO               number := 0;
    MnUnlimT               number := 0;
    sst                    varchar2(2);
    zf                     number(1);
    coun                   number;
    scost                  number;
    sdurcm                 number;
    sdurm                  number;
    curnm                  sys_refcursor;
  BEGIN
    open curnm for 'select c.servicetype,decode(c.call_cost,0,0,1),count(*),sum(c.call_cost),
sum(decode(c.servicetype,''C'',ceil(c.dur/60),''G'',c.dur/1024,''W'',c.dur/1024/1024,c.dur)),
sum(decode(c.servicetype,''C'',c.dur/60,''G'',c.dur/1024,''W'',c.dur/1024/1024,c.dur))
 from call_' || to_char(smonth, 'mm_yyyy') || ' c
where c.start_time>(SELECT nvl(DB_LOADER_PCKG.GET_PHONE_BALANCE_DATE(:phone_number),trunc(sysdate,''mm'')-1/86400) FROM DUAL)
and (c.servicetype=''C''
or (c.servicetype=''S'' and c.call_cost<>0)
or (c.servicetype=''U'' and c.call_cost<>0)
or c.servicetype=''G''
or c.servicetype=''W'')
and c.subscr_no=:phone_number
group by c.servicetype,decode(c.call_cost,0,0,1)' USING ssubscr, ssubscr;
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
   return 's='||to_char(DetailSum)||' ZeroCostOutcomeMinutes='||to_char(ZeroCostOutcomeMinutes)||
   ' ZeroCostOutcomeCount='||to_char(ZeroCostOutcomeCount)||' CallsCost='||to_char(CallsCost)||
   ' CallsMinutes='||to_char(CallsMinutes)||' CallsCount='||to_char(CallsCount);
    exception
      when others then
        null;
  end;
