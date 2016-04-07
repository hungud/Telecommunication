
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."MAIL_REQ_QUERY" IS
  pMESSAGE_TITLE VARCHAR2(300);
  pMAIL_TEXT     CLOB;
  pPARAM_NAME    varchar2(100);
  psend_count integer;
  prowid rowid;
cursor curp is
    select rowid,cbr.message_title,cbr.mail_text,cbr.param_name,cbr.send_count
      from MAIL_REQUEST cbr
     where cbr.date_send is null;
--#Version=1
begin
  open curp;
  loop
    FETCH curp
      into prowid,pMESSAGE_TITLE, pMAIL_TEXT,  pPARAM_NAME, psend_count;
    EXIT WHEN curp%NOTFOUND;
    begin
      send_sys_mail_multi(pMESSAGE_TITLE, pMAIL_TEXT, pPARAM_NAME,84);
      update MAIL_REQUEST mr set mr.send_count=psend_count+1,mr.date_send=sysdate
      where mr.rowid=prowid;
      commit;
      DBMS_LOCK.SLEEP(5);
    EXCEPTION
      WHEN others THEN
      update MAIL_REQUEST mr set mr.send_count=psend_count+1
      where mr.rowid=prowid;
      commit;
    end;
  end loop;
  close curp;
END;
