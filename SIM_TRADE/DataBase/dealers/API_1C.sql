CREATE OR REPLACE PACKAGE WWW_DEALER.API_1C AS
--
--#Version=4 
--
-- ��������� ������� ������������
  PROCEDURE UPLOAD_BALANCE_CHANGE(
    DATAFILE IN VARCHAR2 DEFAULT NULL,
    UPLOADED_FILE_ID IN VARCHAR2 DEFAULT NULL
  );
  
-- ������� �� ������� ������������
  PROCEDURE UPLOAD_CONTRAGENT_RESTS(
    DATAFILE IN VARCHAR2 DEFAULT NULL,
    UPLOADED_FILE_ID IN VARCHAR2 DEFAULT NULL
  );
-- ��������������
  PROCEDURE UPLOAD_BONUSES(
    DATAFILE IN VARCHAR2 DEFAULT NULL,
    UPLOADED_FILE_ID IN VARCHAR2 DEFAULT NULL
  );

 -- ������� ������������ ������
  PROCEDURE UPLOAD_PHONE_RETURN(
    DATAFILE IN VARCHAR2 DEFAULT NULL,
    UPLOADED_FILE_ID IN VARCHAR2 DEFAULT NULL
  );
  
  -- ���������
  PROCEDURE UPLOAD_ACTIVATION(
    DATAFILE IN VARCHAR2 DEFAULT NULL,
    UPLOADED_FILE_ID IN VARCHAR2 DEFAULT NULL
  );

  -- ������� ������������ ������
  PROCEDURE UPLOAD_PHONE_NUMBER(
    DATAFILE IN VARCHAR2 DEFAULT NULL,
    UPLOADED_FILE_ID IN VARCHAR2 DEFAULT NULL
  );
  
  PROCEDURE UPLOAD_CONTRAGENT(
    DATAFILE IN VARCHAR2 DEFAULT NULL,
    UPLOADED_FILE_ID IN VARCHAR2 DEFAULT NULL
  );
  
  -- 
  PROCEDURE UPLOAD_TARIFF_CHANGE_RULE(
    DATAFILE IN VARCHAR2 DEFAULT NULL,
    UPLOADED_FILE_ID IN VARCHAR2 DEFAULT NULL
  );
  
END;
/

CREATE OR REPLACE PACKAGE BODY WWW_DEALER.API_1C AS
--
  PROCEDURE APPEND_LOG(
    vTABLE_NAME VARCHAR2, 
    vMESSAGE VARCHAR2,
    pCHANGE_TYPE VARCHAR2 DEFAULT 'L'
    ) IS
  --
  PRAGMA AUTONOMOUS_TRANSACTION;
  --
  BEGIN
    INSERT INTO D_LOG_EXCHANGE(
      CHANGE_TYPE, 
      RESOURCE_TYPE, 
      TEXT
    ) VALUES (
     pCHANGE_TYPE, 
     vTABLE_NAME,
     vMESSAGE);
   COMMIT;
  END;
--
  PROCEDURE UPLOAD_TABLE(
    pDATAFILE_ID IN VARCHAR2,
    pTARGET_TABLE_NAME IN VARCHAR2, 
    pSOURCE_FIELDS IN VARCHAR2,
    pTARGET_FIELDS IN VARCHAR2,
    pPOST_LOAD_UPDATE IN VARCHAR2 DEFAULT NULL,
    pSHOW IN VARCHAR2 DEFAULT 0
    ) IS
    CNT NUMBER;
    DBF BLOB;
    vDATE_BEGIN DATE;
    vDATE_AFTER_UNZIP DATE;
    vDATE_BEFORE_POST_UPDATE DATE;
    CURSOR c IS 
      SELECT BLOB_CONTENT 
      FROM FILE_OBJECTS 
      WHERE NAME=pDATAFILE_ID
      FOR UPDATE;
    vDATA BLOB;
  BEGIN
    vDATE_BEGIN := SYSDATE;
    APPEND_LOG(pTARGET_TABLE_NAME, '������ ��������', 'B');
    OPEN C;
    FETCH C INTO vDATA;
    -- DBF := UTL_COMPRESS.LZ_UNCOMPRESS(vDATA);
    unzip_blob( vDATA, DBF );
    vDATE_AFTER_UNZIP := SYSDATE;

    --insert into test_2 (f1) values ('2');
    --commit;
    
    EXECUTE IMMEDIATE 'TRUNCATE TABLE '||pTARGET_TABLE_NAME;
    DBASE_PKG.load_Table(DBF, 
      pTARGET_TABLE_NAME, 
      NULL, 
      pTARGET_FIELDS, 
      pSOURCE_FIELDS, 
      CASE NVL(pSHOW, 0) WHEN 1 THEN TRUE ELSE FALSE END);
    COMMIT;
    
    vDATE_BEFORE_POST_UPDATE := SYSDATE;
    
    IF pPOST_LOAD_UPDATE IS NOT NULL THEN
      -- �� ���� �������� ������ ���� ���� DATE_LOAD, ��������� ���    
      EXECUTE IMMEDIATE 'UPDATE '||pTARGET_TABLE_NAME||' SET '||pPOST_LOAD_UPDATE;
    END IF;
    --        
    EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM '||pTARGET_TABLE_NAME INTO CNT;
    HTP.PRINT('OK. Uploaded :'||CNT||' ROWS. Date Start '||TO_CHAR(vDATE_BEGIN,'DD.MM.YYYY HH24:MI:SS')||' Date after unzip '||TO_CHAR(vDATE_AFTER_UNZIP,'DD.MM.YYYY HH24:MI:SS')||' Date Finish '||TO_CHAR(SYSDATE,'DD.MM.YYYY HH24:MI:SS'));
 --   DELETE FROM FILE_OBJECTS WHERE CURRENT OF C;
    CLOSE C;
    APPEND_LOG(pTARGET_TABLE_NAME, '�������� ���������. ��������� :'||CNT||' �������.'||CHR(13)||CHR(10)||
      ' Date Start       '||TO_CHAR(vDATE_BEGIN,'DD.MM.YYYY HH24:MI:SS')||CHR(13)||CHR(10)||
      ' Date after unzip '||TO_CHAR(vDATE_AFTER_UNZIP,'DD.MM.YYYY HH24:MI:SS')||CHR(13)||CHR(10)||
      ' Date before postprocess '||TO_CHAR(vDATE_BEFORE_POST_UPDATE,'DD.MM.YYYY HH24:MI:SS')||CHR(13)||CHR(10)||      
      ' Date Finish      '||TO_CHAR(SYSDATE,'DD.MM.YYYY HH24:MI:SS')||'.', 'L');
  EXCEPTION WHEN OTHERS THEN
    APPEND_LOG(pTARGET_TABLE_NAME, SUBSTR('������ ��������. '||CHR(13)||CHR(10)||
                     dbms_utility.format_error_stack||CHR(13)||CHR(10)||
                     dbms_utility.format_error_backtrace, 1, 1000), 'E');
    HTP.P('������ �������� '||pTARGET_TABLE_NAME||'. '|| CHR(13)||CHR(10)||
                     dbms_utility.format_error_stack||CHR(13)||CHR(10)||
                     dbms_utility.format_error_backtrace);
  END;
--
  PROCEDURE UPLOAD_BALANCE_CHANGE(
    DATAFILE IN VARCHAR2 DEFAULT NULL,
    UPLOADED_FILE_ID IN VARCHAR2 DEFAULT NULL
  ) IS
  BEGIN
    UPLOAD_TABLE(
      DATAFILE,
      'LOAD_BALANCE_CHANGE',
      'USER_NAME,USER_GUID,DATE_TIME,SUM_INCOME,SUMOUTCOME,BAL_AFTER,PH_NUMBER,OPERATOR,TARIFFNAME,TARIFFGUID,IS_DIRECT,TYPECHANGE,PERCNT,PERIOD', 
      'USER_NAME,USER_GUID,DATE_TIME_STR,SUM_INCOME,SUM_OUTCOME,BALANCE_AFTER,PHONE_NUMBER,OPERATOR,TARIFF_NAME,TARIFF_GUID,IS_DIRECT,TYPE_CHANGE,PERCENT_STR,PERIOD_STR',
      'DATE_LOAD = SYSDATE, DATE_TIME = TO_DATE(DATE_TIME_STR, ''DD.MM.YYYY HH24:MI:SS''), PERIOD = TO_DATE(PERIOD_STR, ''DD.MM.YYYY HH24:MI:SS''), PERCENT = TO_NUMBER(PERCENT_STR)'
      );
  END;
  
-- ������� ������������
  PROCEDURE UPLOAD_CONTRAGENT_RESTS(
    DATAFILE IN VARCHAR2 DEFAULT NULL,
    UPLOADED_FILE_ID IN VARCHAR2 DEFAULT NULL
  ) IS
  BEGIN
    UPLOAD_TABLE(
      DATAFILE,
      'LOAD_CONTRAGENT_REST',
      'CONTR_GUID,USER_NAME,CONTR_DESC,PHONE_NUM,OPERATOR,TARIFFNAME,TARIFFGUID,IS_DIRECT',
      'CONTRAGENT_GUID,USER_NAME,CONTRAGENT_DESCRIPTION,PHONE_NUMBER,OPERATOR,TARIFF_NAME,TARIFF_GUID,IS_DIRECT', 
      'DATE_LOAD = SYSDATE'
      );
  END;

-- ������
  PROCEDURE UPLOAD_BONUSES(
    DATAFILE IN VARCHAR2 DEFAULT NULL,
    UPLOADED_FILE_ID IN VARCHAR2 DEFAULT NULL
  ) IS
  BEGIN
    UPLOAD_TABLE(
      DATAFILE,
      'LOAD_BONUS',
      'USER_NAME,USER_GUID,BONUS_DATE,PHONE_NUM,BONUS_SUMM,OPERATOR,TARIFFNAME,TARIFFGUID,DATE_ACTIV,FULL_SUM,BONUS_PERC,IS_DIRECT',
      'USER_NAME,USER_GUID,BONUS_DATE_STR,PHONE_NUMBER,BONUS_SUMM,OPERATOR,TARIFF_NAME,TARIFF_GUID,DATE_ACTIVATION_STR,FULL_SUM,BONUS_PERCENT,IS_DIRECT', 
      'DATE_LOAD = SYSDATE, BONUS_DATE = TO_DATE(BONUS_DATE_STR, ''DD.MM.YYYY HH24:MI:SS''), DATE_ACTIVATION = DECODE(TO_DATE(DATE_ACTIVATION_STR, ''DD.MM.YYYY HH24:MI:SS''), TO_DATE(''01.01.0001'', ''DD.MM.YYYY''), TO_DATE(NULL), TO_DATE(DATE_ACTIVATION_STR, ''DD.MM.YYYY HH24:MI:SS'')), USER_NAME = TRIM(USER_NAME), OPERATOR = TRIM(OPERATOR), TARIFF_NAME = TRIM(TARIFF_NAME)'
      -- ���� ��������� 01.01.0001 0:00:00 ��������� � NULL, ��������� ��������� � ���� 
      );
  END;
--
-- �������� 
  PROCEDURE UPLOAD_PHONE_RETURN(
    DATAFILE IN VARCHAR2 DEFAULT NULL,
    UPLOADED_FILE_ID IN VARCHAR2 DEFAULT NULL
  ) IS
  BEGIN
    UPLOAD_TABLE(
      DATAFILE,    
      'LOAD_PHONE_RETURN',      
      'CONT_DESCR,             CONTR_GUID,      PHONE_NUM,    OPERATOR, TARIFFNAME,  TARIFFGUID,  IS_DIRECT, DATE_TIME,     DATE_LOAD,     DATE_ACTIV',
      'CONTRAGENT_DESCRIPTION, CONTRAGENT_GUID, PHONE_NUMBER, OPERATOR, TARIFF_NAME, TARIFF_GUID, IS_DIRECT, DATE_TIME_STR, DATE_LOAD_STR, DATE_ACTIVATION_STR', 
      'DATE_LOAD = SYSDATE, DATE_TIME = TO_DATE(DATE_TIME_STR, ''DD.MM.YYYY HH24:MI:SS''), DATE_ACTIVATION = DECODE(TO_DATE(DATE_ACTIVATION_STR, ''DD.MM.YYYY HH24:MI:SS''), TO_DATE(''01.01.0001'', ''DD.MM.YYYY''), TO_DATE(NULL), TO_DATE(DATE_ACTIVATION_STR, ''DD.MM.YYYY HH24:MI:SS'')), OPERATOR = TRIM(OPERATOR), TARIFF_NAME = TRIM(TARIFF_NAME)'      
    ) ;
  END;

  -- ���������
  PROCEDURE UPLOAD_ACTIVATION(
    DATAFILE IN VARCHAR2 DEFAULT NULL,
    UPLOADED_FILE_ID IN VARCHAR2 DEFAULT NULL
  ) IS
  BEGIN
    UPLOAD_TABLE(
      DATAFILE,    
      'LOAD_ACTIVATION',      
      'CONT_DESCR, CONTR_GUID, DATE_ACTIV, IS_DIRECT, OPERATOR, PHONE_NUM, TARIFFGUID, TARIFFNAME, USER_NAME',
      'CONTRAGENT_DESCRIPTION, CONTRAGENT_GUID, DATE_ACTIVATION_STR, IS_DIRECT, OPERATOR, PHONE_NUMBER, TARIFF_GUID, TARIFF_NAME, USER_NAME',
      'DATE_LOAD = SYSDATE, DATE_ACTIVATION = DECODE(TO_DATE(DATE_ACTIVATION_STR, ''DD.MM.YYYY HH24:MI:SS''), TO_DATE(''01.01.0001'', ''DD.MM.YYYY''), TO_DATE(NULL), TO_DATE(DATE_ACTIVATION_STR, ''DD.MM.YYYY HH24:MI:SS'')), OPERATOR = TRIM(OPERATOR), TARIFF_NAME = TRIM(TARIFF_NAME)'      
    ) ; 
  END;

-- ������� ������������ ������
  PROCEDURE UPLOAD_PHONE_NUMBER(
    DATAFILE IN VARCHAR2 DEFAULT NULL,
    UPLOADED_FILE_ID IN VARCHAR2 DEFAULT NULL
  ) IS
  BEGIN
    UPLOAD_TABLE(
      DATAFILE,    
      'LOAD_PHONE_NUMBER',      
      'PHONE_NUM,    COST, OPERATOR, TARIFFGUID,  TARIFFNAME,  REST_COUNT, IS_DIRECT, DATE_LOAD,     STORE_GUID,      STORE_NAME',
      'PHONE_NUMBER, COST, OPERATOR, TARIFF_GUID, TARIFF_NAME, REST_COUNT, IS_DIRECT, DATE_LOAD_STR, MAIN_STORE_GUID, MAIN_STORE_NAME',
      'DATE_LOAD = SYSDATE, OPERATOR = TRIM(OPERATOR), TARIFF_NAME = TRIM(TARIFF_NAME), TARIFF_GUID = TRIM(TARIFF_GUID), MAIN_STORE_GUID = TRIM(MAIN_STORE_GUID)'      
    ) ;   
  END;  

-- 
  PROCEDURE UPLOAD_CONTRAGENT(
    DATAFILE IN VARCHAR2 DEFAULT NULL,
    UPLOADED_FILE_ID IN VARCHAR2 DEFAULT NULL
  ) IS
  BEGIN
    --raise_application_error(-20001, '����� ������');
    UPLOAD_TABLE(
      DATAFILE,    
      'LOAD_CONTRAGENT',
      'DESCRIPT,    BALANCE, USER_NAME, PSSWRDHASH,    GUID, IS_LOCKED, IS_UPLOAD, DATE_LOAD,      MANAGDESCR,             MANAGUSNAM,        MANPSDHASH,            MANAGGUID,    MANAGISLOC,        MANAGISUPL,        IS_DELETED, MANAGISDEL',      
      'DESCRIPTION, BALANCE, USER_NAME, PASSWORD_HASH, GUID, IS_LOCKED, IS_UPLOAD, DATE_LOAD_STR,  MANAGER_DESCRIPTION,    MANAGER_USER_NAME, MANAGER_PASSWORD_HASH, MANAGER_GUID, MANAGER_IS_LOCKED, MANAGER_IS_UPLOAD, IS_DELETED, MANAGER_IS_DELETED',      
      'DATE_LOAD = SYSDATE, PASSWORD_HASH = TRIM(PASSWORD_HASH), GUID = TRIM(GUID), MANAGER_PASSWORD_HASH = TRIM(MANAGER_PASSWORD_HASH), MANAGER_GUID = TRIM(MANAGER_GUID)'      
    ) ;  
  END;   
  
-- 
  PROCEDURE UPLOAD_TARIFF_CHANGE_RULE(
    DATAFILE IN VARCHAR2 DEFAULT NULL,
    UPLOADED_FILE_ID IN VARCHAR2 DEFAULT NULL
  ) IS
  BEGIN
    --raise_application_error(-20001, '����� ������');
    UPLOAD_TABLE(
      DATAFILE,    
      'LOAD_TARIFF_CHANGE_RULE',
      'TR_GD_FROM,       TR_NM_FROM,       TR_GUID_TO,     TR_NAME_TO,     IS_DR_FROM,     IS_DR_TO,     OPER_FROM,     OPER_TO,     PRICE',      
      'TARIFF_GUID_FROM, TARIFF_NAME_FROM, TARIFF_GUID_TO, TARIFF_NAME_TO, IS_DIRECT_FROM, IS_DIRECT_TO, OPERATOR_FROM, OPERATOR_TO, PRICE',      
      'DATE_LOAD = SYSDATE, TARIFF_NAME_FROM = TRIM(TARIFF_NAME_FROM)'      
    ) ;  
  END;
     
END;
/