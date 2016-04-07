
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."HOTBILLINGGETDETAILCLOB" (pmsisdn in varchar2)
    return clob as
   clob_pointer CLOB ;
   v_buf VARCHAR2(400);
   cursor curm is
   select hb.col_value from hot_billing hb
   where hb.subscr_no=pmsisdn
   order by hb.call_time;
 BEGIN
   open curm;
   DBMS_LOB.CREATETEMPORARY(clob_pointer, TRUE);
   loop
    FETCH curm
      into v_buf;
    EXIT WHEN curm%NOTFOUND;
  v_buf :=v_buf||chr(13)||chr(10);
  DBMS_LOB.writeappend(clob_pointer,length(v_buf),v_buf);
   END LOOP;
 -- DBMS_LOB.CLOSE (clob_pointer);
  return clob_pointer;
END;
