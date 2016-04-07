
  CREATE OR REPLACE PROCEDURE "LONTANA"."DELETE_DOUBLE_DETAIL" (
  SUBSCR_NO      VARCHAR2 DEFAULT NULL,
  pMonth_year    INTEGER DEFAULT NULL,
  pDBF_ID        INTEGER DEFAULT NULL)
IS
--
--#Verion=7
--v7 24.12.2015 Матюнин. Исправдена ошибка при составлении запроса, для склеивания строк вместо || исопльзовался + 
--v6 06.10.2015 Афросин лишнюю переменную убрали
--v5 06.10.2015 Крайнов переделал формирования запроса
--v4. 30.09.2015 Афросин Переделал API_DBF_ID на параметр :API_DBF_ID
--v3. 29.09.2015 Афросин Убрал удаление дубликатов если текущая дата больше 18 числа
-- v2. 12.01.2015 - Матюнин. При переходе с месяца на месяц, если в загружаемой детализациипо АПИ имелись данные за предыдущий месяц, 
--                           то они в предыдщем месяце дублировались, так как процедура зачистки дублей брала SYSDATE в качестве определения месяца. 
--                           Исправлено: теперь рассматриваем и предыдущий период   
--
  cSQL_BEGIN CONSTANT VARCHAR2 (549 CHAR) := '
                                                delete from CALL_%MONTH_DEST% td
                                                where td.DBF_ID = :API_DBF_ID
                                              ' ;
  cSQL_EXISTS_PATH   CONSTANT VARCHAR2 (658 CHAR) := '
                                                        and exists (select 1 from CALL_%MONTH_DEST% td1
                                                                      where td.START_TIME = td1.START_TIME
                                                                            and td.SUBSCR_NO = td1.SUBSCR_NO
                                                                            and td.CALL_COST = td1.CALL_COST
                                                                            %DBF_ID_PATH%
                                                                            )
                                                     ' ;
  API_DBF_ID                  INTEGER;
  mm_year                     VARCHAR2 (7 CHAR);
  previous_mm_year            VARCHAR2 (7 CHAR);

  tempSQL_EXISTS_PATH         VARCHAR2 (1000 CHAR);
  tmp_DBF_ID                  INTEGER;
  vSQL_BEGIN                  VARCHAR2 (1000 CHAR);
BEGIN
  API_DBF_ID := NVL (TO_NUMBER (MS_CONSTANTS.GET_CONSTANT_VALUE ('API_DBF_ID')), -1);
  mm_year := TO_CHAR (SYSDATE, 'mm_yyyy');
  previous_mm_year := TO_CHAR (ADD_MONTHS (SYSDATE, -1), 'mm_yyyy');

  IF (pDBF_ID IS NULL) OR (pDBF_ID = API_DBF_ID) THEN
    tempSQL_EXISTS_PATH := REPLACE (
                                    cSQL_EXISTS_PATH,
                                    '%DBF_ID_PATH%',
                                    ' and td1.DBF_ID <> :API_DBF_ID'
                                   );
    tmp_DBF_ID := API_DBF_ID;
  ELSE
    tempSQL_EXISTS_PATH := REPLACE (
                                    cSQL_EXISTS_PATH,
                                    '%DBF_ID_PATH%',
                                    ' and td1.DBF_ID = :DBF_ID'
                                   );
    tmp_DBF_ID := pDBF_ID;
  END IF;

  IF pMonth_year IS NOT NULL THEN
    vSQL_BEGIN := REPLACE (
                            cSQL_BEGIN,
                            '%MONTH_DEST%',
                            TO_CHAR (TRUNC (pMonth_year / 100))
                            || '_'
                            || TO_CHAR (MOD (pMonth_year, 100))
                          );
  ELSE
    vSQL_BEGIN := cSQL_BEGIN;
  END IF;

  IF SUBSCR_NO IS NOT NULL THEN
    vSQL_BEGIN := vSQL_BEGIN || ' and td.SUBSCR_NO = :pPHONE';

    EXECUTE IMMEDIATE
        REPLACE (vSQL_BEGIN || tempSQL_EXISTS_PATH, '%MONTH_DEST%', mm_year)
        USING API_DBF_ID, SUBSCR_NO, tmp_DBF_ID;

    IF (pMonth_year IS NULL) AND (TO_NUMBER (TO_CHAR (SYSDATE, 'dd')) < 18) THEN
      EXECUTE IMMEDIATE REPLACE (vSQL_BEGIN || tempSQL_EXISTS_PATH,
                                 '%MONTH_DEST%',
                                 previous_mm_year)
          USING API_DBF_ID, SUBSCR_NO, tmp_DBF_ID;
    END IF;
  ELSE
    EXECUTE IMMEDIATE
       REPLACE (cSQL_BEGIN || tempSQL_EXISTS_PATH, '%MONTH_DEST%', mm_year)
       USING API_DBF_ID, tmp_DBF_ID;

    IF (pMonth_year IS NULL) AND (TO_NUMBER (TO_CHAR (SYSDATE, 'dd')) < 18) THEN
      EXECUTE IMMEDIATE REPLACE (vSQL_BEGIN || tempSQL_EXISTS_PATH,
                                  '%MONTH_DEST%',
                                  previous_mm_year)
          USING API_DBF_ID, tmp_DBF_ID;
    END IF;
  END IF;
END;