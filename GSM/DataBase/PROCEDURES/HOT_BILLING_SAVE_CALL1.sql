/* Formatted on 23/03/2015 15:08:05 (QP5 v5.252.13127.32867) */
CREATE OR REPLACE PROCEDURE hot_billing_save_call1
IS
--
--v2 Афросин 23.03.2015 Убрал удаление дубликатов. Перенес их в  hot_billing_PCKG.SAVE_CALL (1, 0, 0);
--
BEGIN
   -- Call the procedure
   hot_billing_PCKG.SAVE_CALL (1, 0, 0);
   -- поиск и удаление дублей по АПИ и ГБ
   --DELETE_DOUBLE_DETAIL;
   
END;
/
