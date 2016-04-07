CREATE OR REPLACE PROCEDURE H_BALANCE IS
--#Version=1
--
BEGIN
  H_BEGIN('Расшифровка баланса');
  HTP.PRINT('
          <br>Подробная таблица изменений баланса, отсортированная по дате в обратном порядке,
          снизу таблицы отображены: 
          <ul>
            <li>Сумма платежй.</li>
            <li>Сумма начислений.</li>
            <li><b>Итоговый баланс</b>.</li>
          </ul>
          Справа от таблицы кнопка <IMG border="0" alt="GSM" src="IMG_XLS_ICON" > 
          сохранит подробный баланс в отдельном Excel файле.<br>');
  H_END;
END;
/
