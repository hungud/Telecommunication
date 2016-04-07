
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."SAMPLE3_TAB_FNC" (pi_row IN sys_refcursor)
return sample3_typ_tab PIPELINED AS
l_string       LONG;
l_comma_index  PLS_INTEGER;
l_index        PLS_INTEGER := 1;
TYPE ListTyp IS TABLE OF VARCHAR2(100);
l_names ListTyp := ListTyp();
l_namesIter NUMBER :=1;
l_Iter NUMBER :=1;
l_cIter NUMBER :=1;
l_element varchar2(4000);
l_field1 varchar2(32000);
pi_rownumber number := 1;

l_class varchar2(10);
l_store_number varchar2(6);
l_pallet varchar2(6);
l_lot varchar2(6);
l_case varchar2(6);
l_item varchar2(6);
l_action varchar2(10);
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
LOOP
     FETCH pi_row INTO l_field1;
     EXIT WHEN pi_row%NOTFOUND;

select
to_char(to_date(rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,6),';'),'yyyymmddhh24miss'),'dd.mm.yyyy'||chr(9)||'hh24:mi:ss')||
chr(9)||to_char(to_date(substr(rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,46),';'),-6),'hh24miss'),'hh24:mi:ss')||
chr(9)||decode(rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,85),';'),rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,5),';'),'',rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,85),';'))||
chr(9)||nvl((select sv.feature_de from services sv
      where sv.feature_co=rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,13),';')),rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,141),';'))||
chr(9)||decode(nvl((select sv.descriptio from services sv
      where sv.feature_co=rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,13),';')),rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,141),';')),'GPRS internet','GPRS-Internet',
      'Звонок на спец номер (О)','исх/доп.сервис','MMS for HLR','MMS',nvl((select sv.descriptio from services sv
      where sv.feature_co=rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,13),';')),rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,141),';')))||
chr(9)||rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,32),';')||
chr(9)||substr(rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,27),';'),0,instr(rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,27),';'),',00')-1)||
chr(9)||rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,49),';')||
chr(9)||rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,74),';')||
chr(9)||nvl((select mn.mn_unlim_group from MN_UNLIM_SERVICES mn
      where mn.feature_co=rtrim(regexp_substr(str,'(^|[^;]*)($|;)',1,13),';')),0) into l_element from
--      select str from
(select l_field1 as str from dual) ;
PIPE ROW ( sample3_typ(l_element));

END LOOP;
RETURN;
END;
