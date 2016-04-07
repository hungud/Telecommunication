CREATE OR REPLACE procedure INS_T_ACCOUNTS2(txtID in out varchar2) 
is
pos number;
id  varchar2(50);
begin
pos := 10;
  while pos > 0 loop
    pos := instr(txtId,',',1);
    id := substr(txtId,1,pos-1);
    txtId := substr(txtId,pos+1); 
    if pos > 0 then
      insert into T_ACCOUNTS(ACCOUNT_ID) values (id);
    else
      insert into T_ACCOUNTS(ACCOUNT_ID) values (txtId);
    end if;  
  end loop;
end;
/

GRANT EXECUTE ON INS_T_ACCOUNTS2 TO BUSINESS_COMM_ROLE;
GRANT EXECUTE ON INS_T_ACCOUNTS2 TO BUSINESS_COMM_ROLE_RO;