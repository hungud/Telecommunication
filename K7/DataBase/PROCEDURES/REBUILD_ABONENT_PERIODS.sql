CREATE OR REPLACE PROCEDURE REBUILD_ABONENT_PERIODS(
  pYEAR_MONTH IN INTEGER, 
  pPHONE_NUMBER IN VARCHAR2
  ) IS
-- Version = 3
-- 2015.07.27 Крайнов. Убран фильтр по активности в отрезании дня сзади при пред активности.
  CURSOR C IS
    SELECT H.PHONE_NUMBER, 
           NVL(H.PHONE_IS_ACTIVE, 0) IS_ACTIVE, 
           TRUNC(H.BEGIN_DATE) BEGIN_DATE,
           TRUNC(H.END_DATE) END_DATE,
           H.CELL_PLAN_CODE TARIFF_CODE, 
           H.BEGIN_DATE + (H.END_DATE - H.BEGIN_DATE)/2 CHECK_DATE,
           H.BEGIN_DATE REAL_BEGIN_DATE, 
           H.END_DATE REAL_END_DATE
      FROM DB_LOADER_ACCOUNT_PHONE_HISTS H      
      WHERE H.PHONE_NUMBER = pPHONE_NUMBER
        AND TRUNC(H.BEGIN_DATE) <= LAST_DAY(TO_DATE(pYEAR_MONTH, 'YYYYMM'))
        AND TRUNC(H.END_DATE) >= TO_DATE(pYEAR_MONTH, 'YYYYMM')
      ORDER BY H.BEGIN_DATE DESC;
  CURSOR D(pBEGIN IN DATE, pEND IN DATE) IS
    SELECT *
      FROM QUEUE_PHONE_REBLOCK_LOG Q
      WHERE Q.PHONE_NUMBER = pPHONE_NUMBER
        AND Q.TICKED_UNLOCK_ID IS NOT NULL
        AND Q.DATE_UNLOCK >= pBEGIN - 1/24
        AND Q.DATE_UNLOCK <= pEND;
  CURSOR MONTH_BEGIN IS
    select d1.YEAR_MONTH,
           d1.PHONE_NUMBER,
           d1.BEGIN_DATE,
           d1.END_DATE,
           d1.TARIFF_CODE OLD_TP_CODE,
           D1.TARIFF_ID OLD_TP_ID,
           D2.TARIFF_CODE NEW_TP_CODE,
           D2.TARIFF_ID NEW_TP_ID
      from db_loader_abonent_periods d1,
           db_loader_abonent_periods d2
      where d1.YEAR_MONTH = pYEAR_MONTH
        and d1.PHONE_NUMBER = pPHONE_NUMBER
        and d1.BEGIN_DATE = to_date(d1.YEAR_MONTH||'01', 'yyyymmdd')
        and d1.END_DATE = d1.BEGIN_DATE
        and d1.YEAR_MONTH = d2.YEAR_MONTH
        and d1.PHONE_NUMBER = d2.PHONE_NUMBER
        and d2.BEGIN_DATE = d1.END_DATE + 1
        and exists (select 1
                      from db_loader_account_phone_hists h1
                      where h1.PHONE_NUMBER = d1.PHONE_NUMBER
                        and trunc(h1.END_DATE) = d1.END_DATE)
        and exists (select 1
                      from db_loader_account_phone_hists h2
                      where h2.PHONE_NUMBER = d2.PHONE_NUMBER
                        and trunc(h2.BEGIN_DATE) = d2.BEGIN_DATE - 1);   
  vD_MONTH_BEGIN MONTH_BEGIN%ROWTYPE;                                         
  vDUMMY C%ROWTYPE;
  vD_DUMMY D%ROWTYPE;
  vDATE_BEGIN DATE;
  vDATE_END DATE;
  vDATE_CHECK DATE;
  vPREV_STATE INTEGER;
  vLAST INTEGER;
  vBEGIN DATE;
  vEND DATE;
  vTARIFF_ID INTEGER;
BEGIN
  NULL;
  -- Очищение данных
  delete DB_LOADER_ABONENT_PERIODS db
    where db.YEAR_MONTH = pYEAR_MONTH
      and db.PHONE_NUMBER = pPHONE_NUMBER;
  -- Заполнение обновленными данными
  vDATE_BEGIN:=TO_DATE(pYEAR_MONTH, 'YYYYMM');
  vDATE_END:=LAST_DAY(vDATE_BEGIN);
  vDATE_CHECK:=vDATE_END+1;
  vPREV_STATE:=0;
  vLAST:=0;
  OPEN C;
  FETCH C INTO vDUMMY;
  IF C%FOUND THEN
    LOOP
      -- Тело цикла
      -- Определение границ по статусу
    /*  IF vPREV_STATE = 1 THEN
        vDUMMY.END_DATE:=vDUMMY.END_DATE-1;
      END IF;      */
      IF (vDUMMY.BEGIN_DATE <> vDUMMY.REAL_BEGIN_DATE)
          AND (vDUMMY.IS_ACTIVE = 0) THEN
        vDUMMY.BEGIN_DATE:=vDUMMY.BEGIN_DATE+1;
      END IF;
      IF (vPREV_STATE = 1) AND (vDUMMY.END_DATE >= vDATE_CHECK) THEN
        vDUMMY.END_DATE:=vDUMMY.END_DATE - 1;
      END IF;
      -- Проверка границ периода
      IF vDUMMY.BEGIN_DATE < vDATE_BEGIN THEN
        vDUMMY.BEGIN_DATE := vDATE_BEGIN;
        vLAST:=1;
      END IF;
      IF vDUMMY.END_DATE > vDATE_END THEN
        vDUMMY.END_DATE := vDATE_END;
      END IF;
      IF TRUNC(vDUMMY.CHECK_DATE) > vDUMMY.END_DATE THEN
        IF vDUMMY.END_DATE = vDUMMY.BEGIN_DATE THEN
          -- вЫБРАННЫЙ ПЕРИОД В ОДИН ДЕНЬ И ИМЕЕТ НАЧАЛО - КОНЕЦ В ВИДЕ ДАТЫ БЕЗ ВРЕМЕНИ
          vDUMMY.CHECK_DATE := vDUMMY.END_DATE + 1 - 5/24/60;  
        ELSE
          vDUMMY.CHECK_DATE := vDUMMY.END_DATE - 5/24/60;
        END IF;
      END IF;
      /*  IF vDUMMY.END_DATE < vDATE_CHECK THEN
          -- Вычисление отрезка                  
          vDATE_CHECK:=vDUMMY.END_DATE;
        END IF;*/
      IF (vDUMMY.IS_ACTIVE = 1) 
          AND (vDUMMY.REAL_END_DATE < vDUMMY.REAL_BEGIN_DATE + 3/24 ) THEN
        OPEN D(vDUMMY.REAL_BEGIN_DATE, vDUMMY.REAL_END_DATE);
        FETCH D INTO vD_DUMMY;
        IF D%FOUND THEN
          vDUMMY.IS_ACTIVE:=0;
          -- Из-за принудительной смены активности(т.к. была переблокировка)сдвиг начала
          vDUMMY.BEGIN_DATE:=vDUMMY.BEGIN_DATE+1;
        END IF;
        CLOSE D;
      END IF;
      IF (vDUMMY.BEGIN_DATE <= vDUMMY.END_DATE) AND (vDUMMY.END_DATE < vDATE_CHECK) THEN
        vTARIFF_ID:=GET_PHONE_TARIFF_ID(pPHONE_NUMBER, vDUMMY.TARIFF_CODE, vDUMMY.CHECK_DATE);
        INSERT INTO DB_LOADER_ABONENT_PERIODS(YEAR_MONTH, PHONE_NUMBER, BEGIN_DATE, END_DATE, TARIFF_CODE, TARIFF_ID, IS_ACTIVE, CHECK_DATE)
          VALUES(pYEAR_MONTH, pPHONE_NUMBER, vDUMMY.BEGIN_DATE, vDUMMY.END_DATE, vDUMMY.TARIFF_CODE, vTARIFF_ID, vDUMMY.IS_ACTIVE, vDUMMY.CHECK_DATE);
        /*IF (vDUMMY.IS_ACTIVE = 0) AND (vDATE_CHECK > vDUMMY.BEGIN_DATE + 1) THEN  
          vDATE_CHECK:=vDUMMY.BEGIN_DATE + 1;*/
--        ELSE
          vDATE_CHECK:=vDUMMY.BEGIN_DATE;
--        END IF;
        vPREV_STATE:=vDUMMY.IS_ACTIVE;
      END IF;
      -- Выход из цикла
      FETCH C INTO vDUMMY;
      EXIT WHEN C%NOTFOUND;
    END LOOP;
  END IF;
  CLOSE C;
  -- Сохранение
  COMMIT;
  -- Проверка первого дня:
  OPEN MONTH_BEGIN;
  FETCH MONTH_BEGIN INTO vD_MONTH_BEGIN;
  IF MONTH_BEGIN%FOUND THEN
    UPDATE DB_LOADER_ABONENT_PERIODS D    
      SET D.TARIFF_CODE = vD_MONTH_BEGIN.NEW_TP_CODE,
          D.TARIFF_ID = vD_MONTH_BEGIN.NEW_TP_ID
      WHERE D.YEAR_MONTH = vD_MONTH_BEGIN.YEAR_MONTH
        AND D.PHONE_NUMBER = vD_MONTH_BEGIN.PHONE_NUMBER
        AND D.BEGIN_DATE = vD_MONTH_BEGIN.BEGIN_DATE
        AND D.END_DATE = vD_MONTH_BEGIN.END_DATE;        
  END IF; 
  CLOSE MONTH_BEGIN;
  COMMIT;
END;