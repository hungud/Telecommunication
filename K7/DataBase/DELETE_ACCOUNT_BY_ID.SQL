select * from accounts where account_id=58


select count(*) from DB_LOADER_ACCOUNT_PHONE_OPTS where account_id=58;
select count(*) from DB_LOADER_ACCOUNT_PHONES where account_id=58;
select count(*) from DB_LOADER_BILLS where account_id=58;
select count(*) from DB_LOADER_BILLS_ADD where account_id=58;
select count(*) from DB_LOADER_PAYMENTS where account_id=58;
select count(*) from DB_LOADER_PHONE_STAT where account_id=58;
select count(*) from DB_LOADER_FULL_BILL_ABON_PER where account_id=58;



delete DB_LOADER_ACCOUNT_PHONE_OPTS where account_id=58;
delete DB_LOADER_ACCOUNT_PHONES where account_id=58;
delete DB_LOADER_BILLS where account_id=58;
delete DB_LOADER_BILLS_ADD where account_id=58;
delete DB_LOADER_PAYMENTS where account_id=58;
delete DB_LOADER_PHONE_STAT where account_id=58;
delete DB_LOADER_FULL_BILL_ABON_PER where account_id=58;

