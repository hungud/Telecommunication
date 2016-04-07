CREATE OR REPLACE PROCEDURE SEND_DBF_TO_FTP
as
--Version =1
--
--v.1 Кочнев  01.12.2015 Создал процедуру по заданию #3752
begin
  SEND_FILES_TO_FTP('.dbf', '1C/TO_1C', 'DIR_BILL_FOR_1C', 2);
  -- расширение файла, например - '.dbf'
  -- Путь на FTP сервере - должен существовать
  -- название переменной в таблице - constant- фактически это  директория в Оракл
  -- для отправляемых на FTP файлов 1С - 2
end;
/