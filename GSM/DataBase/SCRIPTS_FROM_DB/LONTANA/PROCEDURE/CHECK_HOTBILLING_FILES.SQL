
  CREATE OR REPLACE PROCEDURE "LONTANA"."CHECK_HOTBILLING_FILES" (
   p_interval   IN INTEGER DEFAULT 1,
   p_date_to    IN DATE DEFAULT SYSDATE)
AS
  -- v1 - 04.12.2014 - Бакунов Константин
   -- параметры:
   --     p_interval  - период времени
   --         1 - за час (default)
   --         2 - за день
   --         3 - за неделю
   --     p_date_to  - дата-время, на которую выполнить проверку, default = sysdate

   v_avg_files_per_interval   INTEGER; -- среднее количество файлов за за заданный период
   v_files_count              INTEGER; -- количество файлов
   v_date_from                DATE;    -- дата-время начала периода
   v_nfiles_diff_percent      INTEGER; -- предельный процент уменьшения количества файлов за заданный период
BEGIN
   v_nfiles_diff_percent :=
      MS_PARAMS.GET_PARAM_VALUE ('AVG_HOT_BIL_NFILES_DIFF_PERCENT');

   IF p_interval = 1
   THEN
      v_date_from := SYSDATE - 1 / 24;
      v_avg_files_per_interval :=
         MS_PARAMS.GET_PARAM_VALUE ('AVG_HOT_BIL_FILES_PER_HOUR');
   ELSE
      IF p_interval = 2
      THEN
         v_date_from := SYSDATE - 1;
         v_avg_files_per_interval :=
            MS_PARAMS.GET_PARAM_VALUE ('AVG_HOT_BIL_FILES_PER_DAY');
      ELSE
         IF p_interval = 3
         THEN
            v_date_from := SYSDATE - 7;
            v_avg_files_per_interval :=
               MS_PARAMS.GET_PARAM_VALUE ('AVG_HOT_BIL_FILES_PER_WEEK');
         END IF;
      END IF;
   END IF;

   SELECT COUNT(*)
   INTO v_files_count
   FROM hot_billing_files hb
   WHERE hb.load_sdate BETWEEN v_date_from AND p_date_to;


   IF   ((v_avg_files_per_interval - v_files_count)
         / v_avg_files_per_interval)
      * 100 > v_nfiles_diff_percent
   THEN
      -- Отправка сообщения на почту о снижения количества приходящих файлов гор. биллинга от среднее
      /*SEND_MAIL('',
                       'Информация о количестве файлов горячего биллинга',
                       'Обнаружено существенное отклонение количества файлов горячего биллинга от среднего количества');*/
      return;
   END IF;
END;