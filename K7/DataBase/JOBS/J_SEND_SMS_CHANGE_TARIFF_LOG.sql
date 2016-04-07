select beeline.phone_number, beeline.change_date,
         beeline.tariff_code, tarifer.tariff_name, beeline.tariff_code_lag
    from 
        (select trunc(begin_date) change_date, 
               begin_date, phone_number, 
               cell_plan_code tariff_code,
               lag(cell_plan_code) over (partition by phone_number order by begin_date) tariff_code_lag
          from DB_LOADER_ACCOUNT_PHONE_HISTS
         --where PHONE_NUMBER = '9654041993' для теста
        ) beeline
       ,(select distinct c.phone_number_federal, 
               cc.contract_change_date, 
               t.tariff_code, 
               t.tariff_name, 
               trunc(cc.contract_change_date) change_date
          from contract_changes cc, 
               contracts c, 
               tariffs t 
         where cc.docum_type_id = 4 
           and c.contract_id = cc.contract_id 
           and cc.tariff_id = t.tariff_id
           --and C.PHONE_NUMBER_FEDERAL = '9654041993' для теста
       ) tarifer
  where beeline.tariff_code_lag is not null 
    and beeline.tariff_code <> beeline.tariff_code_lag
    and beeline.phone_number = tarifer.phone_number_federal
    and beeline.tariff_code = tarifer.tariff_code
    and ((beeline.change_date = tarifer.change_date) or
         (beeline.change_date = tarifer.change_date-1)or
         (beeline.change_date = tarifer.change_date+1)
        )
    and not exists 
           (select 1 from SEND_SMS_CHANGE_TARIFF_LOG
             where phone_number = beeline.phone_number 
               and tariff_code = beeline.tariff_code
               and change_date = beeline.change_date
               and error_text is null
           )
    and ( (beeline.change_date > SYSDATE - 1) or
          (tarifer.change_date > SYSDATE - 1) )