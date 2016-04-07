
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."TESTCALC_BALANCE_ROWS2" (
  pPHONE_NUMBER IN VARCHAR2,
  pDATE_ROWS IN OUT NOCOPY DBMS_SQL.DATE_TABLE,
  pCOST_ROWS IN OUT NOCOPY DBMS_SQL.NUMBER_TABLE,
  pDESCRIPTION_ROWS IN OUT NOCOPY DBMS_SQL.VARCHAR2_TABLE,
  pFILL_DESCRIPTION IN BOOLEAN DEFAULT TRUE,
  pBALANCE_DATE IN DATE DEFAULT NULL
  ) IS
--
--#Version=55
--
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
  CURSOR C_CONTRACT IS
    SELECT
      CONTRACTS.CONTRACT_DATE,
      CONTRACTS.CONTRACT_ID,
      CONTRACTS.IS_CREDIT_CONTRACT,
      CONTRACTS.ABON_TP_DISCOUNT,
      CONTRACTS.INSTALLMENT_PAYMENT_DATE,
      CONTRACTS.INSTALLMENT_PAYMENT_SUM,
      CONTRACTS.INSTALLMENT_PAYMENT_MONTHS,
      CONTRACTS.OPTION_GROUP_ID
    FROM
      CONTRACTS
    WHERE
      CONTRACTS.PHONE_NUMBER_FEDERAL = pPHONE_NUMBER
      AND (pBALANCE_DATE IS NULL OR CONTRACTS.CONTRACT_DATE <= pBALANCE_DATE)
--      AND CONTRACTS.CONTRACT_ID NOT IN (
--          SELECT CONTRACT_CANCELS.CONTRACT_ID
--            FROM CONTRACT_CANCELS)
    ORDER BY
      CONTRACTS.CONTRACT_DATE DESC
      ;
  CURSOR C_BALANCE(aPHONE_NUMBER VARCHAR2, aCONTRACT_DATE date) IS
    SELECT
      PHONE_BALANCES.BALANCE_DATE,
      PHONE_BALANCES.BALANCE_VALUE,
      PHONE_BALANCES.FIX_YEAR_MONTH_ID
    FROM
      PHONE_BALANCES
    WHERE
      PHONE_BALANCES.PHONE_NUMBER = aPHONE_NUMBER
      AND (pBALANCE_DATE IS NULL OR PHONE_BALANCES.BALANCE_DATE <= pBALANCE_DATE)
      and (aCONTRACT_DATE IS NULL OR PHONE_BALANCES.BALANCE_DATE >= aCONTRACT_DATE)
    ORDER BY
      PHONE_BALANCES.BALANCE_DATE DESC
      ;
  CURSOR cPHONE_STATUS_HISTORY(aPHONE_NUMBER VARCHAR2, pBEGIN_DATE DATE, pEND_DATE DATE, pCALC_ABON_PAYMENT_TO_MONTHEND INTEGER) IS
    SELECT
      CASE
        WHEN DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_IS_ACTIVE=0 THEN
          TRUNC(DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE)+1
        ELSE
          TRUNC(DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE)
      END as BEGIN_DATE,
      CASE
        WHEN TRUNC(DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE) > pEND_DATE THEN
          TRUNC(pEND_DATE)
        ELSE
          CASE
            WHEN DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_IS_ACTIVE=0 THEN
              TRUNC(DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE)-1
            ELSE
              TRUNC(DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE)
          END
      END as END_DATE,
      DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_IS_ACTIVE,
      DB_LOADER_ACCOUNT_PHONE_HISTS.CELL_PLAN_CODE,
      DB_LOADER_ACCOUNT_PHONE_HISTS.HISTORY_ID,
      TARIFFS.TARIFF_ID,
      -- В зависимости от активности номера либо простая либо блокированная цена
      CASE WHEN (DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_IS_ACTIVE=1)
        -- Если абонент блокирован в настоящий момент, то считаем абонплату как для действующего
        OR ((DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE > SYSDATE)
              AND (TO_CHAR(DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE, 'YYYYMM') = TO_CHAR(SYSDATE, 'YYYYMM'))
              AND (pCALC_ABON_PAYMENT_TO_MONTHEND=1))
        THEN NVL(TARIFFS.MONTHLY_PAYMENT, 0)
        ELSE NVL(TARIFFS.MONTHLY_PAYMENT_LOCKED, 0)
      END as MONTHLY_PRICE,
      -- В зависимости от активности номера либо простая либо блокированная стоимость
      CASE WHEN (DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_IS_ACTIVE=1)
        -- Если абонент блокирован в настоящий момент, то считаем абонплату как для действующего
        OR ((DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE > SYSDATE)
              AND (TO_CHAR(DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE, 'YYYYMM') = TO_CHAR(SYSDATE, 'YYYYMM'))
              AND (pCALC_ABON_PAYMENT_TO_MONTHEND=1))
        THEN NVL(TARIFFS.DAYLY_PAYMENT, 0)
        ELSE NVL(TARIFFS.DAYLY_PAYMENT_LOCKED, 0)
      END as DAYLY_PRICE
    FROM
      DB_LOADER_ACCOUNT_PHONE_HISTS,
      TARIFFS
    WHERE
      DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_NUMBER = aPHONE_NUMBER
      AND TRUNC(DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE) <= pEND_DATE
      AND TRUNC(DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE) >= pBEGIN_DATE
      --AND TARIFFS.TARIFF_CODE=DB_LOADER_ACCOUNT_PHONE_HISTS.CELL_PLAN_CODE
      -- Коду может соответствовать несколько тарифов, выбираем подходящий
      AND TARIFFS.TARIFF_ID = GET_PHONE_TARIFF_ID(
        aPHONE_NUMBER,
        DB_LOADER_ACCOUNT_PHONE_HISTS.CELL_PLAN_CODE,
        NVL(CASE
              WHEN DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE-1>DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE THEN
                DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE-1
              ELSE DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE
            END, SYSDATE)
        )
      AND (pBALANCE_DATE IS NULL OR DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE <= pBALANCE_DATE)
    ORDER BY
      DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE DESC
      ;
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
           'Детализация звонков за ' || TO_CHAR(DATE_LAST_UPDATE,'MM.YYYY') || ' (на '
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
    SELECT TRUNC(H.BEGIN_DATE) BEGIN_DATE,
           TRUNC(H.END_DATE) END_DATE
      FROM DB_LOADER_ACCOUNT_PHONE_HISTS H
      WHERE H.PHONE_NUMBER=pPHONE_NUMBER
        AND TRUNC(H.BEGIN_DATE)<=TRUNC(pEND_DATE)
        AND TRUNC(H.END_DATE)>=TRUNC(pBEGIN_DATE)
        AND H.PHONE_IS_ACTIVE=1
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
  vACCOUNT_ID INTEGER;
  recCODE DB_LOADER_ACCOUNT_PHONE_HISTS.CELL_PLAN_CODE%TYPE;
  recDEP DEP%ROWTYPE;
  recOPER OPER%ROWTYPE;
  recPHONE_STATUS_HISTORY cPHONE_STATUS_HISTORY%ROWTYPE;
  recPHONE_STATUS_HISTORY2 cPHONE_STATUS_HISTORY%ROWTYPE;
  vCONTRACT_DATE        DATE;
  vCONTRACT_ID          CONTRACTS.CONTRACT_ID%TYPE;
  vCREDIT CONTRACTS.IS_CREDIT_CONTRACT%TYPE;
  --vPAYMENTS_VALUE       NUMBER(15, 2);
  --vBILLS_VALUE          NUMBER(15, 2);
  vSTART_BALANCE_VALUE  NUMBER(15, 2);
  vSTART_BALANCE_DATE   DATE;
  vSTART_BALANCE_DATE_FOR_PAYMS DATE;
  vABON_PAYMENT_START_DATE DATE;
  vOPTION_GROUP_ID INTEGER;
--  vABON_PAYMENT_SUM     NUMBER(15, 2);
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
  vTEMP_DATE_BEGIN_ABON DATE; -- Временная переменная(хранит дату активации)
  PREV_STATUS NUMBER;
  pCALC_ABON_PAYMENT_TO_MONTHEND INTEGER;
  TEMP_DATE_END_SCHET DATE;  -- Дата, по-которую абонка рассчитана
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
BEGIN
  --
  pDATE_ROWS.DELETE;
  pCOST_ROWS.DELETE;
  pDESCRIPTION_ROWS.DELETE;
  --
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
  FOR rec IN (
    SELECT
      PAYMENT_DATE,
      PAYMENT_SUM,
      PAYMENT_REMARK
    FROM
      V_FULL_BALANCE_PAYMENTS
    WHERE
      V_FULL_BALANCE_PAYMENTS.PHONE_NUMBER=pPHONE_NUMBER
      AND (
        V_FULL_BALANCE_PAYMENTS.PAYMENT_DATE >= vSTART_BALANCE_DATE_FOR_PAYMS
        OR (V_FULL_BALANCE_PAYMENTS.CONTRACT_ID = vCONTRACT_ID
             and V_FULL_BALANCE_PAYMENTS.PAYMENT_REMARK<>'Стартовый баланс'
             AND vFIX_YEAR_MONTH_ID IS NULL)
        )
     /* AND (pBALANCE_DATE IS NULL OR V_FULL_BALANCE_PAYMENTS.PAYMENT_DATE <= pBALANCE_DATE
      or (V_FULL_BALANCE_PAYMENTS.CONTRACT_ID = vCONTRACT_ID
      and  V_FULL_BALANCE_PAYMENTS.PAYMENT_REMARK<>'Стартовый баланс')
      )*/

     /*  AND ( pBALANCE_DATE IS NULL
      OR (V_FULL_BALANCE_PAYMENTS.PAYMENT_DATE <= pBALANCE_DATE
      or nvl(V_FULL_BALANCE_PAYMENTS.CONTRACT_ID,0) >0
      and V_FULL_BALANCE_PAYMENTS.PAYMENT_REMARK<>'Стартовый баланс'
      ))
       */

        AND ( (pBALANCE_DATE IS NULL
      OR V_FULL_BALANCE_PAYMENTS.PAYMENT_DATE <= pBALANCE_DATE)

      or (nvl(V_FULL_BALANCE_PAYMENTS.CONTRACT_ID,0) >0
       and V_FULL_BALANCE_PAYMENTS.PAYMENT_REMARK<>'Стартовый баланс'
       --and V_FULL_BALANCE_PAYMENTS.PAYMENT_DATE <= pBALANCE_DATE
       )
      )

      ) LOOP
    APPEND_ROW(rec.PAYMENT_DATE, rec.PAYMENT_SUM, 'Оплата: '||rec.PAYMENT_REMARK);
  END LOOP;
  -- начисления
  FLAG_CURR_MONTH:=0; --зА ТЕК МЕСЯЦ СЧЕТ ЕЩЕ НЕ ВЫСТАВЛЕН
  FOR rec IN (
    SELECT
      BILL_DATE,
      CASE
        WHEN vABON_COEFFICIENT = 1 THEN  - NVL(V_FULL_BALANCE_BILLS.BILL_SUM, 0)
        ELSE  - NVL(V_FULL_BALANCE_BILLS.BILL_SUM, 0)
              - NVL(V_FULL_BALANCE_BILLS.ABON_TP_NEW, 0) * (vABON_COEFFICIENT - 1)
      END BILL_SUM,
      V_FULL_BALANCE_BILLS.REMARK
      --'Начислено согласно счёту оператора за прошедший месяц'
    FROM
      V_FULL_BALANCE_BILLS
    WHERE
      V_FULL_BALANCE_BILLS.PHONE_NUMBER=pPHONE_NUMBER
      AND V_FULL_BALANCE_BILLS.BILL_DATE >= vSTART_BALANCE_DATE----vCORRECT_ACTIVATION_DATE_DAYS
      AND (pBALANCE_DATE IS NULL OR V_FULL_BALANCE_BILLS.BILL_DATE <= pBALANCE_DATE)
   --   and ((V_FULL_BALANCE_BILLS.BILL_CHECKED=1 and ms_constants.GET_CONSTANT_VALUE('USE_BILL_CHECK')='1')
   --         or (ms_constants.GET_CONSTANT_VALUE('USE_BILL_CHECK')<>'1'))
      )
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
  ELSE
    vTEMP_DATE_BEGIN_ABON:=vSTART_BALANCE_DATE;
  END IF;
  -- Определим дату начала расчёта
  SELECT MAX(LAST_DATE)
  INTO vABON_PAYMENT_START_DATE
  FROM (
    -- Счета (первый день после последнего счёта)
    SELECT
      TRUNC(DB_LOADER_BILLS.DATE_END)+1 LAST_DATE
    FROM DB_LOADER_BILLS,
         ACCOUNT_LOADED_BILLS
    WHERE DB_LOADER_BILLS.PHONE_NUMBER = pPHONE_NUMBER
      AND ACCOUNT_LOADED_BILLS.ACCOUNT_ID = DB_LOADER_BILLS.ACCOUNT_ID
      AND ACCOUNT_LOADED_BILLS.YEAR_MONTH = DB_LOADER_BILLS.YEAR_MONTH
      AND ACCOUNT_LOADED_BILLS.LOAD_BILL_IN_BALANCE = 1
 --     and ((DB_LOADER_BILLS.BILL_CHECKED=1 and ms_constants.GET_CONSTANT_VALUE('USE_BILL_CHECK')='1')
 --           or (ms_constants.GET_CONSTANT_VALUE('USE_BILL_CHECK')<>'1'))
    UNION ALL
    -- Счета нофого формата
    SELECT TRUNC(LAST_DAY(TO_DATE(TO_CHAR(DB_LOADER_FULL_FINANCE_BILL.YEAR_MONTH)||'01', 'YYYYMMDD')))+1 LAST_DATE
      FROM DB_LOADER_FULL_FINANCE_BILL,
           ACCOUNT_LOADED_BILLS
      WHERE DB_LOADER_FULL_FINANCE_BILL.PHONE_NUMBER = pPHONE_NUMBER
        AND ACCOUNT_LOADED_BILLS.ACCOUNT_ID = DB_LOADER_FULL_FINANCE_BILL.ACCOUNT_ID
        AND ACCOUNT_LOADED_BILLS.YEAR_MONTH = DB_LOADER_FULL_FINANCE_BILL.YEAR_MONTH
        AND ACCOUNT_LOADED_BILLS.LOAD_BILL_IN_BALANCE = 1
        AND DB_LOADER_FULL_FINANCE_BILL.COMPLETE_BILL = 1
    UNION ALL
    -- либо дата баланса/договора
    SELECT vTEMP_DATE_BEGIN_ABON
    FROM DUAL
  );
  IF vABON_PAYMENT_START_DATE<vSTART_BALANCE_DATE THEN
    vABON_PAYMENT_START_DATE:=vSTART_BALANCE_DATE;
  END IF;
  vCHECK_ABON_MODULE_DATE:=vABON_PAYMENT_START_DATE-1;
  -- Начислено
  FOR recPAYMENTS IN (
  SELECT DISTINCT
    DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH,
    CASE
      WHEN vSERVER_NAME='SIM_TRADE'
        THEN ADD_MONTHS(TO_DATE(TO_CHAR(DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH)||'26', 'YYYYMMDD'), -1)
      ELSE TO_DATE(DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH, 'YYYYMM')
    END BEGIN_DATE,
    CASE
      WHEN vSERVER_NAME='SIM_TRADE'
        THEN TO_DATE(TO_CHAR(DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH)||'25', 'YYYYMMDD')
      ELSE ADD_MONTHS(TO_DATE(DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH, 'YYYYMM'), 1)-1
    END END_DATE,
    CASE
      WHEN vSERVER_NAME='SIM_TRADE'
        THEN ADD_MONTHS(TO_DATE(TO_CHAR(DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH)||'26', 'YYYYMMDD'), -1)
      ELSE TO_DATE(DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH, 'YYYYMM')
    END FIRST_MONTH_DATE,
    CASE
      WHEN vSERVER_NAME='SIM_TRADE'
        THEN TO_DATE(TO_CHAR(DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH)||'25', 'YYYYMMDD')
      ELSE ADD_MONTHS(TO_DATE(DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH, 'YYYYMM'), 1)-1
    END LAST_MONTH_DATE,
    DB_LOADER_ACCOUNT_PHONES.PHONE_IS_ACTIVE,
    DB_LOADER_ACCOUNT_PHONES.CELL_PLAN_CODE
  FROM
    DB_LOADER_ACCOUNT_PHONES
  WHERE
    DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER=pPHONE_NUMBER
    AND (pBALANCE_DATE IS NULL OR TO_DATE(DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH, 'YYYYMM')<=pBALANCE_DATE)
    AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH >= TO_CHAR(vABON_PAYMENT_START_DATE, 'YYYYMM')
  UNION ALL
  -- А здесь добавим информацию текущего месяц, если он уже начался, а данные ещё не загружены.
  -- Все сведения берём из предыдущего месяца.
SELECT
    TO_NUMBER(TO_CHAR(
      ADD_MONTHS(
        TO_DATE(DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH, 'YYYYMM'),
        1), -- Увеличим номер месяца на 1
      'YYYYMM'
        )) as YEAR_MONTH,
    ADD_MONTHS(TO_DATE(DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH, 'YYYYMM'), 1) BEGIN_DATE,
    ADD_MONTHS(TO_DATE(DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH, 'YYYYMM'), 2)-1 END_DATE,
    ADD_MONTHS(TO_DATE(DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH, 'YYYYMM'), 1) FIRST_MONTH_DATE,
    ADD_MONTHS(TO_DATE(DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH, 'YYYYMM'), 2)-1 LAST_MONTH_DATE,
    DB_LOADER_ACCOUNT_PHONES.PHONE_IS_ACTIVE,
    DB_LOADER_ACCOUNT_PHONES.CELL_PLAN_CODE
  FROM
    DB_LOADER_ACCOUNT_PHONES
  WHERE
    DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER=pPHONE_NUMBER
    AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH = TO_CHAR(SYSDATE-5, 'YYYYMM')
    AND NOT EXISTS(
      SELECT 1 FROM DB_LOADER_ACCOUNT_PHONES
      WHERE DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH=TO_NUMBER(TO_CHAR(NVL(pBALANCE_DATE, SYSDATE), 'YYYYMM'))
      )
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
        PREV_STATUS:=NULL;
        TEMP_DATE_END_SCHET:=TRUNC(recPAYMENTS.END_DATE+1);
        OPEN cPHONE_STATUS_HISTORY(pPHONE_NUMBER, recPAYMENTS.BEGIN_DATE, recPAYMENTS.END_DATE, pCALC_ABON_PAYMENT_TO_MONTHEND);
        FETCH cPHONE_STATUS_HISTORY INTO recPHONE_STATUS_HISTORY;
        LOOP
          vPERIOD_ACTIV:=vPERIOD_ACTIV + recPHONE_STATUS_HISTORY.PHONE_IS_ACTIVE;
          IF TRUNC(recPHONE_STATUS_HISTORY.END_DATE)>=TRUNC(TEMP_DATE_END_SCHET-1) THEN
            recPHONE_STATUS_HISTORY.END_DATE:=TRUNC(TEMP_DATE_END_SCHET-1);
          END IF;
          IF (recPHONE_STATUS_HISTORY.END_DATE>=recPHONE_STATUS_HISTORY.BEGIN_DATE)
              AND(TRUNC(recPHONE_STATUS_HISTORY.BEGIN_DATE)<=TRUNC(TEMP_DATE_END_SCHET-1)) THEN
            -- Первый раз всегда заходим в цикл, даже если нет записей.
            -- Установим значения по умолчанию, если истории нет
            IF recPHONE_STATUS_HISTORY.CELL_PLAN_CODE IS NULL THEN
              recPHONE_STATUS_HISTORY.CELL_PLAN_CODE := recPAYMENTS.CELL_PLAN_CODE;
            END IF;
            IF recPHONE_STATUS_HISTORY.PHONE_IS_ACTIVE IS NULL THEN
              recPHONE_STATUS_HISTORY.PHONE_IS_ACTIVE := recPAYMENTS.PHONE_IS_ACTIVE;
            END IF;
            IF ABON_PAY_DAY_AFTER_BLOCK THEN
              IF (recPHONE_STATUS_HISTORY.PHONE_IS_ACTIVE=0) THEN
                IF recPHONE_STATUS_HISTORY.END_DATE-recPHONE_STATUS_HISTORY.BEGIN_DATE>=vCALC_ABON_BLOCK_COUNT_DAYS THEN
                  recPHONE_STATUS_HISTORY.END_DATE:=recPHONE_STATUS_HISTORY.BEGIN_DATE+vCALC_ABON_BLOCK_COUNT_DAYS;
                END IF;
              END IF;
            END IF;
            IF recPHONE_STATUS_HISTORY.BEGIN_DATE < recPAYMENTS.BEGIN_DATE THEN
              recPHONE_STATUS_HISTORY.BEGIN_DATE:=recPAYMENTS.BEGIN_DATE;
            END IF;
            -- Определим дневную стоимость
            recPHONE_STATUS_HISTORY.DAYLY_PRICE := recPHONE_STATUS_HISTORY.DAYLY_PRICE
                + (recPHONE_STATUS_HISTORY.MONTHLY_PRICE / (recPAYMENTS.LAST_MONTH_DATE - recPAYMENTS.FIRST_MONTH_DATE + 1));
            IF (NOT(vACCOUNT_ID=54 AND TO_NUMBER(TO_CHAR(recPHONE_STATUS_HISTORY.END_DATE, 'YYYYMM'))<=201202))
                AND (TRUNC(recPHONE_STATUS_HISTORY.BEGIN_DATE)<=TRUNC(recPHONE_STATUS_HISTORY.END_DATE)) THEN
              APPEND_ROW(
                recPHONE_STATUS_HISTORY.BEGIN_DATE,
                --Процент владельца
                RECALC_CHARGE_COST(pPHONE_NUMBER, -(vABON_COEFFICIENT * recPHONE_STATUS_HISTORY.DAYLY_PRICE*(TRUNC(recPHONE_STATUS_HISTORY.END_DATE)-TRUNC(recPHONE_STATUS_HISTORY.BEGIN_DATE)+1))),
                'Абонплата ('
                  || recPHONE_STATUS_HISTORY.CELL_PLAN_CODE
                  || CASE WHEN recPHONE_STATUS_HISTORY.PHONE_IS_ACTIVE = 1 THEN
                    ', активный'
                    ELSE
                    ', блокирован'
                    END
                  || ') c ' || TO_CHAR(recPHONE_STATUS_HISTORY.BEGIN_DATE, 'DD.MM.YYYY') || ' по ' || TO_CHAR(recPHONE_STATUS_HISTORY.END_DATE, 'DD.MM.YYYY') || ' ('
                  || ROUND(RECALC_CHARGE_COST(pPHONE_NUMBER, recPHONE_STATUS_HISTORY.DAYLY_PRICE), 2) || ' руб./день)'
                );
            END IF;
            TEMP_DATE_END_SCHET:=TRUNC(recPHONE_STATUS_HISTORY.BEGIN_DATE);
          END IF;
          PREV_STATUS:=recPHONE_STATUS_HISTORY.PHONE_IS_ACTIVE;
          FETCH cPHONE_STATUS_HISTORY INTO recPHONE_STATUS_HISTORY;
          EXIT WHEN cPHONE_STATUS_HISTORY%NOTFOUND;
        END LOOP;
        CLOSE cPHONE_STATUS_HISTORY;
  --      vABON_PAYMENT_SUM := vABON_PAYMENT_SUM +
  --        (recPAYMENTS.DAYLY_PRICE * (recPAYMENTS.END_DATE - recPAYMENTS.START_DATE + 1));
      END IF;
  -- Проверка наличия данных этого месяца
      FLAG_DATA_OPTIONS_CURR_MONTH:=0;
      FOR recFLAG IN (
        SELECT
          DB_LOADER_ACCOUNT_PHONE_OPTS.OPTION_CODE
        FROM
          DB_LOADER_ACCOUNT_PHONE_OPTS
        WHERE
          DB_LOADER_ACCOUNT_PHONE_OPTS.YEAR_MONTH=recPAYMENTS.YEAR_MONTH
          AND DB_LOADER_ACCOUNT_PHONE_OPTS.PHONE_NUMBER=pPHONE_NUMBER
        )
      LOOP
        FLAG_DATA_OPTIONS_CURR_MONTH:=1;
        EXIT;
      END LOOP;
      PAYMENTS_PREV_MONTH:=CASE
                             WHEN recPAYMENTS.YEAR_MONTH-ROUND(recPAYMENTS.YEAR_MONTH/100)*100=1 THEN recPAYMENTS.YEAR_MONTH-89
                             ELSE recPAYMENTS.YEAR_MONTH-1
                           END;
      FOR recSERVICES IN (
        SELECT
          DB_LOADER_ACCOUNT_PHONE_OPTS.OPTION_CODE,
          DB_LOADER_ACCOUNT_PHONE_OPTS.OPTION_NAME,
          DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_ON_DATE,
          DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_OFF_DATE,
          DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_ON_COST,
          DB_LOADER_ACCOUNT_PHONE_OPTS.MONTHLY_PRICE,
          ACCOUNTS.OPERATOR_ID,
          TARIFF_OPTIONS.DISCR_SPISANIE
        FROM
          DB_LOADER_ACCOUNT_PHONE_OPTS,
          ACCOUNTS,
          TARIFF_OPTIONS
        WHERE DB_LOADER_ACCOUNT_PHONE_OPTS.ACCOUNT_ID=ACCOUNTS.ACCOUNT_ID --ACCOUNT_ID=45
          AND DB_LOADER_ACCOUNT_PHONE_OPTS.OPTION_CODE = TARIFF_OPTIONS.OPTION_CODE(+)
          AND (
            (DB_LOADER_ACCOUNT_PHONE_OPTS.YEAR_MONTH=recPAYMENTS.YEAR_MONTH
              AND FLAG_DATA_OPTIONS_CURR_MONTH=1)
            OR (DB_LOADER_ACCOUNT_PHONE_OPTS.YEAR_MONTH=PAYMENTS_PREV_MONTH
              AND FLAG_DATA_OPTIONS_CURR_MONTH=0
              AND DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_OFF_DATE>=TO_DATE(TO_CHAR(recPAYMENTS.YEAR_MONTH)||'01','YYYYMMDD') )
              )
          AND DB_LOADER_ACCOUNT_PHONE_OPTS.PHONE_NUMBER=pPHONE_NUMBER -- '9037786589'
         -- AND (DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_ON_COST <> 0 OR DB_LOADER_ACCOUNT_PHONE_OPTS.MONTHLY_PRICE <> 0)
          AND (pBALANCE_DATE IS NULL OR DB_LOADER_ACCOUNT_PHONE_OPTS.TURN_ON_DATE <= pBALANCE_DATE)
        )
      LOOP
        -- Начальная дата
        vSERVICE_START_DATE := recPAYMENTS.BEGIN_DATE; -- Начало месяца
        IF vSERVICE_START_DATE < recSERVICES.TURN_ON_DATE THEN
          vSERVICE_START_DATE := TRUNC(recSERVICES.TURN_ON_DATE); -- Дата подключения
        END IF;
        -- Конечная дата
        vSERVICE_END_DATE := recPAYMENTS.LAST_MONTH_DATE; -- Конец месяца
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
        GET_TARIFF_OPTION_COST(
          recSERVICES.OPERATOR_ID,
          GET_PHONE_TARIFF_ID(pPHONE_NUMBER, recCODE, vDATE_SERVICE_CHECK), -- Тариф БЕРЕМ по функции
          recSERVICES.OPTION_CODE,
          vDATE_SERVICE_CHECK,
          vNEW_TURN_ON_COST,
          vNEW_MONTHLY_COST
          );
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
            APPEND_ROW(
              recSERVICES.TURN_ON_DATE,
              --Процент владельца
              RECALC_CHARGE_COST(pPHONE_NUMBER, -recSERVICES.TURN_ON_COST),
              'Подключена услуга ' || recSERVICES.OPTION_NAME
                || ' (' || recSERVICES.OPTION_CODE
                || ') с ' || TO_CHAR(recSERVICES.TURN_ON_DATE, 'DD.MM.YYYY')
              );
          END IF;
        END IF;
        -- Ежемесячная абонентская плата за услугу
        IF (recSERVICES.MONTHLY_PRICE <> 0)AND(NVL(vCREDIT, 0)<>1) AND (vPERIOD_ACTIV > 0) THEN
          --
          --   Списание абонплаты делаем так:
          --   - Если услуга подключена в текущем месяце, то по количеству дней
          --     от даты подключения до конца месяца, либо до даты отключения,
          --     либо до текущей даты, если абонплату считаем "по сегодня".
          --   - Если услуга подключена ранее, то в размере месячной платы, либо
          --     по количеству дней от начала месяца до даты отключения.
          --   - Если услуга подключена позднее (если счёта ещё нет), то списание не делаем.
          --
          -- Если абонплата считается не до конца месяца, то корректируем дату окончания
          IF (NOT vCALC_ABON_PAYMENT_TO_MONTHEND) THEN     -- Проверка как считается по умолчанию, до конца месяца или иначе
            IF (vSERVICE_END_DATE > TRUNC(NVL(pBALANCE_DATE, SYSDATE)))
              AND (NVL(recSERVICES.DISCR_SPISANIE, 0)<>1) THEN   -- Услуга списывается не дискретно, при списании по тек день.
              vSERVICE_END_DATE := TRUNC(NVL(pBALANCE_DATE, SYSDATE));
            END IF;
          ELSE   -- Списание по конец месяца
            IF (vSERVICE_END_DATE > TRUNC(NVL(pBALANCE_DATE, SYSDATE)))
                AND (NVL(recSERVICES.DISCR_SPISANIE, 1) = 0) THEN  -- Услуга списывается не дискретно, при списании по конец месаца.
              vSERVICE_END_DATE := TRUNC(NVL(pBALANCE_DATE, SYSDATE));
            END IF;
          END IF;
          -- Если услуга отключена ранее конца проверяемого месяца, то
          -- дата окончания услуги корректируется
          IF vSERVICE_END_DATE > recSERVICES.TURN_OFF_DATE THEN
            vSERVICE_END_DATE := recSERVICES.TURN_OFF_DATE;
          END IF;
          --
          vSERVICE_PAID_FULL:=0;
          IF (pPHONE_NUMBER='9099093514')AND(recSERVICES.OPTION_CODE='MN_UNLIMC')and(vSERVICE_END_DATE>=TRUNC(NVL(pBALANCE_DATE, SYSDATE))) then
            IF vSERVICE_END_DATE>=trunc(sysdate) then
              vSERVICE_END_DATE:=
                CASE
                  WHEN TO_NUMBER(TO_CHAR(SYSDATE, 'DD'))<=25 THEN
                    TO_DATE('25'||TO_CHAR(SYSDATE, 'MMYYYY'), 'DDMMYYYY')
                  ELSE TO_DATE('25'||TO_CHAR(ADD_MONTHS(SYSDATE, 1), 'MMYYYY'), 'DDMMYYYY')
                END;
              vSERVICE_PAID_FULL:=1;
            END IF;
          END IF;
          --
          IF (recSERVICES.OPTION_CODE='GPRS_FS')AND(vSERVICE_END_DATE>SYSDATE) THEN
            vSERVICE_END_DATE:=SYSDATE;
          END IF;
          --
          IF vCALC_OPTIONS_DAILY_ACTIV='1' THEN
            vLAST_DAY_OPTION_ADD:=vSERVICE_START_DATE-1;
            vCOUNT_ACT_OPTION:=0;
            FOR recACTIV IN OPT_ACT(vSERVICE_START_DATE, vSERVICE_END_DATE) LOOP
              IF recACTIV.BEGIN_DATE<=vLAST_DAY_OPTION_ADD THEN
                recACTIV.BEGIN_DATE:=vLAST_DAY_OPTION_ADD+1;
              END IF;
              IF recACTIV.END_DATE>vSERVICE_END_DATE THEN
                recACTIV.END_DATE:=vSERVICE_END_DATE;
              END IF;
              vCOUNT_ACT_OPTION:=vCOUNT_ACT_OPTION+(TRUNC(recACTIV.END_DATE)-TRUNC(recACTIV.BEGIN_DATE)+1);
              vLAST_DAY_OPTION_ADD:=recACTIV.END_DATE;
            END LOOP;
          END IF;
          -- Списание
          IF (vSERVICE_START_DATE <= vSERVICE_END_DATE)
              AND (pBALANCE_DATE IS NULL OR vSERVICE_START_DATE <= pBALANCE_DATE) THEN
            IF vSERVICE_PAID_FULL=0 THEN
              APPEND_ROW(
                vSERVICE_START_DATE,
                -recSERVICES.MONTHLY_PRICE
                * CASE
                    WHEN (NOT vCALC_ABON_PAYMENT_TO_MONTHEND) AND (NVL(recSERVICES.DISCR_SPISANIE, 0) = 1) THEN 1
                    ELSE CASE
                           WHEN vCALC_OPTIONS_DAILY_ACTIV='1' THEN vCOUNT_ACT_OPTION
                           ELSE (TRUNC(vSERVICE_END_DATE) - TRUNC(vSERVICE_START_DATE) + 1)
                         END / (TRUNC(recPAYMENTS.LAST_MONTH_DATE) - TRUNC(recPAYMENTS.FIRST_MONTH_DATE) + 1)
                  END
                ,
                'Абонплата за услугу ' || recSERVICES.OPTION_NAME
                  || ' (' || recSERVICES.OPTION_CODE
                  || ') с ' || TO_CHAR(vSERVICE_START_DATE, 'DD.MM.YYYY')
                  || ' по ' || TO_CHAR(vSERVICE_END_DATE, 'DD.MM.YYYY')
                  || CASE
                       WHEN vCALC_OPTIONS_DAILY_ACTIV='1' THEN ' Был акт. дн: '||TO_CHAR(vCOUNT_ACT_OPTION)
                       ELSE ''
                     END
                );
            ELSE
              APPEND_ROW(
                vSERVICE_START_DATE,
                --Процент владельца
                CASE
                  WHEN TO_NUMBER(TO_CHAR(SYSDATE, 'DD'))<=25 THEN -recSERVICES.MONTHLY_PRICE
                  ELSE  -recSERVICES.MONTHLY_PRICE*2
                END
                ,
                'Плата за услугу ' || recSERVICES.OPTION_NAME || ' до ' ||
                TO_CHAR(CASE
                          WHEN TO_NUMBER(TO_CHAR(SYSDATE, 'DD'))<=25 THEN
                            TO_DATE('25'||TO_CHAR(SYSDATE, 'MMYYYY'), 'DDMMYYYY')
                          ELSE TO_DATE('25'||TO_CHAR(ADD_MONTHS(SYSDATE, 1), 'MMYYYY'), 'DDMMYYYY')
                        END, 'DD.MM.YYYY')
                );
            END IF;
          END IF;
        END IF;
      END LOOP;
    END IF;
  END LOOP;
END;
