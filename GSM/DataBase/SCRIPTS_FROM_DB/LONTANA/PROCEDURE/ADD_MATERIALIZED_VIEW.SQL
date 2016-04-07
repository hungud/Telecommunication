
  CREATE OR REPLACE PROCEDURE "LONTANA"."ADD_MATERIALIZED_VIEW" 
is
begin
  execute immediate 'create materialized view MV_PROFIT_BY_PHONES_YEAR
build immediate
refresh complete on demand next trunc(add_months(sysdate,1),''mm'')+24
as SELECT * FROM V_PROFIT_BY_PHONES_YEAR' ;
end;