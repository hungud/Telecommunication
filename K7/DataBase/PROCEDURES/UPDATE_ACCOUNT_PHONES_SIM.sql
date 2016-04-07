CREATE OR REPLACE procedure UPDATE_ACCOUNT_PHONES_SIM IS                                          
  vRes VARCHAR2(1000);
  vPhone integer;
  oldSim VARCHAR2(18);
  
  --Version 2
  --
  --v.2 2015.12.15 Алексеев. Поправил косяк с записью данных в таблицу REPLACE_SIM_LOG. Данные писались без указания параметров
  
BEGIN
  --перебираем все л/с
  for rec in (select 
                   ACCOUNT_ID, 
                   n_method, 
                   is_collector
                 from accounts)
  loop 
    --проверяем возможность обновления
    if strInLike(23,nvl(rec.n_method,'0;'),';','()')=1 then
      --если л/с коллектора
      if rec.is_collector = 1 then
        vRes := BEELINE_API_PCKG.Collect_account_phone_SIM(rec.ACCOUNT_ID); 
      else
        vRes := BEELINE_API_PCKG.account_phone_SIM(rec.ACCOUNT_ID); 
      end if;          
    end if;
  end loop;
  
  --после того как загрузили номера SIM, обновляем информацию в dop_phones 
  for irec in (SELECT 
                      db.ACCOUNT_ID, 
                      db.PHONE_NUMBER, 
                      db.SIM_NUMBER, 
                      db.IMSI_NUMBER,
                      AC.ACCOUNT_NUMBER,
                      AC.COMPANY_NAME
                   FROM DB_LOADER_SIM db,
                             ACCOUNTS ac
                   WHERE DB.ACCOUNT_ID = AC.ACCOUNT_ID)
  loop
    --если в таблице phones_dop имеется запись по номеру, то обновляем dop
    select count(dop.PHONE_NUMBER)
    into vPhone
    from phones_dop dop
    where dop.PHONE_NUMBER = irec.PHONE_NUMBER; 
    oldSim := ''; 
    
    if vPhone = 1 then
      --определяем старый номер сим карты
      select pd.SIM
      into oldSim
      from phones_dop pd
      where pd.phone_number = irec.PHONE_NUMBER;  
      --обновление
      UPDATE PHONES_DOP dp
      SET dp.sim = irec.SIM_NUMBER, 
             dp.BAN = irec.ACCOUNT_NUMBER,
             dp.NAME_BAN = irec.COMPANY_NAME,
             dp.datetime_sim = trunc(sysdate)
      WHERE dp.PHONE_NUMBER = irec.PHONE_NUMBER;     
      commit;
    else
      --вставка  
       INSERT INTO PHONES_DOP (PHONE_NUMBER, BAN, SIM, NAME_BAN, DATETIME_SIM) 
       VALUES (irec.PHONE_NUMBER, irec.ACCOUNT_NUMBER, irec.SIM_NUMBER, irec.COMPANY_NAME, trunc(sysdate));
       commit;
    end if;  
    --Добавление в историю 
    insert into REPLACE_SIM_LOG(PHONE, OLD_SIM, NEW_SIM, REP_USER, REP_DATE, ERR, BSAL_ID, SIM_LOG_TYPE_ID)
    values(irec.PHONE_NUMBER, oldSim, irec.SIM_NUMBER, null, null, 0, null, 2);
    commit;      
  end loop;            
END;