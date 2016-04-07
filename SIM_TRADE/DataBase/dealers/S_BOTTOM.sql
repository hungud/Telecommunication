CREATE OR REPLACE PROCEDURE S_BOTTOM IS
--#Version=2
BEGIN
  IF G_STATE.NEED_PRINT_HEADERS THEN
--    IF NOT G_STATE.NO_DISPLAY_PANELS THEN
--      HTP.PRINT('<tr><td colspan=3><hr></td></tr>');
      /*    
      HTP.PRINT('<tr><td colspan=3>
<div class="copyright">
Разработка <a href="http://www.tarifer.ru/" target="_blank">Tarifer.ru</a>
</div>
</td></tr>');
      */
--    END IF;
    HTP.PRINT('
      </div>
    </div>');
HTP.PRINT('
  <div class="footer">
    <span>
      Информация, приводимая в Личном кабинете, носит справочный характер. 
      Отображаемое состояние Лицевого счета может отличаться от реальных данных, 
      хранимых в финансовых системах ООО"ДжиЭсЭм Корпорация". © ООО"ДжиЭсЭм Корпорация". ® Все права защищены.
      <br/>
    </span>
	</div>');
HTP.PRINT('
  </body>');
  END IF;
END; 
/

