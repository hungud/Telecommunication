
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."SAMPLE3_TAB_FNC3" (pi_row IN sys_refcursor)
return HOT_BIL_TAB PIPELINED AS
call_d varchar2(10);
call_t varchar2(8);
durp varchar2(8);
dialedp varchar2(11);
ftcodep varchar2(400);
ft_descp varchar2(400);
callingp varchar2(14);
chargep varchar2(14);
volp varchar2(14);
cell_idp varchar2(14);
mnunlimp varchar2(1);
call_time date;
l_element varchar2(4000);
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
LOOP
     FETCH pi_row INTO call_d,call_t,durp,dialedp,ftcodep,ft_descp,callingp,chargep,volp,cell_idp,mnunlimp;
     EXIT WHEN pi_row%NOTFOUND;
     ftcodep:=ftcodep||chr(9);
select to_date(call_d||call_t,'dd.mm.yyyyhh24:mi:ss'),
call_d||chr(9)||call_t||
chr(9)||durp||
chr(9)||dialedp||
chr(9)||ftcodep||
ft_descp||
chr(9)||callingp||
chr(9)||chargep||
chr(9)||volp||
chr(9)||cell_idp||
decode(mnunlimp,null,null,chr(9)||mnunlimp) into call_time,l_element from dual;
PIPE ROW ( HOT_BIL_TYPE(null,call_time,l_element));

END LOOP;
RETURN;
END;
