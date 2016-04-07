
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."CALC_BALANCE_ROWS2" (
  pPHONE_NUMBER IN VARCHAR2,
  pDATE_ROWS IN OUT NOCOPY DBMS_SQL.DATE_TABLE,
  pCOST_ROWS IN OUT NOCOPY DBMS_SQL.NUMBER_TABLE,
  pDESCRIPTION_ROWS IN OUT NOCOPY DBMS_SQL.VARCHAR2_TABLE,
  pFILL_DESCRIPTION IN BOOLEAN DEFAULT TRUE,
  pBALANCE_DATE IN DATE DEFAULT NULL,
  pDAILYWRITEOFF IN INTEGER DEFAULT 0
  ) IS
--
--#Version=75
--75. 2015.12.14 Алексеев. Изменил логику для номеров с отсрочкой абонки. Убрал проверку на месяц существования контаркта.
--                                      Теперь алгоритм отсрочки списания абонки распространяется только на номера, находящиеся в таблице PHONE_CALC_ABON_TP_UNLIM_ON,
--                                      вне зависимости от месяца заведения контракта.
--74. 2015.12.09 Афросин. Заменил латинскую букву 'c' на кириллицу в расшифровке списания абон.платы 
--73. 2015.08.26 Крайнов. Оптимизация вычисления даны начала можелирования..
--72. Крайнов. Поправки по подключению счетов.
--71. Крайнов. Изменены начисления услуг.
--70. Крайнов. Добавлена связь системой баланса 2.0.
--69. Крайнов. Устранены ошибки абонок при смене ТП.
--68. Алексеев. Ввел изменения по алгоритму отсрочки списания абонки.
--67. Крайнов. Списание услуг изменено, учтена активность номера.
--66. Крайнов. Исправление определения пред дискретных периодов.
--65. Крайнов. Оптимизация.
--64. Крайнов. Переключение баланса на счета Тарифера.
--63. Крайнов. Удаление лишних абонок в блоке.
--62. Крайнов. Поправки по Драйвам.
--61. Крайнов. Добавление нового вида тарифов.
--60. Крайнов. Замена курсора по истории на заранее подсчитанную таблицу абон активности DB_LOADER_ABONENT_PERIODS
--59. Крайнов. Сменил учет периодов для моделирования, сокращения числа дней проверки при отсутсвии данных после смены месяца.
--58. #1412, #1343
--55. Крайнов. Добавил учет групп услуг.
--54. Назин. Закоментил костыль в APPEND_ROW исключающий учёт деталок для номеров из balance_var_except
--54. Назин. Вставил костыль в APPEND_ROW исключающий учёт деталок для номеров из balance_var_except
--53. Крайнов. пОПРАВКА РАСЧЕТА ДИСКРЕТНЫХ УСЛУГ при подключении посреди месяца
--52. Крайнов. Исправление бага РАССЧЕТА УСЛУГ ПРИ ПОЛНОМ БЛОКЕ..
--51. Крайнов. Исправление бага при расчете в прошлых месяцах(попадала деталка текущего).
--50. Крайнов. Дискретное списание услуг.
--49. Крайнов. Смена дней учета блок абонки на парамерт из справочника. Уточнение описания строк рассрочки.
--48. Крайнов. Добавление округлений при учете дат.
--46. Крайнов. Исправление дублирования модуляции при смене л/с посреди месяца
--44. Крайнов. правка ошибок
--35. Крайнов. Исправил ошибку определения тарифа у услуги.
--25. Крайнов. Поставил учет дней, за которые абонка уже начислилась(убрал перехлест)
--24. Крайнов. Добавил округлений даты, дни(концы периода акт) - активны.
--23. Крайнов. Переделал учет периодов под К7, сохраняя мод GSM
--22. Крайнов. Переделал учет даты активации при подсчете абонплаты
--21. Уколов. Теперь засчитываются платежи, сделанные за 4 дня до даты договора.
--20. Крайнов. Добавлено начисление процента владельца(RECALC_CHARGE_COST).
--19. Крайнов. Если сумма в отчете начислений больше, то считаем ее, вместо суммы в детализациях.
--18. Крайнов. Поставил учет опций прошлого месяца, если за новый нет данных.
--17. Уколов. Сделал зачет платежей, прикрепленных к контракту вручную.
--16. Уколов. Сделал коррекцию даты активации согласно константе CORRECT_ACTIVATION_DATE_DAYS.
--    Если константы нет, то коррекция не делается.
--15. Уколов. Поправил расчёт абонплаты за услугу по алгоритму "до сегодня".
--    Раньше считалось до конца месяца независимо от настроек расчёта.
--    При вычислении тарифа для стоимости услуг сделал поправку в 5 дней на случай задержки загрузки.
--14. Крайнов. Добавил защиту по дате контракта.
--13. Уколов. Добавил защиту на удвоение абонплаты при неправильной входной информации об организации.
--12. 29.08.2011 Крайнов. Добавил обрезание абон платы по дате, до входной
-- Не учитываем историю изменения условий тарифов (нет данных)
--
  DAY_PAY_IN_BLOK CONSTANT NUMBER:=5;
  DAYS_NESTABIL CONSTANT INTEGER:=5;
  cDAYS_PAYMENT_BEFORE_CONTRACT INTEGER := 4; -- Дня до начала контракта, для которых нужно засчитывать платежи
  vTEMP_DATE_BEGIN_ABON DATE;
  vCONTRACT_DATE        DATE;
  CURSOR C_CONTRACT IS
    SELECT  CONTRACTS.CONTRACT_DATE,
            CONTRACTS.CONTRACT_ID,
            CONTRACTS.IS_CREDIT_CONTRACT,
            CONTRACTS.ABON_TP_DISCOUNT,
            CONTRACTS.INSTALLMENT_PAYMENT_DATE,
            CONTRACTS.INSTALLMENT_PAYMENT_SUM,
            CONTRACTS.INSTALLMENT_PAYMENT_MONTHS,
            CONTRACTS.OPTION_GROUP_ID
      FROM CONTRACTS
      WHERE CONTRACTS.PHONE_NUMBER_FEDERAL = pPHONE_NUMBER
        AND (pBALANCE_DATE IS NULL OR CONTRACTS.CONTRACT_DATE <= pBALANCE_DATE)
      ORDER BY CONTRACTS.CONTRACT_DATE DESC;
  CURSOR C_BALANCE(aPHONE_NUMBER VARCHAR2, aCONTRACT_DATE date) IS
    SELECT PHONE_BALANCES.BALANCE_DATE,
           PHONE_BALANCES.BALANCE_VALUE,
           PHONE_BALANCES.FIX_YEAR_MONTH_ID
      FROM PHONE_BALANCES
      WHERE PHONE_BALANCES.PHONE_NUMBER = aPHONE_NUMBER
        AND (pBALANCE_DATE IS NULL OR PHONE_BALANCES.BALANCE_DATE <= pBALANCE_DATE)
        and (aCONTRACT_DATE IS NULL OR PHONE_BALANCES.BALANCE_DATE >= aCONTRACT_DATE)
      ORDER BY PHONE_BALANCES.BALANCE_DATE DESC;
  CURSOR DEP(pCONTRACT_ID IN INTEGER) IS
    SELECT CURRENT_DEPOSITE_VALUE, DATE_DEPOSITE_CHANGE
      FROM CONTRACT_DEPOSITES
      WHERE CONTRACT_ID=pCONTRACT_ID;
  CURSOR OPER(pCONTRACT_ID IN INTEGER,pDATE DATE) IS
    SELECT NOTE
      FROM CONTRACT_DEPOSITE_OPER
      WHERE CONTRACT_ID=pCONTRACT_ID
        AND OPERATION_DATE_TIME=pDATE;
  CURSOR CODE(pDATE IN DATE) IS
    SELECT CELL_PLAN_CODE
      FROM DB_LOADER_ACCOUNT_PHONE_HISTS
      WHERE DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_NUMBER=pPHONE_NUMBER
        AND DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE<=pDATE
        AND DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE>=pDATE;
  CURSOR DB_REPORT(pYEAR_MONTH IN INTEGER) IS
    SELECT DATE_LAST_UPDATE,
           --Процент владельца добавляется к стоимости
           TRUNC(RECALC_CHARGE_COST(pPHONE_NUMBER, -DETAIL_SUM), 2) AS BILL_SUM,
           'Дет. зв. из тек. нач. за ' || TO_CHAR(DATE_LAST_UPDATE,'MM.YYYY') || ' (на '
           || TO_CHAR(DATE_LAST_UPDATE,'DD.MM.YYYY HH24:MI') || ')' AS REMARKS
      FROM DB_LOADER_REPORT_DATA
      WHERE DB_LOADER_REPORT_DATA.PHONE_NUMBER=pPHONE_NUMBER
        AND DB_LOADER_REPORT_DATA.YEAR_MONTH=pYEAR_MONTH;
  CURSOR NEW_DATE_ABON(pSTART_BALANCE_DATE IN DATE,
                       pCORRECT_ACTIVATION_DATE_DAYS IN INTEGER) IS
    SELECT FIRST_VALUE(DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE) OVER (ORDER BY DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE ASC)
        FROM DB_LOADER_ACCOUNT_PHONE_HISTS
        WHERE DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_NUMBER=pPHONE_NUMBER
          AND DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_IS_ACTIVE=1
          AND DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE>=pSTART_BALANCE_DATE-pCORRECT_ACTIVATION_DATE_DAYS
          AND DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE<=pSTART_BALANCE_DATE+pCORRECT_ACTIVATION_DATE_DAYS;
  CURSOR ACC_ID IS
    SELECT P1.ACCOUNT_ID
      FROM DB_LOADER_ACCOUNT_PHONES P1
      WHERE P1.PHONE_NUMBER=pPHONE_NUMBER
        AND P1.YEAR_MONTH=(SELECT MAX(P2.YEAR_MONTH)
                             FROM DB_LOADER_ACCOUNT_PHONES P2);
  CURSOR OPT_ACT(pBEGIN_DATE IN DATE, pEND_DATE IN DATE) IS
    SELECT CASE
             WHEN TRUNC(H.BEGIN_DATE) > TRUNC(pBEGIN_DATE) THEN TRUNC(H.BEGIN_DATE)
             ELSE TRUNC(pBEGIN_DATE)
           END BEGIN_DATE,
           CASE
             WHEN TRUNC(H.END_DATE) < TRUNC(pEND_DATE) THEN TRUNC(H.END_DATE)
             ELSE TRUNC(pEND_DATE)
           END END_DATE
      FROM DB_LOADER_ABONENT_PERIODS H
      WHERE H.PHONE_NUMBER=pPHONE_NUMBER
        AND TRUNC(H.BEGIN_DATE)<=TRUNC(pEND_DATE)
        AND TRUNC(H.END_DATE)>=TRUNC(pBEGIN_DATE)
        AND H.IS_ACTIVE=1
      ORDER BY H.BEGIN_DATE ASC;
  CURSOR PH_W_D_A IS
    SELECT *
      FROM PHONE_NUMBER_WITH_DAILY_ABON PHA
      WHERE PHA.PHONE_NUMBER=pPHONE_NUMBER;
  CURSOR TARIFF_PAY_TYPE IS
    SELECT NVL(tariffs.TARIFF_ABON_DAILY_PAY, 1) CALC_ABON_PAYMENT_TO_NOW
           from tariffs
           where TARIFFS.TARIFF_ID =
                   GET_PHONE_TARIFF_ID(pPHONE_NUMBER,
                                       (select DB_LOADER_ACCOUNT_PHONES.CELL_PLAN_CODE
                                          from DB_LOADER_ACCOUNT_PHONES
                                          WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER=pPHONE_NUMBER
                                            AND DB_LOADER_ACCOUNT_PHONES.LAST_CHECK_DATE_TIME=
                                                 (select MAX(P2.LAST_CHECK_DATE_TIME)
                                                    from DB_LOADER_ACCOUNT_PHONES P2
                                                    WHERE P2.PHONE_NUMBER=pPHONE_NUMBER
                                                    )),
                                       SYSDATE);
  CURSOR SDVIG_D(cTARIFF_ID IN INTEGER, cBEGIN_DATE IN DATE, cSDVIG_DISCR_SPISANIE IN INTEGER) IS
    SELECT *
      FROM DB_LOADER_ABONENT_PERIODS D
      WHERE D.PHONE_NUMBER = pPHONE_NUMBER
        AND D.TARIFF_ID = cTARIFF_ID
        AND D.BEGIN_DATE < cBEGIN_DATE
        AND D.YEAR_MONTH = TO_NUMBER(TO_CHAR(ADD_MONTHS(cBEGIN_DATE, -cSDVIG_DISCR_SPISANIE), 'YYYYMM'))
        AND NOT EXISTS (SELECT 1
                          FROM DB_LOADER_ABONENT_PERIODS D1
                          WHERE D1.PHONE_NUMBER = pPHONE_NUMBER
                            AND D1.TARIFF_ID <> cTARIFF_ID
                            AND D1.BEGIN_DATE < cBEGIN_DATE 
                            AND D1.BEGIN_DATE > D.BEGIN_DATE);                                       
  vACCOUNT_ID INTEGER;
  recCODE DB_LOADER_ACCOUNT_PHONE_HISTS.CELL_PLAN_CODE%TYPE;
  recDEP DEP%ROWTYPE;
  recOPER OPER%ROWTYPE;
  vCONTRACT_ID          CONTRACTS.CONTRACT_ID%TYPE;
  vCREDIT CONTRACTS.IS_CREDIT_CONTRACT%TYPE;
  vSTART_BALANCE_VALUE  NUMBER(15, 2);
  vSTART_BALANCE_DATE   DATE;
  vSTART_BALANCE_DATE_FOR_PAYMS DATE;
  vABON_PAYMENT_START_DATE DATE;
  vOPTION_GROUP_ID INTEGER;
  vSERVICE_START_DATE DATE; -- Дана начала  расчёта абонплаты за услугу.
  vSERVICE_END_DATE DATE;   -- Дата окончания расчёта абонплаты за услугу.
  vNEW_TURN_ON_COST NUMBER; -- Стоимость подключение тарифной опции (из справочника).
  vNEW_MONTHLY_COST NUMBER; -- Стоимость опции в месяц (из справочника).
  ABON_PAY_DAY_AFTER_BLOCK BOOLEAN;
  HISTORY_ID_ACT INTEGER;
  HISTORY_ID_BL INTEGER;
  HISTORY_ID_END_DATE DATE;
  REC_BILL_DATE DATE;
  REC_BILL_SUM NUMBER;
  REC_REMARK VARCHAR2(300);
  rec_REPORT DB_REPORT%ROWTYPE;
  FLAG_CURR_MONTH INTEGER;
  FLAG_DATA_OPTIONS_CURR_MONTH INTEGER;
  PAYMENTS_PREV_MONTH INTEGER;
  vCALC_ABON_PAYMENT_TO_MONTHEND BOOLEAN; -- Признак расчёта абонплаты до конца месяца
  --
  -- Количество дней, на которые надо делать коррекцию расчёта абонплаты.
  -- Если дата активации не совпадает с датой договора, то нужно делать расчёт от даты активации.
  vCORRECT_ACTIVATION_DATE_DAYS INTEGER;
 -- vTEMP_DATE_BEGIN_ABON DATE; -- Временная переменная(хранит дату активации)
  PREV_STATUS NUMBER;
  pCALC_ABON_PAYMENT_TO_MONTHEND INTEGER;
  TEMP_DATE_BEGIN_SCHET DATE;  -- Дата, по-которую абонка рассчитана
  vDATE_SERVICE_CHECK DATE;
  vSERVER_NAME VARCHAR2(50 CHAR);
  vCALC_OPTIONS_DAILY_ACTIV varchar2(30 char);
  vLAST_DAY_OPTION_ADD DATE;
  vCOUNT_ACT_OPTION INTEGER;
  vDUMMY_PH PH_W_D_A%ROWTYPE;
  vFIX_YEAR_MONTH_ID INTEGER;
  vSERVICE_PAID_FULL INTEGER;
  vDUMMY_TPT TARIFF_PAY_TYPE%rowtype;
  vCHECK_ABON_MODULE_DATE DATE;
  vABON_DISCOUNT integer;
  vINST_PAYMENT_DATE date;
  vINST_PAYMENT_SUM number(13, 2);
  vINST_PAYMENT_MONTH integer;
  vINST_TEMP_DATE date;
  vINST_TEMP_SUM number(13, 2);
  vINST_TEMP_DESCR VARCHAR2(300 CHAR);
  vABON_COEFFICIENT number(15, 4);
  i INTEGER;
  vCALC_ABON_BLOCK_COUNT_DAYS NUMBER;
  vPERIOD_ACTIV INTEGER;
  vOPTION_GROUP_COSTS DBMS_SQL.VARCHAR2_TABLE;
  vOPTION_GROUP_LIST VARCHAR2(500 CHAR);
  L BINARY_INTEGER;
  I BINARY_INTEGER;
  vPREV_DISCR_TARIFF_ID INTEGER;
  VPREV_DISCR_YEAR_MONTH INTEGER;
  NEED_DISCR_SPISANIE INTEGER;
  NEED_DAILY_SPISANIE INTEGER;
  pPhoneCnt INTEGER;
  DUMMY_S_D SDVIG_D%ROWTYPE;
  vOPTS_ROWID DBMS_SQL.VARCHAR2_TABLE;
  vCHECK_OPTS INTEGER;
--
  PROCEDURE APPEND_ROW(pDATE DATE, pCOST NUMBER, pDESCRIPTION VARCHAR2) IS
    C BINARY_INTEGER;
  --  exclude integer;
  BEGIN
/*
  --Отбор исключений
        begin
        select 1 into exclude from dual
             where exists(select * from balance_var_except w where w.phone_number=pPHONE_NUMBER
                                                               and w.date_close is null
                                                               and w.enable=1
                                                               and decode(substr(upper(pDESCRIPTION),1,3)
                                                               ,'ДЕТ',1
                                                               ,0)=w.var_type);
        exception
          when others then exclude:=0;
        end; */
    IF pCOST <> 0 /*and exclude=0*/ THEN
      C := pDATE_ROWS.COUNT+1;
      pDATE_ROWS(C) := pDATE;
      pCOST_ROWS(C) := pCOST;
      IF pFILL_DESCRIPTION THEN
        pDESCRIPTION_ROWS(C) := pDESCRIPTION;
      END IF;
    END IF;
  END;
--
  function fLOAD_BILL_IN_BALANCE(faccount_id number,fYEAR_MONTH number) return number is
    res number:=0;
  begin
    SELECT count(*) into res
      FROM ACCOUNT_LOADED_BILLS AB
      WHERE AB.ACCOUNT_ID=faccount_id and AB.YEAR_MONTH>=fYEAR_MONTH
        and AB.LOAD_BILL_IN_BALANCE = 1;
    if res>0 then 
      res:=1; 
    end if;
    return res;
  end;
--
  function F_CHECK_OPTION(ROWID_CHAR IN VARCHAR2) 
    return INTEGER is
    L INTEGER;
    J INTEGER;
    N INTEGER;
  begin
    J:=vOPTS_ROWID.LAST;   
    N:=0; 
    IF J IS NOT NULL THEN
      FOR L IN vOPTS_ROWID.FIRST..vOPTS_ROWID.LAST
      LOOP
        IF vOPTS_ROWID(L) = ROWID_CHAR THEN
          N:=L;
        END IF;
      END LOOP;
      IF N=0 THEN -- Ранее не встечалось
        L:=vOPTS_ROWID.COUNT;
        vOPTS_ROWID(L+1):=ROWID_CHAR;        
      END IF;
    ELSE
      vOPTS_ROWID.DELETE;
      N:=vOPTS_ROWID.COUNT;
      vOPTS_ROWID(N+1):=ROWID_CHAR;
    END IF;
    return N;
  end;
--  
BEGIN
  --
  pDATE_ROWS.DELETE;
  pCOST_ROWS.DELETE;
  pDESCRIPTION_ROWS.DELETE;
  vOPTS_ROWID.DELETE;
  --
  vABON_PAYMENT_START_DATE:=TO_DATE('01.01.1990', 'DD.MM.YYYY');
  OPEN ACC_ID;
  FETCH ACC_ID INTO vACCOUNT_ID;
  IF ACC_ID%NOTFOUND THEN
    vACCOUNT_ID:=0;
  END IF;
  CLOSE ACC_ID;
  --
  vCALC_ABON_PAYMENT_TO_MONTHEND := ('1' = MS_CONSTANTS.GET_CONSTANT_VALUE('CALC_ABON_PAYMENT_TO_MONTH_END'));
  IF vCALC_ABON_PAYMENT_TO_MONTHEND THEN
    OPEN PH_W_D_A;
    FETCH PH_W_D_A INTO vDUMMY_PH;
    IF PH_W_D_A%FOUND THEN
      pCALC_ABON_PAYMENT_TO_MONTHEND:=0;
    ELSE
      OPEN TARIFF_PAY_TYPE;
      FETCH TARIFF_PAY_TYPE INTO vDUMMY_TPT;
      IF TARIFF_PAY_TYPE%FOUND THEN
        pCALC_ABON_PAYMENT_TO_MONTHEND:=vDUMMY_TPT.CALC_ABON_PAYMENT_TO_NOW;
      ELSE
        pCALC_ABON_PAYMENT_TO_MONTHEND:=1;
      END IF;
      CLOSE TARIFF_PAY_TYPE;
    END IF;
    CLOSE PH_W_D_A;
  ELSE
    pCALC_ABON_PAYMENT_TO_MONTHEND:=0;
  END IF;
  -- Количество дней коррекции даты активации
  vCORRECT_ACTIVATION_DATE_DAYS := NVL(MS_CONSTANTS.GET_CONSTANT_VALUE('CORRECT_ACTIVATION_DATE_DAYS'), 0);
  --
 -- vSERVER_NAME:=MS_CONSTANTS.GET_CONSTANT_VALUE('SERVER_NAME');
  --
  vCALC_OPTIONS_DAILY_ACTIV:=MS_CONSTANTS.GET_CONSTANT_VALUE('CALC_OPTIONS_DAILY_ACTIV');
  --
  OPEN C_CONTRACT;
  FETCH C_CONTRACT INTO vCONTRACT_DATE, vCONTRACT_ID, vCREDIT, vABON_DISCOUNT, vINST_PAYMENT_DATE, vINST_PAYMENT_SUM, vINST_PAYMENT_MONTH, vOPTION_GROUP_ID;
  CLOSE C_CONTRACT;
  IF MS_CONSTANTS.GET_CONSTANT_VALUE('USE_ABON_DISCOUNTS') = '1' THEN
    vABON_COEFFICIENT:= 1 + nvl(vABON_DISCOUNT, 0)/100;
  ELSE
    vABON_COEFFICIENT:=1;
  END IF;
  IF MS_CONSTANTS.GET_CONSTANT_VALUE('USE_INSTALLMENT_PAYMENT') = '1' THEN
    IF vINST_PAYMENT_MONTH IS NOT NULL THEN
      FOR I IN 0..vINST_PAYMENT_MONTH-1 LOOP
        IF ADD_MONTHS(vINST_PAYMENT_DATE, I) < SYSDATE THEN
          IF ADD_MONTHS(vINST_PAYMENT_DATE-1, I+1) < SYSDATE THEN
            vINST_TEMP_DATE:=ADD_MONTHS(vINST_PAYMENT_DATE-1, I+1);
            vINST_TEMP_SUM:=TRUNC(vINST_PAYMENT_SUM/vINST_PAYMENT_MONTH, 2);
          ELSE
            vINST_TEMP_DATE:=TRUNC(SYSDATE);
            vINST_TEMP_SUM:=TRUNC(vINST_PAYMENT_SUM / vINST_PAYMENT_MONTH
              * (1 - (ADD_MONTHS(vINST_PAYMENT_DATE-1, I+1) - TRUNC(SYSDATE)) / (ADD_MONTHS(vINST_PAYMENT_DATE-1, I+1) - ADD_MONTHS(vINST_PAYMENT_DATE-1, I))), 2);
          END IF;
          IF ADD_MONTHS(vINST_PAYMENT_DATE-1, I+1) < SYSDATE THEN
            vINST_TEMP_DESCR:='Рассрочка: ' || TO_CHAR(I+1) || 'й месяц. С ' || TO_CHAR(ADD_MONTHS(vINST_PAYMENT_DATE-1, I)+1, 'DD.MM.YYYY')
             || ' по ' || TO_CHAR(ADD_MONTHS(vINST_PAYMENT_DATE-1, I+1), 'DD.MM.YYYY') || ' ' || ' ('
             || TRUNC(vINST_PAYMENT_SUM / vINST_PAYMENT_MONTH / (ADD_MONTHS(vINST_PAYMENT_DATE-1, I+1) - ADD_MONTHS(vINST_PAYMENT_DATE-1, I)), 2) || ' р/сутки)';
          ELSE
            vINST_TEMP_DESCR:='Рассрочка: ' || TO_CHAR(I+1) || 'й месяц. С ' || TO_CHAR(ADD_MONTHS(vINST_PAYMENT_DATE-1, I)+1, 'DD.MM.YYYY')
             || ' по ' || TO_CHAR(TRUNC(SYSDATE), 'DD.MM.YYYY') || ' ('
             || TRUNC(vINST_PAYMENT_SUM / vINST_PAYMENT_MONTH / (ADD_MONTHS(vINST_PAYMENT_DATE-1, I+1) - ADD_MONTHS(vINST_PAYMENT_DATE-1, I)), 2) || ' р/сутки)';
          END IF;
          APPEND_ROW(vINST_TEMP_DATE, -vINST_TEMP_SUM, vINST_TEMP_DESCR);
        END IF;
      END LOOP;
    END IF;
  END IF;
  -- Если есть льготная группа услуг, прочтем ее
  IF (vOPTION_GROUP_ID IS NOT NULL) AND (MS_CONSTANTS.GET_CONSTANT_VALUE('USE_TARIFF_OPTION_GROUP') = '1') THEN
    vOPTION_GROUP_COSTS.DELETE;
    vOPTION_GROUP_LIST:='';
    FOR recTOGC IN (SELECT TOGC.*
                  FROM TARIFF_OPTION_GROUP TOG,
                       TARIFF_OPTION_GROUP_COSTS TOGC
                  WHERE TOG.OPTION_GROUP_ID = vOPTION_GROUP_ID
                    AND TOG.IS_ACTIVE = 1
                    AND TOG.OPTION_GROUP_ID = TOGC.OPTION_GROUP_ID)
    LOOP
      vOPTION_GROUP_LIST:=vOPTION_GROUP_LIST || ';' || recTOGC.OPTION_CODE;
      vOPTION_GROUP_COSTS(vOPTION_GROUP_COSTS.COUNT + 1):=recTOGC.OPTION_CODE || ';' || recTOGC.TURN_ON_COST || ';' || recTOGC.MONTHLY_COST || ';' || recTOGC.BILL_TURN_ON_COST || ';' || recTOGC.BILL_MONTHLY_COST;
    END LOOP;
  END IF;
  -- Корректировка баланса
  OPEN C_BALANCE(pPHONE_NUMBER, vCONTRACT_DATE);
  FETCH C_BALANCE INTO vSTART_BALANCE_DATE, vSTART_BALANCE_VALUE, vFIX_YEAR_MONTH_ID;
  IF C_BALANCE%NOTFOUND THEN
    vSTART_BALANCE_DATE := NVL(vCONTRACT_DATE, TO_DATE('01.01.2000', 'DD.MM.YYYY'));
    -- Дата для зачёта платежей особенная - на 4 дня меньше договора
    vSTART_BALANCE_DATE_FOR_PAYMS := vSTART_BALANCE_DATE-cDAYS_PAYMENT_BEFORE_CONTRACT;
    vSTART_BALANCE_VALUE := 0;
  ELSE
    vSTART_BALANCE_DATE_FOR_PAYMS := vSTART_BALANCE_DATE;
  END IF;
  CLOSE C_BALANCE;
  IF vSTART_BALANCE_VALUE <> 0 THEN
    APPEND_ROW(vSTART_BALANCE_DATE, vSTART_BALANCE_VALUE, 'Стартовый баланс');
  END IF;
  --Учет депозитов
  IF vCONTRACT_ID IS NOT NULL THEN
    OPEN DEP(vCONTRACT_ID);
    FETCH DEP INTO recDEP;
    CLOSE DEP;
    OPEN OPER(vCONTRACT_ID,recDEP.DATE_DEPOSITE_CHANGE);
    FETCH OPER INTO recOPER;
    CLOSE OPER;
    APPEND_ROW(recDEP.DATE_DEPOSITE_CHANGE, -recDEP.CURRENT_DEPOSITE_VALUE, 'Депозит клиента. '||recOPER.NOTE);
  END IF;
   -- Платежи после даты договора
  FOR rec IN (SELECT PAYMENT_DATE,
                     PAYMENT_SUM,
                     PAYMENT_REMARK,
                     reverseschet  -- оплата реверс  ( #1343)
                FROM V_FULL_BALANCE_PAYMENTS
                WHERE V_FULL_BALANCE_PAYMENTS.PHONE_NUMBER=pPHONE_NUMBER
                  AND (V_FULL_BALANCE_PAYMENTS.PAYMENT_DATE >= vSTART_BALANCE_DATE_FOR_PAYMS
                        OR (V_FULL_BALANCE_PAYMENTS.CONTRACT_ID = vCONTRACT_ID
                             and V_FULL_BALANCE_PAYMENTS.PAYMENT_REMARK<>'Стартовый баланс'
                             AND vFIX_YEAR_MONTH_ID IS NULL))
                  AND (pBALANCE_DATE IS NULL OR V_FULL_BALANCE_PAYMENTS.PAYMENT_DATE <= pBALANCE_DATE))
  LOOP
    APPEND_ROW(rec.PAYMENT_DATE, rec.PAYMENT_SUM, 'Оплата: '||rec.PAYMENT_REMARK || case when nvl(rec.reverseschet, 0) = 1 then '(До появления счет.)' else ' ' end);
    if (rec.reverseschet=1 and fLOAD_BILL_IN_BALANCE(vACCOUNT_ID,to_char(rec.PAYMENT_DATE,'YYYYMM'))=1) then
      APPEND_ROW(rec.PAYMENT_DATE, -rec.PAYMENT_SUM, 'Оплата Компенсирующая: '||rec.PAYMENT_REMARK);
    end if;
  END LOOP;
   -- Начисления абон платы за доп статус
  FOR rec IN (SELECT BALANCE_DATA.CHARGES_DATE,
                     BALANCE_DATA.CHARGES_SUMM,
                     BALANCE_DATA.CHARGES_COMMENT
                FROM BALANCE_DATA
                WHERE BALANCE_DATA.PHONE_NUMBER=pPHONE_NUMBER
                  AND BALANCE_DATA.CONTRACT_ID = vCONTRACT_ID
                  AND (pBALANCE_DATE IS NULL OR BALANCE_DATA.CHARGES_DATE <= pBALANCE_DATE)
              UNION ALL
              SELECT BALANCE_DATA_DAILY_CHARGES.CHARGES_DATE,
                     BALANCE_DATA_DAILY_CHARGES.CHARGES_SUMM,
                     BALANCE_DATA_DAILY_CHARGES.CHARGES_COMMENT
                from BALANCE_DATA_DAILY_CHARGES 
                where BALANCE_DATA_DAILY_CHARGES.CONTRACT_ID = vCONTRACT_ID
                  and BALANCE_DATA_DAILY_CHARGES.PHONE_NUMBER = pPHONE_NUMBER)
  LOOP
    APPEND_ROW(rec.CHARGES_DATE, rec.CHARGES_SUMM, rec.CHARGES_COMMENT);    
  END LOOP;
  -- начисления
  FLAG_CURR_MONTH:=0; --зА ТЕК МЕСЯЦ СЧЕТ ЕЩЕ НЕ ВЫСТАВЛЕН
  FOR rec IN (SELECT V_FULL_BALANCE_BILLS.BILL_DATE,
                     CASE
                       WHEN vABON_COEFFICIENT = 1 THEN  - NVL(V_FULL_BALANCE_BILLS.BILL_SUM, 0)
                       ELSE  - NVL(V_FULL_BALANCE_BILLS.BILL_SUM, 0)
                             - NVL(V_FULL_BALANCE_BILLS.ABON_TP_NEW, 0) * (vABON_COEFFICIENT - 1)
                     END BILL_SUM,
                     V_FULL_BALANCE_BILLS.REMARK
                --'Начислено согласно счёту оператора за прошедший месяц'
                FROM V_FULL_BALANCE_BILLS
                WHERE V_FULL_BALANCE_BILLS.PHONE_NUMBER=pPHONE_NUMBER
                  AND V_FULL_BALANCE_BILLS.BILL_DATE >= vSTART_BALANCE_DATE----vCORRECT_ACTIVATION_DATE_DAYS
                  AND (pBALANCE_DATE IS NULL OR V_FULL_BALANCE_BILLS.BILL_DATE <= pBALANCE_DATE)
                ORDER BY V_FULL_BALANCE_BILLS.BILL_DATE DESC)
  LOOP
    IF TO_CHAR(SYSDATE,'YYYYMM')=TO_CHAR(rec.BILL_DATE,'YYYYMM') THEN --ПОПАДЕТСЯ ЛИ ТЕКУЩИЙ МЕСЯЦ В ДАННОЙ СТРОКЕ
      FLAG_CURR_MONTH:=1;
    END IF;
    IF SUBSTR(rec.REMARK,1,1)='Д' THEN --ЕСЛИ ДЕТАЛИЗАЦИЯ ТО УТОЧНИМ
      rec_REPORT.DATE_LAST_UPDATE:=NULL;
      IF TO_NUMBER(TO_CHAR(SYSDATE,'DD'))-DAYS_NESTABIL>0
          OR TO_CHAR(rec.BILL_DATE,'YYYYMM')<>TO_CHAR(SYSDATE,'YYYYMM') THEN --DAYS_NESTABIL ДНЕЙ ОТ НАЧАЛА МЕСЯЦА НЕПОНЯТКИ С БИЛАЙНОМ
        OPEN DB_REPORT(TO_NUMBER(TO_CHAR(rec.BILL_DATE,'YYYYMM')));
        FETCH DB_REPORT INTO rec_REPORT;
        CLOSE DB_REPORT;
        IF rec_REPORT.DATE_LAST_UPDATE IS NOT NULL THEN
          IF (rec.BILL_DATE IS NULL) OR (rec.BILL_SUM>rec_REPORT.BILL_SUM) THEN
            rec.BILL_DATE:=rec_REPORT.DATE_LAST_UPDATE;
            rec.BILL_SUM:=rec_REPORT.BILL_SUM;
            rec.REMARK:=rec_REPORT.REMARKS;
          END IF;
        END IF;
      END IF;
      APPEND_ROW(rec.BILL_DATE, rec.BILL_SUM, rec.REMARK);
    ELSE
      APPEND_ROW(rec.BILL_DATE, rec.BILL_SUM, rec.REMARK);
    END IF;
  END LOOP;
  IF (FLAG_CURR_MONTH=0) AND (TO_NUMBER(TO_CHAR(SYSDATE,'DD'))-DAYS_NESTABIL>0)
      AND (pBALANCE_DATE IS NULL
            OR TO_NUMBER(TO_CHAR(SYSDATE,'YYYYMM')) = TO_NUMBER(TO_CHAR(pBALANCE_DATE,'YYYYMM'))) THEN --ЗА ТЕК МЕСЯЦ НЕ БЫЛО НИЧЕГО, ПРОБУЕМ НАЙТИ ОТЧЕТ
    rec_REPORT.DATE_LAST_UPDATE:=NULL;
    OPEN DB_REPORT(TO_NUMBER(TO_CHAR(SYSDATE,'YYYYMM')));
    FETCH DB_REPORT INTO rec_REPORT;
    CLOSE DB_REPORT;
    IF rec_REPORT.DATE_LAST_UPDATE IS NOT NULL THEN
      APPEND_ROW(rec_REPORT.DATE_LAST_UPDATE, rec_REPORT.BILL_SUM, rec_REPORT.REMARKS);
    END IF;
  END IF;
  -- Абонплата по тарифу
  -- Не учитываем историю изменения тарифа и статуса номера (нет данных)!
  -- Не учитываем историю изменения условий тарифов (нет данных)
  --
  IF '1' = MS_CONSTANTS.GET_CONSTANT_VALUE('CALC_ABON_PAYMENT_BLOCK_5_DAYS') THEN
    ABON_PAY_DAY_AFTER_BLOCK:=TRUE;
    vCALC_ABON_BLOCK_COUNT_DAYS:=NVL(MS_PARAMS.GET_PARAM_VALUE('CALC_ABON_BLOCK_COUNT_DAYS'), 1);
    IF vCALC_ABON_BLOCK_COUNT_DAYS < 1 THEN
      vCALC_ABON_BLOCK_COUNT_DAYS:=1;
    END IF;
  ELSE
    ABON_PAY_DAY_AFTER_BLOCK:=FALSE;
    vCALC_ABON_BLOCK_COUNT_DAYS:=0;
  END IF;
  --
  -- Найдем дату активации
  IF vCORRECT_ACTIVATION_DATE_DAYS<>0 THEN
    OPEN NEW_DATE_ABON(vSTART_BALANCE_DATE, vCORRECT_ACTIVATION_DATE_DAYS);
    FETCH NEW_DATE_ABON INTO vTEMP_DATE_BEGIN_ABON;
    IF NEW_DATE_ABON%NOTFOUND THEN
      vTEMP_DATE_BEGIN_ABON:=vSTART_BALANCE_DATE;
    END IF;
    CLOSE NEW_DATE_ABON;
    IF vTEMP_DATE_BEGIN_ABON < vSTART_BALANCE_DATE - vCORRECT_ACTIVATION_DATE_DAYS THEN
      vTEMP_DATE_BEGIN_ABON:=vSTART_BALANCE_DATE;
    END IF;
  ELSE
    vTEMP_DATE_BEGIN_ABON:=vSTART_BALANCE_DATE;
  END IF;
  -- Определим дату начала расчёта
  SELECT LAST_DAY(TO_DATE(YEAR_MONTH || '01', 'YYYYMMDD')) + 1 INTO vABON_PAYMENT_START_DATE
    FROM (SELECT MAX(ALB.YEAR_MONTH) YEAR_MONTH
            from ACCOUNT_LOADED_BILLS ALB
            where ALB.LOAD_BILL_IN_BALANCE = 1
              and ALB.ACCOUNT_ID = CONVERT_PCKG.GET_ACCOUNT_ID_BY_PHONE(pPHONE_NUMBER));
  IF vABON_PAYMENT_START_DATE < vTEMP_DATE_BEGIN_ABON THEN
    vABON_PAYMENT_START_DATE:=vTEMP_DATE_BEGIN_ABON;
  END IF;
  IF (vABON_PAYMENT_START_DATE<vSTART_BALANCE_DATE and CONVERT_PCKG.GET_IS_COLLECTOR_BY_PHONE(pPHONE_NUMBER) <> 1)THEN
    vABON_PAYMENT_START_DATE:=vSTART_BALANCE_DATE;
  END IF;
  IF ((CONVERT_PCKG.GET_IS_COLLECTOR_BY_PHONE(pPHONE_NUMBER)=1) 
      and (abs(vABON_PAYMENT_START_DATE-vSTART_BALANCE_DATE)<3)
      and (GET_BILL_IN_BALANCE(vACCOUNT_ID,to_char(vCONTRACT_DATE,'YYYYMM'))=0)) then
    vABON_PAYMENT_START_DATE:=vSTART_BALANCE_DATE;
  END IF;
  vCHECK_ABON_MODULE_DATE:=vABON_PAYMENT_START_DATE-1;
  -- Начислено
  FOR recPAYMENTS IN (
  SELECT YEAR_MONTH,
         TO_DATE(YEAR_MONTH, 'YYYYMM') BEGIN_DATE,
         ADD_MONTHS(TO_DATE(YEAR_MONTH, 'YYYYMM'), 1)-1 END_DATE,
         TO_DATE(YEAR_MONTH, 'YYYYMM') FIRST_MONTH_DATE,
         ADD_MONTHS(TO_DATE(YEAR_MONTH, 'YYYYMM'), 1)-1 LAST_MONTH_DATE,
         TARIFF_CODE
    FROM DB_LOADER_PHONE_PERIODS
    WHERE PHONE_NUMBER=pPHONE_NUMBER
      AND (pBALANCE_DATE IS NULL OR TO_DATE(YEAR_MONTH, 'YYYYMM')<=pBALANCE_DATE)
      AND YEAR_MONTH >= TO_NUMBER(TO_CHAR(vABON_PAYMENT_START_DATE, 'YYYYMM'))
  UNION ALL
  -- А здесь добавим информацию текущего месяц, если он уже начался, а данные ещё не загружены.
  -- Все сведения берём из предыдущего месяца.
  SELECT TO_NUMBER(TO_CHAR(ADD_MONTHS(TO_DATE(YEAR_MONTH, 'YYYYMM'), 1), 'YYYYMM')) as YEAR_MONTH, -- Увеличим номер месяца на 1          
         ADD_MONTHS(TO_DATE(YEAR_MONTH, 'YYYYMM'), 1) BEGIN_DATE,
         ADD_MONTHS(TO_DATE(YEAR_MONTH, 'YYYYMM'), 2)-1 END_DATE,
         ADD_MONTHS(TO_DATE(YEAR_MONTH, 'YYYYMM'), 1) FIRST_MONTH_DATE,
         ADD_MONTHS(TO_DATE(YEAR_MONTH, 'YYYYMM'), 2)-1 LAST_MONTH_DATE,
         TARIFF_CODE
    FROM DB_LOADER_PHONE_PERIODS
    WHERE PHONE_NUMBER=pPHONE_NUMBER
      AND YEAR_MONTH = TO_CHAR(SYSDATE-1, 'YYYYMM')
      AND NOT EXISTS (SELECT 1 FROM DB_LOADER_PHONE_PERIODS
                        WHERE YEAR_MONTH=TO_NUMBER(TO_CHAR(NVL(pBALANCE_DATE, SYSDATE), 'YYYYMM')))
  ORDER BY YEAR_MONTH
    )
  LOOP
    vPERIOD_ACTIV:=0;
    -- Проверка, что данных период еще не моделировался
    IF recPAYMENTS.END_DATE > vCHECK_ABON_MODULE_DATE THEN
      vCHECK_ABON_MODULE_DATE:=recPAYMENTS.END_DATE;
  --    dbms_output.put_line('recPAYMENTS.END_DATE=' || recPAYMENTS.END_DATE);
      IF NVL(vCREDIT, 0)<>1 THEN -- Если 1, то договор кредитный, тогда абонку не считаем
        IF recPAYMENTS.BEGIN_DATE < vABON_PAYMENT_START_DATE THEN
          recPAYMENTS.BEGIN_DATE := vABON_PAYMENT_START_DATE;
        END IF;
        IF pCALC_ABON_PAYMENT_TO_MONTHEND=1 THEN
          -- Абонплата считается на конец текущего месяца.
          NULL;
        ELSE
          -- Абонплату нужно считать по текущую дату.
          IF recPAYMENTS.END_DATE > TRUNC(SYSDATE) THEN
            recPAYMENTS.END_DATE := TRUNC(SYSDATE);
          END IF;
        END IF;
        -- По умолчанию считаем, что предыдущий день был в блоке.
        PREV_STATUS:=0;
        TEMP_DATE_BEGIN_SCHET:=TRUNC(recPAYMENTS.BEGIN_DATE-1);
        vPREV_DISCR_TARIFF_ID:=0;
        VPREV_DISCR_YEAR_MONTH:=0;
        FOR recPHONE_STATUS_HISTORY IN (SELECT D.BEGIN_DATE,
                                               D.END_DATE,
                                               D.TARIFF_ID,
                                               D.TARIFF_CODE CELL_PLAN_CODE,
                                               D.IS_ACTIVE PHONE_IS_ACTIVE,
                                               CASE 
                                                 WHEN (D.IS_ACTIVE=1)
                                                 -- Если абонент блокирован в настоящий момент, то считаем абонплату как для действующего
                                                   OR ((D.END_DATE > SYSDATE)
                                                         AND (TO_CHAR(D.BEGIN_DATE, 'YYYYMM') = TO_CHAR(SYSDATE, 'YYYYMM'))
                                                         AND (pCALC_ABON_PAYMENT_TO_MONTHEND=1))
                                                 THEN NVL(TR.MONTHLY_PAYMENT, 0)
                                                 ELSE NVL(TR.MONTHLY_PAYMENT_LOCKED, 0)
                                               END as MONTHLY_PRICE,
                                               -- В зависимости от активности номера либо простая либо блокированная стоимость
                                               CASE WHEN (D.IS_ACTIVE=1)
                                                 -- Если абонент блокирован в настоящий момент, то считаем абонплату как для действующего
                                                 OR ((D.END_DATE > SYSDATE)
                                                       AND (TO_CHAR(D.BEGIN_DATE, 'YYYYMM') = TO_CHAR(SYSDATE, 'YYYYMM'))
                                                       AND (pCALC_ABON_PAYMENT_TO_MONTHEND=1))
                                                 THEN NVL(TR.DAYLY_PAYMENT, 0)
                                                 ELSE NVL(TR.DAYLY_PAYMENT_LOCKED, 0)
                                               END as DAYLY_PRICE,
                                               NVL(DISCR_SPISANIE, 0) DISCR_SPISANIE,
                                               NVL(SDVIG_DISCR_SPISANIE, 0) SDVIG_DISCR_SPISANIE,
                                               NVL(TR.IS_AUTO_INTERNET, 0) IS_AUTO_INTERNET
                                          FROM DB_LOADER_ABONENT_PERIODS D,
                                               TARIFFS TR
                                          WHERE D.PHONE_NUMBER = pPHONE_NUMBER
                                            AND D.YEAR_MONTH = recPAYMENTS.YEAR_MONTH
                                            AND (pBALANCE_DATE IS NULL OR D.BEGIN_DATE <= pBALANCE_DATE)
                                            AND D.END_DATE >= TRUNC(vABON_PAYMENT_START_DATE)
                                            AND D.TARIFF_ID = TR.TARIFF_ID(+)
                                          ORDER BY D.BEGIN_DATE ASC, D.END_DATE ASC)
        LOOP  
          NEED_DISCR_SPISANIE:=0;   
          NEED_DAILY_SPISANIE:=0;        
          IF (recPHONE_STATUS_HISTORY.BEGIN_DATE = recPAYMENTS.FIRST_MONTH_DATE)
              AND (recPHONE_STATUS_HISTORY.END_DATE = recPAYMENTS.LAST_MONTH_DATE)
              AND (recPHONE_STATUS_HISTORY.PHONE_IS_ACTIVE = 0) THEN
            -- Если номер весь месяц в блоке, то отменяем по нему абонку.
            recPHONE_STATUS_HISTORY.END_DATE:=recPHONE_STATUS_HISTORY.BEGIN_DATE - 1;
          END IF;
          -- Суммирование кол-ва активных периодов.
          vPERIOD_ACTIV:=vPERIOD_ACTIV + recPHONE_STATUS_HISTORY.PHONE_IS_ACTIVE;
          IF TRUNC(recPHONE_STATUS_HISTORY.BEGIN_DATE)<=TRUNC(TEMP_DATE_BEGIN_SCHET+1) THEN
            recPHONE_STATUS_HISTORY.BEGIN_DATE:=TRUNC(TEMP_DATE_BEGIN_SCHET+1);
          END IF;
          IF TRUNC(recPHONE_STATUS_HISTORY.END_DATE) > TRUNC(sysdate) THEN
            recPHONE_STATUS_HISTORY.END_DATE:=TRUNC(sysdate);
          END IF;
          IF (recPHONE_STATUS_HISTORY.END_DATE>=recPHONE_STATUS_HISTORY.BEGIN_DATE)
              AND(TRUNC(recPHONE_STATUS_HISTORY.END_DATE)>=TRUNC(TEMP_DATE_BEGIN_SCHET+1)) THEN
            -- Установим значения по умолчанию, если истории нет
            IF recPHONE_STATUS_HISTORY.CELL_PLAN_CODE IS NULL THEN
              recPHONE_STATUS_HISTORY.CELL_PLAN_CODE := recPAYMENTS.TARIFF_CODE;
            END IF;
            IF ABON_PAY_DAY_AFTER_BLOCK THEN
              IF (recPHONE_STATUS_HISTORY.PHONE_IS_ACTIVE=0) THEN
                IF recPHONE_STATUS_HISTORY.END_DATE-recPHONE_STATUS_HISTORY.BEGIN_DATE>=vCALC_ABON_BLOCK_COUNT_DAYS-1 THEN
                  recPHONE_STATUS_HISTORY.END_DATE:=recPHONE_STATUS_HISTORY.BEGIN_DATE+vCALC_ABON_BLOCK_COUNT_DAYS-1;
                END IF;
                -- Если предущий период тоже блок, то этот считать не нужно.
                IF (PREV_STATUS = 0) THEN 
                  recPHONE_STATUS_HISTORY.END_DATE:=recPHONE_STATUS_HISTORY.BEGIN_DATE-1;
                END IF;
              END IF;
            END IF;
            IF recPHONE_STATUS_HISTORY.BEGIN_DATE < recPAYMENTS.BEGIN_DATE THEN
              recPHONE_STATUS_HISTORY.BEGIN_DATE:=recPAYMENTS.BEGIN_DATE;
            END IF;
            -- Определим дневную стоимость
            recPHONE_STATUS_HISTORY.DAYLY_PRICE := recPHONE_STATUS_HISTORY.DAYLY_PRICE
                + (recPHONE_STATUS_HISTORY.MONTHLY_PRICE / (recPAYMENTS.LAST_MONTH_DATE - recPAYMENTS.FIRST_MONTH_DATE + 1));
            IF (recPHONE_STATUS_HISTORY.PHONE_IS_ACTIVE = 1)
                AND (recPHONE_STATUS_HISTORY.DISCR_SPISANIE = 1)
               /* AND (recPHONE_STATUS_HISTORY.TARIFF_ID <> vPREV_DISCR_TARIFF_ID)*/ THEN
--                dbms_output.put_line('discr');
              IF (recPHONE_STATUS_HISTORY.SDVIG_DISCR_SPISANIE <> 0) THEN
                OPEN SDVIG_D(recPHONE_STATUS_HISTORY.TARIFF_ID, recPHONE_STATUS_HISTORY.BEGIN_DATE, recPHONE_STATUS_HISTORY.SDVIG_DISCR_SPISANIE);
                FETCH SDVIG_D INTO DUMMY_S_D;
                IF SDVIG_D%FOUND THEN                 
                  NEED_DISCR_SPISANIE:=1;
                  NEED_DAILY_SPISANIE:=0;
                ELSE
                  NEED_DAILY_SPISANIE:=1;
                  NEED_DISCR_SPISANIE:=0;
                END IF;
                CLOSE SDVIG_D;
              ELSE
                NEED_DISCR_SPISANIE:=1;
                NEED_DAILY_SPISANIE:=0;
              END IF;
            END IF;
            if (NEED_DISCR_SPISANIE = 1) then
              --если дата контракта в ходит в месяц исследуемого периода и имеется сдвиг дискретного списания, то посуточное списание делаем
              if to_char(vCONTRACT_DATE, 'yyyymm') = to_char(recPHONE_STATUS_HISTORY.BEGIN_DATE, 'yyyymm')
                  and (nvl(recPHONE_STATUS_HISTORY.SDVIG_DISCR_SPISANIE, 0)>=1) then
                NEED_DISCR_SPISANIE:=0;
                NEED_DAILY_SPISANIE:=1;
              end if;
              --меняем логику списания АП для номеров с тп с признаком автоподключения пакетов и которые мы запомнили, т.е. лежат в таблице PHONE_CALC_ABON_TP_UNLIM_ON.
              --номера лежат с указанием периода , по которому будем вести алгоритм
              if (recPHONE_STATUS_HISTORY.IS_AUTO_INTERNET = 1) then
                --Номера с интернет тарифом с автоподключением пакетов в конце месяца при недостатке средств для списания абонки блокировать не будем, а дадим им отсрочку
                --В связи с этим АП будем списываться в месяце, который мы указали в таблице PHONE_CALC_ABON_TP_UNLIM_ON, посуточно до тех пор пока
                --на номере не пополнится счет для списания полной абонки или пока номер не заблокируем. 
                --Если в месяце, который мы запомнили в таблице PHONE_CALC_ABON_TP_UNLIM_ON, номер заблокировали и пополнений не было, а это значит что он не разблокировался, то всегда теперь считаем период активности в текущем месяце посуточно!   
                --Такие номера запоминаем в последний день месяца в разрезе год/месяц с будущим месяцем, т.е. месяцем по которому будет действовать текущий алгоритм
                pPhoneCnt := 0;
                SELECT count(*)
                   INTO pPhoneCnt
                  FROM PHONE_CALC_ABON_TP_UNLIM_ON
                WHERE PHONE_NUMBER = pPHONE_NUMBER
                    AND YEAR_MONTH = to_number(TO_CHAR(recPHONE_STATUS_HISTORY.BEGIN_DATE, 'YYYYMM')) --нам интересен только месяц который мы запомнили
                    AND TARIFF_ID = recPHONE_STATUS_HISTORY.TARIFF_ID;
                  
                --если номер с данным периодом присутствует в таблице PHONE_CALC_ABON_TP_UNLIM_ON
                if pPhoneCnt > 0 then
                    --если текущая дата определения баланса не принадлежит периоду, который мы запоминали, и номер все еще находится в табл. с отсрочкой АП, 
                    --т.е. номер был блокирован и разблокирован не был, делаем посуточное списание
                    if (to_number(to_char(sysdate, 'YYYYMM')) > to_number(TO_CHAR(recPHONE_STATUS_HISTORY.BEGIN_DATE, 'YYYYMM'))) then             
                      NEED_DAILY_SPISANIE:=1;
                    end if;  
                    --нам необходимо также учесть, что в месяце, который мы запоминали, если номер не блокирован и на номере отриц. балансом с учетом дискретного списания, 
                    --то абонку списывать посуточно пока он не заблокируется или не пополнется счет (т.е. исчезнет из табл. PHONE_CALC_ABON_TP_UNLIM_ON)
                    if (to_number(to_char(sysdate, 'YYYYMM')) = to_number(TO_CHAR(recPHONE_STATUS_HISTORY.BEGIN_DATE, 'YYYYMM'))) then
                      --если баланс с учетом дискретного списания меньше 0 (признак pDailyWriteOFF = 1) или текущий тариф не равен тарифу в момент запоминания номера (тарифу в данный временной период), т.е 
                      --прозошла смена тп. По старому тп при наличии номера в табл. PHONE_CALC_ABON_TP_UNLIM_ON необх. посчитать посуточно
                      if (pDailyWriteOFF = 1) OR (recPHONE_STATUS_HISTORY.TARIFF_ID <> NVL(GET_CURR_PHONE_TARIFF_ID(pPHONE_NUMBER), 0)) then 
                        NEED_DAILY_SPISANIE:=1; 
                      end if;
                    end if;                 
                end if;  
              end if;
              --
            end if; 
            IF TRUNC(recPHONE_STATUS_HISTORY.BEGIN_DATE)<=TRUNC(recPHONE_STATUS_HISTORY.END_DATE) THEN  --ЕСЛИ ДАТЫ ПОДХОДЯТ
              IF (recPHONE_STATUS_HISTORY.DISCR_SPISANIE = 1) AND (NEED_DAILY_SPISANIE <> 1) THEN
                IF NEED_DISCR_SPISANIE = 1 THEN
                  IF (vPREV_DISCR_YEAR_MONTH <> TO_NUMBER(TO_CHAR(recPHONE_STATUS_HISTORY.BEGIN_DATE, 'YYYYMM')))
                      AND (vPREV_DISCR_TARIFF_ID <> recPHONE_STATUS_HISTORY.TARIFF_ID) THEN
                    APPEND_ROW(
                      recPHONE_STATUS_HISTORY.BEGIN_DATE,
                      --Процент владельца
                      RECALC_CHARGE_COST(pPHONE_NUMBER, -(vABON_COEFFICIENT * recPHONE_STATUS_HISTORY.MONTHLY_PRICE)),
                      '1 Абонплата ('
                        || recPHONE_STATUS_HISTORY.CELL_PLAN_CODE
                        || CASE WHEN recPHONE_STATUS_HISTORY.PHONE_IS_ACTIVE = 1 THEN
                          ', активный'
                          ELSE
                          ', блокирован'
                          END
                        || '), списано за месяц'
                      ); 
                    vPREV_DISCR_TARIFF_ID:=recPHONE_STATUS_HISTORY.TARIFF_ID;
                    vPREV_DISCR_YEAR_MONTH:=TO_NUMBER(TO_CHAR(recPHONE_STATUS_HISTORY.BEGIN_DATE, 'YYYYMM'));
                  END IF;
                END IF;
              ELSE
                APPEND_ROW(
                  recPHONE_STATUS_HISTORY.BEGIN_DATE,
                  --Процент владельца
                  RECALC_CHARGE_COST(pPHONE_NUMBER, -(vABON_COEFFICIENT * recPHONE_STATUS_HISTORY.DAYLY_PRICE*(TRUNC(recPHONE_STATUS_HISTORY.END_DATE)-TRUNC(recPHONE_STATUS_HISTORY.BEGIN_DATE)+1))),
                  '1 Абонплата ('
                    || recPHONE_STATUS_HISTORY.CELL_PLAN_CODE
                    || CASE WHEN recPHONE_STATUS_HISTORY.PHONE_IS_ACTIVE = 1 THEN
                      ', активный'
                      ELSE
                      ', блокирован'
                      END
                    || ') с ' || TO_CHAR(recPHONE_STATUS_HISTORY.BEGIN_DATE, 'DD.MM.YYYY') || ' по ' || TO_CHAR(recPHONE_STATUS_HISTORY.END_DATE, 'DD.MM.YYYY') || ' ('
                    || ROUND(RECALC_CHARGE_COST(pPHONE_NUMBER, recPHONE_STATUS_HISTORY.DAYLY_PRICE), 2) || ' руб./день)'
                  );
              END IF; 
            END IF;
            TEMP_DATE_BEGIN_SCHET:=TRUNC(recPHONE_STATUS_HISTORY.END_DATE);
          END IF;
          PREV_STATUS:=recPHONE_STATUS_HISTORY.PHONE_IS_ACTIVE;
        END LOOP;   
      END IF;
  -- Проверка наличия данных этого месяца
      FLAG_DATA_OPTIONS_CURR_MONTH:=0;
      FOR recFLAG IN (SELECT DB_LOADER_ACCOUNT_PHONE_OPTS.OPTION_CODE 
                        FROM DB_LOADER_ACCOUNT_PHONE_OPTS 
                        WHERE DB_LOADER_ACCOUNT_PHONE_OPTS.YEAR_MONTH=recPAYMENTS.YEAR_MONTH 
                          AND DB_LOADER_ACCOUNT_PHONE_OPTS.PHONE_NUMBER=pPHONE_NUMBER)
      LOOP
        FLAG_DATA_OPTIONS_CURR_MONTH:=1;
        EXIT;
      END LOOP;
      PAYMENTS_PREV_MONTH:=CASE
                             WHEN recPAYMENTS.YEAR_MONTH-ROUND(recPAYMENTS.YEAR_MONTH/100)*100=1 THEN recPAYMENTS.YEAR_MONTH-89
                             ELSE recPAYMENTS.YEAR_MONTH-1
                           END;
      FOR recSERVICES IN (SELECT DB_LOADER_ACCOUNT_PHONE_OPTS.OPTION_CODE,
                                 DB_LOADER_ACCOUNT_PHONE_OPTS.OPTION_NAME,
                                 DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_ON_DATE,
                                 DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_OFF_DATE,
                                 DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_ON_COST,
                                 DB_LOADER_ACCOUNT_PHONE_OPTS.MONTHLY_PRICE,
                                 ACCOUNTS.OPERATOR_ID,
                                 TARIFF_OPTIONS.DISCR_SPISANIE,
                                 DB_LOADER_ABONENT_PERIODS.BEGIN_DATE,
                                 DB_LOADER_ABONENT_PERIODS.END_DATE,
                                 DB_LOADER_ABONENT_PERIODS.TARIFF_ID,
                                 ROWIDTOCHAR(DB_LOADER_ACCOUNT_PHONE_OPTS.ROWID) ROWID_CHAR
                            FROM DB_LOADER_ACCOUNT_PHONE_OPTS,
                                 ACCOUNTS,
                                 TARIFF_OPTIONS, 
                                 DB_LOADER_ABONENT_PERIODS
                            WHERE DB_LOADER_ACCOUNT_PHONE_OPTS.ACCOUNT_ID=ACCOUNTS.ACCOUNT_ID(+) --ACCOUNT_ID=45
                              AND DB_LOADER_ACCOUNT_PHONE_OPTS.OPTION_CODE = TARIFF_OPTIONS.OPTION_CODE(+)
                              and DB_LOADER_ABONENT_PERIODS.YEAR_MONTH = recPAYMENTS.YEAR_MONTH
                              and DB_LOADER_ABONENT_PERIODS.PHONE_NUMBER = pPHONE_NUMBER
                              and DB_LOADER_ABONENT_PERIODS.END_DATE >= DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_ON_DATE
                              and (nvl(DB_LOADER_ABONENT_PERIODS.IS_ACTIVE, 0) = 1
                                    or INSTR(DB_LOADER_ACCOUNT_PHONE_OPTS.OPTION_CODE, 'RDIRECT') > 0)
                              AND ((DB_LOADER_ACCOUNT_PHONE_OPTS.YEAR_MONTH=recPAYMENTS.YEAR_MONTH
                                    AND FLAG_DATA_OPTIONS_CURR_MONTH=1)
                                OR (DB_LOADER_ACCOUNT_PHONE_OPTS.YEAR_MONTH=PAYMENTS_PREV_MONTH
                                    AND FLAG_DATA_OPTIONS_CURR_MONTH=0
                                    AND NVL(DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_OFF_DATE, sysdate + 32) >=
                                          TO_DATE(TO_CHAR(recPAYMENTS.YEAR_MONTH)||'01','YYYYMMDD') ) )
                              AND DB_LOADER_ACCOUNT_PHONE_OPTS.PHONE_NUMBER=pPHONE_NUMBER -- '9037786589'
                              AND NVL(DB_LOADER_ACCOUNT_PHONE_OPTS.ADDED_FOR_RETARIF, 0) <> 1
                             -- AND (DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_ON_COST <> 0 OR DB_LOADER_ACCOUNT_PHONE_OPTS.MONTHLY_PRICE <> 0)
                              AND ((pBALANCE_DATE IS NULL AND DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_ON_DATE <=SYSDATE) 
                                  OR (DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_ON_DATE <= pBALANCE_DATE) ) 
                            order by DB_LOADER_ACCOUNT_PHONE_OPTS.OPTION_CODE asc, DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_ON_DATE asc,
                                     DB_LOADER_ABONENT_PERIODS.BEGIN_DATE asc, DB_LOADER_ABONENT_PERIODS.END_DATE asc)
      LOOP
        -- Начальная дата
        vSERVICE_START_DATE := recPAYMENTS.BEGIN_DATE; -- Начало месяца
        IF vSERVICE_START_DATE < recSERVICES.BEGIN_DATE THEN
          vSERVICE_START_DATE := TRUNC(recSERVICES.BEGIN_DATE);
        END IF;
        IF vSERVICE_START_DATE < recSERVICES.TURN_ON_DATE THEN
          vSERVICE_START_DATE := TRUNC(recSERVICES.TURN_ON_DATE); -- Дата подключения
        END IF;
        -- Конечная дата
        vSERVICE_END_DATE := recPAYMENTS.LAST_MONTH_DATE; -- Конец месяца
        IF vSERVICE_END_DATE > recSERVICES.END_DATE THEN
          vSERVICE_END_DATE := TRUNC(recSERVICES.END_DATE);
        END IF;
        --
        vDATE_SERVICE_CHECK:=recSERVICES.TURN_ON_DATE+1;
        IF vDATE_SERVICE_CHECK<vCONTRACT_DATE THEN
          vDATE_SERVICE_CHECK:=vCONTRACT_DATE+1;
        END IF;
        IF vDATE_SERVICE_CHECK<TO_DATE(recPAYMENTS.YEAR_MONTH||'01', 'YYYYMMDD') THEN
          vDATE_SERVICE_CHECK:=TO_DATE(recPAYMENTS.YEAR_MONTH||'01', 'YYYYMMDD')+1;
        END IF;
        OPEN CODE(vDATE_SERVICE_CHECK); -- Дата подключения услуги + 5 дней на случай запаздывания загрузки
        FETCH CODE INTO recCODE; -- ПОЛУЧАМ КОД ТАРИФА В ТОТ МИГ
        CLOSE CODE;             --
        GET_TARIFF_OPTION_COST(recSERVICES.OPERATOR_ID,
                               recSERVICES.TARIFF_ID,
                               --GET_PHONE_TARIFF_ID(pPHONE_NUMBER, recCODE, vDATE_SERVICE_CHECK), -- Тариф БЕРЕМ по функции
                               recSERVICES.OPTION_CODE,
                               vDATE_SERVICE_CHECK,
                               vNEW_TURN_ON_COST,
                               vNEW_MONTHLY_COST);
        -- Если стоимость в справочнике задана, то используем её.
        recSERVICES.TURN_ON_COST := NVL(NVL(vNEW_TURN_ON_COST, recSERVICES.TURN_ON_COST), 0);
        recSERVICES.MONTHLY_PRICE := NVL(NVL(vNEW_MONTHLY_COST, recSERVICES.MONTHLY_PRICE), 0);
        -- Если подключен справочник группы услуг, возможны поправки, то проверяем, есть ли эта услуга среди них.
        IF (vOPTION_GROUP_ID IS NOT NULL) THEN
          IF INSTR(vOPTION_GROUP_LIST, recSERVICES.OPTION_CODE) > 0 THEN
            L:=vOPTION_GROUP_COSTS.LAST;
            FOR I IN vOPTION_GROUP_COSTS.FIRST..L
            LOOP
              IF (INSTR(vOPTION_GROUP_COSTS(I), recSERVICES.OPTION_CODE) > 0) THEN
                IF (INSTR(vOPTION_GROUP_COSTS(I), ';', 1, 2) > 0) THEN
                  recSERVICES.TURN_ON_COST:=TO_NUMBER(SUBSTR(vOPTION_GROUP_COSTS(I),
                                                             INSTR(vOPTION_GROUP_COSTS(I), ';', 1, 1) + 1,
                                                             INSTR(vOPTION_GROUP_COSTS(I), ';', 1, 2)-INSTR(vOPTION_GROUP_COSTS(I), ';', 1, 1)-1   ));
                END IF;
                IF (INSTR(vOPTION_GROUP_COSTS(I), ';', 1, 2) > 0) THEN
                  recSERVICES.MONTHLY_PRICE:=TO_NUMBER(SUBSTR(vOPTION_GROUP_COSTS(I),
                                                              INSTR(vOPTION_GROUP_COSTS(I), ';', 1, 2) + 1,
                                                              INSTR(vOPTION_GROUP_COSTS(I), ';', 1, 3)-INSTR(vOPTION_GROUP_COSTS(I), ';', 1, 2)-1   ));
                END IF;
              END IF;
            END LOOP;
          END IF;
        END IF;
        -- Стоимость подключения списываем только в том месяце, в котором подключили.
        IF recSERVICES.TURN_ON_COST <> 0 THEN
          -- Если стоимость подключения ненулевая,
          -- то надо проверить дату подключения.
          -- Если дата подключения в текущем месяце, то надо её учесть.
          IF TO_CHAR(recSERVICES.TURN_ON_DATE, 'YYYYMM') = recPAYMENTS.YEAR_MONTH THEN
            vCHECK_OPTS:=F_CHECK_OPTION(recSERVICES.ROWID_CHAR);
            IF vCHECK_OPTS = 0 THEN
              APPEND_ROW(recSERVICES.TURN_ON_DATE,
                         -recSERVICES.TURN_ON_COST,
                         'Подключена услуга ' || recSERVICES.OPTION_NAME
                           || ' (' || recSERVICES.OPTION_CODE
                           || ') с ' || TO_CHAR(recSERVICES.TURN_ON_DATE, 'DD.MM.YYYY'));
            END IF;
          END IF;
        END IF;
        -- Ежемесячная абонентская плата за услугу
        IF (recSERVICES.MONTHLY_PRICE <> 0)AND(NVL(vCREDIT, 0)<>1) AND (vPERIOD_ACTIV > 0) THEN
          -- Если абонплата считается не до конца месяца, то корректируем дату окончания
          IF vSERVICE_END_DATE > TRUNC(NVL(pBALANCE_DATE, SYSDATE)) THEN  
               -- Услуга списывается не дискретно, при списании по тек день.
            vSERVICE_END_DATE := TRUNC(NVL(pBALANCE_DATE, SYSDATE));
          END IF;
          -- Если услуга отключена ранее конца проверяемого месяца, то
          -- дата окончания услуги корректируется
          IF vSERVICE_END_DATE > recSERVICES.TURN_OFF_DATE THEN
            vSERVICE_END_DATE := recSERVICES.TURN_OFF_DATE;
          END IF;
          --
          IF vCALC_OPTIONS_DAILY_ACTIV='1' THEN
            IF (NVL(recSERVICES.DISCR_SPISANIE, 0) = 0) 
                AND (INSTR(recSERVICES.OPTION_CODE, 'RDIRECT') = 0) THEN
              vCOUNT_ACT_OPTION:=0;
              -- 
              FOR recACTIV IN OPT_ACT(vSERVICE_START_DATE, vSERVICE_END_DATE) LOOP
                vCOUNT_ACT_OPTION:=vCOUNT_ACT_OPTION+(TRUNC(recACTIV.END_DATE)-TRUNC(recACTIV.BEGIN_DATE)+1);
              END LOOP;
            ELSE
              vCOUNT_ACT_OPTION:=1;
            END IF;
          END IF;
          -- Списание
          IF (vSERVICE_START_DATE <= vSERVICE_END_DATE)
              AND (pBALANCE_DATE IS NULL OR vSERVICE_START_DATE <= pBALANCE_DATE) THEN
            IF NVL(recSERVICES.DISCR_SPISANIE, 0) = 1 THEN
              vCHECK_OPTS:=F_CHECK_OPTION(recSERVICES.ROWID_CHAR);
              IF vCHECK_OPTS = 0 THEN
                APPEND_ROW(
                  vSERVICE_START_DATE,
                  -recSERVICES.MONTHLY_PRICE,
                  '2 Абонплата за услугу ' || recSERVICES.OPTION_NAME
                    || ' (' || recSERVICES.OPTION_CODE || ') , списано за месяц'
                    || CASE
                         WHEN vCALC_OPTIONS_DAILY_ACTIV='1' THEN ' Был акт. дн: '||TO_CHAR(vCOUNT_ACT_OPTION)
                         ELSE ''
                       END);   
              END IF;            
            ELSE
              APPEND_ROW(
                vSERVICE_START_DATE,
                -recSERVICES.MONTHLY_PRICE
                * CASE
                    WHEN (vCALC_OPTIONS_DAILY_ACTIV='1') AND (INSTR(recSERVICES.OPTION_CODE, 'RDIRECT') = 0) 
                      THEN vCOUNT_ACT_OPTION
                    ELSE (TRUNC(vSERVICE_END_DATE) - TRUNC(vSERVICE_START_DATE) + 1)
                  END / (TRUNC(recPAYMENTS.LAST_MONTH_DATE) - TRUNC(recPAYMENTS.FIRST_MONTH_DATE) + 1),
                '2 Абонплата за услугу ' || recSERVICES.OPTION_NAME 
                  || ' (' || recSERVICES.OPTION_CODE || ') ' 
                  || 'с ' || TO_CHAR(vSERVICE_START_DATE, 'DD.MM.YYYY') 
                  || ' по ' || TO_CHAR(vSERVICE_END_DATE, 'DD.MM.YYYY')
                  || CASE
                       WHEN vCALC_OPTIONS_DAILY_ACTIV='1' 
                         THEN ' Был акт. дн: '||TO_CHAR(vCOUNT_ACT_OPTION)
                       ELSE ''
                     END
                );            
            END IF;
          END IF;
        END IF;
      END LOOP;
    END IF;
  END LOOP;
END;