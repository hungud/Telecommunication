CREATE OR REPLACE PROCEDURE ADMIN_FAQ(
  SESSION_ID IN VARCHAR2 DEFAULT NULL,
  PAGE IN NUMBER DEFAULT 1,
  ID IN NUMBER DEFAULT NULL,
  MOVE_UP IN VARCHAR2 DEFAULT NULL
  ) IS
--#Version=1
--
  vCURRENT_PAGE BINARY_INTEGER := 1;
  vINDEX BINARY_INTEGER := 0;
  vCOUNT BINARY_INTEGER;
  cITEMS_ON_PAGE CONSTANT BINARY_INTEGER := 10000;
  vROWS_EXISTS BOOLEAN := FALSE;
  --
  CURSOR C(ID INTEGER) IS
    SELECT *
    FROM D_FAQS
    WHERE D_FAQS.D_FAQ_ID=ID;
  CURSOR C_UP_ORDER_NUMBER(pORDER_NUMBER INTEGER) IS
    SELECT *
    FROM D_FAQS
    WHERE D_FAQS.ORDER_NUMBER<pORDER_NUMBER
    ORDER BY D_FAQS.ORDER_NUMBER DESC;
  C_REC C%ROWTYPE;
  C2_REC C%ROWTYPE;
BEGIN
  S_BEGIN(SESSION_ID=>SESSION_ID);
  IF G_STATE.IS_ADMIN=1 THEN
    HTP.PRINT('
        <div id="content">');
    HTP.PRINT('<h2>Управление Частыми Вопросами</h2>
<table  class="info_table">
<tr>
  <td colspan="2" style="padding: 15px 0px 25px 0px; text-align: left">
    <a href="ADMIN_EDIT_FAQ?' || G_STATE.SESSION_KEY_PARAM_1 || '">Добавить</a>
  </td>
</tr>');
    IF ID IS NOT NULL AND MOVE_UP IS NOT NULL THEN
      -- Найдем вышестоящий номер
      OPEN C(ID);
      FETCH C INTO C_REC;
      IF C%FOUND THEN
        OPEN C_UP_ORDER_NUMBER(C_REC.ORDER_NUMBER);
        FETCH C_UP_ORDER_NUMBER INTO C2_REC;
        IF C_UP_ORDER_NUMBER%FOUND THEN
          -- Обмениваем местами
          UPDATE D_FAQS
          SET ORDER_NUMBER=C2_REC.ORDER_NUMBER
          WHERE D_FAQS.D_FAQ_ID=C_REC.D_FAQ_ID;
          UPDATE D_FAQS
          SET ORDER_NUMBER=C_REC.ORDER_NUMBER
          WHERE D_FAQS.D_FAQ_ID=C2_REC.D_FAQ_ID;
          COMMIT;
        END IF;
        CLOSE C_UP_ORDER_NUMBER;
      END IF;
      CLOSE C;
    END IF;
    FOR rec IN (
      SELECT
        D_FAQS.D_FAQ_ID,
        D_FAQS.ORDER_NUMBER, 
        D_FAQS.FAQ_HEADER, 
        D_FAQS.FAQ_REQUEST, 
        D_FAQS.FAQ_RESPONSE, 
        D_FAQS.FAQ_ENABLED 
      FROM
        D_FAQS
      ORDER BY
        D_FAQS.ORDER_NUMBER
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
          ||'<h3><a href="admin_edit_faq?ID='|| rec.D_FAQ_ID || G_STATE.SESSION_KEY_PARAM_2 || '">'
          ||HTF.ESCAPE_SC(rec.FAQ_HEADER)|| '</a></h3>' 
          ||CASE WHEN rec.FAQ_ENABLED=0 THEN 'Выключен.<br/>' ELSE NULL END 
          ||S_PRINT_TEXT(rec.FAQ_REQUEST)|| '<br/><br/>' 
          ||S_PRINT_TEXT(rec.FAQ_RESPONSE));
        IF vINDEX <> 1 THEN
          HTP.PRINT('<br/><a href="ADMIN_FAQ?ID='||rec.D_FAQ_ID||'&'||'amp;MOVE_UP=1'||G_STATE.SESSION_KEY_PARAM_2||'">[Поднять]</a>');
        END IF;
        HTP.PRINT('</td>
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
        D_FAQS;
    --
    S_SHOW_PAGE_LIST(
      PAGE,
      TRUNC((vCOUNT+cITEMS_ON_PAGE-1)/cITEMS_ON_PAGE),
      'ADMIN_NEWS');
--
    HTP.PRINT('</div>');
  END IF;
  S_END;
EXCEPTION WHEN OTHERS THEN
  OUT_ERROR(SQLERRM);
END;
/
