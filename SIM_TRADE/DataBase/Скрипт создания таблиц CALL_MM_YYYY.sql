DECLARE 
  D VARCHAR2(30);
  sM varchar2(2);
  month_start  Integer;
  month_end  Integer;
  yyyy Integer;
begin
  
  month_start := 1;
  month_end := 12;
  yyyy := :yyyy;
  
  STOP_JOB_PCKG.STOP_JOB(2);
  
  for i  IN  month_start .. month_end
  LOOP
   
    IF I<10 THEN
      D := 'CALL_0'||I;
      sM := '0'||I;
    ELSE
      D := 'CALL_'||I;
      sM := to_char(I);
    end if;
        
    D := D ||'_'||yyyy;
        
    DBMS_OUTPUT.PUT_LINE(d);

    EXECUTE IMMEDIATE 'CREATE TABLESPACE '||D||' DATAFILE   ''/u02/app/oracle/oradata/SIMTRADE/'||d||'_0001.DBF'' SIZE 70M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED';

    EXECUTE IMMEDIATE 'CREATE TABLE '||D||'
    (
      SUBSCR_NO         VARCHAR2(11 BYTE),
      START_TIME        DATE,
      AT_FT_CODE        VARCHAR2(6 BYTE),
      DBF_ID            NUMBER(38),
      CALL_COST         NUMBER,
      COSTNOVAT         NUMBER,
      DUR               NUMBER,
      IMEI              VARCHAR2(15 BYTE),
      SERVICETYPE       VARCHAR2(1 BYTE),
      SERVICEDIRECTION  NUMBER(1),
      ISROAMING         VARCHAR2(1 BYTE),
      ROAMINGZONE       VARCHAR2(6 BYTE),
      CALL_DATE         VARCHAR2(10 BYTE),
      CALL_TIME         VARCHAR2(8 BYTE),
      DURATION          VARCHAR2(8 BYTE),
      DIALED_DIG        VARCHAR2(21 BYTE),
      AT_FT_DE          VARCHAR2(240 BYTE),
      AT_FT_DESC        VARCHAR2(240 BYTE),
      CALLING_NO        VARCHAR2(21 BYTE),
      AT_CHG_AMT        VARCHAR2(14 BYTE),
      DATA_VOL          VARCHAR2(14 BYTE),
      CELL_ID           VARCHAR2(6 BYTE),
      MN_UNLIM          NUMBER(1),
      INSERT_DATE       DATE,
      COST_CHNG         NUMBER
    )
    TABLESPACE '||D||'
    PCTUSED    40
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          16K
                NEXT             8K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               )
    LOGGING 
    NOCOMPRESS 
    NOCACHE
    NOPARALLEL
    MONITORING';

    EXECUTE IMMEDIATE 'COMMENT ON TABLE '||D||' IS ''äåòàëèçàöèÿ ïî ïåðèîäó''';

    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.SUBSCR_NO IS ''ÍÎÌÅÐ''';

    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.START_TIME IS ''ÄÀÒÀ È ÂÐÅÌß ÇÂÎÍÊÀ''';

    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.AT_FT_CODE IS ''ÊÎÄ ÇÂÎÍÊÀ Â ÁÈËÀÉÍÅ''';

    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.DBF_ID IS ''ID ÔÀÉËÀ ÈÑÒÎ×ÍÈÊÀ''';

    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.CALL_COST IS ''ÑÒÎÈÌÎÑÒÜ ÇÂÎÍÊÀ''';

    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.COSTNOVAT IS ''ÑÒÎÈÌÎÑÒÜ ÇÂÎÍÊÀ ÁÅÇ ÍÄÑ''';

    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.DUR IS ''ÄËÈÒÅËÜÍÎÑÒÜ''';

    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.IMEI IS ''ÊÎÄ ÑÈÌ-ÊÀÐÒÛ ÈËÈ ÀÏÏÀÐÀÒÀ''';

    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.SERVICETYPE IS ''ÒÈÏ ÇÂÎÍÊÀ''';

    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.SERVICEDIRECTION IS ''ÍÀÏÐÀÂËÅÍÈÅ ÇÂÎÍÊÀ (1-ÈÑÕ, 2 -ÂÕÎÄ)''';

    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.ISROAMING IS ''ÏÐÈÇÍÀÊ ÐÎÓÌÈÍÃÀ''';

    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.ROAMINGZONE IS ''ÇÎÍÀ ÐÎÓÌÈÍÃÀ''';

    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.CALL_DATE IS ''ÄÀÒÀ ÇÂÎÍÊÀ''';

    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.CALL_TIME IS ''ÂÐÅÌß ÇÂÎÍÊÀ''';

    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.DURATION IS ''ÄËÈÒÅËÜÍÎÑÒÜ''';

    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.DIALED_DIG IS ''ÑÎÁÅÑÅÄÍÈÊ''';

    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.AT_FT_DE IS ''ÊÐÀÒÊÈÉ ÊÎÌÌÅÍÒÀÐÈÉ ÒÈÏÀ ÇÂÎÍÊÀ''';

    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.AT_FT_DESC IS ''ÊÎÌÌÅÍÒÀÐÈÉ ÒÈÏÀ ÇÂÎÍÊÀ''';

    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.CALLING_NO IS ''ÇÂÎÍÈÂØÈÉ ÍÎÌÅÐ''';

    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.DATA_VOL IS ''ÄËÈÒÅËÜÍÎÑÒÜ''';

    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.MN_UNLIM IS ''ÏÐÈÇÍÀÊ ÌÅÆÄÓÍÀÐÎÄÍÎÃÎ ÁÅÇËÈÌÈÒÀ''';

    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.INSERT_DATE IS ''ÄÀÒÀ ÂÑÒÀÂÊÈ ÇÂÎÍÊÀ''';

    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.COST_CHNG IS ''ÄÎÁÀÂÎ×ÍÀß ÑÒÎÈÌÎÑÒÜ ÇÂÎÍÊÀ''';


    EXECUTE IMMEDIATE 'CREATE INDEX '||D||'$DBF_ID$IDX ON '||D||' 
    (DBF_ID)
    compress
    LOGGING
    TABLESPACE '||D||'
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          10M
                NEXT             10M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               )
    NOPARALLEL';


    EXECUTE IMMEDIATE 'CREATE INDEX '||D||'$SUBSCR#MN$IDX ON '||D||'
    (SUBSCR_NO, MN_UNLIM)
    compress 2
    LOGGING
    TABLESPACE '||D||'
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          10M
                NEXT             10M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               )
    NOPARALLEL';


    EXECUTE IMMEDIATE 'CREATE INDEX '||D||'$SUBSCR_NO$IDX ON '||D||'
    (SUBSCR_NO)
    compress
    LOGGING
    TABLESPACE '||D||'
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          10M
                NEXT             10M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               )
    NOPARALLEL';


    EXECUTE IMMEDIATE 'CREATE INDEX '||D||'$SUBSCR#STIME$IDX ON '||D||'
    (SUBSCR_NO, START_TIME)
    compress 1
    LOGGING
    TABLESPACE '||D||'
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          10M
                NEXT             10M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               )
    NOPARALLEL';


    EXECUTE IMMEDIATE 'CREATE INDEX '||D||'$DBF$SUBSCR$COST ON '||D||'
    (DBF_ID, SUBSCR_NO, CALL_COST)
    COMPRESS 1
    LOGGING
    TABLESPACE '||D||'
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               )
    NOPARALLEL';

    EXECUTE IMMEDIATE 'ALTER TABLE '||D||' ADD (
      CONSTRAINT '||D||'$START_TIME$N
      CHECK ("START_TIME" IS NOT NULL))';

    EXECUTE IMMEDIATE 'ALTER TABLE '||D||' ADD (
      CONSTRAINT '||D||'$DBF_ID$F 
      FOREIGN KEY (DBF_ID) 
      REFERENCES HOT_BILLING_FILES (HBF_ID))';

    EXECUTE IMMEDIATE 'GRANT DELETE, SELECT, UPDATE ON '||D||' TO SIM_TRADE_ROLE';

    EXECUTE IMMEDIATE 'GRANT SELECT ON '||D||' TO SIM_TRADE_ROLE_RO';

    --ñîçäàåì ñòðîêó â òàáëèöå HOT_BILLING_MONTH
    INSERT INTO HOT_BILLING_MONTH (YEAR_MONTH, DB) VALUES (yyyy||sM, 1);

  end loop;
  commit;
  DBMS_OUTPUT.PUT_LINE('çàâåðøåíî');
end;