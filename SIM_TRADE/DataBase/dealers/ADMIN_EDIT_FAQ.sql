CREATE OR REPLACE PROCEDURE ADMIN_EDIT_FAQ(
  SESSION_ID IN VARCHAR2 DEFAULT NULL,
  ID IN INTEGER DEFAULT NULL,
  P_ORDER_NUMBER IN INTEGER DEFAULT NULL,
  P_FAQ_HEADER IN VARCHAR2 DEFAULT NULL,
  P_FAQ_REQUEST IN VARCHAR2 DEFAULT NULL,
  P_FAQ_RESPONSE IN VARCHAR2 DEFAULT NULL,
  P_IS_ENABLED IN VARCHAR2 DEFAULT NULL,
  P_SAVE_FAQ IN VARCHAR2 DEFAULT NULL,
  P_CANCEL_FAQ IN VARCHAR2 DEFAULT NULL
  ) IS
--Version=1
  CURSOR C IS
    SELECT D_FAQ_ID, ORDER_NUMBER, FAQ_HEADER, FAQ_REQUEST, FAQ_RESPONSE, FAQ_ENABLED
    FROM D_FAQS
    WHERE D_FAQS.D_FAQ_ID = ID
    ;
  vREC C%ROWTYPE;
  CURSOR C_DUPLICATE(H VARCHAR2) IS
    SELECT 1
    FROM D_FAQS
    WHERE D_FAQS.FAQ_HEADER = H
    AND DATE_CREATED > SYSDATE-(15/24/60/60) -- запрещаем дублирование в течение 15 секунд
    ;
  vDUMMY NUMBER;
  vERROR_MESSAGE VARCHAR2(200 CHAR);
  vORDER_NUMBER INTEGER;
BEGIN
  S_BEGIN(SESSION_ID=>SESSION_ID);
  IF G_STATE.IS_ADMIN=1 THEN
    --debug_out(P_NEW_HEADER);
    HTP.PRINT('<div id="content">');
    --
    IF P_SAVE_FAQ IS NOT NULL THEN
      IF vERROR_MESSAGE IS NULL THEN
        IF P_FAQ_HEADER IS NULL THEN
          vERROR_MESSAGE := 'Нужно указать заголовок.';
        END IF;
      END IF;
      IF vERROR_MESSAGE IS NULL THEN
        IF P_FAQ_RESPONSE IS NULL THEN
          vERROR_MESSAGE := 'Нужно указать ответ.';
        END IF;
      END IF;
      IF vERROR_MESSAGE IS NOT NULL THEN
        OUT_ERROR(vERROR_MESSAGE);
      ELSE
        vORDER_NUMBER := P_ORDER_NUMBER;
        IF ID IS NULL THEN
          -- Защищаем от двойного сохранения
          OPEN C_DUPLICATE(P_FAQ_HEADER);
          FETCH C_DUPLICATE INTO vDUMMY;
          IF C_DUPLICATE%NOTFOUND THEN
            IF vORDER_NUMBER IS NULL THEN
              SELECT NVL(MAX(ORDER_NUMBER), 0)+10
              INTO vORDER_NUMBER
              FROM D_FAQS;
            END IF;
            INSERT INTO D_FAQS (
              ORDER_NUMBER, 
              FAQ_HEADER, 
              FAQ_REQUEST, 
              FAQ_RESPONSE, 
              FAQ_ENABLED
            ) VALUES (
              VORDER_NUMBER,
              P_FAQ_HEADER,
              P_FAQ_REQUEST,
              P_FAQ_RESPONSE,
              CASE WHEN P_IS_ENABLED IS NULL THEN 0 ELSE 1 END
              );
            COMMIT;
          END IF;
          CLOSE C_DUPLICATE;
          S_OUT_MESSAGE('Запись добавлена.');
        ELSE
          UPDATE D_FAQS SET
            ORDER_NUMBER=NVL(vORDER_NUMBER, ORDER_NUMBER), 
            FAQ_HEADER=P_FAQ_HEADER, 
            FAQ_REQUEST=P_FAQ_REQUEST, 
            FAQ_RESPONSE=P_FAQ_RESPONSE, 
            FAQ_ENABLED=CASE WHEN P_IS_ENABLED IS NULL THEN 0 ELSE 1 END
          WHERE
            D_FAQS.D_FAQ_ID = ADMIN_EDIT_FAQ.ID
            ;
          S_OUT_MESSAGE('Изменения сохранены.');
        END IF;
      END IF;
    END IF;
    --
    HTP.PRINT('<a href="ADMIN_FAQ?'|| G_STATE.SESSION_KEY_PARAM_1 || '">Вернуться</a><br /><br />');
    --
    -- Форма ввода
    --
    IF P_SAVE_FAQ IS NULL 
      OR ID IS NOT NULL 
      OR vERROR_MESSAGE IS NOT NULL THEN
      --
      OPEN C;
      FETCH C INTO vREC;
      HTP.PRINT('<form action="ADMIN_EDIT_FAQ" method="post">
<input type="hidden" name="SESSION_ID" value="'||G_STATE.SESSION_ID||'" />
<input type="hidden" name="ID" value="'||vREC.D_FAQ_ID||'" />
<table>
  <tr>
    <td style="width: 80px; font-weight: bold">Включен:</td>
    <td style="width: 80px; "><input type="checkbox" name="P_IS_ENABLED"' || CASE WHEN ID IS NULL OR vREC.FAQ_ENABLED=1 THEN ' checked="checked"' ELSE NULL END ||' /></td>
  </tr>
  <tr>
    <td style="width: 80px; font-weight: bold">Заголовок:</td>
    <td colspan="3"><input id="faq_header" type="text" name="P_FAQ_HEADER" size="50" value="'||HTF.ESCAPE_SC(NVL(P_FAQ_HEADER, vREC.FAQ_HEADER))||'" /></td>
  </tr>
  <tr>
    <td style="width: 80px; font-weight: bold">Вопрос:</td>
    <td colspan="3"><textarea name="P_FAQ_REQUEST" cols="50" rows="3">'||HTF.ESCAPE_SC(NVL(P_FAQ_REQUEST, vREC.FAQ_REQUEST))||'</textarea></td>
  </tr>
  <tr>
    <td style="width: 80px; font-weight: bold">Ответ:</td>
    <td colspan="3"><textarea name="P_FAQ_RESPONSE" cols="50" rows="6">'||HTF.ESCAPE_SC(NVL(P_FAQ_RESPONSE, vREC.FAQ_RESPONSE))||'</textarea></td>
  </tr>
  <tr>
    <td style="width: 80px; font-weight: bold"></td>
    <td style="width: 80px; "><input type="submit" name="P_SAVE_FAQ" value="Сохранить" />
    <input type="submit" name="P_CANCEL_FAQ" value="Отмена" 
      onclick=''javascript: window.location="ADMIN_FAQ?'||G_STATE.SESSION_KEY_PARAM_1 || '"; return false;''/></td>
  </tr>
</table>
</form>
<script type="javascript">
  document.getElementById("faq_header").focus();
</script>
        ');
      CLOSE C;
    END IF;
    HTP.PRINT('</div>');
  END IF;
  S_END;
EXCEPTION WHEN OTHERS THEN
  OUT_ERROR(SQLERRM);
END;
/

  