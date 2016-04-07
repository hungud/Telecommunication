
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."HOT_BILLING_SAVE_DETAILA" (modn   in integer,
                                                     resm   in integer,
                                                     smonth in date) IS
  cursor cur_g is
    select hb.subscr_no, trunc(hb.call_time, 'mm'), count(*)
      from HOT_BILLING hb
     where mod(hb.subscr_no, modn) = resm
    --        and hb.subscr_no='9032630853'
       and trunc(hb.call_time, 'mm') = smonth
     group by hb.subscr_no, trunc(hb.call_time, 'mm');
  --  type Ref_Cur is ref cursor;
  cur_n      SYS_REFCURSOR;
  rowi       rowid;
  subscr     varchar2(11);
  mons       date;
  callt      date;
  callv      varchar2(4000);
  k          number;
  cf         utl_file.file_type;
  DIRECTORYP varchar2(50);
  --ptbl_rowid tbl_rowid := tbl_rowid();
BEGIN
  open cur_g;
  loop
    FETCH cur_g
      into subscr, mons, k;
    EXIT WHEN cur_g%NOTFOUND;
    DIRECTORYP := 'HB' || to_char(mons, 'yyyy_mm');
    cf         := utl_file.fopen(DIRECTORYP, subscr || '.txt', 'W');
    open cur_n for 'select rowid,hb.call_time,hb.col_value from HOT_BILLING hb
where hb.subscr_no=''' || subscr || '''
and trunc(hb.call_time,''mm'')=trunc(to_date(''' || to_char(mons,
                                                                'dd.mm.yyyy') || ''',''dd.mm.yyyy''),''mm'')
 order by 2';
    loop
      fetch cur_n
        into rowi, callt, callv;
      exit when cur_n%NotFound;
      utl_file.put_line(cf, callv,true);
      if rowi is not null then
        delete hot_billing hbb where hbb.rowid = rowi;
      end if;
    end loop;
    close cur_n;
  --  utl_file.fflush(cf);
    utl_file.fclose(cf);
    commit;
  end loop;
  close cur_g;
  
end;
