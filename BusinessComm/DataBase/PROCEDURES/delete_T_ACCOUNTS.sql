CREATE OR REPLACE procedure delete_T_ACCOUNTS
is
begin
  delete from T_ACCOUNTS;
end;
/

GRANT EXECUTE ON delete_T_ACCOUNTS TO BUSINESS_COMM_ROLE;
GRANT EXECUTE ON delete_T_ACCOUNTS TO BUSINESS_COMM_ROLE_RO;