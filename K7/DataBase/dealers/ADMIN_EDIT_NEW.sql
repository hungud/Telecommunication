CREATE OR REPLACE PROCEDURE ADMIN_EDIT_NEW(
  SESSION_ID IN VARCHAR2 DEFAULT NULL,
  ID IN INTEGER DEFAULT NULL,
  P_NEW_DATE IN VARCHAR2 DEFAULT NULL,
  P_NEW_TIME IN VARCHAR2 DEFAULT NULL,
  P_NEW_HEADER IN VARCHAR2 DEFAULT NULL,
  P_NEW_ANNOTATION IN VARCHAR2 DEFAULT NULL,
  P_NEW_TEXT IN VARCHAR2 DEFAULT NULL,
  P_IS_ENABLED IN VARCHAR2 DEFAULT NULL,
  P_IS_ON_TOP IN VARCHAR2 DEFAULT NULL,
  P_SEND_NEW IN VARCHAR2 DEFAULT NULL,
  P_CANCEL_NEW IN VARCHAR2 DEFAULT NULL
  ) IS
--Version=1
  CURSOR C IS
    SELECT D_NEW_ID, DATE_OF_NEW, NEW_HEADER, NEW_ANNOTATION, NEW_TEXT, NEW_ENABLED, NEW_IS_ON_TOP
    FROM D_NEWS
    WHERE D_NEWS.D_NEW_ID = ID
    ;
  vREC C%ROWTYPE;
  CURSOR C_DUPLICATE(H VARCHAR2) IS
    SELECT 1
    FROM D_NEWS
    WHERE D_NEWS.NEW_HEADER = H
    AND DATE_CREATED > SYSDATE-(15/24/60/60) -- запрещаем дублирование в течение 15 секунд
    ;
  vDUMMY NUMBER;
  vERROR_MESSAGE VARCHAR2(200 CHAR);
  vDATE_TIME date;
BEGIN
  S_BEGIN(SESSION_ID=>SESSION_ID);
  IF G_STATE.IS_ADMIN=1 THEN
    --debug_out(P_NEW_HEADER);
    HTP.PRINT('<div id="content">');
    --
    IF P_SEND_NEW IS NOT NULL THEN
      IF P_NEW_DATE IS NULL THEN
        vERROR_MESSAGE := 'Нужно указать дату новости.';
      END IF;
      IF vERROR_MESSAGE IS NULL THEN
        BEGIN
          vDATE_TIME := TO_DATE(P_NEW_DATE, 'DD.MM.YYYY');
        EXCEPTION WHEN OTHERS THEN
          vERROR_MESSAGE := 'Дата указана неправильно (используйте формат ДД.ММ.ГГГГ).';
        END;
      END IF;
      IF vERROR_MESSAGE IS NULL 
        AND ID IS NULL 
        AND vDATE_TIME < SYSDATE-30 THEN
        vERROR_MESSAGE := 'Дата за прошлый период не разрешается.';
      END IF;
      IF P_NEW_TIME IS NOT NULL THEN
        IF vERROR_MESSAGE IS NULL THEN
          BEGIN
            vDATE_TIME := TO_DATE(P_NEW_TIME, 'HH24:MI');
          EXCEPTION WHEN OTHERS THEN
            vERROR_MESSAGE := 'Время указано с ошибкой (используйте формат ЧЧ:ММ).';
          END;
        END IF;
        IF vERROR_MESSAGE IS NULL THEN
          vDATE_TIME := TO_DATE(P_NEW_DATE || ' ' || P_NEW_TIME, 'DD.MM.YYYY HH24:MI');
        END IF;
      END IF;
      IF vERROR_MESSAGE IS NULL THEN
        IF P_NEW_HEADER IS NULL THEN
          vERROR_MESSAGE := 'Нужно указать заголовок.';
        END IF;
      END IF;
      IF vERROR_MESSAGE IS NULL THEN
        IF P_NEW_TEXT IS NULL THEN
          vERROR_MESSAGE := 'Нужно указать текст сообщения.';
        END IF;
      END IF;
      IF vERROR_MESSAGE IS NOT NULL THEN
        OUT_ERROR(vERROR_MESSAGE);
      ELSE
        IF ID IS NULL THEN
          -- Защищаем от двойного сохранения
          OPEN C_DUPLICATE(P_NEW_HEADER);
          FETCH C_DUPLICATE INTO vDUMMY;
          IF C_DUPLICATE%NOTFOUND THEN
            INSERT INTO D_NEWS (
              DATE_OF_NEW, 
              NEW_HEADER, 
              NEW_ANNOTATION, 
              NEW_TEXT, 
              NEW_ENABLED, 
              NEW_IS_ON_TOP
            ) VALUES (
              vDATE_TIME,
              P_NEW_HEADER,
              P_NEW_ANNOTATION,
              P_NEW_TEXT,
              CASE WHEN P_IS_ENABLED IS NULL THEN 0 ELSE 1 END,
              CASE WHEN P_IS_ON_TOP IS NULL THEN 0 ELSE 1 END
              );
            COMMIT;
          END IF;
          CLOSE C_DUPLICATE;
          S_OUT_MESSAGE('Новость добавлена.');
        ELSE
          UPDATE D_NEWS SET
            DATE_OF_NEW = vDATE_TIME, 
            NEW_HEADER = P_NEW_HEADER, 
            NEW_ANNOTATION = P_NEW_ANNOTATION, 
            NEW_TEXT = P_NEW_TEXT,
            NEW_ENABLED = CASE WHEN P_IS_ENABLED IS NULL THEN 0 ELSE 1 END, 
            NEW_IS_ON_TOP = CASE WHEN P_IS_ON_TOP IS NULL THEN 0 ELSE 1 END
          WHERE
            D_NEWS.D_NEW_ID = ADMIN_EDIT_NEW.ID
            ;
          S_OUT_MESSAGE('Изменения сохранены.');
        END IF;
      END IF;
    END IF;
    --
    HTP.PRINT('<a href="ADMIN_NEWS?'|| G_STATE.SESSION_KEY_PARAM_1 || '">Вернуться</a><br /><br />');
    --
    -- Форма ввода
    --
    IF P_SEND_NEW IS NULL 
      OR ID IS NOT NULL 
      OR vERROR_MESSAGE IS NOT NULL THEN
      --
      OPEN C;
      FETCH C INTO vREC;
      HTP.PRINT('<form action="ADMIN_EDIT_NEW" method="post">
<input type="hidden" name="SESSION_ID" value="'||G_STATE.SESSION_ID||'" />
<input type="hidden" name="ID" value="'||vREC.D_NEW_ID||'" />
<table>
  <tr>
    <td style="width: 80px; font-weight: bold">Дата:</td>
    <td style="width: 80px; "><input type="text" name="P_NEW_DATE" size="10" value="'|| NVL(P_NEW_DATE, TO_CHAR(NVL(vREC.DATE_OF_NEW, SYSDATE), 'DD.MM.YYYY'))||'" /></td>
    <td style="width: 160px; font-weight: bold">Время:</td>
    <td><input type="text" name="P_NEW_TIME" size="5" value="'|| NVL(P_NEW_TIME, TO_CHAR(NVL(vREC.DATE_OF_NEW, SYSDATE), 'HH24:MI'))||'" /></td>
  </tr>
  <tr>
    <td style="width: 80px; font-weight: bold">Включена:</td>
    <td style="width: 80px; "><input type="checkbox" name="P_IS_ENABLED"' || CASE WHEN ID IS NULL OR vREC.NEW_ENABLED=1 THEN ' checked="checked"' ELSE NULL END ||' /></td>
    <td style="width: 160px; font-weight: bold">Прикреплена сверху:</td>
    <td><input type="checkbox" name="P_IS_ON_TOP"' || CASE WHEN vREC.NEW_IS_ON_TOP=1 THEN ' checked="checked"' ELSE NULL END ||' /></td>
  </tr>
  <tr>
    <td style="width: 80px; font-weight: bold">Название:</td>
    <td colspan="3"><input id="new_header" type="text" name="P_NEW_HEADER" size="50" value="'||HTF.ESCAPE_SC(NVL(P_NEW_HEADER, vREC.NEW_HEADER))||'" /></td>
  </tr>
  <tr>
    <td style="width: 80px; font-weight: bold">Аннотация:</td>
    <td colspan="3"><textarea name="P_NEW_ANNOTATION" cols="50" rows="3">'||HTF.ESCAPE_SC(NVL(P_NEW_ANNOTATION, vREC.NEW_ANNOTATION))||'</textarea></td>
  </tr>
  <tr>
    <td style="width: 80px; font-weight: bold">Текст:</td>
    <td colspan="3"><textarea name="P_NEW_TEXT" cols="50" rows="8">'||HTF.ESCAPE_SC(NVL(P_NEW_TEXT, vREC.NEW_TEXT))||'</textarea></td>
  </tr>
  <tr>
    <td style="width: 80px; font-weight: bold"></td>
    <td style="width: 80px; "><input type="submit" name="P_SEND_NEW" value="Сохранить" /></td>
    <td style="width: 160px; "><input type="submit" name="P_CANCEL_NEW" value="Отмена" 
      onclick=''javascript: window.location="ADMIN_NEWS?'||G_STATE.SESSION_KEY_PARAM_1 || '"; return false;''/></td>
  </tr>
</table>
</form>
<script type="javascript">
  document.getElementById("new_header").focus();
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

  