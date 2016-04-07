CREATE OR REPLACE PROCEDURE S_SHOW_MY_MESSAGES(
  pSHOW_ALL_MESSAGES IN BOOLEAN,
  pMESSAGE_TEXT IN VARCHAR2,
  pMESSAGE_TEXT_SUBMIT IN VARCHAR2
  ) IS
--#Version=1
  vMESSAGE_INDEX BINARY_INTEGER := 0;
  cMESSAGES_ON_PAGE CONSTANT BINARY_INTEGER := 5;
  vMORE_EXISTS BOOLEAN := FALSE;
  vMESSAGES_EXISTS BOOLEAN := FALSE; 
  CURSOR C_DUPLICATE(H INTEGER) IS
    SELECT 1
    FROM D_MESSAGES
    WHERE D_MESSAGES.REQUEST_USER_ID = H
    AND DATE_CREATED > SYSDATE-(5/24/60/60) -- запрещаем дублирование в течение 5 секунд
    ;
  vDUMMY NUMBER;
BEGIN
  IF G_STATE.USER_ID IS NOT NULL THEN
    IF pMESSAGE_TEXT_SUBMIT IS NOT NULL
      AND pMESSAGE_TEXT IS NOT NULL THEN
      -- Защищаем от двойного сохранения
      OPEN C_DUPLICATE(G_STATE.USER_ID);
      FETCH C_DUPLICATE INTO vDUMMY;
      IF C_DUPLICATE%NOTFOUND THEN
        INSERT INTO D_MESSAGES (REQUEST_USER_ID, REQUEST_DATE_TIME, REQUEST_TEXT)
        VALUES (G_STATE.USER_ID, SYSDATE, pMESSAGE_TEXT);
        COMMIT;
      END IF;
    END IF;
    HTP.PRINT('
<div style="border: thin none; padding: 10px;">
  <h2>Последние сообщения</h2>
  <table style="margin-bottom: 5px;">
');
  FOR rec IN (
    SELECT
      D_MESSAGES.REQUEST_USER_ID, 
      D_MESSAGES.REQUEST_DATE_TIME, 
      D_MESSAGES.REQUEST_TEXT, 
      D_MESSAGES.RESPONSE_USER_ID, 
      D_MESSAGES.RESPONSE_DATE_TIME, 
      D_MESSAGES.RESPONSE_TEXT
    FROM
      D_MESSAGES
    WHERE
      REQUEST_USER_ID=G_STATE.USER_ID
    ORDER BY
      D_MESSAGES.REQUEST_DATE_TIME DESC
    ) LOOP
    vMESSAGE_INDEX := vMESSAGE_INDEX + 1;
    IF pSHOW_ALL_MESSAGES
      OR vMESSAGE_INDEX < cMESSAGES_ON_PAGE
      OR rec.RESPONSE_DATE_TIME IS NULL
      THEN
      IF vMESSAGES_EXISTS THEN
        HTP.PRINT('<tr><td colspan="2" style="padding: 5px 0px 5px 0px; border-top: thin dashed"></td></tr>');
      END IF;
      vMESSAGES_EXISTS := TRUE;
      HTP.PRINT('<tr><td width="150" style="vertical-align: top; text-align: center"><b>Вопрос:</b><br/>'
        ||INITCAP(S_GET_DATE_TIME_TEXT(rec.REQUEST_DATE_TIME))||'</td>
        <td style="vertical-align: top; text-align: left">'||S_PRINT_TEXT(rec.REQUEST_TEXT)||'</td></tr>');
      IF rec.RESPONSE_DATE_TIME IS NULL THEN
        HTP.PRINT('<tr><td width="150" style="vertical-align: top; text-align: center">Ответ:</td><td style="text-align: left" >-</td></tr>');
      ELSE
      HTP.PRINT('<tr style="background-color: #F4F4F4;"><td width="150" style="vertical-align: top; text-align: center;"><b>Ответ:</b><br/>'
        ||INITCAP(S_GET_DATE_TIME_TEXT(rec.RESPONSE_DATE_TIME))||'</td>
        <td style="vertical-align: top; text-align: left">'||S_PRINT_TEXT(rec.RESPONSE_TEXT)||'</td></tr>
        ');
      END IF;
    ELSE
      vMORE_EXISTS := TRUE;
    END IF;
  END LOOP;
  HTP.PRINT('</table>');
  IF NOT vMESSAGES_EXISTS THEN
    HTP.PRINT('Нет сообщений');
  END IF;
  IF pSHOW_ALL_MESSAGES THEN
    HTP.PRINT('<a href="MESSAGES?'||G_STATE.SESSION_KEY_PARAM_1||'">Показать последние</a>
');
  ELSIF vMORE_EXISTS THEN
    HTP.PRINT('<a href="MESSAGES?SHOW_ALL_MESSAGES=1'||G_STATE.SESSION_KEY_PARAM_2||'">Показать все</a>
');
  END IF;
  HTP.PRINT('</div>');
  -- Написать сообщение (форма)
  HTP.PRINT('<p/><p/>
<div style="border: thin solid; padding: 10px;">
  <form action="messages" method="post" >
    <input type="hidden" name="SESSION_ID" value="'||G_STATE.SESSION_ID||'" />
    <table border="0" cellpadding="2" cellspacing="2" bgcolor="#F0F0F0">
      <tr>
        <td style="padding: 10px"><h2 align="left">Написать сообщение:</h2></td>
      </tr>
      <tr>
        <td style="padding: 10px">
          <textarea name="message_text" rows="10" cols="50" style="width: 100%; height: 200px" ></textarea>
        </td>
      </tr>
      <tr>
        <td align="right" style="padding: 10px;">
          <input type="submit" style="cursor: hand;" name="message_text_submit" value="Отправить" />
          <input type="reset"  style="cursor: hand;" name="message_text_cancel" value="Отмена" />
        </td>
      </tr>
    </table>
  </form>
</div>
');
  END IF;
--
END;
/
