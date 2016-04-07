CREATE OR REPLACE PROCEDURE BLOCK_PHN_CALC_ABON_TP_UNLIM IS

    --version 5
    --
    --v.5 Алексеев Разделил логику на 2 части: 1 - для новых контрактов, 2 - для старых
    --                    В зависимости от этого блокируем номера. Новые по значению параметра DAY_BLOCK_PHN_CALC_ABON_TP_UNLIM_NEW_PHN,
    --                    старые - DAY_BLOCK_PHN_CALC_ABON_TP_UNLIM_OLD_PHN.
    --                    Поправил запрос.
    --v.4 Алексеев При отборе номеров убрал условие на месяц существование контракта.
    --                    Ранее брались номера, у которых контракт заведен в прошлом месяце.
    --                    По новой логике алгоритм делаем более гибким, т.к. теперь в алгоритме будут участвовать и старые номера.
    --v.3 Алексеев Ограничил работу процедуры временем: работаем с 3-его дня месяца или со второго если время позже 21:00
    --v.2 Алексеев Перед установкой доп. статуса 302, добавил проверуку на анличие данного доп. статуса. Если нет, то устанавливаем
    
    V VARCHAR2(500 CHAR);
    vCntPhone integer;
    vDay_New integer;
    vday_Old integer;
BEGIN
  --разделяем логику на 2 части, одна для новых контрактов, вторая - для старых.
  --в зависимости от разделения блокируем номера.
  --отбираем номера, которые имеются в таблице PHONE_CALC_ABON_TP_UNLIM_ON.
  --В данную табл. попадают номера, у которых тп с признаком автоподключения пакетов и в конце месяца было недостаточно средств для списания абонки
  --когда у номера будет достаточно средств для списания абонки, он удалится из таблицы
  --отсылаем смс если текущая дата принадлежит второму месяцу существования контракта
  
  --определяем дни блокировки для новых и старых контрактов
  vDay_New := to_number(MS_params.GET_PARAM_VALUE('DAY_BLOCK_PHN_CALC_ABON_TP_UNLIM_NEW_PHN')); --новые
  vDay_Old := to_number(MS_params.GET_PARAM_VALUE('DAY_BLOCK_PHN_CALC_ABON_TP_UNLIM_OLD_PHN')); --старые

  for rec in (
                    select 
                        VC.CONTRACT_ID,
                        VC.PHONE_NUMBER_FEDERAL
                     from V_CONTRACTS VC,
                             TARIFFS TR,
                             DB_LOADER_ACCOUNT_PHONES D
                    where VC.TARIFF_ID = TR.TARIFF_ID(+)
                       and NVL(TR.IS_AUTO_INTERNET, 0) = 1
                       and VC.CONTRACT_CANCEL_DATE IS NULL
                       --and to_number(TO_CHAR(ADD_MONTHS(VC.CONTRACT_DATE, 1), 'YYYYMM')) = to_number(to_char(sysdate, 'YYYYMM'))
                       and D.PHONE_NUMBER = VC.PHONE_NUMBER_FEDERAL
                       and D.YEAR_MONTH = to_number(TO_CHAR(sysdate, 'YYYYMM')) 
                       and NVL(D.PHONE_IS_ACTIVE, -1) = 1   
                       and exists 
                                  (
                                    select AB.PHONE_NUMBER
                                      from PHONE_CALC_ABON_TP_UNLIM_ON ab
                                    where AB.PHONE_NUMBER = VC.PHONE_NUMBER_FEDERAL
                                        and AB.YEAR_MONTH = to_number(TO_CHAR(sysdate, 'YYYYMM')) 
                                        and ab.TARIFF_ID = TR.TARIFF_ID
                                  )
                       and (
                               (
                                 (to_number(TO_CHAR(ADD_MONTHS(VC.CONTRACT_DATE, 1), 'YYYYMM')) = to_number(to_char(sysdate, 'YYYYMM'))) 
                                 AND
                                 (
                                   (to_number(to_char(sysdate, 'DD')) > vDay_New) 
                                   or 
                                   ((to_number(to_char(sysdate, 'DD')) = vDay_New) and ((sysdate-TRUNC(sysdate)) > 21/24))
                                 )
                               )
                               OR
                               (
                                 (to_number(TO_CHAR(ADD_MONTHS(VC.CONTRACT_DATE, 1), 'YYYYMM')) <> to_number(to_char(sysdate, 'YYYYMM'))) 
                                 AND
                                 (
                                   (to_number(to_char(sysdate, 'DD')) > vDay_Old) 
                                   or 
                                   ((to_number(to_char(sysdate, 'DD')) = vDay_Old) and ((sysdate-TRUNC(sysdate)) > 21/24))
                                 )
                               )
                             )
                      )
  loop
    --определяем величину баланса. В функцию баланса передаем парамерт 1, чтобы считалось дискретное списание АП.
    IF GET_ABONENT_BALANCE(rec.PHONE_NUMBER_FEDERAL, null, null, 1) <= 0 THEN
      --если не проставляем доп. статус "Драйв, недостаточно для абон.платы на мес." , то проставляем его
      vCntPhone := 0;
      SELECT COUNT(*)
         INTO vCntPhone
        FROM CONTRACTS C
      WHERE C.CONTRACT_ID = rec.CONTRACT_ID
           AND NVL(C.DOP_STATUS, 0) = 302;
            
      IF nvl(vCntPhone, 0) = 0 THEN
        UPDATE CONTRACTS C
              SET C.DOP_STATUS = 302
         WHERE C.CONTRACT_ID = rec.CONTRACT_ID;
        COMMIT;
      END IF;
      --блокировка
      V:=BEELINE_API_PCKG.LOCK_PHONE(rec.PHONE_NUMBER_FEDERAL,0, 'S1B');
    END IF;
  end loop;
END;