
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."TEST_SMS_ALARM_PHONE" (subscr  in varchar2,
                                                 PDBF_ID in integer) IS
  flag                integer;
  SMS                 varchar2(2000);
  phone_num           varchar2(11);
  tarif_id            int;
  SMS_TEXT_MN_ROAMING varchar2(140);
  vphone_num          varchar2(64); 

  cursor curp1 is
    SELECT regexp_substr(str, '[^,]+', 1, level) str
      FROM (SELECT MS_params.GET_PARAM_VALUE('PHONE_NOTICE_ROAM') str
              FROM dual) t
    CONNECT BY instr(str, ',', 1, level - 1) > 0;
  cursor curp is
    SELECT regexp_substr(str, '[^,]+', 1, level) str
      FROM (SELECT MS_params.GET_PARAM_VALUE('PHONE_NOTICE_CALL') str
              FROM dual) t
    CONNECT BY instr(str, ',', 1, level - 1) > 0;

  cursor curp_MN_ROAMING is
    SELECT regexp_substr(str, '[^,]+', 1, level) str
      FROM (SELECT MS_params.GET_PARAM_VALUE('SEND_PNUM_MN_ROAMING') str
              FROM dual) t
    CONNECT BY instr(str, ',', 1, level - 1) > 0;

begin
  select count(*)
    into flag
    from hot_billing_temp_call htc, DB_LOADER_ACCOUNT_PHONES dlp
   where ((Instr(Lower(AT_FT_DESC), 'internet') > 0) or
         (Instr(Lower(AT_FT_DESC), 'gprs') > 0) or
         (Instr(Lower(AT_FT_DESC), 'интернет') > 0) or
         (Instr(Lower(AT_FT_DESC), 'wap') > 0))
     and to_number(substr(AT_CHG_AMT,
                          0,
                          decode(instr(AT_CHG_AMT, ',00') - 1,
                                 -1,
                                 length(AT_CHG_AMT),
                                 instr(AT_CHG_AMT, ',00') - 1)),
                   '999999D99',
                   ' NLS_NUMERIC_CHARACTERS = '',.''') > 0
     and dlp.phone_number = htc.subscr_no
     and dlp.year_month = to_number(substr(htc.ch_seiz_dt, 1, 6))
     and GET_PHONE_TARIFF_ID(Dlp.PHONE_NUMBER,
                             Dlp.CELL_PLAN_CODE,
                             Dlp.LAST_CHECK_DATE_TIME) in
         (SELECT to_number(regexp_substr(str, '[^,]+', 1, level)) str
            FROM (SELECT MS_params.GET_PARAM_VALUE('TP_NOTIFY_GPRS') str
                    FROM dual) t
          CONNECT BY instr(str, ',', 1, level - 1) > 0)
     and htc.subscr_no = subscr
     and htc.dbf_id = PDBF_ID
     and not exists
   (select 1
            from ALARM_PHONE_LOG apl
           where apl.phone = htc.subscr_no
             and trunc(apl.date_insert, 'mm') = trunc(sysdate, 'mm')
             and apl.type_alarm = 1);
  if flag > 0 then
    select GET_PHONE_TARIFF_ID(phone_number, DD.CELL_PLAN_CODE)
      Into tarif_id
      from db_loader_account_phones DD
     where phone_number = subscr
       and year_month = to_char(sysdate, 'YYYYMM');
    if Instr(MS_params.GET_PARAM_VALUE('TP_NOTIFY_GPRS_ISKL'),
             to_char(tarif_id)) > 0 then
      SMS := LOADER3_pckg.SEND_SMS(subscr,
                                   'SMS-info',
                                   MS_params.GET_PARAM_VALUE('MES_NOTIFY_GPRS_ISKL'));
    else
      SMS := LOADER3_pckg.SEND_SMS(subscr,
                                   'SMS-info',
                                   MS_params.GET_PARAM_VALUE('MES_NOTIFY_GPRS'));
    end if;
  
    insert into ALARM_PHONE_LOG values (subscr, null, 1);
    commit;
  end if;
  select count(*)
    into flag
    from hot_billing_temp_call htc, DB_LOADER_ACCOUNT_PHONES dlp
   where Instr(Lower(AT_FT_DESC), 'sms') = 0
     and Instr(Lower(AT_FT_DESC), 'смс') = 0
     and Instr(Lower(AT_FT_DESC), 'короткие сообщения') = 0
     and Instr(Lower(AT_FT_DESC), 'mms') = 0
     and Instr(Lower(AT_FT_DESC), 'ммс') = 0
     and Instr(Lower(AT_FT_DESC), 'internet') = 0
     and Instr(Lower(AT_FT_DESC), 'gprs') = 0
     and Instr(Lower(AT_FT_DESC), 'интернет') = 0
     and Instr(Lower(AT_FT_DESC), 'wap') = 0
     and to_number(substr(AT_CHG_AMT,
                          0,
                          decode(instr(AT_CHG_AMT, ',00') - 1,
                                 -1,
                                 length(AT_CHG_AMT),
                                 instr(AT_CHG_AMT, ',00') - 1)),
                   '999999D99',
                   ' NLS_NUMERIC_CHARACTERS = '',.''') > 0
     and mod(to_number(substr(AT_CHG_AMT,
                              0,
                              decode(instr(AT_CHG_AMT, ',00') - 1,
                                     -1,
                                     length(AT_CHG_AMT),
                                     instr(AT_CHG_AMT, ',00') - 1)),
                       '999999D99',
                       ' NLS_NUMERIC_CHARACTERS = '',.'''),
             5) = 0
     and dlp.phone_number = htc.subscr_no
     and dlp.year_month = to_number(substr(htc.ch_seiz_dt, 1, 6))
     and GET_PHONE_TARIFF_ID(Dlp.PHONE_NUMBER,
                             Dlp.CELL_PLAN_CODE,
                             Dlp.LAST_CHECK_DATE_TIME) in
         (SELECT to_number(regexp_substr(str, '[^,]+', 1, level)) str
            FROM (SELECT MS_params.GET_PARAM_VALUE('TP_NOTIFY_CALL') str
                    FROM dual) t
          CONNECT BY instr(str, ',', 1, level - 1) > 0)
     and htc.subscr_no = subscr
     and htc.dbf_id = PDBF_ID
     and not exists
   (select 1
            from ALARM_PHONE_LOG apl
           where apl.phone = htc.subscr_no
             and trunc(apl.date_insert, 'mm') = trunc(sysdate, 'mm')
             and apl.type_alarm = 2);
  if flag > 0 then
    select count(*)
      into flag
      from hot_billing_temp_call htc, DB_LOADER_ACCOUNT_PHONES dlp
     where Instr(Lower(AT_FT_DESC), 'sms') = 0
       and Instr(Lower(AT_FT_DESC), 'смс') = 0
       and Instr(Lower(AT_FT_DESC), 'короткие сообщения') = 0
       and Instr(Lower(AT_FT_DESC), 'mms') = 0
       and Instr(Lower(AT_FT_DESC), 'ммс') = 0
       and Instr(Lower(AT_FT_DESC), 'internet') = 0
       and Instr(Lower(AT_FT_DESC), 'gprs') = 0
       and Instr(Lower(AT_FT_DESC), 'интернет') = 0
       and Instr(Lower(AT_FT_DESC), 'wap') = 0
       and Instr(nvl((select sv.feature_de
                       from services sv
                      where sv.feature_co = AT_FT_CODE),
                     AT_FT_DESC),
                 'CF') > 0
       and to_number(substr(AT_CHG_AMT,
                            0,
                            decode(instr(AT_CHG_AMT, ',00') - 1,
                                   -1,
                                   length(AT_CHG_AMT),
                                   instr(AT_CHG_AMT, ',00') - 1)),
                     '999999D99',
                     ' NLS_NUMERIC_CHARACTERS = '',.''') > 0
       and mod(to_number(substr(AT_CHG_AMT,
                                0,
                                decode(instr(AT_CHG_AMT, ',00') - 1,
                                       -1,
                                       length(AT_CHG_AMT),
                                       instr(AT_CHG_AMT, ',00') - 1)),
                         '999999D99',
                         ' NLS_NUMERIC_CHARACTERS = '',.'''),
               5) = 0
       and dlp.phone_number = htc.subscr_no
       and dlp.year_month = to_number(substr(htc.ch_seiz_dt, 1, 6))
       and GET_PHONE_TARIFF_ID(Dlp.PHONE_NUMBER,
                               Dlp.CELL_PLAN_CODE,
                               Dlp.LAST_CHECK_DATE_TIME) in
           (SELECT to_number(regexp_substr(str, '[^,]+', 1, level)) str
              FROM (SELECT MS_params.GET_PARAM_VALUE('TP_NOTIFY_CALL') str
                      FROM dual) t
            CONNECT BY instr(str, ',', 1, level - 1) > 0)
       and htc.subscr_no = subscr
       and htc.dbf_id = PDBF_ID;
    if flag = 0 then
      open curp;
      loop
        FETCH curp
          into phone_num;
        EXIT WHEN curp%NOTFOUND;
        SMS := LOADER3_pckg.SEND_SMS(phone_num,
                                     'SMS-info',
                                     'У абонента ' || subscr ||
                                     ' закончился пакет plus.');
      end loop;
      close curp;
      insert into ALARM_PHONE_LOG values (subscr, null, 2);
      commit;
    else
      select count(*)
        into flag
        from ALARM_PHONE_LOG apl
       where apl.phone = subscr
         and trunc(apl.date_insert) = trunc(sysdate)
         and apl.type_alarm = 3;
      if flag = 0 then
        SMS := LOADER3_pckg.SEND_SMS(subscr,
                                     'SMS-info',
                                     MS_params.GET_PARAM_VALUE('MES_NOTIFY_CALL'));
        insert into ALARM_PHONE_LOG values (subscr, null, 3);
        commit;
      end if;
    end if;
  end if;

  -- МН роуминг без санкции
  -- МН роуминг без санкции
  select count(*)
    into flag
    from hot_billing_temp_call    htc,
         DB_LOADER_ACCOUNT_PHONES dlp,
         contracts                c,
         roaming_svc_ref          r
   where dlp.phone_number = htc.subscr_no
     and dlp.year_month = to_number(substr(htc.ch_seiz_dt, 1, 6))
        
     and htc.subscr_no = subscr
     and htc.dbf_id = PDBF_ID
     and c.phone_number_federal = htc.subscr_no
     and htc.data_vol != 0
     and nvl(c.mn_roaming, 0) = 0
     and r.roaming_svc_cod = htc.at_ft_code;

  if flag > 0 then
  
    for z in curp_MN_ROAMING loop
         
     SMS_TEXT_MN_ROAMING:=replace(MS_params.GET_PARAM_VALUE('SEND_TEXT_MN_ROAMING'),'%%',subscr);
       
       SMS := LOADER3_pckg.SEND_SMS(phone_num,
                                 'SMS-info',
                                 SMS_TEXT_MN_ROAMING);
                               
    insert into ALARM_PHONE_LOG values (subscr, null, 4); -- 4 - мн роуминг без санкции

   commit;
    
  end loop;
    
  
  end if;

end;
