CREATE OR REPLACE PROCEDURE CALC_BALANCE_ABPROWS2 (
  pPHONE_NUMBER IN VARCHAR2,
  pDATE_ROWS IN OUT NOCOPY DBMS_SQL.DATE_TABLE,
  pCOST_ROWS IN OUT NOCOPY DBMS_SQL.NUMBER_TABLE,
  pDESCRIPTION_ROWS IN OUT NOCOPY DBMS_SQL.VARCHAR2_TABLE,
  pFILL_DESCRIPTION IN BOOLEAN DEFAULT TRUE,
  pBALANCE_DATE IN DATE DEFAULT NULL
  ) IS

vPERIOD_ACTIV INTEGER;
  DAY_PAY_IN_BLOK CONSTANT NUMBER:=5;
  DAYS_NESTABIL CONSTANT INTEGER:=5;
  cDAYS_PAYMENT_BEFORE_CONTRACT INTEGER := 4; -- ��� �� ������ ���������, ��� ������� ����� ����������� �������
  CURSOR C_CONTRACT IS
    SELECT
      CONTRACTS.CONTRACT_DATE,
      CONTRACTS.CONTRACT_ID,
      CONTRACTS.IS_CREDIT_CONTRACT
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
      -- � ����������� �� ���������� ������ ���� ������� ���� ������������� ����
      CASE WHEN (DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_IS_ACTIVE=1)
        -- ���� ������� ���������� � ��������� ������, �� ������� ��������� ��� ��� ������������
        OR ((DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE > SYSDATE)
              AND (TO_CHAR(DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE, 'YYYYMM') = TO_CHAR(SYSDATE, 'YYYYMM'))
              AND (pCALC_ABON_PAYMENT_TO_MONTHEND=1))
        THEN NVL(TARIFFS.MONTHLY_PAYMENT, 0)
        ELSE NVL(TARIFFS.MONTHLY_PAYMENT_LOCKED, 0)
      END as MONTHLY_PRICE,
      -- � ����������� �� ���������� ������ ���� ������� ���� ������������� ���������
      CASE WHEN (DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_IS_ACTIVE=1)
        -- ���� ������� ���������� � ��������� ������, �� ������� ��������� ��� ��� ������������
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
      -- ���� ����� ��������������� ��������� �������, �������� ����������
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
           --������� ��������� ����������� � ���������
           TRUNC(RECALC_CHARGE_COST(pPHONE_NUMBER, -DETAIL_SUM), 2) AS BILL_SUM,
           '����������� ������� �� ' || TO_CHAR(DATE_LAST_UPDATE,'MM.YYYY') || ' (�� '
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
--  vABON_PAYMENT_SUM     NUMBER(15, 2);
  vSERVICE_START_DATE DATE; -- ���� ������  ������� ��������� �� ������.
  vSERVICE_END_DATE DATE;   -- ���� ��������� ������� ��������� �� ������.
  vNEW_TURN_ON_COST NUMBER; -- ��������� ����������� �������� ����� (�� �����������).
  vNEW_MONTHLY_COST NUMBER; -- ��������� ����� � ����� (�� �����������).
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
  vCALC_ABON_PAYMENT_TO_MONTHEND BOOLEAN; -- ������� ������� ��������� �� ����� ������
  --
  -- ���������� ����, �� ������� ���� ������ ��������� ������� ���������.
  -- ���� ���� ��������� �� ��������� � ����� ��������, �� ����� ������ ������ �� ���� ���������.
  vCORRECT_ACTIVATION_DATE_DAYS INTEGER;
  vTEMP_DATE_BEGIN_ABON DATE; -- ��������� ����������(������ ���� ���������)
  PREV_STATUS NUMBER;
  pCALC_ABON_PAYMENT_TO_MONTHEND INTEGER;
  TEMP_DATE_END_SCHET DATE;  -- ����, ��-������� ������ ����������
  vDATE_SERVICE_CHECK DATE;
  vSERVER_NAME VARCHAR2(50 CHAR);
  vCALC_OPTIONS_DAILY_ACTIV varchar2(30 char);
  vLAST_DAY_OPTION_ADD DATE;
  vCOUNT_ACT_OPTION INTEGER;
  vDUMMY_PH PH_W_D_A%ROWTYPE;
  vFIX_YEAR_MONTH_ID INTEGER;
  vSERVICE_PAID_FULL INTEGER;
  vDUMMY_TPT TARIFF_PAY_TYPE%rowtype;
--
  PROCEDURE APPEND_ROW(pDATE DATE, pCOST NUMBER, pDESCRIPTION VARCHAR2) IS
    C BINARY_INTEGER;
  BEGIN
    IF pCOST <> 0 THEN
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
  -- ���������� ���� ��������� ���� ���������
  vCORRECT_ACTIVATION_DATE_DAYS := NVL(MS_CONSTANTS.GET_CONSTANT_VALUE('CORRECT_ACTIVATION_DATE_DAYS'), 0);
  --
 -- vSERVER_NAME:=MS_CONSTANTS.GET_CONSTANT_VALUE('SERVER_NAME');
  --
  vCALC_OPTIONS_DAILY_ACTIV:=MS_CONSTANTS.GET_CONSTANT_VALUE('CALC_OPTIONS_DAILY_ACTIV');
  --
  OPEN C_CONTRACT;
  FETCH C_CONTRACT INTO vCONTRACT_DATE, vCONTRACT_ID, vCREDIT;
  CLOSE C_CONTRACT;
 
  
  -- ����������
  FLAG_CURR_MONTH:=0; --�� ��� ����� ���� ��� �� ���������

  -- ��������� �� ������
  -- �� ��������� ������� ��������� ������ � ������� ������ (��� ������)!
  -- �� ��������� ������� ��������� ������� ������� (��� ������)
  --
  IF '1' = MS_CONSTANTS.GET_CONSTANT_VALUE('CALC_ABON_PAYMENT_BLOCK_5_DAYS') THEN
    ABON_PAY_DAY_AFTER_BLOCK:=TRUE;
  ELSE
    ABON_PAY_DAY_AFTER_BLOCK:=FALSE;
  END IF;
  --
  -- ������ ���� ���������
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
  -- ��������� ���� ������ �������
  SELECT MAX(LAST_DATE)
  INTO vABON_PAYMENT_START_DATE
  FROM (
    -- ����� (������ ���� ����� ���������� �����)
    SELECT
      TRUNC(DB_LOADER_BILLS.DATE_END)+1 LAST_DATE
    FROM DB_LOADER_BILLS
    WHERE DB_LOADER_BILLS.PHONE_NUMBER = pPHONE_NUMBER
      and ((DB_LOADER_BILLS.BILL_CHECKED=1 and ms_constants.GET_CONSTANT_VALUE('USE_BILL_CHECK')='1')
            or (ms_constants.GET_CONSTANT_VALUE('USE_BILL_CHECK')<>'1'))
    UNION ALL
    -- ����� ������ �������
    SELECT TRUNC(LAST_DAY(TO_DATE(TO_CHAR(DB_LOADER_FULL_FINANCE_BILL.YEAR_MONTH)||'01', 'YYYYMMDD')))+1 LAST_DATE
      FROM DB_LOADER_FULL_FINANCE_BILL
      WHERE DB_LOADER_FULL_FINANCE_BILL.PHONE_NUMBER = pPHONE_NUMBER
        AND DB_LOADER_FULL_FINANCE_BILL.COMPLETE_BILL = 1
        and DB_LOADER_FULL_FINANCE_BILL.YEAR_MONTH <=201311
    UNION ALL
    -- ���� ���� �������/��������
    SELECT vTEMP_DATE_BEGIN_ABON
    FROM DUAL
  );
  IF vABON_PAYMENT_START_DATE<vSTART_BALANCE_DATE THEN
    vABON_PAYMENT_START_DATE:=vSTART_BALANCE_DATE;
  END IF;
  -- ���������
  FOR recPAYMENTS IN (
  SELECT DISTINCT
    DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH,
    TO_DATE(DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH, 'YYYYMM') BEGIN_DATE,
    ADD_MONTHS(TO_DATE(DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH, 'YYYYMM'), 1)-1 END_DATE,
    TO_DATE(DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH, 'YYYYMM') FIRST_MONTH_DATE,
    ADD_MONTHS(TO_DATE(DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH, 'YYYYMM'), 1)-1 LAST_MONTH_DATE,
    DB_LOADER_ACCOUNT_PHONES.PHONE_IS_ACTIVE,
    DB_LOADER_ACCOUNT_PHONES.CELL_PLAN_CODE
  FROM
    DB_LOADER_ACCOUNT_PHONES
  WHERE
    DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER=pPHONE_NUMBER
    AND (pBALANCE_DATE IS NULL OR TO_DATE(DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH, 'YYYYMM')<=pBALANCE_DATE)
    AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH >= TO_CHAR(vABON_PAYMENT_START_DATE, 'YYYYMM')
  UNION ALL
  -- � ����� ������� ���������� �������� �����, ���� �� ��� �������, � ������ ��� �� ���������.
  -- ��� �������� ���� �� ����������� ������.
SELECT
    TO_NUMBER(TO_CHAR(
      ADD_MONTHS(
        TO_DATE(DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH, 'YYYYMM'),
        1), -- �������� ����� ������ �� 1
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
    )
  LOOP
--    dbms_output.put_line('recPAYMENTS.END_DATE=' || recPAYMENTS.END_DATE);
vPERIOD_ACTIV:=0;
    IF NVL(vCREDIT, 0)<>1 THEN -- ���� 1, �� ������� ���������, ����� ������ �� �������
      IF recPAYMENTS.BEGIN_DATE < vABON_PAYMENT_START_DATE THEN
        recPAYMENTS.BEGIN_DATE := vABON_PAYMENT_START_DATE;
      END IF;
      IF pCALC_ABON_PAYMENT_TO_MONTHEND=1 THEN
        -- ��������� ��������� �� ����� �������� ������.
        NULL;
      ELSE
        -- ��������� ����� ������� �� ������� ����.
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
          -- ������ ��� ������ ������� � ����, ���� ���� ��� �������.
          -- ��������� �������� �� ���������, ���� ������� ���
          IF recPHONE_STATUS_HISTORY.CELL_PLAN_CODE IS NULL THEN
            recPHONE_STATUS_HISTORY.CELL_PLAN_CODE := recPAYMENTS.CELL_PLAN_CODE;
          END IF;
          IF recPHONE_STATUS_HISTORY.PHONE_IS_ACTIVE IS NULL THEN
            recPHONE_STATUS_HISTORY.PHONE_IS_ACTIVE := recPAYMENTS.PHONE_IS_ACTIVE;
          END IF;
          IF ABON_PAY_DAY_AFTER_BLOCK THEN
            IF (recPHONE_STATUS_HISTORY.PHONE_IS_ACTIVE=0)
                  AND (PREV_STATUS IS NULL
                         OR PREV_STATUS=1) THEN
              IF recPHONE_STATUS_HISTORY.END_DATE-recPHONE_STATUS_HISTORY.BEGIN_DATE>=5 THEN
                recPHONE_STATUS_HISTORY.END_DATE:=recPHONE_STATUS_HISTORY.BEGIN_DATE+5;
              END IF;
            END IF;
          END IF;
          IF recPHONE_STATUS_HISTORY.BEGIN_DATE < recPAYMENTS.BEGIN_DATE THEN
            recPHONE_STATUS_HISTORY.BEGIN_DATE:=recPAYMENTS.BEGIN_DATE;
          END IF;
          -- ��������� ������� ���������
          recPHONE_STATUS_HISTORY.DAYLY_PRICE := recPHONE_STATUS_HISTORY.DAYLY_PRICE
              + (recPHONE_STATUS_HISTORY.MONTHLY_PRICE / (recPAYMENTS.LAST_MONTH_DATE - recPAYMENTS.FIRST_MONTH_DATE + 1));
          IF (NOT(vACCOUNT_ID=54 AND TO_NUMBER(TO_CHAR(recPHONE_STATUS_HISTORY.END_DATE, 'YYYYMM'))<=201202))
              AND (TRUNC(recPHONE_STATUS_HISTORY.BEGIN_DATE)<=TRUNC(recPHONE_STATUS_HISTORY.END_DATE)) THEN
            APPEND_ROW(
              recPHONE_STATUS_HISTORY.BEGIN_DATE,
              --������� ���������
              RECALC_CHARGE_COST(pPHONE_NUMBER, -(recPHONE_STATUS_HISTORY.DAYLY_PRICE*(recPHONE_STATUS_HISTORY.END_DATE-recPHONE_STATUS_HISTORY.BEGIN_DATE+1))),
              '��������� ('
                || recPHONE_STATUS_HISTORY.CELL_PLAN_CODE
                || CASE WHEN recPHONE_STATUS_HISTORY.PHONE_IS_ACTIVE = 1 THEN
                  ', ��������'
                  ELSE
                  ', ����������'
                  END
                || ') c ' || TO_CHAR(recPHONE_STATUS_HISTORY.BEGIN_DATE, 'DD.MM.YYYY') || ' �� ' || TO_CHAR(recPHONE_STATUS_HISTORY.END_DATE, 'DD.MM.YYYY') || ' ('
                || ROUND(RECALC_CHARGE_COST(pPHONE_NUMBER, recPHONE_STATUS_HISTORY.DAYLY_PRICE), 2) || ' ���./����)'
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
-- �������� ������� ������ ����� ������
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
        ACCOUNTS.OPERATOR_ID
      FROM
        DB_LOADER_ACCOUNT_PHONE_OPTS,
        ACCOUNTS
      WHERE --ACCOUNT_ID=45
        DB_LOADER_ACCOUNT_PHONE_OPTS.ACCOUNT_ID=ACCOUNTS.ACCOUNT_ID
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
      -- ��������� ����
      vSERVICE_START_DATE := recPAYMENTS.BEGIN_DATE; -- ������ ������
      IF vSERVICE_START_DATE < recSERVICES.TURN_ON_DATE THEN
        vSERVICE_START_DATE := TRUNC(recSERVICES.TURN_ON_DATE); -- ���� �����������
      END IF;
      -- �������� ����
      vSERVICE_END_DATE := recPAYMENTS.LAST_MONTH_DATE; -- ����� ������
      --
      vDATE_SERVICE_CHECK:=recSERVICES.TURN_ON_DATE+1;
      IF vDATE_SERVICE_CHECK<vCONTRACT_DATE THEN
        vDATE_SERVICE_CHECK:=vCONTRACT_DATE+1;
      END IF;
      IF vDATE_SERVICE_CHECK<TO_DATE(recPAYMENTS.YEAR_MONTH||'01', 'YYYYMMDD') THEN
        vDATE_SERVICE_CHECK:=TO_DATE(recPAYMENTS.YEAR_MONTH||'01', 'YYYYMMDD')+1;
      END IF;
      OPEN CODE(vDATE_SERVICE_CHECK+5); -- ���� ����������� ������ + 5 ���� �� ������ ������������ ��������
      FETCH CODE INTO recCODE; -- ������� ��� ������ � ��� ���
      CLOSE CODE;             --
      GET_TARIFF_OPTION_COST(
        recSERVICES.OPERATOR_ID,
        GET_PHONE_TARIFF_ID(pPHONE_NUMBER, recCODE, vDATE_SERVICE_CHECK), -- ����� ����� �� �������
        recSERVICES.OPTION_CODE,
        vDATE_SERVICE_CHECK,
        vNEW_TURN_ON_COST,
        vNEW_MONTHLY_COST
        );
      -- ���� ��������� � ����������� ������, �� ���������� �.
      recSERVICES.TURN_ON_COST := NVL(NVL(vNEW_TURN_ON_COST, recSERVICES.TURN_ON_COST), 0);
      recSERVICES.MONTHLY_PRICE := NVL(NVL(vNEW_MONTHLY_COST, recSERVICES.MONTHLY_PRICE), 0);
      -- ��������� ����������� ��������� ������ � ��� ������, � ������� ����������.
      IF recSERVICES.TURN_ON_COST <> 0 THEN
        -- ���� ��������� ����������� ���������,
        -- �� ���� ��������� ���� �����������.
        -- ���� ���� ����������� � ������� ������, �� ���� � ������.
        IF TO_CHAR(recSERVICES.TURN_ON_DATE, 'YYYYMM') = recPAYMENTS.YEAR_MONTH THEN
          APPEND_ROW(
            recSERVICES.TURN_ON_DATE,
            --������� ���������
            RECALC_CHARGE_COST(pPHONE_NUMBER, -recSERVICES.TURN_ON_COST),
            '���������� ������ ' || recSERVICES.OPTION_NAME
              || ' (' || recSERVICES.OPTION_CODE
              || ') � ' || TO_CHAR(recSERVICES.TURN_ON_DATE, 'DD.MM.YYYY')
            );
        END IF;
      END IF;
      -- ����������� ����������� ����� �� ������
      IF (recSERVICES.MONTHLY_PRICE <> 0)AND(NVL(vCREDIT, 0)<>1) AND (vPERIOD_ACTIV > 0)THEN
        --
        --   �������� ��������� ������ ���:
        --   - ���� ������ ���������� � ������� ������, �� �� ���������� ����
        --     �� ���� ����������� �� ����� ������, ���� �� ���� ����������,
        --     ���� �� ������� ����, ���� ��������� ������� "�� �������".
        --   - ���� ������ ���������� �����, �� � ������� �������� �����, ����
        --     �� ���������� ���� �� ������ ������ �� ���� ����������.
        --   - ���� ������ ���������� ������� (���� ����� ��� ���), �� �������� �� ������.
        --
        -- ���� ��������� ��������� �� �� ����� ������, �� ������������ ���� ���������
        IF NOT vCALC_ABON_PAYMENT_TO_MONTHEND THEN
          IF vSERVICE_END_DATE > TRUNC(NVL(pBALANCE_DATE, SYSDATE)) THEN
            vSERVICE_END_DATE := TRUNC(NVL(pBALANCE_DATE, SYSDATE));
          END IF;
        END IF;
        -- ���� ������ ��������� ����� ����� ������������ ������, ��
        -- ���� ��������� ������ ��������������
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
        IF (recSERVICES.OPTION_CODE='GPRS_FS' or recSERVICES.OPTION_CODE='GPRS_1GB')AND(vSERVICE_END_DATE>SYSDATE) THEN
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
        -- ��������
        IF (vSERVICE_START_DATE <= vSERVICE_END_DATE)
            AND (pBALANCE_DATE IS NULL OR vSERVICE_START_DATE <= pBALANCE_DATE) THEN
          IF vSERVICE_PAID_FULL=0 THEN
            APPEND_ROW(
              vSERVICE_START_DATE,
              --������� ���������
              RECALC_CHARGE_COST(pPHONE_NUMBER,
                -recSERVICES.MONTHLY_PRICE
                * CASE
                    WHEN vCALC_OPTIONS_DAILY_ACTIV='1' THEN vCOUNT_ACT_OPTION
                    ELSE (TRUNC(vSERVICE_END_DATE) - TRUNC(vSERVICE_START_DATE) + 1)
                  END
                / (TRUNC(recPAYMENTS.LAST_MONTH_DATE) - TRUNC(recPAYMENTS.FIRST_MONTH_DATE) + 1))
              ,
              '��������� �� ������ ' || recSERVICES.OPTION_NAME
                || ' (' || recSERVICES.OPTION_CODE
                || ') � ' || TO_CHAR(vSERVICE_START_DATE, 'DD.MM.YYYY')
                || ' �� ' || TO_CHAR(vSERVICE_END_DATE, 'DD.MM.YYYY')
                || CASE
                     WHEN vCALC_OPTIONS_DAILY_ACTIV='1' THEN ' ��� ���. ��: '||TO_CHAR(vCOUNT_ACT_OPTION)
                     ELSE ''
                   END
              );
          ELSE
            APPEND_ROW(
              vSERVICE_START_DATE,
              --������� ���������
              RECALC_CHARGE_COST(pPHONE_NUMBER,
                CASE
                  WHEN TO_NUMBER(TO_CHAR(SYSDATE, 'DD'))<=25 THEN -recSERVICES.MONTHLY_PRICE
                  ELSE  -recSERVICES.MONTHLY_PRICE*2
                END)
              ,
              '����� �� ������ ' || recSERVICES.OPTION_NAME || ' �� ' ||
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
  END LOOP;
END;
/