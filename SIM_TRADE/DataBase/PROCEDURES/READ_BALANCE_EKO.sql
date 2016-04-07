CREATE OR REPLACE PROCEDURE READ_BALANCE_EKO(
  pPHONE IN VARCHAR2
  ) IS
  vX XMLTYPE;
  vURL VARCHAR2(500 CHAR);  
  vSUM NUMBER;
  vFILE_NAME VARCHAR2(300 CHAR);
BEGIN  
  DELETE FROM ABONENT_BALANCE_ROWS; -- ??????? ??? TRUNCATE
  vURL:='https://gsmcorporacia:sdv4f5gSDjh49ddsPFg@gt287.ekomobile.ru:9084/cgi-bin/iface.cgi?action=getpaymentsANDphone=(PHONE_NUMBER)';
  vURL:=REPLACE(vURL, '(PHONE_NUMBER)', pPHONE);
  BEGIN
    vFILE_NAME:=loader3_pckg.GET_PARTNER_URL(vURL);
    IF INSTR(vFILE_NAME, pPHONE) > 0 THEN 
      select XMLTYPE(READ_XML_URL_FILE(vFILE_NAME)) into vX from DUAL; 
      for rec in(
        SELECT EXTRACTVALUE(VALUE(TA), '*/phone') PHONE,  
               EXTRACTVALUE(VALUE(TA), '*/agent_date') AGENT_DATE,  
               EXTRACTVALUE(VALUE(TA), '*/sum') SUMMA,   
               EXTRACTVALUE(VALUE(TA), '*/note') NOTE,  
               VALUE(TA) VALUE_XML                        
          FROM TABLE(XMLSequence((vX).extract('response/data/*'))) TA )
      loop
        IF REC.PHONE IS NOT NULL THEN
          BEGIN
            vSUM:=TO_NUMBER(REC.SUMMA);
          exception
            WHEN OTHERS THEN
              vSUM:=TO_NUMBER(REPLACE(REC.SUMMA, '.', ','));
          END;
          insert into ABONENT_BALANCE_ROWS (ROW_DATE, ROW_COST, ROW_COMMENT)
            values (TO_DATE(SUBSTR(REC.AGENT_DATE, 1, 8), 'YYYYMMDD') ,   vSUM,  REC.NOTE );
        END IF;
      end loop;
     --dbms_output.put_line(i);
      COMMIT;
    ELSE
      insert into ABONENT_BALANCE_ROWS (ROW_DATE, ROW_COST, ROW_COMMENT)
        values (TRUNC(SYSDATE) ,   0,  'Ошибка выполнения.' );
      commit;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      insert into ABONENT_BALANCE_ROWS (ROW_DATE, ROW_COST, ROW_COMMENT)
        values (TRUNC(SYSDATE),   0,  'Ошибка выполнения.' );
      commit;
  END;
END;
/
