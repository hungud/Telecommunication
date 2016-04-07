CREATE OR REPLACE FUNCTION GET_PHONE_DETAIL_FROM_CALL(
  pPHONE_NUMBER IN VARCHAR2,
  pYEAR_MONTH IN INTEGER
  ) RETURN T_VARCHAR2_4000_TAB PIPELINED IS
--#Version=1
--
-- Позволяет получать детализация в виде строк, аналогичных хранимому файлу детализаций.
-- Использование: 
--   SELECT * FROM TABLE(GET_DETAIL_FROM_CALL('9689681650', 201408))
--
  vMONTH VARCHAR2(2);
  vYEAR VARCHAR2(4);
  v_stmt_str VARCHAR2(2000);
  TYPE CallCurTyp  IS REF CURSOR;
  v_call_cursor    CallCurTyp;
  vRESULT VARCHAR2(4000);
BEGIN
  vMONTH := SUBSTR(pYEAR_MONTH, 5, 2);
  vYEAR := SUBSTR(pYEAR_MONTH, 1, 4);
    -- Dynamic SQL statement with placeholder:
  v_stmt_str := 'SELECT tcs.subscr_no||chr(9)||tcs.call_date||chr(9)||tcs.call_time||chr(9)|| 
tcs.SERVICETYPE||chr(9)||tcs.servicedirection||chr(9)||decode(tcs.subscr_no,tcs.calling_no,tcs.dialed_dig,tcs.calling_no)||chr(9)|| 
decode(tcs.servicetype,''G'',tcs.data_vol,tcs.dur)||chr(9)||tcs.call_cost||chr(9)||tcs.isroaming||chr(9)||tcs.roamingzone||chr(9)|| 
tcs.AT_FT_DE||chr(9)||tcs.cell_id||chr(9)||tcs.costnovat||chr(9)||(select max(bb.zone_name) from beeline_bs_zones bb 
    where bb.beeline_bs_zone_id=TRIM( BOTH chr(13) FROM tcs.cell_id)) RES 
from CALL_' || vMONTH || '_' || vYEAR || ' tcs 
where tcs.subscr_no=:'||'PHONE_NUMBER order by tcs.start_time';
--
  -- Open cursor, specify bind argument in USING clause:
  OPEN v_call_cursor FOR v_stmt_str USING pPHONE_NUMBER;

  -- Fetch rows from result set one at a time:
  LOOP
    FETCH v_call_cursor INTO vRESULT;
    EXIT WHEN v_call_cursor%NOTFOUND;
    PIPE ROW(vRESULT);
  END LOOP;

  -- Close cursor:
  CLOSE v_call_cursor;
END;
/

create synonym corp_mobile_lk.GET_PHONE_DETAIL_FROM_CALL for GET_PHONE_DETAIL_FROM_CALL;
grant execute on GET_PHONE_DETAIL_FROM_CALL to corp_mobile_lk;
