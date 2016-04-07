
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_COLLECT_CHECK_STATUS" ("PHONE_NUMBER") AS 
  select t.phone_number from auto_blocked_phone t  --блоки
where t.block_date_time between sysdate-20/1440 and sysdate-15/1440
and exists
    (select 1 from db_loader_account_phones ph
            where ph.account_id in (select acc.account_id from accounts acc where acc.is_collector=1)
                  and ph.phone_number=t.phone_number
                  and ph.year_month=to_char(sysdate,'YYYYMM')
     )
and not exists
    (select 1 from beeline_soap_api_log l where l.phone=t.phone_number and l.load_type=3 and l.insert_date between sysdate-15/1440 and sysdate
    )
union all

select un.phone_number from AUTO_UNBLOCKED_PHONE un
where un.unblock_date_time between sysdate-20/1440 and sysdate-15/1440
and exists
    (select 1 from db_loader_account_phones ph --блоки
            where ph.account_id in (select acc.account_id from accounts acc where acc.is_collector=1)
                  and ph.phone_number=un.phone_number
                  and ph.year_month=to_char(sysdate,'YYYYMM')
     )
and not exists
    (select 1 from beeline_soap_api_log l where l.phone=un.phone_number and l.load_type=3 and l.insert_date between sysdate-15/1440 and sysdate
    )
