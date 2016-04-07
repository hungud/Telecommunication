CREATE OR REPLACE PROCEDURE P_LOG_DISCR_SPISANIE_ABON IS
  
  --Version 1
  --
  --v.1 Алексеев 26.10.2015 Процедура логирования списания абон. плат за тариф и услуги на номерах, 
  --                                     у которых тп с дискретным списание абонки.
  
  v_cnt INTEGER;
  vCHARGES_TYPE_ID INTEGER;
begin
  --получаем номера с тп с дискетным списанием.
  --отсекаем номера, у которых имеется сдвиг дискретного списания и в теущем месяце идет посуточное списание
  --отсекаем не коллекторские номера
  for rec in (
                    select 
                         V.PHONE_NUMBER_FEDERAL,
                         V.TARIFF_ID
                      from v_contracts v,
                              tariffs tr,
                              DB_LOADER_ACCOUNT_PHONES db,
                              accounts ac
                    where V.CONTRACT_CANCEL_DATE is null
                        and V.TARIFF_ID = TR.TARIFF_ID
                        and V.PHONE_NUMBER_FEDERAL = DB.PHONE_NUMBER
                        and DB.YEAR_MONTH = (
                                                                select max(PH.YEAR_MONTH)
                                                                  from DB_LOADER_ACCOUNT_PHONES ph
                                                                where PH.PHONE_NUMBER = V.PHONE_NUMBER_FEDERAL
                                                           )
                        and DB.ACCOUNT_ID = AC.ACCOUNT_ID
                        and nvl(TR.DISCR_SPISANIE, 0) = 1
                        and to_number(to_char(sysdate, 'YYYYMM')) >= to_number(to_char(add_months(V.CONTRACT_DATE, nvl(TR.SDVIG_DISCR_SPISANIE, 0)), 'YYYYMM'))
                        and nvl(AC.IS_COLLECTOR, 0) = 1
                )
  loop
    BEGIN 
      --берем расшифровку баланса
      CALC_BALANCE_ROWS(rec.PHONE_NUMBER_FEDERAL);
       
      --данные записались в таблицу ABONENT_BALANCE_ROWS. Теперь работаем с ней/
      --отбираем данные только за текущий месяц.
      for v_rec in (
                          select 
                              AB.ROW_DATE, 
                              AB.ROW_COST, 
                              AB.ROW_COMMENT
                            from ABONENT_BALANCE_ROWS ab
                          where to_number(to_char(AB.ROW_DATE, 'YYYYMM')) = to_number(to_char(sysdate, 'YYYYMM'))
                       )
      loop
        --логируем записи если было списание абонки за месяц по тп и все абонки по услугам
        IF ((INSTR(v_rec.ROW_COMMENT, 'Абонплата') > 0) and
             (INSTR(v_rec.ROW_COMMENT, 'услуг') = 0) and
             (INSTR(v_rec.ROW_COMMENT, 'списано за месяц') > 0))
              OR
            ((INSTR(v_rec.ROW_COMMENT, 'Абонплата') > 0) and
             (INSTR(v_rec.ROW_COMMENT, 'услуг') > 0)) THEN
          --проверяем наличие фиксирования данной записи в логах
          --списание услуг может быть ежедневным, поэтому будет добавляться новая запись списания
          --для учета списания услуг будет различаться дата по которую списали
          --учитываем тарифы на номерах
          select count(*)
             into v_cnt
            from LOG_DISCR_SPISANIE_ABON lg
          where lg.PHONE_NUMBER = rec.PHONE_NUMBER_FEDERAL
              and lg.YEAR_MONTH = to_number(to_char(sysdate, 'YYYYMM'))
              and lg.TEXT_COMMENT = v_rec.ROW_COMMENT
              and lg.TARIFF_ID = rec.TARIFF_ID;
                      
          IF nvl(v_cnt, 0) = 0 THEN
            --определяем тариф или услуга
            IF (INSTR(v_rec.ROW_COMMENT, 'услуг') > 0) THEN
              vCHARGES_TYPE_ID := 9;
            ELSE
              vCHARGES_TYPE_ID := 8;
            END IF;

            --фиксируем записи в логах         
            INSERT INTO LOG_DISCR_SPISANIE_ABON 
            (
              YEAR_MONTH, 
              PHONE_NUMBER, 
              DATE_INSERT, 
              ABON_SUM, 
              CHARGES_TYPE_ID, 
              TEXT_COMMENT,
              BALANCE,
              TARIFF_ID
            ) 
            VALUES 
            (
              to_number(to_char(sysdate, 'YYYYMM')),
              rec.PHONE_NUMBER_FEDERAL,
              sysdate,
              abs(v_rec.ROW_COST),
              vCHARGES_TYPE_ID,
              v_rec.ROW_COMMENT,
              GET_ABONENT_BALANCE(rec.PHONE_NUMBER_FEDERAL),
              rec.TARIFF_ID
            );
          END IF;
        END IF;
      end loop;
      --комитим тут чтобы не потрерять данные временной таблицы ABONENT_BALANCE_ROWS
      COMMIT;
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
  end loop;
end;