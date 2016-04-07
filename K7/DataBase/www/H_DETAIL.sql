CREATE OR REPLACE PROCEDURE H_DETAIL IS
--#Version=1
--
BEGIN
  H_BEGIN('ƒетализаци€');
  HTP.PRINT('
          <br>ѕомес€чна€ таблица, отсортированна€ в обратном пор€дке,
          отображающа€:
          <ul>
            <li>ћес€ц.</li>
            <li>—умма начислений оператора в данном мес€це.</li>
            <li>—сылка <font color=green><b>ѕодробно</b></font> раскрывающа€ снизу подробную детализацию по данному мес€цу.</li>
            <li> нопка <IMG border="0" alt="GSM" src="IMG_XLS_ICON"> сохран€юща€ подробную детализацию по данному мес€цу в отдельном Excel файле.</li>
          </ul><br>');
  H_END;
END;
/
