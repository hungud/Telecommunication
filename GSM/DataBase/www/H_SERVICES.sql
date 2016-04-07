CREATE OR REPLACE PROCEDURE H_SERVICES IS
--#Version=1
--
BEGIN
  H_BEGIN('Управление услугами');
  HTP.PRINT('
          <br>Таблица подключенных абонентом услуг содержащая:
          <ul>
            <li>Дату подключения.</li>
            <li>Название услуги.</li>');
--            <li>Ежемесячную абонентскую плату.</li>
  HTP.PRINT('
          </ul><br>');
  H_END;
END;
/
