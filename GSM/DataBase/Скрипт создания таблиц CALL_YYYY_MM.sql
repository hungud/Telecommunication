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
  
  for i  IN  month_start .. month_end LOOP
    IF I<10 THEN
      D := '_0'||I;
      sM := '0'||I;
    ELSE
      D := '_'||I;
      sM := to_char(I);
    end if;
        
    D := 'CALL_'||yyyy||D;
        
    EXECUTE IMMEDIATE 'CREATE TABLESPACE '||D||' DATAFILE ''C:\ORACLE\ORADATA\GSMCORP\'||d||'_01.DBF'' SIZE 70M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED';

    EXECUTE IMMEDIATE 'CREATE TABLE '||D||'
    (
      DBF_ID       INTEGER,
      SUBSCR_NO    NUMBER(11),
      CH_SEIZ_DT   DATE,
      US_SEQ_N     NUMBER(9),
      AT_SOC       VARCHAR2(9 BYTE),
      AT_FT_CODE   VARCHAR2(6 BYTE),
      PC_PLAN_CD   VARCHAR2(9 BYTE),
      C_ACT_CD     VARCHAR2(1 BYTE),
      AT_CHG_AMT   NUMBER(11,2),
      CALLING_NO   VARCHAR2(21 BYTE),
      MESSAGE_TP   VARCHAR2(1 BYTE),
      SRV_FT_CD    VARCHAR2(6 BYTE),
      DURATION     VARCHAR2(8 BYTE),
      DATA_VOL     NUMBER(11,2),
      IMEI         NUMBER(15),
      CELL_ID      NUMBER(6),
      PROV_ID      VARCHAR2(8 BYTE),
      DIALED_DIG   VARCHAR2(21 BYTE),
      UOM          VARCHAR2(2 BYTE),
      DISCT_SOCS   VARCHAR2(100 BYTE),
      CALL_COST    NUMBER(11,2),
      DUR          NUMBER(11,2),
      MN_UNLIM     NUMBER(1),
      INSERT_DATE  DATE,
      
      CONSTRAINT '||D||'$AT_FT_CODE$F 
      FOREIGN KEY (AT_FT_CODE) 
      REFERENCES HOT_BILLING_CALL_AT_FT_CODE (AT_FT_CODE)
      ENABLE VALIDATE,
      
      CONSTRAINT '||D||'$C_ACT_CD$F 
      FOREIGN KEY (C_ACT_CD) 
      REFERENCES HOT_BILLING_CALL_C_ACT_CD (C_ACT_CD)
      ENABLE VALIDATE,
     
      CONSTRAINT '||D||'$DBF_ID$F 
      FOREIGN KEY (DBF_ID) 
      REFERENCES HOT_BILLING_FILES (HBF_ID)
      ENABLE VALIDATE,
     
      CONSTRAINT '||D||'$MESSAGE_TP$F 
      FOREIGN KEY (MESSAGE_TP) 
      REFERENCES HOT_BILLING_CALL_MESSAGE_TP (MESSAGE_TP)
      ENABLE VALIDATE,
      
      CONSTRAINT '||D||'$PROV_ID$F 
      FOREIGN KEY (PROV_ID) 
      REFERENCES HOT_BILLING_CALL_PROV_ID (PROV_ID)
      ENABLE VALIDATE,
      
      CONSTRAINT '||D||'$SRV_FT_CD$F 
      FOREIGN KEY (SRV_FT_CD) 
      REFERENCES HOT_BILLING_CALL_SRV_FT_CD (SRV_FT_CD)
      ENABLE VALIDATE,
      
      CONSTRAINT '||D||'$UOM$F 
      FOREIGN KEY (UOM) 
      REFERENCES HOT_BILLING_CALL_UOM (UOM)
      ENABLE VALIDATE
      
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

    EXECUTE IMMEDIATE 'COMMENT ON TABLE '||D||' IS ''Детализации звонков за 2015 - 11''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.DBF_ID IS ''ID файла источника''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.SUBSCR_NO IS ''Сотовый номер''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.CH_SEIZ_DT IS ''Дата_время совершения звонка''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.US_SEQ_N IS ''Порядковый номер записи (служебное поле)''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.AT_SOC IS ''Услуга, по которой определяется тарификация''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.AT_FT_CODE IS ''Код звонка в билайне''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.PC_PLAN_CD IS ''Тарифный план''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.C_ACT_CD IS ''Тип вызова''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.AT_CHG_AMT IS ''Стоимость''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.CALLING_NO IS ''Номер инициатора звонка''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.MESSAGE_TP IS ''Тип записи: домашний или роуминг''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.SRV_FT_CD IS ''Сервис (код)''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.DURATION IS ''Длительность''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.DATA_VOL IS ''Объем (для data)''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.IMEI IS ''IMEI (код)''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.CELL_ID IS ''Идентификатор соты''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.PROV_ID IS ''Роуминг-провайдер''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.DIALED_DIG IS ''Набранный номер''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.UOM IS ''Единица измерения''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN '||D||'.DISCT_SOCS IS ''Услуга-скидка''';

    EXECUTE IMMEDIATE 'CREATE INDEX I_'||D||'$DBF_ID ON '||D||' 
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


    EXECUTE IMMEDIATE 'CREATE INDEX I_'||D||'$SUBSC$AT_FT_CD ON '||D||'
      (SUBSCR_NO, AT_FT_CODE)
      LOGGING
      TABLESPACE '||D||'
      PCTFREE    10
      INITRANS   2
      MAXTRANS   255
      STORAGE    (
                INITIAL          64K
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               )
      NOPARALLEL
      COMPRESS 1';


    EXECUTE IMMEDIATE 'CREATE INDEX PK_'||D||' ON  '||D||'
      (SUBSCR_NO, CH_SEIZ_DT, US_SEQ_N)
      LOGGING
      TABLESPACE  '||D||'
      PCTFREE    10
      INITRANS   2
      MAXTRANS   255
      STORAGE    (
                INITIAL          64K
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               )
      NOPARALLEL
      COMPRESS 1';

    EXECUTE IMMEDIATE 'CREATE OR REPLACE TRIGGER TIU_'||D||' 
      BEFORE INSERT OR UPDATE ON '||D||' 
      REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
    DECLARE
      CURSOR C(pYEAR_MONTH IN INTEGER, pSUBSCR_NO IN VARCHAR2, pAT_FT_CODE IN VARCHAR2) IS
        SELECT CS.ROWID
          FROM CALL_STATISTICS CS
          WHERE CS.YEAR_MONTH = pYEAR_MONTH
            AND CS.SUBSCR_NO = pSUBSCR_NO
            AND CS.AT_FT_CODE = pAT_FT_CODE;
      vDUMMY C%ROWTYPE;
      vYEAR_MONTH INTEGER;
    BEGIN
      IF INSERTING AND :NEW.DUR IS NULL THEN
        :NEW.DURATION:=TO_CHAR(TO_DATE(SUBSTR(:NEW.DURATION, -6), ''HH24MISS''), ''HH24:MI:SS'');
        :NEW.DUR:=TO_NUMBER(SUBSTR(:NEW.DURATION, 1, 2)) * 3600 
                + TO_NUMBER(SUBSTR(:NEW.DURATION, 4, 2)) * 60
                + TO_NUMBER(SUBSTR(:NEW.DURATION, 7, 2)); 
        :NEW.INSERT_DATE:=SYSDATE;            
      END IF; 
      IF LENGTH(:NEW.CELL_ID) < 2 THEN
        :NEW.CELL_ID:=NULL;
      END IF;
      -- Обновление статистики
      vYEAR_MONTH:=TO_NUMBER(TO_CHAR(:NEW.CH_SEIZ_DT, ''YYYYMM''));  
      OPEN C(vYEAR_MONTH, :NEW.SUBSCR_NO, :NEW.AT_FT_CODE);
      FETCH C INTO vDUMMY;
      IF C%FOUND THEN
        IF INSERTING THEN      
          UPDATE CALL_STATISTICS CS
            SET CS.CALL_SUM = CS.CALL_SUM + :NEW.CALL_COST,
                CS.DATA_VOL = CS.DATA_VOL + :NEW.DATA_VOL,
                CS.ZERO_COST_DATA_VOL = CS.ZERO_COST_DATA_VOL 
                  + CASE WHEN :NEW.CALL_COST = 0 THEN :NEW.DATA_VOL ELSE 0 END,
                CS.DUR = CS.DUR + :NEW.DUR,
                CS.ZERO_COST_DUR = CS.ZERO_COST_DUR 
                  + CASE WHEN :NEW.CALL_COST = 0 THEN :NEW.DUR ELSE 0 END 
            WHERE CS.ROWID = vDUMMY.ROWID;
        ELSE
          UPDATE CALL_STATISTICS CS
            SET CS.CALL_SUM = CS.CALL_SUM + :NEW.CALL_COST - :OLD.CALL_COST,
                CS.DATA_VOL = CS.DATA_VOL + :NEW.DATA_VOL - :OLD.DATA_VOL,
                CS.ZERO_COST_DATA_VOL = CS.ZERO_COST_DATA_VOL 
                  + CASE WHEN :NEW.CALL_COST = 0 THEN :NEW.DATA_VOL ELSE 0 END 
                  - CASE WHEN :OLD.CALL_COST = 0 THEN :OLD.DATA_VOL ELSE 0 END,
                CS.DUR = CS.DUR + :NEW.DUR - :OLD.DUR,
                CS.ZERO_COST_DUR = CS.ZERO_COST_DUR 
                  + CASE WHEN :NEW.CALL_COST = 0 THEN :NEW.DUR ELSE 0 END 
                  - CASE WHEN :OLD.CALL_COST = 0 THEN :OLD.DUR ELSE 0 END 
            WHERE CS.ROWID = vDUMMY.ROWID;
        END IF;
      ELSE
        INSERT INTO CALL_STATISTICS(YEAR_MONTH, SUBSCR_NO, AT_FT_CODE, CALL_SUM, 
                                    DATA_VOL, ZERO_COST_DATA_VOL, DUR, ZERO_COST_DUR)
          VALUES(vYEAR_MONTH, :NEW.SUBSCR_NO, :NEW.AT_FT_CODE, :NEW.CALL_COST,
                 :NEW.DATA_VOL, CASE WHEN :NEW.CALL_COST = 0 THEN :NEW.DATA_VOL ELSE 0 END, 
                 :NEW.DUR, CASE WHEN :NEW.CALL_COST = 0 THEN :NEW.DUR ELSE 0 END);
      END IF;
      --       
    END;';

    EXECUTE IMMEDIATE 'CREATE OR REPLACE TRIGGER TD_'||D||'  
      BEFORE DELETE ON '||D||'  
      REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
    BEGIN
      IF :OLD.CALL_COST <> 0 THEN
        UPDATE CALL_STATISTICS CS
          SET CS.CALL_SUM = CS.CALL_SUM - :OLD.CALL_COST,
              CS.DATA_VOL = CS.DATA_VOL - :OLD.DATA_VOL,
              CS.ZERO_COST_DATA_VOL = CS.ZERO_COST_DATA_VOL
                - CASE WHEN :OLD.CALL_COST = 0 THEN :OLD.DATA_VOL ELSE 0 END,
              CS.DUR = CS.DUR - :OLD.DUR,
              CS.ZERO_COST_DUR = CS.ZERO_COST_DUR
                - CASE WHEN :OLD.CALL_COST = 0 THEN :OLD.DUR ELSE 0 END 
          WHERE CS.YEAR_MONTH = TO_NUMBER(TO_CHAR(:OLD.CH_SEIZ_DT, ''YYYYMM''))
            AND CS.SUBSCR_NO = :OLD.SUBSCR_NO
            AND CS.AT_FT_CODE = :OLD.AT_FT_CODE;
      END IF;
    END;';


    EXECUTE IMMEDIATE 'GRANT SELECT ON '||D||' TO CRM_USER';

    EXECUTE IMMEDIATE 'GRANT SELECT ON '||D||' TO ROAMING_RETARIF_CHECKER';

    EXECUTE IMMEDIATE 'GRANT DELETE, SELECT, UPDATE ON '||D||' TO LONTANA_ROLE';

    EXECUTE IMMEDIATE 'GRANT SELECT ON '||D||' TO LONTANA_ROLE_RO';

    --создаем строку в таблице HOT_BILLING_MONTH
    merge INTO HOT_BILLING_MONTH hb
    using (select yyyy||sM YEAR_MONTH from dual ) t
    on
      (hb.YEAR_MONTH = t.YEAR_MONTH)
    when not matched then
      insert (YEAR_MONTH, DB) VALUES (t.YEAR_MONTH, 1)
    ;

  end loop;
   commit;
  DBMS_OUTPUT.PUT_LINE('завершено');
end;