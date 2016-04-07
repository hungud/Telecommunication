CREATE OR REPLACE PROCEDURE GET_PAYMENTS_FROM_FTP
--
--#Version=1
--
--v.1 Кочнев 25.11.2015 - Получаем файлы платежей из ФТП в директорию Оракл A
AS
 DIR_PAYMENT VARCHAR2(150);
begin
  DIR_PAYMENT := MS_CONSTANTS.GET_CONSTANT_VALUE('DIR_PAYMENT_FILES_NEW');
  
  GET_FILE_FROM_FTP('.txt','PAYMENTS', 1, DIR_PAYMENT, 'DIR_PAYMENT_FILES_BACKUP');

exception
      when OTHERS then
        rollback;   
END GET_PAYMENTS_FROM_FTP;
/