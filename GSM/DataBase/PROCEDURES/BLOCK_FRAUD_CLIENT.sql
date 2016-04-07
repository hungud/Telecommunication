CREATE OR REPLACE PROCEDURE BLOCK_FRAUD_CLIENT AS
  --
  --#Version=1
  --

  CURSOR C IS
    select fb.phone_number, rowid, fb.add_date
      from FRAUD_BLOCKED_PHONE fb
     where fb.status = 0;

  row_number rowid;
  phone_num  FRAUD_BLOCKED_PHONE.phone_number%type;
  v_add_date FRAUD_BLOCKED_PHONE.add_date%type;
  flag       number;
  LOCK_PH    VARCHAR2(2000);
BEGIN
  open c;
  LOOP
    FETCH C
      into phone_num, row_number, v_add_date;
    EXIT WHEN C%NOTFOUND;
    select count(*)
      into flag
      from AUTO_BLOCKED_PHONE abp
     where abp.phone_number = phone_num
       and abp.block_date_time > v_add_date;
    if flag = 0 then
      select decode(count(*), 0, 1, 0)
        into flag
        from DB_LOADER_ACCOUNT_PHONES dl
       where dl.phone_number = phone_num
         and dl.phone_is_active = 0
         and dl.year_month =
             (select max(dl1.year_month)
                from DB_LOADER_ACCOUNT_PHONES dl1
               where dl1.phone_number = phone_num);
      if flag = 1 then
        LOCK_PH := LOADER3_pckg.LOCK_PHONE(phone_num, 0);
        IF LOCK_PH IS NULL THEN
          update FRAUD_BLOCKED_PHONE fb
             set fb.date_block = sysdate, fb.status = 1
           where fb.rowid = row_number;
          commit;
        end if;
      else
        update FRAUD_BLOCKED_PHONE fb
           set fb.date_block = sysdate, fb.status = 2
         where fb.rowid = row_number;
        commit;
      end if;
    else
      update FRAUD_BLOCKED_PHONE fb
         set fb.date_block = sysdate, fb.status = 2
       where fb.rowid = row_number;
      commit;
    end if;
  
  END LOOP;
END;
