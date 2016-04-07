
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."TESTHB_CALCDETAILSUM" (ssubscr in varchar2,
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
  open curnm for 'select /*+index(c CALL_' || to_char(smonth, 'mm_yyyy') || '$subscr#stime$IDX)*/ c.servicetype,decode(c.call_cost,0,0,1),count(*),sum(c.call_cost),
sum(decode(c.servicetype,''C'',ceil(c.dur/60),''G'',c.dur/1024,''W'',c.dur/1024/1024,c.dur)),
sum(decode(c.servicetype,''C'',c.dur/60,''G'',c.dur/1024,''W'',c.dur/1024/1024,c.dur))
 from (select distinct subscr_no, start_time, dbf_id, call_cost, costnovat, dur, imei, servicetype, servicedirection, isroaming,
roamingzone,call_date, call_time, duration, dialed_dig,calling_no, at_chg_amt, data_vol,
cell_id, mn_unlim, insert_date from call_' || to_char(smonth, 'mm_yyyy') || ' ) c
where c.start_time>nvl(DB_LOADER_PCKG.GET_PHONE_BALANCE_DATE(c.subscr_no),trunc(sysdate,''mm'')-1/86400)
and (c.servicetype=''C''
or (c.servicetype=''S'' and c.call_cost<>0)
or (c.servicetype=''U'' and c.call_cost<>0)
or c.servicetype=''G''
or c.servicetype=''W'')
and c.subscr_no=''' || ssubscr || '''
group by c.servicetype,decode(c.call_cost,0,0,1)';
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
/*  DB_LOADER_PCKG.SET_DB_LOADER_PHONE_STAT(to_number(to_char(smonth,'yyyy')),to_number(to_char(smonth,'mm')),
  GET_login_BY_PHONE(ssubscr),ssubscr,DetailSum,ZeroCostOutcomeMinutes,ZeroCostOutcomeCount,
  CallsCount,CallsMinutes,CallsCost,SMSCount,SMSCost,MMSCount,MMSCost,InternetMB,InternetCost);*/
  SET_DB_LOADER_PHONE_STATHB(to_number(to_char(smonth,'yyyy')),to_number(to_char(smonth,'mm')),
  GET_login_BY_PHONE(ssubscr),ssubscr,DetailSum,ZeroCostOutcomeMinutes,ZeroCostOutcomeCount,
  CallsCount,CallsMinutes,CallsCost,SMSCount,SMSCost,MMSCount,MMSCost,InternetMB,InternetCost);
  exception when others then
    null;
  end;
  open curnm for 'select /*+index(c CALL_' || to_char(smonth, 'mm_yyyy') || '$subscr#MN$IDX)*/ c.mn_unlim,
sum(ceil(c.dur/60)*60) from call_' || to_char(smonth, 'mm_yyyy') || ' c
where c.start_time>=DB_LOADER_PCKG.GET_MN_UNLIM_SDATE(c.subscr_no)
and DB_LOADER_PCKG.GET_MN_UNLIM_SDATE(c.subscr_no)<>to_date(''31.12.1999'',''dd.mm.yyyy'')
and c.mn_unlim<>0
and c.dur>2
and c.subscr_no=''' || ssubscr || '''
group by c.mn_unlim';
  loop
    FETCH curnm
      into zf, sdurm;
    EXIT WHEN curnm%NOTFOUND;
    case zf
      when 1 then
        --2000
        MnUnlimD := MnUnlimD + sdurm;
      when 2 then
        --300
        MnUnlimT := MnUnlimT + sdurm;
      when 3 then
        --150
        MnUnlimO := MnUnlimO + sdurm;
    end case;
  end loop;
  close curnm;
  begin
  --DB_LOADER_PCKG.SET_MN_UNLIM_VOLUME(to_number(to_char(smonth,'yyyy')),to_number(to_char(smonth,'mm')),ssubscr,MnUnlimD,MnUnlimT,MnUnlimO);
  SET_MN_UNLIM_VOLUMEHB(to_number(to_char(smonth,'yyyy')),to_number(to_char(smonth,'mm')),ssubscr,MnUnlimD,MnUnlimT,MnUnlimO);
  exception when others then
    null;
  end;
end;
