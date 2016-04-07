CREATE OR REPLACE PACKAGE LOADER3_PCKG IS
--
--#Version=15
--
--v15. ��������. 12.02.2015 ��� ����������� ����� ����������� � ��� ������ �������� �� �/� ���������� � ��������� �������� �� ������� ������������� ���������� ��� �� �������� �/� (SMS_SETT_ACCOUNTS).
--                          ��� ��������� �/� ��� ����������� ��� ��� ������� �� �������� �/�
--V14. ������� 01,10,2014 ��������� ������� GET_PHONE_DETAIL
--V13.�������� 29.06.2013 ������� GET_PHONE_BILL_DETAIL
--V12.����� 29.25.2013 ���� ������� �� ���-�� SenderName � SendSMS, ����� ��������� �������� k7
--V11.�������� 01.11.2012 ��������� ������� ��� �������� ������� � �����.
--V6.������� 24.08.2011 ������� ���������� � ���������� � �������������
--
  FUNCTION GET_PHONE_DETAIL(
    pYEAR IN INTEGER,
    pMONTH IN INTEGER,
    pPHONE_NUMBER IN VARCHAR2
    ) RETURN CLOB;
    
  FUNCTION GET_PHONE_BILL_DETAIL(
    pYEAR IN INTEGER,
    pMONTH IN INTEGER,
    pPHONE_NUMBER IN VARCHAR2
    ) RETURN CLOB;
  
   FUNCTION GET_SITE_PHONE_DETAIL(
    pLOADING_YEAR  IN INTEGER,
    pLOADING_MONTH IN INTEGER,
    pPHONE_NUMBER  IN VARCHAR2) RETURN CLOB;
--
  FUNCTION LOCK_PHONE(
    pPHONE_NUMBER IN VARCHAR2,
    pMANUAL_BLOCK IN INTEGER DEFAULT 1,
        --
    pNew_site_method in integer default 0
    ) RETURN VARCHAR2;
--
  FUNCTION UNLOCK_PHONE(
    pPHONE_NUMBER IN VARCHAR2,
    pMANUAL_UNLOCK IN INTEGER DEFAULT 1,
    --
    pNew_site_method in integer default 0
    ) RETURN VARCHAR2;
--
/*  FUNCTION SEND_SMS_MULTI(
    pPHONE_NUMBERS IN DBMS_SQL.VARCHAR2_TABLE,
    pMAILING_NAME IN VARCHAR2,
  --  pSENDER_NAME IN VARCHAR2,
    pSMS_TEXT IN VARCHAR2
    ) RETURN VARCHAR2;*/
--    
 FUNCTION SEND_SMS(
    pPHONE_NUMBER IN VARCHAR2,
    pMAILING_NAME IN VARCHAR2,

    pSMS_TEXT IN VARCHAR2,
    pUSE_REPEAT_SEND IN INTEGER DEFAULT 0,
    pSENDER_NAME IN VARCHAR2 DEFAULT NULL
    ) RETURN VARCHAR2;
END LOADER3_PCKG;

--#end if;
/
CREATE OR REPLACE PACKAGE BODY LOADER3_PCKG IS
--
--#Version=13
--
--v15. ��������. 12.02.2015 ��� ����������� ����� ����������� � ��� ������ �������� �� �/� ���������� � ��������� �������� �� ������� ������������� ���������� ��� �� �������� �/� (SMS_SETT_ACCOUNTS).
--                          ��� ��������� �/� ��� ����������� ��� ��� ������� �� �������� �/�
--V12.����� 29.25.2013 ���� ������� �� ���-�� SenderName � SendSMS, ����� ����������� �������� k7
--
--
--

FUNCTION GET_PHONE_DETAIL(
    pYEAR IN INTEGER,
    pMONTH IN INTEGER,
    pPHONE_NUMBER IN VARCHAR2
    ) RETURN CLOB IS
--
CURSOR C IS
  SELECT distinct ACCOUNTS.LOGIN
    FROM
      DB_LOADER_PHONE_STAT,
      ACCOUNTS
    WHERE --DB_LOADER_PHONE_STAT.YEAR_MONTH = pYEAR*100 + pMONTH
      DB_LOADER_PHONE_STAT.PHONE_NUMBER = pPHONE_NUMBER
      AND ACCOUNTS.ACCOUNT_ID=DB_LOADER_PHONE_STAT.ACCOUNT_ID;
  --
  --vLOGIN ACCOUNTS.LOGIN%TYPE;

  res clob;
  new_res clob;
  
  FullFilePath varchar2(1000);
  Dir varchar2(1000);
BEGIN
  
  select directory_path into Dir from dba_directories where DIRECTORY_NAME= 'CALLSMM';
  
  Dir := Dir ||pYEAR ||'_';
  
  if length(to_char(pMONTH)) = 1 then
        Dir := Dir || '0' ||to_char(pMONTH);
    else
        Dir := Dir || to_char(pMONTH);
  end if;
  
  for rec in c
  loop
    IF rec.login IS NOT NULL THEN
      FullFilePath := Dir || '\' || rec.login || '\';
      new_res := pkg_fileutil.blob_to_clob(pkg_fileutil.fn_ReadBLOBfromFile(FullFilePath, pPHONE_NUMBER||'.txt'));
      if res is null then
        res := new_res;
      else
        if new_res is not null then
          dbms_lob.APPEND(res,new_res );
        end if;
      end if;
    END IF;
  end loop;
  return res;
END;
--
--
FUNCTION GET_PHONE_BILL_DETAIL(
    pYEAR IN INTEGER,
    pMONTH IN INTEGER,
    pPHONE_NUMBER IN VARCHAR2
    ) RETURN CLOB IS
--
CURSOR C IS
  SELECT distinct ACCOUNTS.LOGIN
    FROM
      DB_LOADER_PHONE_STAT,
      ACCOUNTS
    WHERE --DB_LOADER_PHONE_STAT.YEAR_MONTH = pYEAR*100 + pMONTH
      DB_LOADER_PHONE_STAT.PHONE_NUMBER = pPHONE_NUMBER
      AND ACCOUNTS.ACCOUNT_ID=DB_LOADER_PHONE_STAT.ACCOUNT_ID;
  --
  --vLOGIN ACCOUNTS.LOGIN%TYPE;

  res clob;
  new_res clob;
BEGIN
  for rec in c
  loop
    IF rec.login IS NOT NULL THEN
      new_res:=LOADER_CALL_PCKG.GET_PHONE_BILL_DETAIL(rec.login, pYEAR, pMONTH, pPHONE_NUMBER);

      if res is null then
        res := new_res;
      else
        if new_res is not null then
          dbms_lob.APPEND(res,new_res );
        end if;
      end if;
    END IF;
  end loop;
  return res;
END;
--
FUNCTION GET_SITE_PHONE_DETAIL(
    pLOADING_YEAR  IN INTEGER,
    pLOADING_MONTH IN INTEGER,
    pPHONE_NUMBER  IN VARCHAR2) RETURN CLOB IS
--
CURSOR C IS
  SELECT distinct ACCOUNTS.LOGIN
    FROM
      DB_LOADER_PHONE_STAT,
      ACCOUNTS
    WHERE --DB_LOADER_PHONE_STAT.YEAR_MONTH = pYEAR*100 + pMONTH
      DB_LOADER_PHONE_STAT.PHONE_NUMBER = pPHONE_NUMBER
      AND ACCOUNTS.ACCOUNT_ID=DB_LOADER_PHONE_STAT.ACCOUNT_ID;
  --
  --vLOGIN ACCOUNTS.LOGIN%TYPE;
  res clob;
  new_res clob;
BEGIN
  for rec in c
  loop
    IF rec.login IS NOT NULL THEN
      new_res:=LOADER_CALL_PCKG.GET_SITE_PHONE_DETAIL(rec.login, pLOADING_YEAR, pLOADING_MONTH, pPHONE_NUMBER);
      if res is null then
        res := new_res;
      else
        if new_res is not null then
          dbms_lob.APPEND(res,new_res );
        end if;
      end if;
    END IF;
  end loop;
  return res;
END;
--
FUNCTION LOCK_PHONE(
    pPHONE_NUMBER IN VARCHAR2,
    pMANUAL_BLOCK IN INTEGER DEFAULT 1,
    --
    pNew_site_method in integer default 0
    ) RETURN VARCHAR2 IS
--
--���������� �.�. 19.11.2012 ����������� ������� ����������� ACCOUNT_ID � ������� C. �������� ������� DB_LOADER_PHONE_STAT �� DB_LOADER_ACCOUNT_PHONES
--����� �.�. 13.03.2013 ���������� ��������� � ������ �� ���������� ����� ����� �������
CURSOR C IS
  SELECT
    Accounts.Account_Id,
    ACCOUNTS.LOGIN,
    ACCOUNTS.PASSWORD,
    OPERATORS.LOADER_SCRIPT_NAME,
    LOADER_SETTINGS.LOADER_DB_CONNECTION,
    LOADER_SETTINGS.LOADER_DB_USER_NAME,
    LOADER_SETTINGS.LOADER_DB_PASSWORD,
    Accounts.Is_Collector
  FROM
      --DB_LOADER_PHONE_STAT,
      DB_LOADER_ACCOUNT_PHONES,
      ACCOUNTS,
      OPERATORS,
      LOADER_SETTINGS
  WHERE --DB_LOADER_PHONE_STAT.PHONE_NUMBER = pPHONE_NUMBER
    DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER = pPHONE_NUMBER
    --AND ACCOUNTS.ACCOUNT_ID=DB_LOADER_PHONE_STAT.ACCOUNT_ID
    AND ACCOUNTS.ACCOUNT_ID=DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID
    AND OPERATORS.OPERATOR_ID=ACCOUNTS.OPERATOR_ID
  ORDER BY
    --DB_LOADER_PHONE_STAT.YEAR_MONTH DESC;
    DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH DESC;

  --
CURSOR ABONENT IS
  SELECT
  ABONENTS.SURNAME,
  ABONENTS.NAME,
  ABONENTS.PATRONYMIC,
  V_CONTRACTS.PHONE_NUMBER_FEDERAL
  FROM ABONENTS,V_CONTRACTS
  WHERE V_CONTRACTS.PHONE_NUMBER_FEDERAL=pPHONE_NUMBER
    AND V_CONTRACTS.CONTRACT_CANCEL_DATE IS NULL
    AND V_CONTRACTS.ABONENT_ID=ABONENTS.ABONENT_ID
  ORDER BY V_CONTRACTS.CONTRACT_DATE DESC;

  vREC C%ROWTYPE;
  abREC ABONENT%ROWTYPE;
  FIO VARCHAR2(2000);
  V_RESULT VARCHAR2(2000);
  Respond varchar2(1000); -- ����� ��  ������ ��������
BEGIN
  OPEN C;
  FETCH C INTO vREC;
  CLOSE C;
  IF vREC.LOGIN IS NOT NULL THEN
    BEGIN
        if pNew_site_method=1 then
            begin--�������� � ������ �������� ������
              null;
              Respond:=loader_call_pckg_n.lock_phone(vREC.Account_Id, pPHONE_NUMBER);
              V_RESULT:=null;
            exception
              when others then Respond:='Error';
            end;
        end if;
    if (Respond='Error' or pNew_site_method=0) then --���� ������ 
      if (vREC.is_collector=0 or vrec.is_collector is null) then--� �� �������������
         V_RESULT:= LOADER_CALL_PCKG.LOCK_PHONE(vREC.LOGIN, vREC.PASSWORD, vREC.LOADER_SCRIPT_NAME,
                     vREC.LOADER_DB_CONNECTION, vREC.LOADER_DB_USER_NAME, vREC.LOADER_DB_PASSWORD,  pPHONE_NUMBER);
      else --���� ������������� 
         V_RESULT:= Respond||' ������ ����� ���������� ����� e-care!';
      end if;
    end if;
    EXCEPTION WHEN OTHERS THEN
      V_RESULT:=SQLERRM;
    END;
    IF V_RESULT IS NULL THEN
      OPEN ABONENT;
      FETCH ABONENT INTO abREC;
      CLOSE ABONENT;
      FIO:=abREC.SURNAME || ' ' || abREC.NAME || ' ' || abREC.PATRONYMIC;
      INSERT INTO AUTO_BLOCKED_PHONE
        (PHONE_NUMBER,
         BALLANCE,
         BLOCK_DATE_TIME,
         MANUAL_BLOCK,
         USER_NAME,
         ABONENT_FIO)
        VALUES (
         pPHONE_NUMBER,
         GET_ABONENT_BALANCE(pPHONE_NUMBER),
         SYSDATE,
         pMANUAL_BLOCK,
         USER,
         FIO
        );
    END IF;
    if Respond<>'Error' and pNew_site_method=1 and pMANUAL_BLOCK=1 then return Respond; else
    RETURN V_RESULT;
    end if;
  ELSE
    RETURN pPHONE_NUMBER || ' �� ������ � ���� ������.';
  END IF;
END;
--
FUNCTION UNLOCK_PHONE(
    pPHONE_NUMBER IN VARCHAR2,
    pMANUAL_UNLOCK IN INTEGER DEFAULT 1,
    --
    pNew_site_method in integer default 0
    ) RETURN VARCHAR2 IS
--
--���������� �.�. 19.11.2012 ����������� ������� ����������� ACCOUNT_ID � ������� C. �������� ������� DB_LOADER_PHONE_STAT �� DB_LOADER_ACCOUNT_PHONES
--����� �.�. 13.03.2013 ���������� ��������� � ������ �� ���������� ����� ����� �������

CURSOR C IS
  SELECT
    ACCOUNTS.ACCOUNT_ID,
    ACCOUNTS.LOGIN,
    ACCOUNTS.PASSWORD,
    OPERATORS.LOADER_SCRIPT_NAME,
    LOADER_SETTINGS.LOADER_DB_CONNECTION,
    LOADER_SETTINGS.LOADER_DB_USER_NAME,
    LOADER_SETTINGS.LOADER_DB_PASSWORD,
    Accounts.Is_Collector
  FROM
      --DB_LOADER_PHONE_STAT,
      DB_LOADER_ACCOUNT_PHONES,
      ACCOUNTS,
      OPERATORS,
      LOADER_SETTINGS
  WHERE --DB_LOADER_PHONE_STAT.PHONE_NUMBER = pPHONE_NUMBER
    DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER = pPHONE_NUMBER
    --AND ACCOUNTS.ACCOUNT_ID=DB_LOADER_PHONE_STAT.ACCOUNT_ID
    AND ACCOUNTS.ACCOUNT_ID=DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID
    AND OPERATORS.OPERATOR_ID=ACCOUNTS.OPERATOR_ID
  ORDER BY
    --DB_LOADER_PHONE_STAT.YEAR_MONTH DESC;
    DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH DESC;
  --
  CURSOR ABONENT IS
  SELECT
    ABONENTS.SURNAME,
    ABONENTS.NAME,
    ABONENTS.PATRONYMIC,
    V_CONTRACTS.PHONE_NUMBER_FEDERAL
  FROM ABONENTS,V_CONTRACTS
    WHERE V_CONTRACTS.PHONE_NUMBER_FEDERAL=pPHONE_NUMBER
      AND V_CONTRACTS.CONTRACT_CANCEL_DATE IS NULL
      AND V_CONTRACTS.ABONENT_ID=ABONENTS.ABONENT_ID
    ORDER BY V_CONTRACTS.CONTRACT_DATE DESC;

  vREC C%ROWTYPE;
  abREC ABONENT%ROWTYPE;
  FIO VARCHAR2(2000);
  V_RESULT VARCHAR2(2000);
  Respond varchar2(1000); -- ����� ��  ������ ��������
BEGIN
  OPEN C;
  FETCH C INTO vREC;
  CLOSE C;
  IF vREC.LOGIN IS NOT NULL THEN
    BEGIN
        if pNew_site_method=1 then
        begin--�������� � ������ �������� ������
        null;
        Respond:=loader_call_pckg_n.unlock_phone(vREC.Account_Id, pPHONE_NUMBER);
        V_RESULT:=null;
        exception
        when others then Respond:='Error';
        end;
        end if;
   if Respond='Error' or pNew_site_method=0 then
      if (vREC.is_collector=0 or vrec.is_collector is null) then--� �� �������������
          V_RESULT:= LOADER_CALL_PCKG.UNLOCK_PHONE(vREC.LOGIN, vREC.PASSWORD, vREC.LOADER_SCRIPT_NAME,
            vREC.LOADER_DB_CONNECTION, vREC.LOADER_DB_USER_NAME, vREC.LOADER_DB_PASSWORD, pPHONE_NUMBER);
      else --���� ������������� 
         V_RESULT:= Respond||' ������ �������� ���������� ����� e-care!';
      end if;
    end if;
    EXCEPTION WHEN OTHERS THEN
      V_RESULT:=SQLERRM;
    END;
    IF V_RESULT IS NULL THEN
      OPEN ABONENT;
      FETCH ABONENT INTO abREC;
      CLOSE ABONENT;
      FIO:=abREC.SURNAME || ' ' || abREC.NAME || ' ' || abREC.PATRONYMIC;
      INSERT INTO AUTO_UNBLOCKED_PHONE
        (PHONE_NUMBER,
         BALLANCE,
         UNBLOCK_DATE_TIME,
         MANUAL_BLOCK,
         USER_NAME,
         ABONENT_FIO)
        VALUES (
         pPHONE_NUMBER,
         GET_ABONENT_BALANCE(pPHONE_NUMBER),
         SYSDATE,
         pMANUAL_UNLOCK,
         USER,
         FIO
        );
    END IF;
    if Respond<>'Error' and pNew_site_method=1 and pMANUAL_UNLOCK=1 then return Respond; else
    RETURN V_RESULT;
    end if;
  ELSE
    RETURN pPHONE_NUMBER || ' �� ������ � ���� ������.';
  END IF;
END;
--
FUNCTION SEND_SMS_MULTI(
    pPHONE_NUMBERS IN DBMS_SQL.VARCHAR2_TABLE,
    pMAILING_NAME IN VARCHAR2,
    pSMS_TEXT IN VARCHAR2,
    pSENDER_NAME IN VARCHAR2 DEFAULT NULL
    ) RETURN VARCHAR2 IS
--

CURSOR C IS
  SELECT
    SMS_SEND_PARAMETRS.LOGIN,
    SMS_SEND_PARAMETRS.PASSWORD,
    SMS_SEND_PARAMETRS.SENDER_NAME,
    SMS_SEND_PARAMETRS.PROVIDER_NAME
  FROM
    SMS_SEND_PARAMETRS
  WHERE SMS_SEND_PARAMETRS.Status=1;
--
  vREC C%ROWTYPE;
  vMAILING_NAME VARCHAR2(30 CHAR);
CURSOR SI IS
  SELECT NVL(MAX(SMS_ID), 0) SMS_ID
    FROM LOG_SEND_SMS
    WHERE LOG_SEND_SMS.YEAR_MONTH=TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMM'));
DUMMY_SI SI%ROWTYPE;
RESUL VARCHAR2(300 CHAR);
vYEAR_MONTH INTEGER;
BEGIN
  OPEN C;
  FETCH C INTO vREC;
  CLOSE C;
  vMAILING_NAME:=pMAILING_NAME;
  OPEN SI;
  FETCH SI INTO DUMMY_SI;
  CLOSE SI;
  DUMMY_SI.SMS_ID:=DUMMY_SI.SMS_ID+1;
  vYEAR_MONTH:=TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMM'));
  INSERT INTO LOG_SEND_SMS(SMS_ID, PHONE_NUMBER, SMS_TEXT)
    VALUES(DUMMY_SI.SMS_ID, pPHONE_NUMBERS(1), pSMS_TEXT);
  vMAILING_NAME:=TO_CHAR(DUMMY_SI.SMS_ID);
 -- IF vREC.LOGIN IS NOT NULL THEN
  RESUL:=LOADER_CALL_PCKG.SEND_SMS_MULTI(
      vREC.LOGIN,
      vREC.PASSWORD,
      vREC.PROVIDER_NAME,
      pPHONE_NUMBERS,
      vMAILING_NAME,
      nvl(pSENDER_NAME,vREC.SENDER_NAME),
      pSMS_TEXT);
  UPDATE LOG_SEND_SMS
    SET NOTE=substr(RESUL,1,100)
    WHERE YEAR_MONTH=vYEAR_MONTH
      AND SMS_ID=DUMMY_SI.SMS_ID;
  COMMIT;
  RETURN RESUL;
END;
--
FUNCTION SEND_SMS(
    pPHONE_NUMBER IN VARCHAR2,
    pMAILING_NAME IN VARCHAR2,
    pSMS_TEXT IN VARCHAR2,
    pUSE_REPEAT_SEND IN INTEGER DEFAULT 0,
    pSENDER_NAME IN VARCHAR2 DEFAULT NULL
    ) RETURN VARCHAR2 IS
CURSOR C IS
  SELECT FORWARDING_PHONE_NUMBER.PHONE_NUMBER_RECIPIENT,
         FORWARDING_PHONE_NUMBER.SMS_TEXT_ADD
    FROM FORWARDING_PHONE_NUMBER
    WHERE FORWARDING_PHONE_NUMBER.PHONE_NUMBER=pPHONE_NUMBER;
vPHONE_NUMBERS  DBMS_SQL.VARCHAR2_TABLE;
ITOG VARCHAR2(200 CHAR);
vREC C%ROWTYPE;
vSMS_TEXT VARCHAR2(500 CHAR);
 ppSENDER_NAME VARCHAR2(32);
BEGIN

  IF MS_CONSTANTS.GET_CONSTANT_VALUE('FORWARDING_SYSTEM_ENABLE')='1' THEN
    OPEN C;
    FETCH C INTO vREC;
    IF C%FOUND THEN
      vPHONE_NUMBERS(1):=vREC.PHONE_NUMBER_RECIPIENT;
      vSMS_TEXT:=vREC.SMS_TEXT_ADD||' '||pSMS_TEXT;
    ELSE
      vPHONE_NUMBERS(1):=pPHONE_NUMBER;
      vSMS_TEXT:=pSMS_TEXT;
    END IF;
    CLOSE C;
  ELSE
    vPHONE_NUMBERS(1):=pPHONE_NUMBER;
    vSMS_TEXT:=pSMS_TEXT;
  END IF;

  --��� ������ ���������� SENDER_NAME-��������� � ���� �/� ����� ������� SMS_SETT_ACCOUNTS = 1, �� �������� SENDER_NAME ��������� �������� �� �������� �/�
  --� ��������� �������: ����� pSENDER_NAME=null ��� ������� �/� SMS_SETT_ACCOUNTS <> 1 - �c������� �������� ��� �� ��������� � �������.
  
  select decode(pSENDER_NAME,
                null,
                decode((select NVL(SMS_SETT_ACCOUNTS, 0)
  				        FROM ACCOUNTS
  				        WHERE ACCOUNT_ID = GET_ACCOUNT_ID_BY_PHONE(pPHONE_NUMBER)),
                       0,
                       pSENDER_NAME,
                       GET_SMS_SENDER_NAME_BY_PHONE(pPHONE_NUMBER)),
                pSENDER_NAME)
    into ppSENDER_NAME
    from dual;


  ITOG:=SEND_SMS_MULTI(
      vPHONE_NUMBERS,
      pMAILING_NAME,
      vSMS_TEXT,
      --pSENDER_NAME
      ppSENDER_NAME
      );
  IF (pUSE_REPEAT_SEND=1)and(ITOG IS NOT NULL) THEN
    INSERT INTO SEND_SMS_QUERY(PHONE_NUMBER, SEND_NAME, TEXT, NOTE)
      VALUES(pPHONE_NUMBER, pMAILING_NAME, pSMS_TEXT, '�� ��������� ��������');
  END IF;
  RETURN ITOG;
END;
END;
/