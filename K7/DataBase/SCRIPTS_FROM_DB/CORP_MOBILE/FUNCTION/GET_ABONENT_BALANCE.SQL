
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."GET_ABONENT_BALANCE" (
  pPHONE_NUMBER IN VARCHAR2,
  pBALANCE_DATE IN DATE DEFAULT NULL,
  pIOT_BALANCE IN VARCHAR2 DEFAULT null,
  pCALC_ABON_TP_UNLIM_OFF IN INTEGER DEFAULT 0
  ) RETURN NUMBER IS
--#Version=10
--
-- 10. Алексеев. Изменил условия попадания номера на посуточное списание абонки для номеров с безлимитным интернетом с отсрочкой абонки.
--                      Убрал условие на месяц существования контракта.
-- 9. Алексеев. Убрал изменения версии 8.
-- 8. Алексеев. Изменил отбор номеров на проверку списания абон. плат. Теперь вставка в таблицу TURN_CHECK_DISCR_SPISANIE_ABON
--                     будет производиться если еще не было зафиксированно списание абон. плат по данному номеру с данным тп.
-- 7. Алексеев. Добавил вставку в таблицу TURN_CHECK_DISCR_SPISANIE_ABON при отсутствии номера в ней.
--                    Данная таблица содержит номера на проверку списания абон. плат. После проверки номер удаляется из таблицы.
--                    Только для коллекторских номеров.
-- 6. Кочнев. Сделан merge с таблицей IOT_CURRENT_BALANCE 
-- 5. Крайнов. Убираем расхождение на 1коп при округлениях.
-- 4. Алексеев. Внес изменения согласно функционалу отсрочки абонки
  PRAGMA AUTONOMOUS_TRANSACTION;
  DATE_ROWS DBMS_SQL.DATE_TABLE;
  COST_ROWS DBMS_SQL.NUMBER_TABLE;
  DESCRIPTION_ROWS DBMS_SQL.VARCHAR2_TABLE;
  vRESULT NUMBER(15, 4);
  L BINARY_INTEGER;
  vBALANCE_DATE DATE;
  v_num0 INTEGER;
  v_num INTEGER;
  v_cnt INTEGER;
BEGIN
  vRESULT := 0;
  vBALANCE_DATE:=pBALANCE_DATE;
/*  IF MS_CONSTANTS.GET_CONSTANT_VALUE('SERVER_NAME')='GSM_CORP' THEN
    IF (NVL(pBALANCE_DATE, SYSDATE)>=TO_DATE('28122011', 'DDMMYYYY'))AND(NVL(pBALANCE_DATE, SYSDATE)<=TO_DATE('01012012', 'DDMMYYYY')) THEN
      vBALANCE_DATE:=TO_DATE('01012012', 'DDMMYYYY');
    END IF;
  END IF;*/
  CALC_BALANCE_ROWS2(pPHONE_NUMBER, DATE_ROWS, COST_ROWS, DESCRIPTION_ROWS, FALSE, vBALANCE_DATE);
  L := COST_ROWS.LAST;
  IF L IS NOT NULL THEN
    FOR I IN COST_ROWS.FIRST..L LOOP
      vRESULT := vRESULT + COST_ROWS(I);
    END LOOP;
  END IF;
  --Для номеров с тп с признаком автоподключения пакетов, у которых в конце месяца
  --недостаточно средств дял списания абонки, в месяце существования контракта, который мы запоминали в таблице PHONE_CALC_ABON_TP_UNLIM_ON,
  --при запроса баланса по USSD или в ЛК показываем баланс с учетом дискретного списания. 
  --Для таких случаев pCALC_ABON_TP_UNLIM_OFF = 1. По default = 0.
  --Изменяем логику только при отрицательном балансе
  IF (pCALC_ABON_TP_UNLIM_OFF = 0) AND (NVL(vRESULT, 0) <= 0) THEN 
    --проверяем что на номере тп с признаком автоподключения пакетов
    select count(1) into v_num0
      from v_contracts ct,
           tariffs tf
      where CT.PHONE_NUMBER_FEDERAL = pPHONE_NUMBER
        and CT.CONTRACT_CANCEL_DATE is null
        and TF.TARIFF_ID=CT.TARIFF_ID
        and NVL(TF.IS_AUTO_INTERNET, 0) = 1;
        --and to_number(TO_CHAR(ADD_MONTHS(CT.CONTRACT_DATE, 1), 'YYYYMM')) = to_number(to_char(sysdate, 'YYYYMM'));      
    IF NVL(v_num0, 0) > 0 THEN
      --Проверяем номер в табл. PHONE_CALC_ABON_TP_UNLIM_ON.
      --В данную табл. попадают номера, у которых тп с признаком автоподключения пакетов и в конце месяца было недостаточно средств для списания абонки
      --необходимо проверить, что текущий тп совпадает с тп в момент запоминания номера, если не совпадает, то была смена, а значит алгоритм отсрочки не учитываем
      --в дни до смены тп списываем посуточно абонку
      SELECT count(*) INTO v_num
        FROM PHONE_CALC_ABON_TP_UNLIM_ON
        WHERE PHONE_NUMBER = pPHONE_NUMBER
          AND YEAR_MONTH = to_number(TO_CHAR(sysdate, 'YYYYMM'))
          AND TARIFF_ID = GET_CURR_PHONE_TARIFF_ID(pPHONE_NUMBER);              
      IF (NVL(v_num, 0) > 0) THEN 
	      vRESULT := 0;
        --передаем признак дискретного списания
        CALC_BALANCE_ROWS2(pPHONE_NUMBER, DATE_ROWS, COST_ROWS, DESCRIPTION_ROWS, FALSE, vBALANCE_DATE, 1); 
        L := COST_ROWS.LAST;
        IF L IS NOT NULL THEN
          FOR I IN COST_ROWS.FIRST..L LOOP
            vRESULT := vRESULT + COST_ROWS(I);
          END LOOP;
        END IF;
      END IF;
    END IF;
  END IF;
  --
 if pIOT_BALANCE is null then
    IF pBALANCE_DATE IS NULL THEN
      select count(CB.PHONE_NUMBER) into v_num 
        from IOT_CURRENT_BALANCE CB 
       where CB.PHONE_NUMBER = pPHONE_NUMBER;
      if v_num > 0 then
        UPDATE IOT_CURRENT_BALANCE CB
          SET CB.BALANCE = vRESULT,
              CB.LAST_UPDATE = SYSDATE,
              CB.UPDATE_TYPE = 2
          WHERE CB.PHONE_NUMBER = pPHONE_NUMBER;
      else
       insert into IOT_CURRENT_BALANCE (PHONE_NUMBER, LAST_UPDATE, UPDATE_TYPE, BALANCE)
                                values (pPHONE_NUMBER, SYSDATE, 2, vRESULT);
      end if;
      COMMIT;
    END IF;
  END IF;

  RETURN ROUND(vRESULT, 2);
END;