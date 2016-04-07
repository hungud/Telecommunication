
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."BILL_SAVE_DETAILS" (smonth in varchar2,
slogin in varchar2) IS
  cursor cur_g is
    select hb.phone, /*trunc(to_date(hb.date_call,'dd.mm.yyyy'),'mm'),*/ count(*)
      from temp_call hb
     group by hb.phone/*, trunc(to_date(hb.date_call,'dd.mm.yyyy'),'mm')*/;
  --  type Ref_Cur is ref cursor;
  cur_n      SYS_REFCURSOR;
  rowi       rowid;
  subscr     varchar2(11);
  callt      date;
  callv      varchar2(4000);
  k          number;
  cf         utl_file.file_type;
  DIRDb  varchar2(256);
  DIRDbt  varchar2(256);
  DIRDbP  varchar2(256);
  --ptbl_rowid tbl_rowid := tbl_rowid();
BEGIN
   DIRDbt:=smonth;
  DIRDbp:=slogin;
  update bill_blob bb set bb.state=1
  where bb.smonth=DIRDbt
  and bb.slogin=DIRDbp;
  commit;
    DIRDbt:=MS_PARAMS.GET_PARAM_VALUE('TEMPDB_DIR');
  execute immediate 'create or replace directory TEMPDB  as '''||DIRDbt||'''';
  open cur_g;
  loop
    FETCH cur_g
      into subscr, /*mons,*/ k;
    EXIT WHEN cur_g%NOTFOUND;
    cf         := utl_file.fopen('TEMPDB', 'N'||subscr || '.txt', 'W');
   -- CalcDetailSumHBSC(subscr, to_date(smonth||'01','yyyy_mmdd'));
    open cur_n for  'select rowid,to_date(tc.date_call||tc.time_call,''dd.mm.yyyyhh24:mi:ss''), convert(tc.phone||chr(9)||tc.date_call||chr(9)||tc.time_call||chr(9)||tc.type_call||chr(9)||tc.in_out||chr(9)||
decode(tc.in_out,1,tc.phone_b,tc.phone_a)||chr(9)||tc.dur||chr(9)||tc.coast||chr(9)||
tc.is_roam||chr(9)||tc.roam_zone||chr(9)||tc.ext_type_call||chr(9)||
tc.cell_id||chr(9)||tc.coast_vo||chr(9)||tc.regi, ''CL8MSWIN1251'') from temp_call tc
where tc.phone=''' || subscr || '''
order by to_date(tc.date_call||tc.time_call,''dd.mm.yyyyhh24:mi:ss'')';
/*and trunc(to_date(tc.date_call,''dd.mm.yyyy''),''mm'')=trunc(to_date(''' || to_char(mons,
                                                                'dd.mm.yyyy') || ''',''dd.mm.yyyy''),''mm'')*/
    loop
      fetch cur_n
        into rowi, callt, callv;
      exit when cur_n%NotFound;
      utl_file.put_line(cf, callv,true);
      if rowi is not null then
        delete temp_call hbb where hbb.rowid = rowi;
      end if;
    end loop;
    close cur_n;
  --  utl_file.fflush(cf);
    utl_file.fclose(cf);
    commit;
    DIRDb:=MS_PARAMS.GET_PARAM_VALUE('DB_DIR');
    DIRDbP:=DIRDb||smonth||'\'||slogin||'\BILLDETAIL\';
    if pkg_fileutil.fn_FileExists(DIRDbP||subscr||'.txt')=1 then
       pkg_fileutil.pr_FileRename(DIRDbP||subscr||'.txt',DIRDbP||subscr||'BAK.txt');
    end if;
    pkg_fileutil.pr_FileMove(DIRDbt||'\N'||subscr||'.txt',DIRDbP||subscr||'.txt');
  end loop;
  close cur_g;
  DIRDbt:=smonth;
  DIRDbp:=slogin;
  select bb.filename into DIRDb from bill_blob bb
  where bb.smonth=DIRDbt
  and bb.slogin=DIRDbp;
   BILL_FILE_DELETE(DIRDb,smonth,slogin);
end;
