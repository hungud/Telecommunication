CREATE OR REPLACE PROCEDURE GPRS_ADD_CUR_TARIFF_IN_LOGIC
IS

  --version 1
  --
  --v.1 Алексеев 08.10.2015 Добавил процедуру, которая для номеров с автоподключением пакетов при смене тп добавляет
  --                                     текущий тп в историю автоподключения интернет-опций (логику) при условии что последним в
  --                                     истории был тп, а не пакет. Если текущий тп не добавлять в историю автоподключений 
  --                                     интернет-опций, то номер браться в обработку на проверку автоподключения пакетов не будет.
  
  v_tar varchar2(60 char);
  v_cnt integer;
  v_num integer;
  v_res varchar2(500 char);
BEGIN
  --для всех номеров из истории подключений интернет-опций
  for rec in (
                      select distinct c.phone
                        from gprs_turn_log c
                      where c.date_off is null 
                          and nvl((select db.phone_is_active 
                                         from db_loader_account_phones db
                                       where db.phone_number = c.phone 
                                           and db.year_month = to_char(sysdate,'yyyymm')), 0) = 1
                          and nvl((select count(1) 
                                         from mnp_remove mnp 
                                       where mnp.temp_phone_number = c.phone 
                                           and mnp.date_created >= sysdate-1), 0) = 0
                          -- обрабатывать только номера с автоинтернет тарифом
                          and exists (
                                            select 1
                                              from v_contracts ct,
                                                      tariffs tf
                                            where CT.PHONE_NUMBER_FEDERAL = c.phone
                                                and CT.CONTRACT_CANCEL_DATE is null
                                                and TF.TARIFF_ID=CT.TARIFF_ID
                                                and nvl(TF.IS_AUTO_INTERNET, 0) = 1
                                         )  
                )
  loop
    begin
      --проверяем текущий тариф с тарифом в таблице логов подключений
      select Tf.TARIFF_CODE
         into v_tar
       from v_contracts ct,
               tariffs tf
      where CT.PHONE_NUMBER_FEDERAL=rec.phone
          and CT.CONTRACT_CANCEL_DATE is null
          and TF.TARIFF_ID=CT.TARIFF_ID
          and nvl(TF.IS_AUTO_INTERNET, 0) = 1;

      --определяем наличие данного тарифа в логах подключения
      select count(*) 
         into v_cnt
       from gprs_turn_log gp
      where gp.phone = rec.phone
         and GP.TARIFF_CODE = v_tar;

      --если тп нет
      if nvl(v_cnt, 0) = 0 then
        --проверяем чтобы открытая запись была с кодом тп
        select count(*)
           into v_num
          from gprs_turn_log gl
        where GL.PHONE = rec.phone
            and GL.DATE_OFF is null
            and exists (
                               select 1
                                 from tariffs ts
                               where TS.TARIFF_CODE = GL.TARIFF_CODE
                                   and nvl(Ts.IS_AUTO_INTERNET, 0) = 1
                           );
        
        --если крайнийи трафик расходовался на тарифе, то вносим тек. тп в историю подключений
        if nvl(v_num, 0) > 0 then
          v_res := ADD_OPT_IN_AUTO_CONNECT_INET(rec.phone, v_tar);
          commit;
        end if;
      end if; 
    exception
      when others then
        null;
    end;
  end loop;
end;