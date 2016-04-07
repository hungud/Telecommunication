create user www_dealer identified by www_dealer_835;

alter user www_dealer default tablespace users;

grant create session to www_dealer;

grant create procedure to www_dealer;

grant create VIEW to www_dealer;

grant unlimited tablespace to www_dealer;

grant create table to www_dealer;

grant create sequence to www_dealer;

alter user www_dealer quota unlimited on users;
