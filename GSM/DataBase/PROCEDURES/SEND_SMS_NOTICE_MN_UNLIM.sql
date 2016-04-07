CREATE OR REPLACE PROCEDURE SEND_SMS_NOTICE_MN_UNLIM AS
  --
  --#Version=1
  --
  vYEAR_MONTH integer;
  SMS         VARCHAR2(2000);
  cursor cur is
    select muv.phone_number,
           sv.sql_text,
           sv.notice_volume_text,
           muv.rowid,
           case
             when ((muv.mnunlimd / 60 >= sv.notice_volume and
                  muv.mnunlimd / 60 < sv.volume_exceeded) and
                  nvl(muv.mnunlimd_sms, 0) = 0 and sv.service_volume_id = 1) then
              1
             when ((muv.mnunlimt / 60 >= sv.notice_volume and
                  muv.mnunlimt / 60 < sv.volume_exceeded) and
                  nvl(muv.mnunlimt_sms, 0) = 0 and sv.service_volume_id = 2) then
              2
             when ((muv.mnunlimo / 60 >= sv.notice_volume and
                  muv.mnunlimo / 60 < sv.volume_exceeded) and
                  nvl(muv.mnunlimo_sms, 0) = 0 and sv.service_volume_id = 3) then
              3
           end case
      from service_volume sv, mn_unlim_volume muv
     where muv.YEAR_MONTH = vYEAR_MONTH
       and (((muv.mnunlimd / 60 >= sv.notice_volume and
           muv.mnunlimd / 60 < sv.volume_exceeded) and
           nvl(muv.mnunlimd_sms, 0) = 0 and sv.service_volume_id = 1) or
           ((muv.mnunlimt / 60 >= sv.notice_volume and
           muv.mnunlimt / 60 < sv.volume_exceeded) and
           nvl(muv.mnunlimt_sms, 0) = 0 and sv.service_volume_id = 2) or
           ((muv.mnunlimo / 60 >= sv.notice_volume and
           muv.mnunlimo / 60 < sv.volume_exceeded) and
           nvl(muv.mnunlimo_sms, 0) = 0 and sv.service_volume_id = 3));
  SQL_T       varchar2(3000);
  sms_text    varchar2(3000);
  sms_pretext varchar2(3000);
  phone_num   varchar2(10);
  roww        rowid;
  smsn        number(1);

begin
  vYEAR_MONTH := to_number(to_char(sysdate, 'yyyy')) * 100 +
                 to_number(to_char(sysdate, 'mm'));
  OPEN CUR;
  LOOP
    FETCH CUR
      into phone_num, SQL_T, sms_pretext, roww, smsn;
    EXIT WHEN CUR%NOTFOUND;
    SQL_T := REPLACE(SQL_T, '%ph_num%', '''' || phone_num || '''');
    SQL_T := REPLACE(SQL_T, '%y_mo%', to_char(vYEAR_MONTH));
    begin
      execute immediate SQL_T
        into sms_text;
    exception
      when others then
        sms_text := '0';
    end;
    if sms_text <> '0' then
      sms_text := REPLACE(sms_pretext, '%SQL_TEXT%', sms_text);
      SMS      := LOADER3_pckg.SEND_SMS(phone_num,
                                        'Смс-оповещение',
                                        sms_text);
      INSERT INTO SEND_SMS_NOTICE_MN_UNLIM_LOG
        (phone_number, SEND_DATE_TIME, ERROR_TEXT)
      VALUES
        (phone_num, sysdate, SMS);
      IF SMS IS NULL THEN
        case smsn
          when 1 then
            update mn_unlim_volume mvv
               set mvv.mnunlimd_sms = 1
             where mvv.rowid = roww;
          when 2 then
            update mn_unlim_volume mvv
               set mvv.mnunlimt_sms = 1
             where mvv.rowid = roww;
          when 3 then
            update mn_unlim_volume mvv
               set mvv.mnunlimo_sms = 1
             where mvv.rowid = roww;
        end case;
      end if;
      COMMIT;
    end if;
  end loop;
  close cur;
END;
