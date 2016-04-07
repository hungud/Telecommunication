
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."ADD_DISTRIBUTED_PAYMENT" (
   PHONE_NUMBER                VARCHAR2,                     -- НОМЕР ТЕЛЕФОНА
   PAYMEN_SUM                  NUMBER,                     -- ОПЛАЧЕННАЯ СУММА
   PAYMENT_DATE_TIME           DATE,                   -- ДАТА И ВРЕМЯ ПЛАТЕЖА
   pREMARK                     VARCHAR2,               -- ПРИМЕЧАНИЯ К ПЛАТЕЖУ
   RECEIVED_PAYMENT_TYPE_ID    INTEGER, -- ТИП ПЛАТЕЖА (ССЫЛКА НА RECEIVED_PAYMENT_TYPES)
   YEAR_MONTH                  NUMBER,          -- ПЕРИОД РАСПРЕДЕЛЕНИЯ ЗАТРАТ
   RUN_MODE                    VARCHAR2,
   pRECEIVED_PAYMENT_ID        INTEGER DEFAULT NULL)
IS
   -- #Version 6
   -- 6. - Крайнов. Перевел на счета Тарифера.
   -- 5. - Матюнин. Исправлен косяк: В случае когда основной платеж был на номер, который имел нулевые затраты за период - для него не регситрировалось удержание!
   -- 4. - Матюнин. Теперь считаем затраты и по тем что нет в балансе
   -- 3. - Матюнин. Исправлен еще один косяк в расчете затрат по текущим затратам + по затратам в закрытые периоды.
   -- 2. - Матюнин. Исправлен косяк в расчете затрат по текущим затратам.
   -- 1. - Матюнин. Процедура для создания платежей распределенных по группе номеров.
   vCONTR                         INTEGER;
   vCOUNT_IN_GROUP                INTEGER;
   vGROUP_ID                      INTEGER;
   vALL_SUM_CALLS                 NUMBER (12, 2);
   vALL_SUM_ABONENT               NUMBER (12, 2);
   vDISTRIBUTE_SUM                NUMBER (12, 2);
   vCUR_PAY                       NUMBER (12, 2);
   vCUR_SUM_PAY                   NUMBER (12, 2);
   vMSG                           VARCHAR2 (200);
   vRECEIVED_PAYMENT_ID           INTEGER;
   vCORRECT_RECEIVED_PAYMENT_ID   INTEGER; -- id КОРРЕКТИРУЮЩЕГО ПЛАТЕЖА ДЛЯ PHONE_NUMBER

   -- ОПРЕДЕЛЯЕМ СПИСОК ДЕЙСТВУЮЩИХ КОНТРАКТОВ ПО ГРУППЕ КОНТРАКТОВ
   CURSOR CONTRACT_LIST (
      pGROUP_ID      CONTRACT_GROUPS.GROUP_ID%TYPE,
      pYEAR_MONTH    NUMBER)
   IS
      SELECT CON.CONTRACT_ID, CON.PHONE_NUMBER_FEDERAL
        FROM CONTRACTS CON, V_CONTRACTS VC, CONTRACT_GROUPS CG
       WHERE     CON.GROUP_ID = CG.GROUP_ID
             AND VC.CONTRACT_ID = CON.CONTRACT_ID
             AND TO_NUMBER (TO_CHAR (CON.CONTRACT_DATE, 'YYYYMM')) <=
                    pYEAR_MONTH
             AND (   VC.CONTRACT_CANCEL_DATE IS NULL
                  OR TO_NUMBER (TO_CHAR (VC.CONTRACT_CANCEL_DATE, 'YYYYMM')) >=
                        pYEAR_MONTH)
             AND CG.GROUP_ID = pGROUP_ID;

   CURSOR PAYMENT_LIST (pPARENT_PAYMENT_ID INTEGER)
   IS
      SELECT RP.RECEIVED_PAYMENT_ID, RP.CONTRACT_ID, RP.PHONE_NUMBER
        FROM RECEIVED_PAYMENTS RP
       WHERE RP.PARENT_PAYMENT_ID = pPARENT_PAYMENT_ID;

   FUNCTION GET_SUMM_ALL_CALLS (pGROUP_ID       CONTRACT_GROUPS.GROUP_ID%TYPE,
                                pYEAR_MONTH     INTEGER,
                                pCONTRACT_ID    INTEGER)
      RETURN NUMBER
   IS
      vSUM_ALL_CALS_ACCOUNT   NUMBER (12, 2);
      vSUM_ALL_CALS_REPORT    NUMBER (12, 2);

      -- ОПРЕДЕЛЯЕМ ОБЩУЮ СУММУ ЗАТРАТ, ПРЕДСТАВЛЕННЫЕ В СЧЕТАХ, ПО ВСЕМ АБОНЕНТАМ ЗА ПЕРИОД
      CURSOR CUR_ALL_ACCOUNT_CALLS (
         pGROUP_ID       CONTRACT_GROUPS.GROUP_ID%TYPE,
         pYEAR_MONTH     INTEGER,
         pCONTRACT_ID    INTEGER)
      IS
         SELECT SUM (FFB.BILL_SUMM)
           INTO vALL_SUM_CALLS
           FROM CONTRACTS CON,
                V_CONTRACTS VC,
                CONTRACT_GROUPS CG,
                TARIFER_BILL_FOR_CLIENTS FFB
          --,DB_LOADER_FULL_FINANCE_BILL FFB
          WHERE     CON.GROUP_ID = CG.GROUP_ID
                AND VC.CONTRACT_ID = CON.CONTRACT_ID
                AND VC.CONTRACT_CANCEL_DATE IS NULL
                AND CG.GROUP_ID = pGROUP_ID
                AND FFB.PHONE_NUMBER = CON.PHONE_NUMBER_FEDERAL
                AND FFB.YEAR_MONTH = pYEAR_MONTH
                AND (   (    pCONTRACT_ID IS NOT NULL
                         AND CON.CONTRACT_ID = pCONTRACT_ID)
                     OR (pCONTRACT_ID IS NULL));

      -- ТЕКУЩИЕ ЗАТРАТЫ АБОНЕНТА НЕ ПРЕДСТАВЛЕННЫЕ В СЧЕТЕ
      CURSOR CUR_ALL_REPORT_CALLS (
         pGROUP_ID       CONTRACT_GROUPS.GROUP_ID%TYPE,
         pYEAR_MONTH     INTEGER,
         pCONTRACT_ID    INTEGER)
      IS
         SELECT SUM (
                   GREATEST (NVL (LRD.DETAIL_SUM, 0),
                             NVL (LPS.ESTIMATE_SUM, 0)))
           INTO vALL_SUM_ABONENT
           FROM CONTRACTS CON,
                DB_LOADER_REPORT_DATA LRD,
                DB_LOADER_PHONE_STAT LPS
          WHERE     CON.GROUP_ID = pGROUP_ID
                AND CON.PHONE_NUMBER_FEDERAL = LRD.PHONE_NUMBER
                AND (   (    pCONTRACT_ID IS NOT NULL
                         AND CON.CONTRACT_ID = pCONTRACT_ID)
                     OR (pCONTRACT_ID IS NULL))
                AND LRD.PHONE_NUMBER = CON.PHONE_NUMBER_FEDERAL
                AND LRD.YEAR_MONTH = pYEAR_MONTH
                AND LRD.YEAR_MONTH = LPS.YEAR_MONTH(+)
                AND LRD.PHONE_NUMBER = LPS.PHONE_NUMBER(+)
                AND NOT EXISTS
                           (                      -- ВСЕ ЧТО НЕ ПОПАЛО В СЧЕТА
                            SELECT *
                              FROM CONTRACTS CON,
                                   V_CONTRACTS VC,
                                   CONTRACT_GROUPS CG,
                                   DB_LOADER_FULL_FINANCE_BILL FFB,
                                   ACCOUNT_LOADED_BILLS ALB
                             WHERE     CON.GROUP_ID = CG.GROUP_ID
                                   AND VC.CONTRACT_ID = CON.CONTRACT_ID
                                   AND VC.CONTRACT_CANCEL_DATE IS NULL
                                   AND CG.GROUP_ID = pGROUP_ID
                                   AND FFB.PHONE_NUMBER =
                                          CON.PHONE_NUMBER_FEDERAL
                                   AND FFB.ACCOUNT_ID = ALB.ACCOUNT_ID
                                   --                    AND ALB.LOAD_BILL_IN_BALANCE = 1
                                   AND ALB.YEAR_MONTH = pYEAR_MONTH);
   BEGIN
      --ОБЩАЯ СУММА ТОЛЬКО ПО ЗВОНКАМ ДЛЯ ВСЕХ АБОНЕНТОВ
      OPEN CUR_ALL_ACCOUNT_CALLS (vGROUP_ID, YEAR_MONTH, pCONTRACT_ID);

      FETCH CUR_ALL_ACCOUNT_CALLS INTO vSUM_ALL_CALS_ACCOUNT;

      CLOSE CUR_ALL_ACCOUNT_CALLS;

      OPEN CUR_ALL_REPORT_CALLS (vGROUP_ID, YEAR_MONTH, pCONTRACT_ID);

      FETCH CUR_ALL_REPORT_CALLS INTO vSUM_ALL_CALS_REPORT;

      CLOSE CUR_ALL_REPORT_CALLS;

      RETURN (NVL (vSUM_ALL_CALS_ACCOUNT, 0) + NVL (vSUM_ALL_CALS_REPORT, 0));
   END;

   PROCEDURE GET_CONTRACT (pPHONE_NUM          VARCHAR2,
                           vCONTR       IN OUT INTEGER,
                           vGROUP_ID    IN OUT INTEGER)
   IS
      -- ОПРЕДЕЛЯЕМ ДЕЙСТВУЮЩИЙ КОНТРАКТ И ГРУППУ КОНТРАКТОВ ПО НОМЕРУ ТЕЛЕФОНА
      CURSOR CUR_CONTRACT (
         pPHONE_NUM    VARCHAR2)
      IS
         SELECT VC.CONTRACT_ID, CN.GROUP_ID
           INTO vCONTR, vGROUP_ID
           FROM CONTRACTS CN, V_CONTRACTS VC
          WHERE     CN.CONTRACT_ID = VC.CONTRACT_ID
                AND VC.CONTRACT_CANCEL_DATE IS NULL -- ПОКА ТАК, ПОЗЖЕ СДЕЛАТЬ ЧТОБЫ ОПРЕДЕЛЯЛСЯ ДЕЙСТВУЮЩИЙ КОНТРАКТ НА УКАЗАННУЮ ДАТУ
                AND VC.PHONE_NUMBER_FEDERAL = pHONE_NUMBER;
   BEGIN
      OPEN CUR_CONTRACT (PHONE_NUMBER);

      FETCH CUR_CONTRACT INTO vCONTR, vGROUP_ID;

      CLOSE CUR_CONTRACT;
   END;
BEGIN
   -- 1. ОПРЕДЕЛЯЕМ ДЕЙСТВУЮЩИЙ КОНТРАКТ ДЛЯ НОМЕРА ТЕЛЕФОНА
   GET_CONTRACT (PHONE_NUMBER, vCONTR, vGROUP_ID);

   -- общая сумма затрат
   vALL_SUM_CALLS := GET_SUMM_ALL_CALLS (vGROUP_ID, YEAR_MONTH, NULL);

   IF NVL (vALL_SUM_CALLS, 0) = 0
   THEN
      SELECT COUNT (*)
        INTO vCOUNT_IN_GROUP
        FROM CONTRACTS CN, CONTRACT_GROUPS CG
       WHERE CN.GROUP_ID = CG.GROUP_ID AND CG.GROUP_ID = vGROUP_ID;
   END IF;

   --2. СОЗДАЕМ ПЛАТЕЖИ В ТАБЛИЦЕ RECEIVED_PAYMENTS
   --2.1 ОПРЕДЕЛЯЕМ СПИСОК НОМЕРОВ ДЛЯ ГРУППЫ

   vCUR_SUM_PAY := 0;
   vMSG :=
         ' Перевод с номера '
      || PHONE_NUMBER
      || ' от '
      || TO_CHAR (PAYMENT_DATE_TIME, 'dd.mm.yyyy')
      || ' на номера группы ';

   IF RUN_MODE = 'INSERT'
   THEN
      -- Регистрируем основной платеж на номер
      vRECEIVED_PAYMENT_ID := NEW_RECEIVED_PAYMENT_ID;

      INSERT INTO RECEIVED_PAYMENTS (RECEIVED_PAYMENT_ID,
                                     PHONE_NUMBER,
                                     PAYMENT_SUM,
                                     PAYMENT_DATE_TIME,
                                     CONTRACT_ID,
                                     FILIAL_ID,
                                     REMARK,
                                     RECEIVED_PAYMENT_TYPE_ID,
                                     IS_DISTRIBUTED,
                                     PAYMENT_PERIOD)
           VALUES (vRECEIVED_PAYMENT_ID,
                   PHONE_NUMBER,
                   PAYMEN_SUM,
                   PAYMENT_DATE_TIME,
                   vCONTR,
                   49,
                   pREMARK,
                   RECEIVED_PAYMENT_TYPE_ID,
                   1,
                   YEAR_MONTH);

      FOR REC IN CONTRACT_LIST (VGROUP_ID, YEAR_MONTH)
      LOOP
         VALL_SUM_ABONENT :=
            GET_SUMM_ALL_CALLS (VGROUP_ID, YEAR_MONTH, REC.CONTRACT_ID);

         -- ОКРУГЛЯЕМ ДО КОПЕЙКИ ЗАЧИСЛЯЕМЫЙ ПЛАТЕЖ ДЛЯ АБОНЕНТА В СООТВЕТСТВИИ С ЕГО ЗАТРАТАМИ
         -- В СЛУЧАЕ ЕСЛИ ОБЩАЯ СУММА ЗАТРАТ РАВНА НУЛЮ, ДЕЛИМ МЕЖЛУ ВСЕМИ УЧАТСНИКАМИ ПОРОВНУ
         IF NVL (VALL_SUM_CALLS, 0) <> 0
         THEN
            VCUR_PAY :=
                 TRUNC (VALL_SUM_ABONENT * PAYMEN_SUM / VALL_SUM_CALLS * 100)
               / 100;
         ELSE
            VCUR_PAY := TRUNC (1 * PAYMEN_SUM / vCOUNT_IN_GROUP * 100) / 100;
         END IF;

         -- ДЛЯ ОСНОВНОГО НОМЕРА РАСЧИТЫВАЕМ ПЛАТЕЖ ОТДЕЛЬНО В КОНЦЕ
         IF (REC.PHONE_NUMBER_FEDERAL <> PHONE_NUMBER)
         THEN
            -- ПОДСЧИТЫВАЕМ ТЕКУЩУЮ СУММУ ЗАЧИСЛЯЕМЫХ ПЛАТЕЖЕЙ НА НОМЕРА ГРУППЫ, КРОМЕ ТОГО НА КОТОРЫЙ ПРИШЕЛ ОСНОВНОЙ ПЛАТЕЖ
            VCUR_SUM_PAY := VCUR_SUM_PAY + VCUR_PAY;

            --В СЛУЧАЕ ПЕРЕБОРА ИТОГОВОЙ СУММЫ ПЛАТЕЖЕЙ, ДЛЯ ПОСЛЕДНЕГО ПЛАТЕЖА ЗАЧИСЛЯЕМ ОСТАВШУЮСЯ СУММУ
            -- В таком случае сумма всех платежей равна сумме платежа
            IF VCUR_SUM_PAY > PAYMEN_SUM
            THEN
               VCUR_PAY := PAYMEN_SUM - (VCUR_SUM_PAY - VCUR_PAY);
               VCUR_SUM_PAY := PAYMEN_SUM;
            END IF;

            INSERT INTO RECEIVED_PAYMENTS (PHONE_NUMBER,
                                           PAYMENT_SUM,
                                           PAYMENT_DATE_TIME,
                                           CONTRACT_ID,
                                           FILIAL_ID,
                                           REMARK,
                                           RECEIVED_PAYMENT_TYPE_ID,
                                           PARENT_PAYMENT_ID,
                                           PAYMENT_PERIOD)
                 VALUES (REC.PHONE_NUMBER_FEDERAL,
                         VCUR_PAY,
                         PAYMENT_DATE_TIME,
                         REC.CONTRACT_ID,
                         49,
                         PREMARK || VMSG,
                         RECEIVED_PAYMENT_TYPE_ID,
                         vRECEIVED_PAYMENT_ID,
                         YEAR_MONTH);
         END IF;
      END LOOP;

      -- РАСЧИТЫВАЕМ ПЛАТЕЖ (УДЕРЖАНИЕ) ДЛЯ ОСНОВНОГО НОМЕРА
      VMSG :=
            ' Удержание с номера за распределение по номерам группы от '
         || TO_CHAR (PAYMENT_DATE_TIME, 'dd.mm.yyyy');

      --IF VCUR_SUM_PAY < PAYMEN_SUM THEN
      INSERT INTO RECEIVED_PAYMENTS (PHONE_NUMBER,
                                     PAYMENT_SUM,
                                     PAYMENT_DATE_TIME,
                                     CONTRACT_ID,
                                     FILIAL_ID,
                                     REMARK,
                                     RECEIVED_PAYMENT_TYPE_ID,
                                     PARENT_PAYMENT_ID,
                                     PAYMENT_PERIOD)
           VALUES (PHONE_NUMBER,
                   (0 - VCUR_SUM_PAY),
                   PAYMENT_DATE_TIME,
                   VCONTR,
                   49,
                   PREMARK || VMSG,
                   RECEIVED_PAYMENT_TYPE_ID,
                   vRECEIVED_PAYMENT_ID,
                   YEAR_MONTH);
   --END IF;
   ELSIF RUN_MODE = 'EDIT'
   THEN
      -- 1. ОПРЕДЕЛЯЕМ СПИСОК НАЧИСЛЕННЫХ ДОЧЕРНИХ ПЛАТЕЖЕЙ ДЛЯ ДАННОГО ПЛАТЕЖА (ВСЕ У КОГО PARENT_PAYMENT_ID = pRECEIVED_PAYMENT_ID)
      -- 2. ПЕРЕРАСЧИТЫВАЕМ ДЛЯ КАЖДОГО ПЛАТЕЖА СУММУ ЗАЧИСЛЕНИЯ
      -- 3. ОБНОВЛЯЕМ СУММУ ПЛАТЕЖА ДЛЯ ПЛАТЕЖЕЙ ИЗ СПИСКА

      FOR REC IN PAYMENT_LIST (pRECEIVED_PAYMENT_ID)
      LOOP
         -- СУММА ЗАТРАЧЕННАЯ АБОНЕНТОМ В ПЕРИОДЕ
         vALL_SUM_ABONENT :=
            GET_SUMM_ALL_CALLS (VGROUP_ID, YEAR_MONTH, REC.CONTRACT_ID);

         -- ДЛЯ ОСНОВНОГО НОМЕРА ОБНОВЛЯЕМ ПЛАТЕЖ ОТДЕЛЬНО В КОНЦЕ
         IF REC.PHONE_NUMBER <> PHONE_NUMBER
         THEN
            -- ОКРУГЛЯЕМ ДО КОПЕЙКИ ЗАЧИСЛЯЕМЫЙ ПЛАТЕЖ ДЛЯ АБОНЕНТА В СООТВЕТСТВИИ С ЕГО ЗАТРАТАМИ
            -- В СЛУЧАЕ ЕСЛИ ОБЩАЯ СУММА ЗАТРАТ РАВНА НУЛЮ, ДЕЛИМ МЕЖЛУ ВСЕМИ УЧАТСНИКАМИ ПОРОВНУ
            IF NVL (VALL_SUM_CALLS, 0) <> 0
            THEN
               VCUR_PAY :=
                    TRUNC (
                       VALL_SUM_ABONENT * PAYMEN_SUM / VALL_SUM_CALLS * 100)
                  / 100;
            ELSE
               VCUR_PAY :=
                  TRUNC (1 * PAYMEN_SUM / vCOUNT_IN_GROUP * 100) / 100;
            END IF;

            -- ПОДСЧИТЫВАЕМ ТЕКУЩУЮ СУММУ ЗАЧИСЛЯЕМЫХ ПЛАТЕЖЕЙ НА НОМЕРА ГРУППЫ, КРОМЕ ТОГО НА КОТОРЫЙ ПРИШЕЛ ОСНОВНОЙ ПЛАТЕЖ
            VCUR_SUM_PAY := VCUR_SUM_PAY + VCUR_PAY;

            --В СЛУЧАЕ ПЕРЕБОРА ИТОГОВОЙ СУММЫ ПЛАТЕЖЕЙ, ДЛЯ ПОСЛЕДНЕГО ПЛАТЕЖА ЗАЧИСЛЯЕМ ОСТАВШУЮСЯ СУММУ
            -- В таком случае сумма всех платежей равна сумме платежа
            IF VCUR_SUM_PAY > PAYMEN_SUM
            THEN
               VCUR_PAY := PAYMEN_SUM - (VCUR_SUM_PAY - VCUR_PAY);
               VCUR_SUM_PAY := PAYMEN_SUM;
            END IF;

            UPDATE RECEIVED_PAYMENTS RP
               SET RP.PAYMENT_SUM = vCUR_PAY, RP.PAYMENT_PERIOD = YEAR_MONTH
             WHERE RP.RECEIVED_PAYMENT_ID = REC.RECEIVED_PAYMENT_ID;
         ELSE
            -- ЗАПОМИНАЕМ ID КОРРЕКТИРУЮЩЕГО ПЛАТЕЖА, САМ ПЛАТЕЖ ПОДСЧИТЫВАЕМ В КОНЦЕ
            vCORRECT_RECEIVED_PAYMENT_ID := REC.RECEIVED_PAYMENT_ID;
         END IF;
      END LOOP;

      -- ОБНОВЛЯЕМ ПЛАТЕЖ (УДЕРЖАНИЕ) ДЛЯ ОСНОВНОГО НОМЕРА
      VMSG :=
            ' Удержание с номера за распределение по номерам группы от '
         || TO_CHAR (PAYMENT_DATE_TIME, 'dd.mm.yyyy');

      -- IF VCUR_SUM_PAY < PAYMEN_SUM THEN       v5
      UPDATE RECEIVED_PAYMENTS RP
         SET RP.PAYMENT_SUM = (0 - VCUR_SUM_PAY),
             RP.PAYMENT_PERIOD = YEAR_MONTH
       WHERE RP.RECEIVED_PAYMENT_ID = vCORRECT_RECEIVED_PAYMENT_ID;

      --END IF;   v5

      -- ОБНОВЛЯЕМ ОСНОВНОЙ ПЛАТЕЖ
      UPDATE RECEIVED_PAYMENTS RP
         SET RP.PAYMENT_SUM = PAYMEN_SUM, RP.PAYMENT_PERIOD = YEAR_MONTH
       WHERE RP.RECEIVED_PAYMENT_ID = pRECEIVED_PAYMENT_ID;
   ELSIF RUN_MODE = 'DELETE'
   THEN
      -- 1. ОПРЕДЕЛЯЕМ СПИСОК НАЧИСЛЕННЫХ ДОЧЕРНИХ ПЛАТЕЖЕЙ ДЛЯ ДАННОГО ПЛАТЕЖА (ВСЕ У КОГО PARENT_PAYMENT_ID = pRECEIVED_PAYMENT_ID)
      -- 2. УДАЛЯЕМ ДОЧЕРИЕ ПЛАТЕЖИ И ОСНОВНОЙ ПЛАТЕЖ
      DELETE FROM RECEIVED_PAYMENTS RP
            WHERE RP.PARENT_PAYMENT_ID = pRECEIVED_PAYMENT_ID;

      -- УДАЛЯЕМ ОСНОВНОЙ ПЛАТЕЖ
      DELETE FROM RECEIVED_PAYMENTS RP
            WHERE RP.RECEIVED_PAYMENT_ID = pRECEIVED_PAYMENT_ID;
   END IF;
END ADD_DISTRIBUTED_PAYMENT;