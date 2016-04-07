
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."LOAD_XML_FILE2" IS
BEGIN
  delete from temp9 where str2 like '%.gz';
  commit;
  for rec in (select * from temp9 where str1 is null) loop
    LOAD_XML_FILE(rec.str2);
    delete temp9 
      where temp9.str2 = rec.str2
        and temp9.str1 is null;
    commit;
  end loop;
  for rec in (select * from temp9 where str1 = 1) loop
    insert into collector_bill_xml(file_name, xml_txt)
      select str2, clb
        from temp9 
        where temp9.str2 = rec.str2
          and temp9.str1 = 1;
    delete temp9 
      where temp9.str2 = rec.str2
        and temp9.str1 = 1;
    commit;
  end loop;
END; 