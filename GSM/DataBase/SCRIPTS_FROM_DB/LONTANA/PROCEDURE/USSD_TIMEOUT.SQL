
  CREATE OR REPLACE PROCEDURE "LONTANA"."USSD_TIMEOUT" is

  XCPAXAction        VARCHAR2(50);
  XCPAMSGID          VARCHAR2(50);
  xcpaussdsession    VARCHAR2(3);
  msisdn             VARCHAR2(11);
  ussd_cur_date      date;
  rowid_USSD_CURRENT rowid;
  id_ussd            integer;
  cursor cur is
    select uc.rowid,
           uc.id,
           uc.update_date,
           uc.msisdn,
           uc.xcpaussdsession,
           uc.xcpaxaction,
           uc.xcpamsgid
      from USSD_CURRENT uc
     where uc.update_date <= sysdate -90 / 86400
     or uc.insert_date <= sysdate -300 / 86400;
  --#Version=1
BEGIN
open cur;
  LOOP
    FETCH cur
      INTO rowid_USSD_CURRENT,
           id_ussd,
           ussd_cur_date,
           msisdn,
           xcpaussdsession,
           XCPAXAction,
           XCPAMSGID;
    EXIT WHEN cur%NOTFOUND;
    IF (MS_CONSTANTS.GET_CONSTANT_VALUE('USSD_LOG_LEVEL') = '2') or
       (MS_CONSTANTS.GET_CONSTANT_VALUE('USSD_LOG_LEVEL') = '1') then
      insert into ussd_log
        (id, xcpaxaction, xcpamsgid, ussd_date, msisdn, error_text,TYPE_LOG)
      values
        (id_ussd,
         XCPAXAction,
         XCPAMSGID,
         ussd_cur_date,
         msisdn,
         'USSD TIMEOUT, xcpaussdsession:' || xcpaussdsession,
         3);
      commit;
    end if;
    delete USSD_CURRENT uc where uc.rowid = rowid_USSD_CURRENT;
    commit;
  END LOOP;
close cur;
EXCEPTION
  WHEN others THEN
    null;
END;
