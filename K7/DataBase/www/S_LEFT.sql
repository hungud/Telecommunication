CREATE OR REPLACE PROCEDURE S_LEFT IS
--#Version=2
--
-- 2. Уколов. Исправлена ссылка в меню "Помощь"
--
  vPAGE_NAME VARCHAR2(40);
BEGIN
  IF G_STATE.NEED_PRINT_HEADERS THEN
    HTP.PRINT('<tr>');
    /*IF NOT G_STATE.NO_DISPLAY_PANELS THEN
      HTP.PRINT('<td valign=top>
<div id="menuLine">');
      HTP.PRINT('<ul><li><a title="Главная страница" href="main?' ||G_STATE.SESSION_KEY_PARAM_1 || '" >Главная</a></li>');
      IF G_STATE.USER_ID IS NOT NULL THEN
        vPAGE_NAME := HTF.ESCAPE_URL(LOWER(SUBSTR(OWA_UTIL.GET_CGI_ENV('PATH_INFO'), 2)));
        IF SUBSTR(vPAGE_NAME, 1, 1) = '!' THEN
          vPAGE_NAME := SUBSTR(vPAGE_NAME, 2);
        END IF;
        IF SUBSTR(vPAGE_NAME, LENGTH(vPAGE_NAME), 1) = '/' THEN
          vPAGE_NAME := SUBSTR(vPAGE_NAME, 1, LENGTH(vPAGE_NAME)-1);
        END IF;
        HTP.PRINT('<li><a title="Просмотр и управление периодами и загруженными файлами" href="periods?' ||G_STATE.SESSION_KEY_PARAM_1 || '">Периоды и файлы</a></li>
<li><a title="Справочник структуры организации, правила компенсации затрат, телефонная книга" href="refs?' ||G_STATE.SESSION_KEY_PARAM_1 || '">Справочники</a></li>
<li><a title="Формирование отчётов" href="reports?' ||G_STATE.SESSION_KEY_PARAM_1 || '">Отчёты</a></li>
<li><a title="Рассылка сотрудникам отчётов по электронной почте" href="manage_email_status?' ||G_STATE.SESSION_KEY_PARAM_1 || '">Рассылка по e-mail</a></li>
</ul>
</div>
<div id="lastMenuLine">
<ul>
<li>
<a title="Почитать справку" href="h_' || vPAGE_NAME || '" target="_blank">Помощь</a></li>
</ul>
<hr>
<ul><li><a title="Безопасное завершение работы" href="main?' ||G_STATE.SESSION_KEY_PARAM_1 || '&' || 'close_session=1">Выход</a></li>
');
      ELSE
        HTP.PRINT('<li>Периоды и файлы</li>
<li>Справочники</li>
<li>Отчёты</li>
<li>Рассылка по e-mail</li>
</ul>
</div>
<div id="lastMenuLine">
<ul>
<li><a title="Почитать справку" href="h_main_no_login" target="_blank">Помощь</a></li>
</li>
</ul>
<hr>
<ul><li>Выход</li>
');
      END IF;
      HTP.PRINT('</ul>
</div>
</td>');
    END IF;*/
    HTP.PRINT('<td valign=top style="padding-left:15px; padding-right:15px">
');
  END IF;
END; 
/

