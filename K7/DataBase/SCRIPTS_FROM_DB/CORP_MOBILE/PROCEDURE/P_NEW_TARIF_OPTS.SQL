
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."P_NEW_TARIF_OPTS" (
  pOPTION_CODE in varchar2
  ) is --код тарифной опции
--
pragma AUTONOMOUS_TRANSACTION;
begin
  INSERT INTO QUEUE_CURRENT_BALANCES(PHONE_NUMBER, QUEUE_TYPE)
    select distinct(OPT.PHONE_NUMBER) phone_NUMBER, 52 QUEUE_TYPE
      from DB_LOADER_ACCOUNT_PHONE_OPTS opt 
      where OPT.OPTION_CODE = pOPTION_CODE 
        and OPT.YEAR_MONTH = to_char(sysdate,'YYYYMM');
  commit;
end p_new_tarif_opts;