CREATE OR REPLACE PROCEDURE ADMIN_MESSAGES(
  SESSION_ID IN VARCHAR2 DEFAULT NULL,
  SHOW_MODE IN VARCHAR2 DEFAULT 'new',
  PAGE IN NUMBER DEFAULT 1
  ) IS
--
  vCOUNT BINARY_INTEGER;
  vNEW_COUNT BINARY_INTEGER;
  PROCEDURE PRINT_ITEM(pMODE IN VARCHAR2, NAME IN VARCHAR2) IS
  BEGIN
    HTP.PRINT('<li><a href="ADMIN_MESSAGES?SHOW_MODE='|| pMODE ||G_STATE.SESSION_KEY_PARAM_2 || '">');
    IF pMODE = SHOW_MODE THEN
      HTP.PRINT('<b>');
    END IF;
    HTP.PRINT(NAME);
    IF pMODE = SHOW_MODE THEN
      HTP.PRINT('</b>');
    END IF;
    HTP.PRINT('</a></li>');
  END;
BEGIN
  S_BEGIN(SESSION_ID=>SESSION_ID);
  IF G_STATE.IS_ADMIN=1 THEN
    HTP.PRINT('
        <div id="content">');
    HTP.PRINT('<table  class="info_table"><tr><td valign="top" style="text-align:left" width="300px">
    <ul>');
    -- Количество новых
    SELECT COUNT(*)
    INTO vNEW_COUNT
    FROM D_MESSAGES
    WHERE D_MESSAGES.RESPONSE_DATE_TIME IS NULL;
    -- Количество всего
    SELECT COUNT(*)
    INTO vCOUNT
    FROM D_MESSAGES;
    PRINT_ITEM('new', 'Новые ('||vNEW_COUNT||')');
    PRINT_ITEM('all', 'Все ('||vCOUNT||')');
    HTP.PRINT('</ul>');
    --S_SHOW_FAQ_LIST;  
    HTP.PRINT('</td><td valign="top" style="text-align:left" width="500px">');
    S_SHOW_ADMIN_MESSAGES(PAGE, SHOW_MODE);
    HTP.PRINT('</td></tr></table>');
    HTP.PRINT('
        </div>');
  END IF;
  S_END;
EXCEPTION WHEN OTHERS THEN
  OUT_ERROR(SQLERRM);
END;
/
