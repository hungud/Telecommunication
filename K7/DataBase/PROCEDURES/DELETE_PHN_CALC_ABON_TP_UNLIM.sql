CREATE OR REPLACE PROCEDURE DELETE_PHN_CALC_ABON_TP_UNLIM is
BEGIN
  --version 4
  --
  --v.4 Алексеев. При отборе номеров убрал условие на месяц существование контракта.
    --            Ранее брались номера, у которых контракт заведен в прошлом месяце.
    --            По новой логике алгоритм делаем более гибким, т.к. теперь в алгоритме будут участвовать и старые номера.
  --v3. Алексеев. Если на длговоре по номеру имеется доп. статус 302, то необходимо его снять.
  --отбираем из табл. PHONE_CALC_ABON_TP_UNLIM_ON номера, у которых баланс с учетом дискретного списания станет > 0
  --производим удаление таких номеров из данной таблицы
  --необходимо проверить, чтобы был новый период в DB_LOADER_ABONENT_PERIODS, иначе 1 числа месяца все номера удаляться, 
  --т.к. из за того что нет периода абонка за месяц не учтется и баланс будет > 0 
  for rec in (
                    select 
                        VC.PHONE_NUMBER_FEDERAL,
                        TR.TARIFF_NAME,
                        TR.MONTHLY_PAYMENT, 
                        TR.TARIFF_ID, 
                        VC.DOP_STATUS,
                        VC.CONTRACT_ID
                     from V_CONTRACTS VC,
                             TARIFFS TR
                    where VC.TARIFF_ID = TR.TARIFF_ID(+)
                       and NVL(TR.IS_AUTO_INTERNET, 0) = 1
                       and VC.CONTRACT_CANCEL_DATE IS NULL
                       --and to_number(TO_CHAR(ADD_MONTHS(VC.CONTRACT_DATE, 1), 'YYYYMM')) = to_number(to_char(sysdate, 'YYYYMM'))
                       and exists 
                                  (
                                    select 1
                                      from PHONE_CALC_ABON_TP_UNLIM_ON ab
                                    where AB.PHONE_NUMBER = VC.PHONE_NUMBER_FEDERAL
                                        and AB.YEAR_MONTH = to_number(TO_CHAR(sysdate, 'YYYYMM')) 
                                        and AB.TARIFF_ID = TR.TARIFF_ID
                                  )
                      and exists
                                 (
                                    select 1
                                    from DB_LOADER_ABONENT_PERIODS ab
                                    where AB.PHONE_NUMBER = VC.PHONE_NUMBER_FEDERAL
                                    and to_number(to_char(AB.BEGIN_DATE, 'YYYYMM')) = to_number(TO_CHAR(sysdate, 'YYYYMM')) 
                                 )
                )
  loop
    --определяем величину баланса. В функцию баланса передаем парамерт 1, чтобы считалось дискретное списание АП.
    IF GET_ABONENT_BALANCE(rec.PHONE_NUMBER_FEDERAL, null, null, 1) > 0 THEN
      --проверяем наличие доп. статуса
      IF NVL(rec.DOP_STATUS, 0) = 302 THEN
        UPDATE CONTRACTS C
              SET C.DOP_STATUS = NULL
         WHERE C.CONTRACT_ID = rec.CONTRACT_ID;
        COMMIT;
      END IF;
      --удаление номера из табл.
      DELETE FROM PHONE_CALC_ABON_TP_UNLIM_ON tp
      WHERE TP.PHONE_NUMBER = rec.PHONE_NUMBER_FEDERAL
      AND TP.YEAR_MONTH = to_number(to_char(sysdate, 'YYYYMM'))
      AND TARIFF_ID = rec.TARIFF_ID;
      COMMIT;
    END IF;
  end loop; 
END;