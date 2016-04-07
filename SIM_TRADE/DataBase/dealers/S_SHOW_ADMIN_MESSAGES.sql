CREATE OR REPLACE PROCEDURE S_SHOW_ADMIN_MESSAGES(
  pPAGE IN BINARY_INTEGER,
  pMODE IN VARCHAR2
  ) IS
--#Version=1
  vCURRENT_PAGE BINARY_INTEGER := 1;
  vINDEX BINARY_INTEGER := 0;
  vCOUNT BINARY_INTEGER;
  cITEMS_ON_PAGE CONSTANT BINARY_INTEGER := 10;
  vROWS_EXISTS BOOLEAN := FALSE;
BEGIN
  IF G_STATE.USER_ID IS NULL THEN RETURN; END IF;
  HTP.PRINT('
<h2>Вопросы дилеров</h2>
<table>
');
  FOR rec IN (
    SELECT
      D_MESSAGES.D_MESSAGE_ID, 
      D_MESSAGES.REQUEST_USER_ID, 
      D_MESSAGES.REQUEST_DATE_TIME, 
      D_MESSAGES.REQUEST_TEXT, 
      D_MESSAGES.RESPONSE_USER_ID, 
      D_MESSAGES.RESPONSE_DATE_TIME, 
      D_MESSAGES.RESPONSE_TEXT,
      D_USER_NAMES.DESCRIPTION,
      D_USER_NAMES.USER_NAME,
      D_USER_NAMES.E_MAIL
    FROM
      D_MESSAGES, D_USER_NAMES
    WHERE
      (D_MESSAGES.RESPONSE_DATE_TIME IS NULL OR pMODE = 'all')
      AND (D_MESSAGES.REQUEST_USER_ID=D_USER_NAMES.USER_ID(+))
    ORDER BY
      D_MESSAGES.REQUEST_DATE_TIME DESC
    ) LOOP
    vROWS_EXISTS := TRUE;
    vINDEX := vINDEX + 1;
    IF vINDEX > cITEMS_ON_PAGE THEN
      vINDEX := 1;
      vCURRENT_PAGE := vCURRENT_PAGE + 1;
    END IF;
    EXIT WHEN vCURRENT_PAGE > pPAGE;
    IF vCURRENT_PAGE = pPAGE THEN
      HTP.PRINT('<tr><td width="150" style="vertical-align: top; padding-bottom: 5px; text-align: center">'
        ||INITCAP(S_GET_DATE_TIME_TEXT(rec.REQUEST_DATE_TIME))|| '<br/>'
        ||rec.USER_NAME ||' '|| REC.DESCRIPTION || 
        '</td>
        <td style="vertical-align: top; padding-bottom: 5px; text-align: left">'||S_PRINT_TEXT(rec.REQUEST_TEXT)||'</td></tr>');
      IF rec.RESPONSE_DATE_TIME IS NULL THEN
        HTP.PRINT('<tr><td width="150" style="vertical-align: top; padding-bottom: 5px; text-align: center">
            <a href="#" id="response_toggle_'||rec.D_MESSAGE_ID||'" onclick=''javascript: 
            var v=document.getElementById("response_'||rec.D_MESSAGE_ID||'"); 
            if (v.style.display=="") {
              v.style.display="none";
              document.getElementById("response_toggle_'||rec.D_MESSAGE_ID||'").innerHTML="Ответить";
            } else {
              v.style.display=""; 
              document.getElementById("response_text_'||rec.D_MESSAGE_ID||'").focus(); 
              document.getElementById("response_toggle_'||rec.D_MESSAGE_ID||'").innerHTML="Скрыть";
            } 
            return false;
            ''>Ответить</a>
          </td>
          <td style="text-align: left; padding-bottom: 5px" >
            <span id="response_'||rec.D_MESSAGE_ID||'" style="display: none">
            ');
            S_ADMIN_PRINT_MESSAGE_FORM(rec.D_MESSAGE_ID);
            HTP.PRINT('</span>
          </td></tr>');
      ELSE
        HTP.PRINT('<tr style="background-color: #F4F4F4;"><td width="150" style="vertical-align: top; text-align: center"><b>Ответ:</b><br/>'
          ||INITCAP(S_GET_DATE_TIME_TEXT(rec.RESPONSE_DATE_TIME))||'</td>
          <td style="vertical-align: top; text-align: left">'||S_PRINT_TEXT(rec.RESPONSE_TEXT)||'</td></tr>
          ');
      END IF;
      HTP.PRINT('<tr><td colspan="2" style="padding: 5px 0px 5px 0px; border-top: thin solid"></td></tr>');
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
      D_MESSAGES
    WHERE
      D_MESSAGES.RESPONSE_DATE_TIME IS NULL OR pMODE = 'all';
  --
  S_SHOW_PAGE_LIST(
    pPAGE,
    TRUNC((vCOUNT+cITEMS_ON_PAGE-1)/cITEMS_ON_PAGE),
    'ADMIN_MESSAGES?MODE='||pMODE);
--
END;
/
