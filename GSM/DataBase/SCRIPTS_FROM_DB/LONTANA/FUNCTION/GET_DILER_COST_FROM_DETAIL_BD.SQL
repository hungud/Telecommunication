
  CREATE OR REPLACE FUNCTION "LONTANA"."GET_DILER_COST_FROM_DETAIL_BD" (
  pPHONE_NUMBER IN VARCHAR2,
  pYEAR_MONTH IN NUMBER
  ) RETURN NUMBER IS
 PRAGMA AUTONOMOUS_TRANSACTION;
  LINE VARCHAR2(4000);
  ITOG NUMBER(15, 4);
BEGIN
  ITOG:=0;
  line:= 'select sum(c10.call_cost) from call_'||SUBSTR('00'||to_char(pYEAR_MONTH-TRUNC(pYEAR_MONTH,-2)), -2, 2)||'_'||to_char(TRUNC(pYEAR_MONTH/100))||
  ' c10,TYPE_CALL_FOR_DILER tcd where c10.subscr_no=:pPHONE and nvl(tcd.type_diler,0)=1 and tcd.type_call=c10.at_ft_de';
EXECUTE IMMEDIATE line into ITOG USING pPHONE_NUMBER;
if itog is null then 
  itog:=-1;
end if;
line:='begin insert into TYPE_CALL_FOR_DILER select c10.at_ft_de,null,null from call_'||SUBSTR('00'||to_char(pYEAR_MONTH-TRUNC(pYEAR_MONTH,-2)), -2, 2)||'_'||to_char(TRUNC(pYEAR_MONTH/100))||
' c10 where not exists(select 1 from TYPE_CALL_FOR_DILER tcd where tcd.type_call=c10.at_ft_de) and c10.subscr_no=:pPHONE; commit; end;';
EXECUTE IMMEDIATE line USING pPHONE_NUMBER;
  RETURN ITOG;
END; 