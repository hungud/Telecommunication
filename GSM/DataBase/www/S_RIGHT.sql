CREATE OR REPLACE PROCEDURE S_RIGHT IS
--#Version=1
BEGIN
  IF G_STATE.NEED_PRINT_HEADERS THEN
/*    IF NOT G_STATE.NO_DISPLAY_PANELS THEN
      HTP.PRINT('</td><td valign=top width="150px">
<h3>Новости:</h3>
<a href="main?' ||G_STATE.SESSION_KEY_PARAM_1 || '" target="_blank">01.10.2008 </a><br>Пробная новость.');
    END IF;*/
    HTP.PRINT('</td></tr>');
  END IF;
END; 
/

