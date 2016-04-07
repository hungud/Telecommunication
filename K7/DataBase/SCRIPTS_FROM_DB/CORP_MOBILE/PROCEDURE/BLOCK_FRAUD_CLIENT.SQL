
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."BLOCK_FRAUD_CLIENT" AS
  --
  --#Version=2
  --
  
  --v.2 24.09.2015 Афросин Добавил процедуру поиска номеров по условиям для дальнейшей блокировки со статусом ФРОД (задача http://redmine.tarifer.ru/issues/2917)
  --                      Необходимо блокировать автоматом номера и проставлять статус фрод при соблюдении следующих условий вместе:
  --                      1. Если номер после активации (дата договора) до 5 дней включительно
  --                      2. Если на номере появились смс с признаком Premium Rate MO SMS (возможно еще похожие признаки, опционально можно будет добавлять)
  --                      3. Стоимость этого смс не равно 0.


  CURSOR C IS
    select fb.phone_number, rowid, fb.add_date
      from FRAUD_BLOCKED_PHONE fb
     where fb.status = 0;

  row_number rowid;
  phone_num  FRAUD_BLOCKED_PHONE.phone_number%type;
  v_add_date FRAUD_BLOCKED_PHONE.add_date%type;
  flag       number;
  LOCK_PH    VARCHAR2(2000);
  
  procedure  FOUND_FRAUD_BY_CONDITIONS AS
    type ref_cursor is ref cursor;
    sql_txt VARCHAR2(1000 CHAR);
    c ref_cursor;
    v_phone_number contracts.phone_number_federal%TYPE;
    cnt_days INTEGER;
    mm_yyyy varchar2(7 char);
    mm_yyyy_minus_cnt_days varchar2(7 char);
  BEGIN
    cnt_days:= nvl(to_number(MS_CONSTANTS.GET_CONSTANT_VALUE('COUNT_DAYS_AUTO_BLOCK_FRAUD')), 5);
    mm_yyyy := TO_CHAR(SYSDATE,'mm_yyyy');
    mm_yyyy_minus_cnt_days := TO_CHAR(TRUNC(SYSDATE)-(cnt_days - 1), 'mm')||'_'||TO_CHAR(TRUNC(SYSDATE)-(cnt_days - 1),'yyyy');
     
    IF mm_yyyy <> mm_yyyy_minus_cnt_days THEN
      sql_txt:='select c.phone_number_federal from v_contracts c
                where trunc(SYSDATE) - c.CONTRACT_DATE <= '||cnt_days||
                ' and c.CONTRACT_CANCEL_DATE is null
                  and (exists (select 1 from CALL_'||mm_yyyy||' where subscr_no = c.PHONE_NUMBER_FEDERAL
                                 and call_cost <> 0
                                 and (at_ft_de=''Premium Rate MO SMS'' or at_ft_desc=''Premium Rate MO SMS''))
                     or exists (select 1 from CALL_'||mm_yyyy_minus_cnt_days||' where subscr_no = c.PHONE_NUMBER_FEDERAL
                                  and call_cost <> 0
                                  and (at_ft_de=''Premium Rate MO SMS'' or at_ft_desc=''Premium Rate MO SMS''))                            
                        )';    
    ELSE
      sql_txt:='select c.phone_number_federal from v_contracts c 
                where trunc(SYSDATE) - c.CONTRACT_DATE <= '||cnt_days||
                ' and c.CONTRACT_CANCEL_DATE is null
                  and exists (select 1 from CALL_'||mm_yyyy||' where subscr_no = c.PHONE_NUMBER_FEDERAL
                               and call_cost <> 0
                              and (at_ft_de=''Premium Rate MO SMS'' or at_ft_desc=''Premium Rate MO SMS''))';
    END IF;
    OPEN c FOR sql_txt;
    LOOP
      FETCH c INTO v_phone_number;
      EXIT WHEN c%NOTFOUND;
      if nvl(CONVERT_PCKG.GET_ACCOUNT_ID_BY_PHONE(v_phone_number), 0) = 1 then
        INSERT INTO fraud_blocked_phone (phone_number) VALUES (v_phone_number);
      end if;
    END LOOP;
    COMMIT;
  END;


  
  
BEGIN
  
  --ищем номера
  --Добавлиене номеров в таблицу FRAUD_BLOCKED_PHONE еще осуществляется где-то извне
  --FOUND_FRAUD_BY_CONDITIONS;
  
  
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