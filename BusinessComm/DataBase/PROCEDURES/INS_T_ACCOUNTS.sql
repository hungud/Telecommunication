CREATE OR REPLACE procedure INS_T_ACCOUNTS(txtID in out varchar2) 
is
begin
 for c in  
   (SELECT REGEXP_SUBSTR (str, '[^,]+', 1, LEVEL) str
     FROM (SELECT txtID str FROM DUAL) t
 CONNECT BY INSTR (str, ',', 1, LEVEL - 1) > 0)
 loop
   insert into  T_ACCOUNTS(ACCOUNT_ID) values (c.str);
  end loop;
end;
/

GRANT EXECUTE ON INS_T_ACCOUNTS TO BUSINESS_COMM_ROLE;
GRANT EXECUTE ON INS_T_ACCOUNTS TO BUSINESS_COMM_ROLE_RO;