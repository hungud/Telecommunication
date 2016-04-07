create user LONTANA_WWW
identified by LONTANA_WWW_173
default tablespace users;

alter user LONTANA_WWW
default tablespace users;

--grant lontana_role to lontana_www;

--REVOKE lontana_role FROM lontana_www;

grant create session to lontana_www;

grant create procedure to lontana_www;

grant create VIEW to lontana_www;

grant unlimited tablespace to lontana_www;

grant create table to lontana_www;

grant create sequence to lontana_www;

alter user lontana_www quota unlimited on users;

GRANT EXECUTE ON UTL_HTTP TO LONTANA_WWW; -- Под SYS

--begin 
--	RECREATE_USER_ROLE1('LONTANA_ROLE'); 
--end;
--/
