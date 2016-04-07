
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."HOT_BILLING_SAVE_CALL_MMR" (mons in date) IS
  cur_n      SYS_REFCURSOR;
  cur_g      SYS_REFCURSOR;
  i       integer;
  subscr     varchar2(11);
  callt      date;
  callv      varchar2(4000);
  k          number;
  cf         utl_file.file_type;
    DIRDb  varchar2(200):='\\10.176.1.100\share\Tarifer\DB\';
  DIRDbP  varchar2(200);
BEGIN
  open cur_g for 'select hb.subscr_no,count(*)
      from CALL_'||to_char(mons,'mm_yyyy')||' hb
     where to_number(hb.subscr_no)>='||MS_constants.GET_CONSTANT_VALUE('CALLNSMMR')||
'     group by hb.subscr_no
      order by 1';
  loop
    FETCH cur_g
      into subscr, k;
    EXIT WHEN cur_g%NOTFOUND;
    DIRDbP:=DIRDb||to_char(mons,'yyyy_mm')||'\'||GET_login_BY_PHONE_M(subscr,mons)||'\';
    cf := utl_file.fopen(DIRDbP, subscr || '.txt', 'a');
    open cur_n for 'select tcs.start_time,
 convert(tcs.subscr_no||chr(9)||tcs.call_date||chr(9)||tcs.call_time||chr(9)||
 tcs.SERVICETYPE||chr(9)||tcs.servicedirection||chr(9)||decode(tcs.subscr_no,tcs.calling_no,tcs.dialed_dig,tcs.calling_no)||chr(9)||
 decode(tcs.servicetype,''G'',tcs.data_vol,tcs.dur)||chr(9)||tcs.call_cost||chr(9)||tcs.isroaming||chr(9)||tcs.roamingzone||chr(9)||
 tcs.AT_FT_DE||chr(9)||tcs.cell_id||chr(9)||tcs.costnovat||chr(9)||(select max(bb.zone_name) from beeline_bs_zones bb
     where bb.beeline_bs_zone_id=TRIM( BOTH chr(13) FROM tcs.cell_id)), ''CL8MSWIN1251'')
 from CALL_'||to_char(mons,'mm_yyyy')||' tcs
 where tcs.subscr_no='''||subscr||
''' order by 1';
    loop
      fetch cur_n
        into  callt, callv;
      exit when cur_n%NotFound;
      utl_file.put_line(cf, callv,true);
    end loop;
    close cur_n;
    utl_file.fclose(cf);
    i:=MS_constants.SET_CONSTANT_VALUE('CALLNSMMR',subscr);
    commit;
  end loop;
  close cur_g;
  i:=MS_constants.SET_CONSTANT_VALUE('CALLNSMMR','0');
  commit;
end;
