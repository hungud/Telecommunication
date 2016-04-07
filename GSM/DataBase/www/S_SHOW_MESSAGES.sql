CREATE OR REPLACE PROCEDURE LONTANA_WWW.S_SHOW_MESSAGES IS

  --Version 3
  --
  --v.3 Алексеев. 27.11.2015. Отделил надпись "Появились вопросы? Напиши оператору (on-line):" от окно диалога полосой.
  --v.2 Алексеев. 18.11.2015. Открыл доступ всем операторам. Закометил лишний код, на текущий момент не исп.
  --v.1 Алексеев. 05.11.2015. Функция показа чата на стороне абонента. Отправка сообщения
  
  pSHOW_ALL_MESSAGES BOOLEAN := FALSE;
  vMORE_EXISTS BOOLEAN := FALSE;
BEGIN
  IF (G_STATE.USER_ID IS NOT NULL) THEN --AND ((nvl(G_STATE.USER_ID, 0) = 139587) or (nvl(G_STATE.USER_ID, 0) = 33151))
    HTP.PRINT('
    <SCRIPT>
        var chat_request_id;
    var phones_request_id;
    var xmlhttp_chat_text;
    var xmlhttp_chat_contragents;
    var xmlhttp_check_new_messages;
    
          function getXmlHttp(){
      try {
        return new ActiveXObject("Msxml2.XMLHTTP");
      } catch (e) {
        try {
          return new ActiveXObject("Microsoft.XMLHTTP");
        } catch (ee) {
        }
      }
      if (typeof XMLHttpRequest!=''undefined'') {
        return new XMLHttpRequest();  
      }
    }
    
    function ResetChatTextXMLHTTP() {
      /*alert(''ResetChatTextXMLHTTP'');*/
      if (typeof xmlhttp_chat_text == ''undefined'') {
         xmlhttp_chat_text = getXmlHttp();        
      } else {
        try {
          xmlhttp_chat_text.abort();
          /* xmlhttp_chat_text = undefined; */
        }
        catch(e) {
          alert("Ошибка при отмене запроса на список сообщений." + e.name + " : " + e.message);
        };
      };
      /* xmlhttp_chat_text = getXmlHttp(); */
    };       
        
        var chat_abonent_request_id;
    
    function ShowChatText(pABONENT_USER_ID, pSERVER_LAST_CHECK_DATE_TIME) {
      /*var xmlhttp_chat_text;
      xmlhttp_chat_text = getXmlHttp();*/        
      ResetChatTextXMLHTTP();
      /*alert(pABONENT_USER_ID);*/
      /*alert(pSERVER_LAST_CHECK_DATE_TIME);*/
      var vURL = "SHOW_USER_CHAT_TXT?pABONENT_USER_ID="+pABONENT_USER_ID+"&pDATE_LAST_CHECK="+pSERVER_LAST_CHECK_DATE_TIME;
      
      /* увеличим текущий номер запроса к серверу и запомним его в переменную */
      var vCHAT_REQUEST_ID;
      if (chat_abonent_request_id == undefined) {
        chat_abonent_request_id = 1;
      } else {
        chat_abonent_request_id = chat_abonent_request_id + 1;
      };
      vCHAT_REQUEST_ID = chat_abonent_request_id;
      xmlhttp_chat_text.open("GET", vURL);
      xmlhttp_chat_text.onreadystatechange = function() {
          if (xmlhttp_chat_text.readyState == 4) {
            if(xmlhttp_chat_text.status == 200) {
              /*alert("RETURN ShowChatText("+ pABONENT_USER_ID + ", " + pSERVER_LAST_CHECK_DATE_TIME + ")  vCHAT_REQUEST_ID = " + vCHAT_REQUEST_ID  + " chat_abonent_request_id = " + chat_abonent_request_id + " result = ''" + xmlhttp_chat_text.responseText + "''");*/
              /* если это результат последнего запроса и окно чата открыто */
              var vResponse = xmlhttp_chat_text.responseText;
              if (chat_abonent_request_id == vCHAT_REQUEST_ID && vResponse != "") {
                /* в конце сообщения 19 символов - дата последнего сообщения и в конце один не значащий символ */
                 /*alert(document.getElementById(''abonent_chat_messages_text'').childNodes[1]);*/
                var tbody = document.getElementById(''abonent_chat_messages_text'').childNodes[1];
                /* пришедший текст добавляем к существующим сообщениям */   
                tbody.innerHTML = tbody.innerHTML + vResponse.slice(0, -20);
                /*alert(''2'');  */
                /* скроллируемся до последнего сообщения */
                document.getElementById("abonent_chat_messages").scrollTop = document.getElementById("abonent_chat_messages").scrollHeight;                            
                /*alert("BEFORE ShowChatText" + " vCHAT_REQUEST_ID = " + vCHAT_REQUEST_ID + " chat_abonent_request_id = " + chat_abonent_request_id);*/
                setTimeout(
                  function() { 
                    ShowChatText(pABONENT_USER_ID, vResponse.slice(-20, -1)) 
                  }, 10);
              } else {
                /*alert("Загрузка отменена. ("+ pABONENT_USER_ID + ", " + pSERVER_LAST_CHECK_DATE_TIME + ")  vCHAT_REQUEST_ID = " + vCHAT_REQUEST_ID  + " chat_abonent_request_id = " + chat_abonent_request_id + " result = ''" + xmlhttp_chat_text.responseText + "''");*/
              };
            } else if (xmlhttp_chat_text.status == 0) {
              /* ничего не выводим, этот случай, когда произошел abort или потерялас связь с сервером, различить их пока не понятно как */
            } else {
              alert("Ошибка отображения списка сообщений " + xmlhttp_chat_text.status + ". " + xmlhttp_chat_text.statusText);
            };                      
          };
      };
      xmlhttp_chat_text.send(null);
    };
</script>

    <script>
        function SendAbonentMessage(pFROM_USER_ID, pMESSAGE_TEXT) {
          var xmlhttp = getXmlHttp();
          var vURL = "SEND_USER_MESSAGE?pFROM_USER_ID="+pFROM_USER_ID+"&pMESSAGE_TEXT="+pMESSAGE_TEXT;
          xmlhttp.open("GET", vURL);
          xmlhttp.onreadystatechange = function() {
          /*alert("SendAbonentMessage");*/
              if (xmlhttp.readyState == 4) {
                if(xmlhttp.status == 200) {
                  var vResult = xmlhttp.responseText;
                  if (vResult == "") {
                    document.getElementById("abonent_chat_messages_result").innerHTML = "";
                    document.getElementById("abonent_chat_messages_result").style.display = "none";
                  }
                  else
                  {
                    document.getElementById("abonent_chat_messages_result").innerHTML = xmlhttp.responseText;
                    document.getElementById("abonent_chat_messages_result").style.display = "block";
                  };

                  document.getElementById("abonent_post_message").disabled = false;
                  document.getElementById("pMESSAGE_TEXT").disabled = false;
                  document.getElementById("pMESSAGE_TEXT").value = "";
                } else {
                  document.getElementById("abonent_post_message").disabled = false;
                  document.getElementById("pMESSAGE_TEXT").disabled = false;
                  alert("Ошибка отправки собщения " + xmlhttp.status + ". " + xmlhttp.statusText);
                };                      
              };
          };
          document.getElementById("abonent_post_message").disabled = true;
          document.getElementById("pMESSAGE_TEXT").disabled = true;
          
          xmlhttp.send(null);   
        };
    </SCRIPT>
    ');

    /*IF pMESSAGE_TEXT_SUBMIT IS NOT NULL
      AND pMESSAGE_TEXT IS NOT NULL THEN
      -- Защищаем от двойного сохранения
      OPEN C_DUPLICATE(G_STATE.USER_ID);
      FETCH C_DUPLICATE INTO vDUMMY;
      IF C_DUPLICATE%NOTFOUND THEN
        INSERT INTO D_INSTANT_MESSAGES (SENDER_USER_ID, MESSAGE_DATE_TIME, TEXT)
        VALUES (G_STATE.USER_ID, SYSDATE, pMESSAGE_TEXT);
        COMMIT;
      END IF;
    END IF;*/
    
    HTP.PRINT('
        </div>
          <div id="cont0" style="padding-bottom: 5px; border-bottom-style: solid; border-bottom-width: 1px; background-color: #FBFBFB;">
          <h5>Появились вопросы? Напиши оператору (on-line):</h5>');
              
    HTP.PRINT('
        </div>
        <div id="abonent_chat_messages" style="border: thin none; padding: 10px; max-height: 100px; overflow-y: auto;background-color: #FBFBFB;">
        <table id="abonent_chat_messages_text" style="margin-bottom: 5px;">
        <tbody>
        </tbody></table>
          ');  
          
   /* IF pSHOW_ALL_MESSAGES THEN
      HTP.PRINT('<a href="MESSAGES?'||G_STATE.SESSION_KEY_PARAM_1||'">Показать последние</a>');
    ELSIF vMORE_EXISTS THEN
      HTP.PRINT('<a href="MESSAGES?SHOW_ALL_MESSAGES=1'||G_STATE.SESSION_KEY_PARAM_2||'">Показать все</a>');
    END IF;*/
   
    -- Написать сообщение (форма)
    HTP.PRINT(
    '</div>
    <div id="cont"> 
    <div style="border: thin solid; padding: 0px;">
    <!--<form action="messages" method="post" accept-charset="windows-1251">
    <input type="hidden" name="SESSION_ID" value="'||G_STATE.SESSION_ID||'" />-->
    <table border="0" cellpadding="1" cellspacing="1" bgcolor="#F0F0F0">
      <tr>
        <td style="padding: 10px">
          <textarea name="message_text" id="pMESSAGE_TEXT" rows="5" cols=150; style="width: 100%; height: 50px" ></textarea>
        </td>
      </tr>
      <tr>
        <td align="right" style="padding: 5px;">
          <!--<input type="submit" style="cursor: hand;" id="abonent_post_message" name="message_text_submit" value="Отправить" />-->
          <!--<input type="reset"  style="cursor: hand;" name="message_text_cancel" value="Отмена" />-->
          <button type="button" id="abonent_post_message" onclick="SendAbonentMessage('||G_STATE.USER_ID||', document.getElementById(''pMESSAGE_TEXT'').value);">Отправить</button>
        </td>
      </tr>
    </table>
    <!--</form>-->
    <div id="abonent_chat_messages_result" style="display: none; "></div>  
    </div>

    <script>
      ShowChatText('||G_STATE.USER_ID||', '''');
    </script>
    ');
  END IF;
END;