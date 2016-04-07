
  CREATE OR REPLACE PROCEDURE "LONTANA"."READ_STATUS_PHONES_EKO" IS
cl clob;  
x xmltype;
i integer;
j integer;
  vURL VARCHAR2(500 CHAR);
  vfn VARCHAR2(1000 CHAR);
  vYEAR_MONTH INTEGER;
begin
i:=0;
 --dbms_output.put_line(i);  
  vYEAR_MONTH:=TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMM'));
  DELETE FROM DB_LOADER_ACCOUNT_PHONES AP
    WHERE AP.ACCOUNT_ID = 225
      AND AP.YEAR_MONTH = vYEAR_MONTH; 
  vURL:='https://gsmcorporacia:sdv4f5gSDjh49ddsPFg@gt287.ekomobile.ru:9084/cgi-bin/iface.cgi?action=getphones';
  --vURL:='http://5.9.166.87/state.xml';
  vfn:= loader3_pckg.GET_PARTNER_URL(vURL);
 select XMLTYPE(READ_XML_URL_FILE( vfn)) into x from DUAL; 
 for rec in(
  SELECT EXTRACTVALUE(VALUE(TA), '*/phone') PHONE_NUMBER,  
         EXTRACTVALUE(VALUE(TA), '*/tarif/name') code,   
         EXTRACTVALUE(VALUE(TA), '*/status/id') st,  
         VALUE(TA) VALUE_XML                        
    FROM TABLE(XMLSequence((x).extract('response/data/*'))) TA 
  )
  loop
    i:=i+1;
    if rec.st = '10' then
      j:=0;
    else
      j:=1;
    end if;
   /* insert into DB_LOADER_ACCOUNT_PHONES(ACCOUNT_ID,YEAR_MONTH,PHONE_NUMBER,PHONE_IS_ACTIVE,CELL_PLAN_CODE)
                                  values(225,      vYEAR_MONTH,rec.phone_number, j,         rec.code );*/
    db_loader_pckg.ADD_ACCOUNT_PHONE(trunc(vYEAR_MONTH/100),
                                     vYEAR_MONTH-trunc(vYEAR_MONTH/100)*100,
                                     'Экомобайл',
                                     rec.phone_number, 
                                     j,
                                     rec.code,
                                     null,
                                     null,
                                     1,
                                     0,
                                     0,
                                     0);
   -- if rec.st <>'10' then
    --dbms_output.put_line(to_char(i)||'~'||rec.phone_number||'~'||rec.code||'~'||rec.st);
   -- end if;
  end loop;
 --dbms_output.put_line(i);
  COMMIT;
end;