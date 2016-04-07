CREATE OR REPLACE PROCEDURE ADMIN_NEWS(
  SESSION_ID IN VARCHAR2 DEFAULT NULL,
  PAGE IN NUMBER DEFAULT 1
  ) IS
--#Version=1
--
  vCURRENT_PAGE BINARY_INTEGER := 1;
  vINDEX BINARY_INTEGER := 0;
  vCOUNT BINARY_INTEGER;
  cITEMS_ON_PAGE CONSTANT BINARY_INTEGER := 10;
  vROWS_EXISTS BOOLEAN := FALSE;
BEGIN
  S_BEGIN(SESSION_ID=>SESSION_ID);
  IF G_STATE.IS_ADMIN=1 THEN
    HTP.PRINT('
        <div id="content">');
    HTP.PRINT('<h2>Управление новостями</h2>
<table  class="info_table">
<tr>
  <td colspan="2" style="padding: 15px 0px 25px 0px; text-align: left">
    <a href="ADMIN_EDIT_NEW?' || G_STATE.SESSION_KEY_PARAM_1 || '">Добавить</a>
  </td>
</tr>');
    FOR rec IN (
      SELECT
        D_NEWS.D_NEW_ID, 
        D_NEWS.DATE_OF_NEW, 
        D_NEWS.NEW_HEADER, 
        D_NEWS.NEW_ANNOTATION, 
        D_NEWS.NEW_TEXT, 
        D_NEWS.NEW_ENABLED, 
        D_NEWS.NEW_IS_ON_TOP
      FROM
        D_NEWS
      ORDER BY
        D_NEWS.NEW_IS_ON_TOP DESC,
        D_NEWS.DATE_OF_NEW DESC
      ) LOOP
      vINDEX := vINDEX + 1;
      IF vINDEX > cITEMS_ON_PAGE THEN
        vINDEX := 1;
        vCURRENT_PAGE := vCURRENT_PAGE + 1;
      END IF;
      EXIT WHEN vCURRENT_PAGE > PAGE;
      IF vCURRENT_PAGE = PAGE THEN
--        IF vROWS_EXISTS THEN
          HTP.PRINT('<tr><td colspan="2" style="padding: 15px 0px 5px 0px; border-top: thin dashed"></td></tr>');
--        END IF;
        vROWS_EXISTS := TRUE;
        HTP.PRINT('<tr><td width="150" style="vertical-align: top; padding-bottom: 5px; text-align: left">'
          ||'<h3><a href="admin_edit_new?ID='|| rec.D_NEW_ID || G_STATE.SESSION_KEY_PARAM_2 || '">'
          ||S_GET_DATE_TIME_TEXT(rec.DATE_OF_NEW)|| ', '
          ||HTF.ESCAPE_SC(rec.NEW_HEADER)|| '</a></h3>' 
          ||HTF.ESCAPE_SC(rec.NEW_ANNOTATION)|| '<br/>' 
          ||S_PRINT_TEXT(rec.NEW_TEXT)
          ||'</td>
          </tr>');
      END IF;
    END LOOP;
    HTP.PRINT('</table>');
    IF NOT vROWS_EXISTS THEN
      HTP.PRINT('Нет сообщений');
    END IF;
    -- Страницы
    SELECT COUNT(*)
      INTO vCOUNT 
      FROM
        D_NEWS;
    --
    S_SHOW_PAGE_LIST(
      PAGE,
      TRUNC((vCOUNT+cITEMS_ON_PAGE-1)/cITEMS_ON_PAGE),
      'ADMIN_NEWS');
--
  END IF;
  S_END;
EXCEPTION WHEN OTHERS THEN
  OUT_ERROR(SQLERRM);
END;
/
