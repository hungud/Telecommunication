CREATE OR REPLACE PROCEDURE GET_SIM_LIST_BY_ACCOUNT (pAccountId ACCOUNTS.ACCOUNT_ID%TYPE) AS
  res varchar2(500 char);
begin
  res :=  BEELINE_API_PCKG.account_phone_SIM(pAccountId);
end;