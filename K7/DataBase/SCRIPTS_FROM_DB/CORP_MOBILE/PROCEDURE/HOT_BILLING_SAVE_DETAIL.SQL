
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."HOT_BILLING_SAVE_DETAIL" (modn in integer,
                                                    resm in integer) IS
  cursor cur_g is
    select hb.subscr_no, trunc(hb.call_time, 'mm'), count(*)
      from HOT_BILLING hb
     where mod(hb.subscr_no, modn) = resm
     and hb.subscr_no='9672823167'
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
    execute immediate 'CREATE TABLE HOT_BILLING_DETAIL (
datep varchar2(10),
timep varchar2(8),
durp varchar2(8),
dialedp varchar2(30),
ft_codep varchar2(200),
ft_descp varchar2(300),
callingp varchar2(30),
chargep varchar2(10),
volp varchar2(10),
cell_idp varchar2(10),
mn_unlimp varchar2(1)
)
 ORGANIZATION EXTERNAL
 (
   TYPE ORACLE_LOADER
   DEFAULT DIRECTORY ' || DIRECTORYP || '
   ACCESS PARAMETERS
   (
             records delimited by 0x''0A''
             badfile ' || DIRECTORYP ||
                      ':''DET%a_%p.bad''
             nologfile
             fields terminated by 0x''09''  LRTRIM
            MISSING FIELD VALUES ARE NULL (datep char(10),
timep char(8),
durp char(8),
dialedp char(30),
ft_codep char(200),
ft_descp char(300),
callingp char(30),
chargep char(10),
volp char(10),
cell_idp char(10),
mn_unlimp char(1))
   )
   LOCATION (''' || subscr || '.txt'')
 )
 PARALLEL 10
 REJECT LIMIT unlimited';
    cf := utl_file.fopen(DIRECTORYP, '2' || subscr || '.txt', 'W');
    open cur_n for 'select rowid,hb.call_time,convert(hb.col_value, ''CL8MSWIN1251'') from HOT_BILLING hb
where hb.subscr_no=''' || subscr || '''
and trunc(hb.call_time,''mm'')=trunc(to_date('''||to_char(mons,'dd.mm.yyyy')||''',''dd.mm.yyyy''),''mm'')
union all
 select null,to_date(tcs.datep||tcs.timep,''dd.mm.yyyyhh24:mi:ss''),
 tcs.datep||chr(9)||tcs.timep||chr(9)||
 tcs.durp||chr(9)||tcs.dialedp||chr(9)||
 tcs.ft_codep||chr(9)||tcs.ft_descp||chr(9)||
 tcs.callingp||chr(9)||tcs.chargep||chr(9)||
 tcs.volp||chr(9)||tcs.cell_idp||chr(9)||
 tcs.mn_unlimp from HOT_BILLING_DETAIL tcs
 order by 2';
    loop
      fetch cur_n
        into rowi, callt, callv;
      exit when cur_n%NotFound;
      utl_file.put_line(cf, callv);
      if rowi is not null then
        delete hot_billing hbb where hbb.rowid = rowi;
      end if;
    end loop;
    close cur_n;
    utl_file.fflush(cf);
    utl_file.fclose(cf);
    execute immediate 'drop TABLE HOT_BILLING_DETAIL';
    UTL_FILE.frename('DIRECTORYP',
                     '2' || subscr || '.txt',
                     'DIRECTORYP',
                     subscr || '.txt',
                     true);
  end loop;
  close cur_g;
  commit;
end;
