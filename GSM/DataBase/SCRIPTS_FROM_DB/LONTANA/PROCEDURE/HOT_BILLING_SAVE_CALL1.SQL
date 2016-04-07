
  CREATE OR REPLACE PROCEDURE "LONTANA"."HOT_BILLING_SAVE_CALL1" (
  nMOD_NUM in number default 0,--модуль потока
  nMOD in number default 1--потоки

)
IS
--
--v2 Афросин 23.03.2015 Убрал удаление дубликатов. Перенес их в  hot_billing_PCKG.SAVE_CALL (1, 0, 0);
--
BEGIN
   -- Call the procedure
   hot_billing_PCKG.SAVE_CALL (nMOD, nMOD_NUM, 0);
   -- поиск и удаление дублей по АПИ и ГБ
   --DELETE_DOUBLE_DETAIL;
   
END;