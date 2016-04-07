
  CREATE OR REPLACE PROCEDURE "SIM_TRADE"."TEMP_ADD_ACCOUNT_PHONE_HISTORY" (
  pPHONE_NUMBER IN VARCHAR2,
  pCELL_PLAN_CODE IN VARCHAR2,        /* КОД ТАРИФНОГО ПЛАНА*/
  pPHONE_IS_ACTIVE  IN NUMBER,        /* 0 - НЕАКТИВНЫЙ, 1 - АКТИВНЫЙ */
  pDATE IN DATE
  ) IS
  --
  VERY_BIG_DATE CONSTANT DATE := TO_DATE('01.01.3000', 'DD.MM.YYYY');
  --
  -- дата попала в промежуток времени истории
  CURSOR CUR_HIST(pPHONE_NUMBER IN VARCHAR2,
                  pDATE IN DATE) IS
    SELECT D.*
    FROM DB_LOADER_ACCOUNT_PHONE_HISTS D
    WHERE D.PHONE_NUMBER = pPHONE_NUMBER
      AND D.BEGIN_DATE <= pDATE AND pDATE < D.END_DATE;
  -- первый промежуток после указанной даты (в будущем)
  CURSOR CUR_HIST_FUTURE(pPHONE_NUMBER IN VARCHAR2,
                         pDATE IN DATE) IS
    SELECT D.*
    FROM DB_LOADER_ACCOUNT_PHONE_HISTS D
    WHERE D.PHONE_NUMBER = pPHONE_NUMBER
      AND D.BEGIN_DATE > pDATE
    ORDER BY D.BEGIN_DATE;
  -- последний промежуток до указанной даты (в прошлом)
  CURSOR CUR_HIST_PAST(pPHONE_NUMBER IN VARCHAR2,
                       pDATE IN DATE) IS
    SELECT D.*
    FROM DB_LOADER_ACCOUNT_PHONE_HISTS D
    WHERE D.PHONE_NUMBER = pPHONE_NUMBER
      AND D.END_DATE <= pDATE
    ORDER BY D.END_DATE DESC;
  REC_HIST CUR_HIST%ROWTYPE;
  vDATE DATE;
BEGIN
  OPEN CUR_HIST(pPHONE_NUMBER, pDATE);
  FETCH CUR_HIST INTO REC_HIST;
  IF CUR_HIST%NOTFOUND THEN
    -- не попали в промежуток времени (скорее всего история еще не велась)
    -- или добавляем дату до начала ведения
    -- (после даты окончания ведения не может быть, тк дата окончания последнего = очень большой дате)
    --
    -- смотрим, есть ли промежутки в прошлом
    OPEN CUR_HIST_PAST(pPHONE_NUMBER, pDATE);
    FETCH CUR_HIST_PAST INTO REC_HIST;
    IF CUR_HIST_PAST%NOTFOUND THEN
      -- смотрим, есть ли промежутки в будущем
      OPEN CUR_HIST_FUTURE(pPHONE_NUMBER, pDATE);
      FETCH CUR_HIST_FUTURE INTO REC_HIST;
      IF CUR_HIST_FUTURE%NOTFOUND THEN
        -- если промежутков нет ни в прошлом ни в будущем,
        -- значит история еще не велась, добавляем первую позицию в истоию
        INSERT INTO DB_LOADER_ACCOUNT_PHONE_HISTS
        (PHONE_NUMBER, BEGIN_DATE, END_DATE, PHONE_IS_ACTIVE, CELL_PLAN_CODE)
        VALUES
        (pPHONE_NUMBER, pDATE, VERY_BIG_DATE, pPHONE_IS_ACTIVE, pCELL_PLAN_CODE);
      ELSE
        -- если промежутки есть только в будущем
        -- подвинем границу последнего на пораньше (до текущей даты)
        UPDATE DB_LOADER_ACCOUNT_PHONE_HISTS D
        SET D.BEGIN_DATE = pDATE
        WHERE D.HISTORY_ID = REC_HIST.HISTORY_ID;
      END IF;
      CLOSE CUR_HIST_FUTURE;
    ELSE
      RAISE_APPLICATION_ERROR(-20000, 'Ошибка ведения истории. Дата новой позиции больше очень большой даты.');
    END IF;
    CLOSE CUR_HIST_PAST;
  ELSE
    -- попали в промежуток времени (практичечки всегда будем попадать сюда)
    IF (REC_HIST.PHONE_IS_ACTIVE = pPHONE_IS_ACTIVE)
      AND (REC_HIST.CELL_PLAN_CODE = pCELL_PLAN_CODE) THEN
      -- попали в промежуток времени, с такой же активностью и тем же тарифом
      NULL; -- ничего не делаем
    ELSE
      -- попали в промежуток времени, с другой активностью
      --
      -- укоротим промежуток, внутрь которого попали
      UPDATE DB_LOADER_ACCOUNT_PHONE_HISTS D
      SET D.END_DATE = pDATE
      WHERE D.HISTORY_ID = REC_HIST.HISTORY_ID;
      -- добавим промежуток времени на укороченное место
      INSERT INTO DB_LOADER_ACCOUNT_PHONE_HISTS
      (PHONE_NUMBER, BEGIN_DATE, END_DATE, PHONE_IS_ACTIVE, CELL_PLAN_CODE)
      VALUES
      (pPHONE_NUMBER, pDATE, REC_HIST.END_DATE, pPHONE_IS_ACTIVE, pCELL_PLAN_CODE);
    END IF;
  END IF;
  CLOSE CUR_HIST;
END;

