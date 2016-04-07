CREATE OR REPLACE FUNCTION CONVERT_BILL_TO_FULL_FIN_BILL(
  pYEAR_MONTH IN INTEGER,
  DELETE_PREV_CONVERT IN INTEGER DEFAULT 0
  ) RETURN VARCHAR2 IS
  vCOUNT INTEGER;
  vITOG VARCHAR2(1000 CHAR);
  vDELET VARCHAR2(1000 CHAR);
-- Version = 1
BEGIN 
  vITOG:='';  
  vDELET:='';          
-- Удаление ранее созданного
  IF ABS(DELETE_PREV_CONVERT) = 1 THEN
    SELECT COUNT(*) INTO vCOUNT
      from DB_LOADER_FULL_FINANCE_BILL FB
      WHERE FB.YEAR_MONTH = pYEAR_MONTH
        AND NVL(FB.BAN, 0) = -1;
    DELETE 
      FROM DB_LOADER_FULL_BILL_ABON_PER AP
      WHERE AP.YEAR_MONTH = pYEAR_MONTH
        AND EXISTS (SELECT 1
                      FROM DB_LOADER_FULL_FINANCE_BILL FB
                      where FB.ACCOUNT_ID=AP.ACCOUNT_ID
                        and FB.YEAR_MONTH=AP.YEAR_MONTH
                        and FB.PHONE_NUMBER =AP.PHONE_NUMBER
                        AND NVL(FB.BAN, 0) = -1);
    DELETE 
      FROM DB_LOADER_FULL_FINANCE_BILL FB
      WHERE FB.YEAR_MONTH = pYEAR_MONTH
        AND NVL(FB.BAN, 0) = -1;
    IF DELETE_PREV_CONVERT = 1 THEN
      vDELET:='Очищено счетов: ' || vCOUNT || '; ';
    ELSE
      vDELET:='Очищено счетов: ' || vCOUNT;
    END IF;
  END IF;       
  IF DELETE_PREV_CONVERT >= 0 THEN    
  -- Создание абон периодов
    SELECT COUNT(*) INTO vCOUNT
      from DB_LOADER_BILLS b
          where YEAR_MONTH = pYEAR_MONTH
            and b.BILL_SUM <> 0
            and not exists (select 1 
                              from DB_LOADER_FULL_FINANCE_BILL
                              where DB_LOADER_FULL_FINANCE_BILL.ACCOUNT_ID=b.ACCOUNT_ID
                                and DB_LOADER_FULL_FINANCE_BILL.YEAR_MONTH=b.YEAR_MONTH
                                and DB_LOADER_FULL_FINANCE_BILL.PHONE_NUMBER =b.PHONE_NUMBER);
    vITOG:='Счетов создано: ' || vCOUNT; 
    insert into DB_LOADER_FULL_BILL_ABON_PER(ACCOUNT_ID,YEAR_MONTH,PHONE_NUMBER, 
                                             DATE_BEGIN,
                                             DATE_END, 
                                             TARIFF_CODE,
                                             ABON_MAIN, ABON_ADD, ABON_ALL)
      select                                 b.ACCOUNT_ID, b.YEAR_MONTH, b.PHONE_NUMBER, 
                                             /*to_date(to_char(b.YEAR_MONTH)||'01','yyyymmdd') DATE_BEGIN,
                                             add_months(to_date(to_char(b.YEAR_MONTH)||'01','yyyymmdd'), 1)-1 DATE_END,*/
                                             B.DATE_BEGIN AS DATE_BEGIN,
                                             B.DATE_END AS DATE_END,
                                             nvl((select ax.TARIFF_CODE from DB_LOADER_FULL_BILL_ABON_PER ax
                                                    where ax.ACCOUNT_ID = b.ACCOUNT_ID and ax.PHONE_NUMBER=b.PHONE_NUMBER 
                                                      and ax.YEAR_MONTH = TO_NUMBER(TO_CHAR(ADD_MONTHS(TO_DATE(to_char(b.YEAR_MONTH)||'01','yyyymmdd'), -1), 'YYYYMM')) -- предыдущий месяц
                                                      and ax.TARIFF_CODE is not null and rownum <=1),
                                                 (select h.CELL_PLAN_CODE from db_loader_account_phone_hists h where h.PHONE_NUMBER=b.PHONE_NUMBER 
                                                    and h.END_DATE>to_date(to_char(b.YEAR_MONTH)||'01','yyyymmdd') 
                                                    and h.begin_DATE<LAST_DAY(to_date(to_char(b.YEAR_MONTH)||'01','yyyymmdd')) 
                                                    and rownum <=1)  ) TAR_CODE, 
                                             b.SUBSCRIBER_PAYMENT_MAIN ABON_MAIN, b.SUBSCRIBER_PAYMENT_ADD ABON_ADD, b.SUBSCRIBER_PAYMENT_MAIN+b.SUBSCRIBER_PAYMENT_ADD ABON_ALL  -- ABON_MAIN,ABON_ADD,ABON_ALL
        from DB_LOADER_BILLS b
          where YEAR_MONTH = pYEAR_MONTH
            and b.BILL_SUM <> 0
            and not exists (select 1 
                              from DB_LOADER_FULL_FINANCE_BILL
                              where DB_LOADER_FULL_FINANCE_BILL.ACCOUNT_ID=b.ACCOUNT_ID
                                and DB_LOADER_FULL_FINANCE_BILL.YEAR_MONTH=b.YEAR_MONTH
                                --AND NVL(BAN, 0) <> -1
                                and DB_LOADER_FULL_FINANCE_BILL.PHONE_NUMBER =b.PHONE_NUMBER); 
  -- Создание самих счетов.
    insert into DB_LOADER_FULL_FINANCE_BILL(ACCOUNT_ID,YEAR_MONTH,PHONE_NUMBER,
                                            ABONKA,CALLS,
                                            SINGLE_PAYMENTS,DISCOUNTS,BILL_SUM,COMPLETE_BILL,
                                            ABON_MAIN, ABON_ADD,ABON_OTHER,
                                            SINGLE_MAIN,SINGLE_ADD,SINGLE_PENALTI,SINGLE_CHANGE_TARIFF,SINGLE_TURN_ON_SERV,
                                            SINGLE_CORRECTION_ROUMING,SINGLE_INTRA_WEB,SINGLE_VIEW_BLACK_LIST,SINGLE_OTHER,
                                            DISCOUNT_YEAR,DISCOUNT_SMS_PLUS,DISCOUNT_CALL,DISCOUNT_COUNT_ON_PHONES,DISCOUNT_OTHERS,
                                            CALLS_COUNTRY,CALLS_SITY,CALLS_LOCAL,CALLS_SMS_MMS,CALLS_GPRS,CALLS_RUS_RPP,CALLS_ALL,
                                            ROUMING_NATIONAL,ROUMING_INTERNATIONAL,DISCOUNT_SOVINTEL,BAN)
      select                                b.ACCOUNT_ID,b.YEAR_MONTH,b.PHONE_NUMBER,
                                            b.SUBSCRIBER_PAYMENT_MAIN+b.SUBSCRIBER_PAYMENT_ADD,b.BILL_SUM-b.SUBSCRIBER_PAYMENT_MAIN-b.SUBSCRIBER_PAYMENT_ADD-b.SINGLE_PAYMENTS-b.DISCOUNT_VALUE, 
                                            b.SINGLE_PAYMENTS,b.DISCOUNT_VALUE,b.BILL_SUM,1,
                                            b.SUBSCRIBER_PAYMENT_MAIN, b.SUBSCRIBER_PAYMENT_ADD, 0, --ABON_MAIN, ABON_ADD,ABON_OTHER,
                                            0,0,0,0,0,  --SINGLE_MAIN,SINGLE_ADD,SINGLE_PENALTI,SINGLE_CHANGE_TARIFF,SINGLE_TURN_ON_SERV,
                                            0,0,0,b.SINGLE_PAYMENTS,  --SINGLE_CORRECTION_ROUMING,SINGLE_INTRA_WEB,SINGLE_VIEW_BLACK_LIST,SINGLE_OTHER,
                                            0,0,0,0,b.DISCOUNT_VALUE,  --DISCOUNT_YEAR,DISCOUNT_SMS_PLUS,DISCOUNT_CALL,DISCOUNT_COUNT_ON_PHONES,DISCOUNT_OTHERS,
                                            b.CALLS_OTHER_COUNTRY_COST,b.CALLS_OTHER_CITY_COST,b.CALLS_LOCAL_COST,b.MESSAGES_COST,b.INTERNET_COST,0,  
                                            --CALLS_COUNTRY,           CALLS_SITY,             CALLS_LOCAL,       CALLS_SMS_MMS,  CALLS_GPRS, CALLS_RUS_RPP,
                                            b.CALLS_OTHER_COUNTRY_COST+b.CALLS_OTHER_CITY_COST+b.CALLS_LOCAL_COST+b.MESSAGES_COST+b.INTERNET_COST, --CALLS_ALL,
                                            b.NATIONAL_ROAMING_COST,b.OTHER_COUNTRY_ROAMING_COST,0,-1  
                                            --ROUMING_NATIONAL,ROUMING_INTERNATIONAL,DISCOUNT_SOVINTEL,BAN
        from DB_LOADER_BILLS b
          where YEAR_MONTH = pYEAR_MONTH
            and b.BILL_SUM <> 0
            and not exists (select 1 
                              from DB_LOADER_FULL_FINANCE_BILL
                              where DB_LOADER_FULL_FINANCE_BILL.ACCOUNT_ID=b.ACCOUNT_ID
                                and DB_LOADER_FULL_FINANCE_BILL.YEAR_MONTH=b.YEAR_MONTH
                                and DB_LOADER_FULL_FINANCE_BILL.PHONE_NUMBER =b.PHONE_NUMBER);
  -- Распределение возврата абонок  
    SELECT COUNT(*) INTO vCOUNT
      from DB_LOADER_FULL_FINANCE_BILL fb 
      where fb.YEAR_MONTH = pYEAR_MONTH 
        and fb.COMPLETE_BILL = 1 and ban = -1 
        and fb.ABONKA <> 0 and fb.ABONKA + fb.SINGLE_PAYMENTS >= 0 and fb.SINGLE_OTHER < 0;       
    vITOG:=vITOG || '; Возврат абонок: ' || vCOUNT; 
    update DB_LOADER_FULL_FINANCE_BILL fb 
      set FB.SINGLE_MAIN = FB.ABON_MAIN * FB.SINGLE_OTHER / FB.ABONKA, 
          FB.SINGLE_ADD = FB.ABON_ADD * FB.SINGLE_OTHER / FB.ABONKA,
          FB.SINGLE_OTHER = FB.SINGLE_OTHER - (FB.ABON_MAIN * FB.SINGLE_OTHER / FB.ABONKA) - (FB.ABON_ADD * FB.SINGLE_OTHER / FB.ABONKA)
      where fb.YEAR_MONTH = pYEAR_MONTH 
        and fb.COMPLETE_BILL = 1 and ban = -1 
        and fb.ABONKA <> 0 and fb.ABONKA + fb.SINGLE_PAYMENTS >= 0 and fb.SINGLE_OTHER < 0;       
  -- Рихтовка расхождений звонков на 1-2 коп. 
    SELECT COUNT(*) INTO vCOUNT
      from DB_LOADER_FULL_FINANCE_BILL fb 
      where fb.YEAR_MONTH = pYEAR_MONTH 
        and ban = -1 and fb.CALLS <> fb.CALLS_ALL
        and ((abs(fb.CALLS - fb.CALLS_ALL) = 0.01)
          or (abs(fb.CALLS - fb.CALLS_ALL) = 0.02));          
    vITOG:=vITOG || '; Звонков совмещено: ' || vCOUNT; 
    update DB_LOADER_FULL_FINANCE_BILL fb  
      set fb.BILL_SUM = fb.BILL_SUM - (fb.CALLS - fb.CALLS_ALL),
          fb.CALLS = fb.CALLS - (fb.CALLS - fb.CALLS_ALL),
          fb.COMPLETE_BILL = 1   
      where fb.YEAR_MONTH = pYEAR_MONTH 
        and ban = -1 and fb.CALLS <> fb.CALLS_ALL
        and ((abs(fb.CALLS - fb.CALLS_ALL) = 0.01)
          or (abs(fb.CALLS - fb.CALLS_ALL) = 0.02));   
  -- Скидка на абон. плату.
    SELECT COUNT(*) INTO vCOUNT
      from DB_LOADER_FULL_FINANCE_BILL fb 
      where fb.YEAR_MONTH = pYEAR_MONTH 
        and ban = -1 and fb.DISCOUNT_OTHERS < 0 and fb.DISCOUNT_YEAR = 0 
        and exists (select 1 
                      from DB_LOADER_FULL_FINANCE_BILL fb1 
                      where FB.ACCOUNT_ID = fb1.ACCOUNT_ID 
                      and to_char(add_months(to_date(fb.YEAR_MONTH,'yyyymm'),-1),'yyyymm') = fb1.YEAR_MONTH 
                      and FB.phone_number = fb1.phone_number 
                      and fb1.DISCOUNT_YEAR <> 0);           
    vITOG:=vITOG || '; Скидка на абон.пл.: ' || vCOUNT; 
    update DB_LOADER_FULL_FINANCE_BILL fb 
      set fb.DISCOUNT_YEAR = (fb.ABON_MAIN + fb.SINGLE_MAIN) * (select fb1.DISCOUNT_YEAR/(fb1.ABON_MAIN + fb1.SINGLE_MAIN) 
                                                                  from DB_LOADER_FULL_FINANCE_BILL fb1 
                                                                  where FB.ACCOUNT_ID = fb1.ACCOUNT_ID 
                                                                    and to_char(add_months(to_date(fb.YEAR_MONTH,'yyyymm'),-1),'yyyymm') = fb1.YEAR_MONTH 
                                                                    and FB.phone_number = fb1.phone_number 
                                                                    and fb1.DISCOUNT_YEAR <> 0),
          fb.DISCOUNT_OTHERS = fb.DISCOUNT_OTHERS - (fb.ABON_MAIN + fb.SINGLE_MAIN) * (select fb1.DISCOUNT_YEAR/(fb1.ABON_MAIN + fb1.SINGLE_MAIN) 
                                                                                         from DB_LOADER_FULL_FINANCE_BILL fb1 
                                                                                         where FB.ACCOUNT_ID = fb1.ACCOUNT_ID 
                                                                                           and to_char(add_months(to_date(fb.YEAR_MONTH,'yyyymm'),-1),'yyyymm') = fb1.YEAR_MONTH 
                                                                                           and FB.phone_number = fb1.phone_number 
                                                                                           and fb1.DISCOUNT_YEAR <> 0)  
      where fb.YEAR_MONTH = pYEAR_MONTH 
        and ban = -1 and fb.DISCOUNT_OTHERS < 0 and fb.DISCOUNT_YEAR = 0 
        and exists (select 1 
                      from DB_LOADER_FULL_FINANCE_BILL fb1 
                      where FB.ACCOUNT_ID = fb1.ACCOUNT_ID 
                      and to_char(add_months(to_date(fb.YEAR_MONTH,'yyyymm'),-1),'yyyymm') = fb1.YEAR_MONTH 
                      and FB.phone_number = fb1.phone_number 
                      and fb1.DISCOUNT_YEAR <> 0);  
  -- Скидки по акции "+ и СМС300"
    SELECT COUNT(*) INTO vCOUNT
      from DB_LOADER_FULL_FINANCE_BILL fb 
      where fb.YEAR_MONTH = pYEAR_MONTH 
        and ban = -1 and fb.DISCOUNT_OTHERS < -300 
        and fb.DISCOUNT_SMS_PLUS = 0 and fb.ABON_ADD > 700
        and exists (select 1 
                      from DB_LOADER_FULL_FINANCE_BILL fb1 
                      where FB.ACCOUNT_ID = fb1.ACCOUNT_ID 
                        and to_char(add_months(to_date(fb.YEAR_MONTH,'yyyymm'),-1),'yyyymm') = fb1.YEAR_MONTH 
                        and FB.phone_number = fb1.phone_number 
                        and fb1.DISCOUNT_SMS_PLUS <> 0);          
    vITOG:=vITOG || '; Скидки по акции "+ и СМС300": ' || vCOUNT; 
    update  DB_LOADER_FULL_FINANCE_BILL fb 
      set fb.DISCOUNT_SMS_PLUS = -(fb.single_add +705),
          fb.DISCOUNT_OTHERS = fb.DISCOUNT_OTHERS + (fb.single_add +705)  
      where fb.YEAR_MONTH = pYEAR_MONTH 
        and ban = -1 and fb.DISCOUNT_OTHERS < -300 
        and fb.DISCOUNT_SMS_PLUS = 0 and fb.ABON_ADD > 700
        and exists (select 1 
                      from DB_LOADER_FULL_FINANCE_BILL fb1 
                      where FB.ACCOUNT_ID = fb1.ACCOUNT_ID 
                        and to_char(add_months(to_date(fb.YEAR_MONTH,'yyyymm'),-1),'yyyymm') = fb1.YEAR_MONTH 
                        and FB.phone_number = fb1.phone_number 
                        and fb1.DISCOUNT_SMS_PLUS <> 0);
  -- Сохраняем
    COMMIT;   
  END IF;
  vITOG:=vDELET || vITOG;
  RETURN vITOG;                                                                
END;
/