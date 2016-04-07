
  CREATE OR REPLACE PACKAGE "CORP_MOBILE"."LOADER2_PCKG" IS
--
--#Version=20
--
-- 20. Автоматический переход на новый месяц в отчете по начислениям.
-- 19. Добавлена загрузка подключенных услуг
-- 18. Добавлен обратный поток детальных счетов.
-- 17. Добавлена загрузка счетов из "Финансовой информации"
--
  PROCEDURE LOAD_PREV_ACCOUNT_DATA(
    pACCOUNT_ID IN INTEGER,
    pSTART_YEAR IN INTEGER,
    pSTART_MONTH IN INTEGER,
    pEND_YEAR IN INTEGER,
    pEND_MONTH IN INTEGER
    );
  --Загрузка счетов прошлых периодов
  PROCEDURE LOAD_REPORT_DATA(
    pACCOUNT_ID IN INTEGER
    );
--
  FUNCTION READ_FIELD_DETAILS(
    pACCOUNT_ID IN INTEGER,
    pYEAR_MONTH IN INTEGER,
    pFIELD_ID IN INTEGER
    ) RETURN VARCHAR2;
  --Загрузка отчетов о начислениях
  PROCEDURE LOAD_ACCOUNT_DATA(
    pACCOUNT_ID IN INTEGER,
    pLOAD_TYPE IN INTEGER
    );
  --Процедура Запуска загрузок по Типу загрузки и Аккаунту
  --1: Платежи
  --2: Детализации
  --3: Статусы телефонов
  --4: Подключенные опции
  --5: Счета
  --6: Отчеты о текущих начислениях
  --7: Детализированные счета из раздела "Финансовая информация".
  --8: Детализированные счета из раздела "Финансовая информация", обратный поток.
  PROCEDURE LOAD_PREV_PAYMENTS(
  pACCOUNT_ID IN INTEGER,
  pYEAR IN INTEGER,
  pMONTH IN INTEGER
  );
  --Загрузка платежей за конкретный месяц
  PROCEDURE LOAD_ACCOUNT_PHONE_OPTIONS(
    pPHONE_NUMBER IN VARCHAR2,
    pERROR OUT VARCHAR2
  );
 --Загрузка подключенных услуг


END LOADER2_PCKG;

CREATE OR REPLACE PACKAGE BODY "CORP_MOBILE"."LOADER2_PCKG" IS
--
TYPE T_LOAD_SETTINGS IS RECORD (
  ACCOUNT_ID ACCOUNTS.ACCOUNT_ID%TYPE,
  DO_AUTO_LOAD_DATA NUMBER(1, 0),
  LOGIN ACCOUNTS.LOGIN%TYPE,
  PASSWORD ACCOUNTS.PASSWORD%TYPE,
  LOADING_YEAR BINARY_INTEGER,
  LOADING_MONTH BINARY_INTEGER,
  LOADER_SCRIPT_NAME OPERATORS.LOADER_SCRIPT_NAME%TYPE,
  LOADER_DB_CONNECTION LOADER_SETTINGS.LOADER_DB_CONNECTION%TYPE,
  LOADER_DB_USER_NAME LOADER_SETTINGS.LOADER_DB_USER_NAME%TYPE,
  LOADER_DB_PASSWORD LOADER_SETTINGS.LOADER_DB_PASSWORD%TYPE,
  LOAD_DETAIL_POOL_SIZE ACCOUNTS.LOAD_DETAIL_POOL_SIZE%TYPE,
  LOAD_DETAIL_THREAD_COUNT ACCOUNTS.LOAD_DETAIL_THREAD_COUNT%TYPE
  );
--
FUNCTION GET_LOADER_SETTINGS(
  pACCOUNT_ID IN INTEGER
  ) RETURN T_LOAD_SETTINGS IS
--Получение настроек соединия для загрузки
s T_LOAD_SETTINGS;
CURSOR C_SETTINGS(pACCOUNT_ID INTEGER) IS
  SELECT ACCOUNTS.ACCOUNT_ID,
         ACCOUNTS.DO_AUTO_LOAD_DATA,
         ACCOUNTS.LOGIN,
         ACCOUNTS.PASSWORD,
         OPERATORS.LOADER_SCRIPT_NAME,
         ACCOUNTS.LOAD_DETAIL_POOL_SIZE,
         ACCOUNTS.LOAD_DETAIL_THREAD_COUNT
    FROM ACCOUNTS, OPERATORS
    WHERE ACCOUNTS.OPERATOR_ID=OPERATORS.OPERATOR_ID
      AND ACCOUNTS.ACCOUNT_ID=pACCOUNT_ID;
vLOAD_DATE DATE;
BEGIN
  OPEN C_SETTINGS(pACCOUNT_ID);
  FETCH C_SETTINGS INTO
    s.ACCOUNT_ID,
    s.DO_AUTO_LOAD_DATA,
    s.LOGIN,
    s.PASSWORD,
    s.LOADER_SCRIPT_NAME,
    s.LOAD_DETAIL_POOL_SIZE,
    S.LOAD_DETAIL_THREAD_COUNT;
  CLOSE C_SETTINGS;
  SELECT  LOADER_DB_CONNECTION,
          LOADER_DB_USER_NAME,
          LOADER_DB_PASSWORD
    INTO
      s.LOADER_DB_CONNECTION,
      s.LOADER_DB_USER_NAME,
      s.LOADER_DB_PASSWORD
    FROM LOADER_SETTINGS;
  -- Дата загрузки соответствует вчерашней дате
  --vLOAD_DATE := SYSDATE-1;
  -- непонятно почему это было сделано, почему бралась предыдущая дата. Овсянников
  vLOAD_DATE := SYSDATE;
  s.LOADING_YEAR := TO_NUMBER(TO_CHAR(vLOAD_DATE, 'YYYY'));
  s.LOADING_MONTH := TO_NUMBER(TO_CHAR(vLOAD_DATE, 'MM'));
  RETURN s;
END;
--Получение настроек соединия для загрузки
FUNCTION GET_NAME_LOAD(
  pLOAD_ID IN INTEGER
  ) RETURN VARCHAR2 IS
--Получить название загрузки по номеру ее типа
CURSOR C(pLOAD_ID INTEGER) IS
  SELECT ACCOUNT_LOAD_TYPE_NAME
    FROM ACCOUNT_LOAD_TYPES
    WHERE ACCOUNT_LOAD_TYPE_ID=pLOAD_ID;
TYP VARCHAR2(200);
BEGIN
  OPEN C(pLOAD_ID);
  FETCH C INTO TYP;
  CLOSE C;
  RETURN TYP;
END;
--Получить название загрузки по номеру ее типа
PROCEDURE LOAD_ACCOUNT_PAYMENTS(s IN T_LOAD_SETTINGS) IS
  vERROR_TEXT VARCHAR2(2000 CHAR);

LOAD_METHOD integer; ---тип загрузки из accounts: 1 - новая, 0- старая
LOAD_METHOD_ERR integer;
--Загрузка платежей текущего месяца и прошлого, если 1-го числа.
BEGIN
LOAD_METHOD:=0; ---тип загрузки из accounts: 1 - новая, 0- старая
LOAD_METHOD_ERR:=0;
      begin--проверяем каким методом грузить
        select strinlike('1',acc.n_method,';','()') into LOAD_METHOD from accounts acc where acc.account_id=s.ACCOUNT_ID;
      exception
        when others then null;
      end;
  if LOAD_METHOD>0 then
    loader_call_pckg_n.LOAD_ACCOUNT_PAYMENTS(
    s.ACCOUNT_ID
    );--новый метод
    begin
    select distinct t.account_id into LOAD_METHOD_ERR from account_load_logs t--проверяем лог за последние 5 мин.
                                 where
                               t.load_date_time between (sysdate-2/1440) and (sysdate)
                               and t.is_success=0
                               and t.account_load_type_id=1
                               and t.account_id=s.ACCOUNT_ID;
    exception
      when no_data_found then null;-- Значить всё прошло ОК!
    end;
  end if;
  if(LOAD_METHOD=0) or  LOAD_METHOD_ERR>0--если есть ошибка в логе используем старый метод
  then
    vERROR_TEXT := LOADER_CALL_PCKG.LOAD_PAYMENTS(
      s.LOGIN,
      s.PASSWORD,
      s.LOADING_YEAR,
      s.LOADING_MONTH,
      s.LOADER_SCRIPT_NAME,
      s.LOADER_DB_CONNECTION,
      s.LOADER_DB_USER_NAME,
      s.LOADER_DB_PASSWORD
    );
      IF (TO_NUMBER(TO_CHAR(SYSDATE, 'DD')) <= 01)
          AND (vERROR_TEXT IS NULL) THEN
        -- В первый день месяца надо загружать текущие периоды
        vERROR_TEXT := LOADER_CALL_PCKG.LOAD_PAYMENTS(
          s.LOGIN,
          s.PASSWORD,
          TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')),
          TO_NUMBER(TO_CHAR(SYSDATE, 'MM')),
          s.LOADER_SCRIPT_NAME,
          s.LOADER_DB_CONNECTION,
          s.LOADER_DB_USER_NAME,
          s.LOADER_DB_PASSWORD
        );
      END IF;
   end if;--ст.метод
-------------
  IF vERROR_TEXT IS NOT NULL THEN
    RAISE_APPLICATION_ERROR(-20200, 'Loading error. ' || vERROR_TEXT);
  END IF;
END;
--Загрузка платежей текущего месяца и прошлого, если 1-го числа.
PROCEDURE LOAD_ACCOUNT_PHONES(s IN T_LOAD_SETTINGS, TURNED_OPTION IN BOOLEAN) IS
  vERROR_TEXT VARCHAR2(2000 CHAR);


LOAD_METHOD integer; ---тип загрузки 1 - новая, 0- старая
LOAD_METHOD_ERR integer;
LOAD_TYPE integer;--номера:3\услуги:4
--Процедура загрузки Статусов телефонов или Подключенных опций
BEGIN
LOAD_METHOD:=0; ---тип загрузки из accounts: 1 - новая, 0- старая
LOAD_METHOD_ERR:=0;
if TURNED_OPTION then LOAD_TYPE:=4; else LOAD_TYPE:=3;end if;

      begin--проверяем каким методом грузить
        select strinlike(to_char(LOAD_TYPE),acc.n_method,';','()') into LOAD_METHOD from accounts acc where acc.account_id=s.ACCOUNT_ID;
      exception
        when others then null;
      end;

  if LOAD_METHOD>0 and not TURNED_OPTION then
    loader_call_pckg_n.UPDATE_ACCOUNT_PHONES_STATE(s.ACCOUNT_ID);--новый метод
  elsif LOAD_METHOD>0 and TURNED_OPTION then
    loader_call_pckg_n.LOAD_PHONES_OPTIONS(s.ACCOUNT_ID);--новый метод
  end if;
  --Проверяем результат
    begin
      select distinct t.account_id into LOAD_METHOD_ERR from account_load_logs t--проверяем лог за последние 5 мин.
                                 where
                               t.load_date_time between (sysdate-2/1440) and (sysdate)
                               and t.is_success=0
                               and t.account_load_type_id=LOAD_TYPE
                               and t.account_id=s.ACCOUNT_ID;
    exception
      when no_data_found then null;-- Значить всё прошло ОК!
    end;

  --Старый метод
  if(LOAD_METHOD=0) or  LOAD_METHOD_ERR>0--если есть ошибка в логе используем старый метод
  then
  vERROR_TEXT := LOADER_CALL_PCKG.LOAD_PHONES(
    s.LOGIN,
    s.PASSWORD,
    s.LOADING_YEAR,
    s.LOADING_MONTH,
    s.LOADER_SCRIPT_NAME,
    s.LOADER_DB_CONNECTION,
    s.LOADER_DB_USER_NAME,
    s.LOADER_DB_PASSWORD,
    TURNED_OPTION
  );
  end if;
  IF vERROR_TEXT IS NOT NULL THEN
    RAISE_APPLICATION_ERROR(-20200, 'Loading error. ' || vERROR_TEXT);
  END IF;
end;
--Процедура загрузки Статусов телефонов или Подключенных опций
PROCEDURE LOAD_ACCOUNT_DETAILS(s IN T_LOAD_SETTINGS) IS
  vERROR_TEXT VARCHAR2(2000 CHAR);
  vERROR_TEXT2 VARCHAR2(2000 CHAR);
  vPHONES DBMS_SQL.VARCHAR2_TABLE;
  pmethod BINARY_INTEGER;
  --vINDEX BINARY_INTEGER;
--  vTHREAD_INDEX BINARY_INTEGER;
  --cPOOL_SIZE CONSTANT INTEGER := 25; -- По 25 номеров за один вызов
  --cTHREAD_COUNT CONSTANT INTEGER := 20; -- В 20 параллельных потоков
  vSERVER_NANE VARCHAR2(50 CHAR);
  vCHECKED INTEGER;
  vBALANCE NUMBER(13, 2);
  vflag varchar2(256);
  --ttp TPHONE_LIST_ARRAY := TPHONE_LIST_ARRAY() ;
begin
  vCHECKED:=0;
  vflag:=MS_CONSTANTS.GET_CONSTANT_VALUE('DB_DETAILS');
  vSERVER_NANE:=MS_CONSTANTS.GET_CONSTANT_VALUE('SERVER_NAME');
  -- сначала получим полный список телефонных номеров
  FOR orgs IN (SELECT DB_LOADER_ACCOUNT_PHONES.ORGANIZATION_ID
    FROM DB_LOADER_ACCOUNT_PHONES
    WHERE DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID=s.ACCOUNT_ID
--    AND DB_LOADER_ACCOUNT_PHONES.PHONE_IS_ACTIVE = 1
    GROUP BY DB_LOADER_ACCOUNT_PHONES.ORGANIZATION_ID
  ) LOOP
    vPHONES.DELETE;
    FOR rec IN (
      SELECT DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER
        FROM DB_LOADER_ACCOUNT_PHONES,
             DB_LOADER_PHONE_STAT
        WHERE DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID=s.ACCOUNT_ID
          AND DB_LOADER_PHONE_STAT.PHONE_NUMBER(+)=DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER
          AND DB_LOADER_PHONE_STAT.YEAR_MONTH(+)=DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH
          and ((vflag='1' and nvl(DB_LOADER_PHONE_STAT.LAST_CHECK_DATE_TIME,sysdate-1-to_number(ms_params.GET_PARAM_VALUE('DAY_SITE_LOAD'),'99999999D9999',' NLS_NUMERIC_CHARACTERS = '',.'''))<=sysdate-to_number(ms_params.GET_PARAM_VALUE('DAY_SITE_LOAD'),'99999999D9999',' NLS_NUMERIC_CHARACTERS = '',.''')) or (vflag='0'))
          AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH = (
            SELECT MAX(DD.YEAR_MONTH)
              FROM DB_LOADER_ACCOUNT_PHONES DD
              WHERE DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID=DD.ACCOUNT_ID)
          AND ((DB_LOADER_ACCOUNT_PHONES.PHONE_IS_ACTIVE = 1) -- Активен
              OR -- Или был активен последние 3 дня.
                EXISTS (SELECT 1 FROM DB_LOADER_ACCOUNT_PHONE_HISTS
                          WHERE DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE > sysdate-to_number(ms_params.GET_PARAM_VALUE('DAY_SITE_LOAD'),'99999999D9999',' NLS_NUMERIC_CHARACTERS = '',.''')
                            AND DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_NUMBER=DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER
                            AND DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_IS_ACTIVE = 1
                       )
              )
          AND NVL(orgs.ORGANIZATION_ID, '---') = NVL(DB_LOADER_ACCOUNT_PHONES.ORGANIZATION_ID, '---')
          -- И телефона нет в списке запрещённых к загрузке
          AND DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER NOT IN (SELECT PHONE_NUMBER
                                                            FROM DB_LOADER_TEMPORAR_DO_NOT_LOAD)
        ORDER BY -- Сначала идут давно не загружаемые.
          DB_LOADER_PHONE_STAT.LAST_CHECK_DATE_TIME ASC NULLS FIRST
    ) LOOP
      vPHONES(vPHONES.COUNT+1) := rec.PHONE_NUMBER;
      IF vSERVER_NANE='GSM_CORP' AND rec.PHONE_NUMBER='9647214343' THEN
        vCHECKED:=1;
      END IF;
    END LOOP;
   /* SELECT strInLike(21,nvl(ac.n_method,'0;'),';','()')
      INTO pmethod
    FROM ACCOUNTS ac WHERE ac.ACCOUNT_ID=s.ACCOUNT_ID;
    if  pmethod = 0 then
    --RAISE_APPLICATION_ERROR(-20000, vPHONES2(3));
    vERROR_TEXT := LOADER_CALL_PCKG.LOAD_PHONE_DETAIL_3(s.LOGIN,
                                                        s.PASSWORD,
                                                        s.LOADING_YEAR,
                                                        s.LOADING_MONTH,
                                                        s.LOADER_SCRIPT_NAME,
                                                        s.LOADER_DB_CONNECTION,
                                                        s.LOADER_DB_USER_NAME,
                                                        s.LOADER_DB_PASSWORD,
                                                        orgs.ORGANIZATION_ID,
                                                        s.LOAD_DETAIL_THREAD_COUNT,
                                                        vPHONES);
   -- if vflag='1' and vPHONES.count>0 then
   --   FOR i IN vPHONES.FIRST .. vPHONES.LAST LOOP
   --       ttp.extend();
   --       ttp(ttp.count) := PHONE_LIST_ARRAYT(vPHONES(i));
   --   END LOOP;
    --  hot_billing_pckg.SAVE_CALL_PHONE(ttp);
   -- end if;
   else*/
     if vPHONES.count>0 then
        FOR i IN vPHONES.FIRST .. vPHONES.LAST LOOP
          hot_billing_pckg.ADD_SITE_DETAIL_API(vPHONES(i),
                                               s.LOADING_YEAR,
                                               s.LOADING_MONTH);
        END LOOP;
     end if;
   --end if;
    IF vCHECKED=1 THEN
      vBALANCE:=GET_ABONENT_BALANCE('9647214343');
      IF vBALANCE<10000 THEN
        vERROR_TEXT2:=LOADER3_pckg.SEND_SMS('9647206565', 'СМС-оповещение', 'Баланс номера 9647214343: '||TO_CHAR(vBALANCE));
      END IF;
    END IF;
    IF vERROR_TEXT IS NOT NULL THEN
      RAISE_APPLICATION_ERROR(-20200, 'Loading error. ' || vERROR_TEXT);
    END IF;
  END LOOP;
end;
--Загрузка детализаций
PROCEDURE LOAD_ACCOUNT_BILLS(
  s IN T_LOAD_SETTINGS,
  pFORCE_SET_PERIOD IN BOOLEAN,
  lOADING_DATE DATE DEFAULT SYSDATE
  --ЗАГРУЗКА ПО ПРЕДЫДУЩЕМУ МЕСЯЦУ ОТ ЭТОЙ ДАТОЙ (08.2011 ОТ 7.09.2011 ИЛИ 12.2010 ОТ 1.01.20011)
  ) IS
  vERROR_TEXT VARCHAR2(2000 CHAR);
  vMONTH INTEGER;
  vYEAR INTEGER;
BEGIN
  vMONTH:=TO_NUMBER(TO_CHAR(lOADING_DATE,'MM'));
  vYEAR:=TO_NUMBER(TO_CHAR(lOADING_DATE,'YYYY'));
  IF vMONTH = 01 THEN
    vMONTH:=12;
    vYEAR:=vYEAR-1;
  ELSE
    vMONTH:=vMONTH-1;
  END IF;
  vERROR_TEXT:=LOADER_CALL_PCKG.LOAD_BILL(
    s.LOGIN,
    s.PASSWORD,
    vYEAR,
    vMONTH,
    s.LOADER_SCRIPT_NAME,
    s.LOADER_DB_CONNECTION,
    s.LOADER_DB_USER_NAME,
    s.LOADER_DB_PASSWORD,
    pFORCE_SET_PERIOD
  );
  IF vERROR_TEXT IS NOT NULL THEN
    RAISE_APPLICATION_ERROR(-20200, 'Loading error. ' || vERROR_TEXT);
  END IF;
end;
--Загрузка счетов за месяц, предидущий к месяцу, содерщащему дату(по умолчанию работает от SYSDATE, т.е просто прошлый месяц)
PROCEDURE LOAD_ACCOUNT_BILL_DETAILS(
  s IN T_LOAD_SETTINGS,
  pFORCE_SET_PERIOD IN BOOLEAN,
  lOADING_DATE DATE DEFAULT SYSDATE
  --ЗАГРУЗКА ПО ПРЕДЫДУЩЕМУ МЕСЯЦУ ОТ ЭТОЙ ДАТОЙ (08.2011 ОТ 7.09.2011 ИЛИ 12.2010 ОТ 1.01.20011)
  ) IS
  vERROR_TEXT VARCHAR2(2000 CHAR);
  vMONTH INTEGER;
  vYEAR INTEGER;
BEGIN
  vMONTH:=TO_NUMBER(TO_CHAR(lOADING_DATE-4,'MM'));
  vYEAR:=TO_NUMBER(TO_CHAR(lOADING_DATE-4,'YYYY'));
  IF vMONTH = 01 THEN
    vMONTH:=12;
    vYEAR:=vYEAR-1;
  ELSE
    vMONTH:=vMONTH-1;
  END IF;
  vERROR_TEXT:=LOADER_CALL_PCKG.LOAD_BILL_DETAILS(
    s.LOGIN,
    s.PASSWORD,
    vYEAR,
    vMONTH,
    s.LOADER_SCRIPT_NAME,
    s.LOADER_DB_CONNECTION,
    s.LOADER_DB_USER_NAME,
    s.LOADER_DB_PASSWORD,
    pFORCE_SET_PERIOD
  );
  IF vERROR_TEXT IS NOT NULL THEN
    RAISE_APPLICATION_ERROR(-20200, 'Loading error. ' || vERROR_TEXT);
  END IF;
end;
--
PROCEDURE LOAD_PREV_ACCOUNT_DATA(pACCOUNT_ID IN INTEGER,
    pSTART_YEAR IN INTEGER,
    pSTART_MONTH IN INTEGER,
    pEND_YEAR IN INTEGER,
    pEND_MONTH IN INTEGER
    ) IS
--  vERR ACCOUNT_LOAD_LOGS.ERROR_TEXT%TYPE;
  s T_LOAD_SETTINGS;
  vMONTH INTEGER;
  vYEAR INTEGER;
BEGIN
  s := GET_LOADER_SETTINGS(pACCOUNT_ID);
  IF s.LOADER_SCRIPT_NAME IS NULL THEN
    RAISE_APPLICATION_ERROR(-20091, 'В справочнике не указан тип загрузки.');
  END IF;
  IF s.PASSWORD IS NULL THEN
    RAISE_APPLICATION_ERROR(-20091, 'В справочнике не указан пароль.');
  END IF;
  IF s.LOGIN IS NULL THEN
    RAISE_APPLICATION_ERROR(-20091, 'В справочнике не указан логин.');
  END IF;
  vMONTH := pSTART_MONTH;
  vYEAR := pSTART_YEAR;
  WHILE vMONTH <= pEND_MONTH AND vYEAR <= pEND_YEAR LOOP
    s.LOADING_MONTH := vMONTH;
    s.LOADING_YEAR := vYEAR;
    -- Платежи
    --LOAD_ACCOUNT_PAYMENTS(s);
    -- Счёт
    LOAD_ACCOUNT_BILLS(s, TRUE, TO_DATE(TO_CHAR(s.LOADING_YEAR*100+s.LOADING_MONTH)||'01','YYYYMMDD')+31);
    --Переводим месяц и год в дату, с добавлением 1 месяца, т.к. процедура выдает к месяцу предшест дате.
    COMMIT;
    vMONTH := vMONTH + 1;
    IF vMONTH >= 12 THEN
      vYEAR := vYEAR + 1;
      vMONTH := 1;
    END IF;
  END LOOP;
END;
--Загрузка счетов прошлых периодов
PROCEDURE LOAD_PREV_PAYMENTS(
  pACCOUNT_ID IN INTEGER,
  pYEAR IN INTEGER,
  pMONTH IN INTEGER
  ) IS
s T_LOAD_SETTINGS;
--vERROR_TEXT VARCHAR2(2000);
BEGIN
  s := GET_LOADER_SETTINGS(pACCOUNT_ID);
  IF s.LOADER_SCRIPT_NAME IS NULL THEN
    RAISE_APPLICATION_ERROR(-20091, 'В справочнике не указан тип загрузки.');
  END IF;
  IF s.PASSWORD IS NULL THEN
    RAISE_APPLICATION_ERROR(-20091, 'В справочнике не указан пароль.');
  END IF;
  IF s.LOGIN IS NULL THEN
    RAISE_APPLICATION_ERROR(-20091, 'В справочнике не указан логин.');
  END IF;
  s.LOADING_MONTH := pMONTH;
  s.LOADING_YEAR := pYEAR;
  LOAD_ACCOUNT_PAYMENTS(s);
END;

--Загрузка платежей за конкретный месяц
PROCEDURE LOAD_REPORT_DATA(
    pACCOUNT_ID IN INTEGER
    ) IS
s T_LOAD_SETTINGS;
vERROR_TEXT VARCHAR2(2000 CHAR);
LOAD_TYPE INTEGER;
LOADING_TYPE_NAME VARCHAR2(200);
LOAD_METHOD integer; ---тип загрузки из accounts: 1 - новая, 0- старая
LOAD_METHOD_ERR integer;
begin_date date;
percent integer;
cnt integer;
cnt_total integer;
new_sum integer;
cursor c is select * from DB_LOADER_REPORT_DATA_TMP;
--Загрузка отчетов о начислениях текущего месяца
BEGIN
 begin_date:=sysdate; -- сохраняем дату начала загрузки
 percent:=75; -- устанавливаем порог, процент записей от общего числа загруженных, у которых уменьшилась сумма начислений
 -- Сохраняем данные
 INSERT INTO DB_LOADER_REPORT_DATA_TMP
  select * from DB_LOADER_REPORT_DATA
  where year_month=(select max(year_month) from DB_LOADER_REPORT_DATA
                    where get_account_id_by_phone(phone_number)= pACCOUNT_ID)
    and get_account_id_by_phone(phone_number)= pACCOUNT_ID;

LOAD_METHOD:=0; ---тип загрузки из accounts: 1 - новая, 0- старая
LOAD_METHOD_ERR:=0;
      begin--проверяем каким методом грузить
        select strinlike('6',acc.n_method,';','()') into LOAD_METHOD from accounts acc where acc.account_id=pACCOUNT_ID;
      exception
        when others then null;
      end;
  if LOAD_METHOD>0 then
    loader_call_pckg_n.LOAD_REPORT_DATA(pACCOUNT_ID);--новый метод
    begin
    select distinct t.account_id into LOAD_METHOD_ERR from account_load_logs t--проверяем лог за последние 5 мин.
                                 where
                               t.load_date_time between (sysdate-2/1440) and (sysdate)
                               and t.is_success=0
                               and t.account_load_type_id=6
                               and t.account_id=pACCOUNT_ID;
    exception
      when no_data_found then null;-- Значить всё прошло ОК!
    end;
  end if;
      if(LOAD_METHOD=0) or  LOAD_METHOD_ERR>0--если есть ошибка в логе используем старый метод
       then
        for c in (select distinct t.account_id from iot_acc_report_data_temp t --проверка на разрешение загрузки
                where t.account_id=pACCOUNT_ID and t.can_load=1 and t.year_month=to_char(sysdate,'YYYYMM'))
         loop
            LOAD_TYPE:=6;
            LOADING_TYPE_NAME:=GET_NAME_LOAD(LOAD_TYPE);
            s := GET_LOADER_SETTINGS(pACCOUNT_ID);
            vERROR_TEXT := LOADER_CALL_PCKG.LOAD_REPORT_DATA(
              s.LOGIN,
              s.PASSWORD,
              s.LOADING_YEAR,
              s.LOADING_MONTH,
              s.LOADER_SCRIPT_NAME,
              s.LOADER_DB_CONNECTION,
              s.LOADER_DB_USER_NAME,
              s.LOADER_DB_PASSWORD
            );
         end loop c;
    end if;
  --сравнение новых и старых данных
  select count(*) into cnt_total from DB_LOADER_REPORT_DATA_TMP;
  if cnt_total > 0 then
    cnt:=0;
    for v in c loop
      exit when c%notfound;
      begin
        select d.detail_sum into new_sum from DB_LOADER_REPORT_DATA d
        where d.date_last_update >= begin_date and d.phone_number = v.phone_number;
      exception
        when no_data_found then new_sum:=v.detail_sum; --делаем текущую сумму наверняка не меньше
      end;
      if new_sum < v.detail_sum then
         cnt:=cnt+1;
      end if;
      if ( cnt*100/cnt_total >= percent ) then
        exit;
      end if;
    end loop;
    if ( cnt*100/cnt_total >= percent ) then
      --переход на новый месяц
     update DB_LOADER_REPORT_DATA set year_month = (select max(year_month)+1 from DB_LOADER_REPORT_DATA_TMP)
     where date_last_update >= begin_date
       and get_account_id_by_phone(phone_number)= pACCOUNT_ID;
     insert into DB_LOADER_REPORT_DATA select * from DB_LOADER_REPORT_DATA_TMP;
    else
     --оставляем месяц прежним
     update DB_LOADER_REPORT_DATA set year_month = (select max(year_month) from DB_LOADER_REPORT_DATA_TMP)
     where date_last_update >= begin_date
       and get_account_id_by_phone(phone_number)= pACCOUNT_ID;
    end if;
  end if;
  COMMIT;
  IF vERROR_TEXT IS NOT NULL THEN
        RAISE_APPLICATION_ERROR(-20200, 'Loading error. ' || vERROR_TEXT);
  END IF;
END;
--
--
FUNCTION READ_FIELD_DETAILS(
    pACCOUNT_ID IN INTEGER,
    pYEAR_MONTH IN INTEGER,
    pFIELD_ID IN INTEGER
    ) RETURN VARCHAR2 IS
s T_LOAD_SETTINGS;
vERROR_TEXT VARCHAR2(2000 CHAR);
--LOADING_TYPE_NAME VARCHAR2(200);
BEGIN
  s := GET_LOADER_SETTINGS(pACCOUNT_ID);
  vERROR_TEXT := LOADER_CALL_PCKG.READ_FIELD_DETAILS(
    s.LOGIN,
    s.PASSWORD,
    TRUNC(pYEAR_MONTH/100),
    pYEAR_MONTH-TRUNC(pYEAR_MONTH/100)*100,
    s.LOADER_SCRIPT_NAME,
    s.LOADER_DB_CONNECTION,
    s.LOADER_DB_USER_NAME,
    s.LOADER_DB_PASSWORD,
    pFIELD_ID
  );
  RETURN vERROR_TEXT;
END;
--Загрузка отчетов о начислениях текущего месяца
PROCEDURE LOAD_ACCOUNT_DATA(
  pACCOUNT_ID IN INTEGER,
  pLOAD_TYPE IN INTEGER
  ) IS
  --Процедура Запуска загрузок по Типу загрузки и Аккаунту
  --1: Платежи
  --2: Детализации
  --3: Статусы телефонов
  --4: Подключенные опции
  --5: Счета
  --6: Отчеты о текущих начислениях
  --7: Детализированные счета из раздела "Финансовая информация"
  --8: Детализированные счета из раздела "Финансовая информация", обратный поток.
vERROR ACCOUNT_LOAD_LOGS.ERROR_TEXT%TYPE;
TEXT_ERROR VARCHAR2(2000 CHAR);
s T_LOAD_SETTINGS;
LOADING_TYPE_NAME VARCHAR2(200);
TIME_TURN DATE;
I INTEGER;
begin
  TIME_TURN:=SYSDATE;
  s := GET_LOADER_SETTINGS(pACCOUNT_ID);
  LOADING_TYPE_NAME:=GET_NAME_LOAD(pLOAD_TYPE);
  IF (s.DO_AUTO_LOAD_DATA = 1) AND (s.LOADER_SCRIPT_NAME IS NOT NULL) THEN
    CASE pLOAD_TYPE
      WHEN 1 THEN LOAD_ACCOUNT_PAYMENTS(S);
      WHEN 2 THEN LOAD_ACCOUNT_DETAILS(S);
      WHEN 3 THEN LOAD_ACCOUNT_PHONES(S, FALSE);
      WHEN 4 THEN LOAD_ACCOUNT_PHONES(S, TRUE);
      WHEN 5 THEN LOAD_ACCOUNT_BILLS(S, FALSE);
      WHEN 6 THEN LOAD_REPORT_DATA(pACCOUNT_ID);
      WHEN 7 THEN LOAD_ACCOUNT_BILL_DETAILS(S, TRUE);
      WHEN 8 THEN LOAD_ACCOUNT_BILL_DETAILS(S, FALSE);
    END CASE;
/*    --Проверка на Удачное выполнение новым методом
    begin
    select distinct t.account_id into i from account_load_logs t--проверяем лог за последние 1 мин.
                                 where
                               t.load_date_time>(sysdate-1/1440)
                               and t.is_success=1
                               and t.account_load_type_id=pLOAD_TYPE
                               and t.account_id=pACCOUNT_ID;
    exception
    when no_data_found then i:='';
    end;
    --Если всё ок тогда ещё раз лог не пишем.
    if i is null then*/

    IF pLOAD_TYPE=2 THEN
      SELECT strInLike(21,nvl(ac.n_method,'0;'),';','()')
      INTO I
      FROM ACCOUNTS ac WHERE ac.ACCOUNT_ID=pACCOUNT_ID;
      if I = 0 then
       SELECT COUNT(*)
       INTO I
        FROM DB_LOADER_PHONE_STAT
        WHERE DB_LOADER_PHONE_STAT.LAST_CHECK_DATE_TIME>=TIME_TURN
            AND DB_LOADER_PHONE_STAT.ACCOUNT_ID=pACCOUNT_ID
            AND DB_LOADER_PHONE_STAT.YEAR_MONTH=TO_NUMBER(TO_CHAR(TIME_TURN,'YYYYMM'));
      else
        select count(*)
        INTO I
        from BEELINE_SOAP_API_LOG al
        where al.account_id=pACCOUNT_ID
              and al.insert_date>=TIME_TURN
              and al.load_type=2;
      end if;
      TEXT_ERROR:=' Успешно загружено детализаций: ' || TO_CHAR(I) || '.';
    else
      TEXT_ERROR:='';
    end if;
    INSERT INTO ACCOUNT_LOAD_LOGS(ACCOUNT_LOAD_LOG_ID, ACCOUNT_ID, LOAD_DATE_TIME,
                                   IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID)
      VALUES(NEW_ACCOUNT_LOAD_LOG_ID, pACCOUNT_ID, SYSDATE,
             1, TEXT_ERROR, pLOAD_TYPE);
    COMMIT;
/*    end if;*/
    ---
  END IF;
EXCEPTION WHEN OTHERS THEN
  vERROR := SQLERRM;
  IF pLOAD_TYPE=2 THEN
    SELECT strInLike(21,nvl(ac.n_method,'0;'),';','()')
      INTO I
      FROM ACCOUNTS ac WHERE ac.ACCOUNT_ID=pACCOUNT_ID;
      if I = 0 then
       SELECT COUNT(*)
       INTO I
        FROM DB_LOADER_PHONE_STAT
        WHERE DB_LOADER_PHONE_STAT.LAST_CHECK_DATE_TIME>=TIME_TURN
            AND DB_LOADER_PHONE_STAT.ACCOUNT_ID=pACCOUNT_ID
            AND DB_LOADER_PHONE_STAT.YEAR_MONTH=TO_NUMBER(TO_CHAR(TIME_TURN,'YYYYMM'));
      else
        select count(*)
        INTO I
        from BEELINE_SOAP_API_LOG al
        where al.account_id=pACCOUNT_ID
              and al.insert_date>=TIME_TURN
              and al.load_type=2;
      end if;
    TEXT_ERROR:='Ошибка загрузки: ' || LOADING_TYPE_NAME || '. Успешно загружено детализаций: ' || TO_CHAR(I) || '. ' || vERROR;
  ELSE
    TEXT_ERROR:='Ошибка загрузки: ' || LOADING_TYPE_NAME || '. ' || vERROR;
  END IF;
  TEXT_ERROR:=REPLACE(TEXT_ERROR,'ORA-20200: Loading error.','');
  INSERT INTO ACCOUNT_LOAD_LOGS(ACCOUNT_LOAD_LOG_ID, ACCOUNT_ID, LOAD_DATE_TIME,
                                 IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID)
    VALUES(NEW_ACCOUNT_LOAD_LOG_ID, pACCOUNT_ID, SYSDATE,
           0, TEXT_ERROR, pLOAD_TYPE);
  COMMIT;
END;

-- Загрузка подключенных услуг
PROCEDURE LOAD_ACCOUNT_PHONE_OPTIONS(pPHONE_NUMBER IN VARCHAR2, pERROR OUT VARCHAR2) IS
  vERROR_TEXT VARCHAR2(2000 CHAR);
  s T_LOAD_SETTINGS;
  LOADING_TYPE_NAME VARCHAR2(200);
BEGIN
  s := GET_LOADER_SETTINGS(get_account_id_by_phone(pPHONE_NUMBER));

  vERROR_TEXT := LOADER_CALL_PCKG.LOAD_PHONE_OPTIONS(
    s.LOGIN,
    s.PASSWORD,
    s.LOADING_YEAR,
    s.LOADING_MONTH,
    s.LOADER_SCRIPT_NAME,
    s.LOADER_DB_CONNECTION,
    s.LOADER_DB_USER_NAME,
    s.LOADER_DB_PASSWORD,
    pPHONE_NUMBER
  );
  LOADING_TYPE_NAME:=GET_NAME_LOAD(4);
  IF vERROR_TEXT IS NULL THEN
    INSERT INTO ACCOUNT_LOAD_LOGS(ACCOUNT_LOAD_LOG_ID, ACCOUNT_ID, LOAD_DATE_TIME,
                                   IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID)
    VALUES(NEW_ACCOUNT_LOAD_LOG_ID, get_account_id_by_phone(pPHONE_NUMBER), SYSDATE,
           1, NULL, 4);
    pError := 'Подключенные услуги успешно обновлены!';
  ELSE
    INSERT INTO ACCOUNT_LOAD_LOGS(ACCOUNT_LOAD_LOG_ID, ACCOUNT_ID, LOAD_DATE_TIME,
                                 IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID)
    VALUES(NEW_ACCOUNT_LOAD_LOG_ID, get_account_id_by_phone(pPHONE_NUMBER), SYSDATE,
           0, 'Ошибка загрузки: ' || LOADING_TYPE_NAME || '. ' || vERROR_TEXT, 4);
    pERROR := 'Ошибка при обновлении подключенных услуг с сайта: ' ||vERROR_TEXT;
  END IF;
  COMMIT;
end;

END;
