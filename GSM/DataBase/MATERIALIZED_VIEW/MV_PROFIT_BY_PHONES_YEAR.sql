--#if GetVersion("MV_PROFIT_BY_PHONES_YEAR") < 1
drop materialized view MV_PROFIT_BY_PHONES_YEAR;
create materialized view MV_PROFIT_BY_PHONES_YEAR
build immediate
refresh complete on demand next trunc(add_months(sysdate,1),'mm')+24
as 
--#Version=1
SELECT * FROM V_PROFIT_BY_PHONES_YEAR;
--#end if