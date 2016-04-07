CREATE OR REPLACE PROCEDURE SHOW_NEWS_TEXT(
  SESSION_ID IN VARCHAR2,
  NEWS_ID in INTEGER
  ) IS
BEGIN
  S_BEGIN(SESSION_ID=>SESSION_ID);
  IF G_STATE.USER_ID IS NOT NULL THEN
    HTP.PRINT('
      <div id="content">');
    FOR rec IN (SELECT *
    FROM D_NEWS
    WHERE D_NEWS.D_NEW_ID=NEWS_ID
    ) LOOP
      HTP.PRINT('<table class="info_table"><tr><td valign="top" style="text-align:left" width="100%">');
      HTP.PRINT('<h3>'||TO_CHAR(rec.DATE_OF_NEW, 'DD.MM.YYYY')||', '||HTF.ESCAPE_SC(rec.NEW_HEADER)||'</h3>');
      HTP.PRINT(rec.NEW_ANNOTATION||'<br/>');
      HTP.PRINT(S_PRINT_TEXT(rec.NEW_TEXT));
      HTP.PRINT('</td></tr></table>');
    END LOOP;
    HTP.PRINT('</div>');
  END IF;
  S_END;
EXCEPTION WHEN OTHERS THEN
  OUT_ERROR(SQLERRM);
END;
/
