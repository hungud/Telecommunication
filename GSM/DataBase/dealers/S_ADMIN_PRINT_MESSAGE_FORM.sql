CREATE OR REPLACE PROCEDURE S_ADMIN_PRINT_MESSAGE_FORM(
  pMESSAGE_ID IN INTEGER
  ) IS
BEGIN
  HTP.PRINT('
<form action="admin_post_message" method="post">
  <input type="hidden" name="SESSION_ID" value="'||G_STATE.SESSION_ID||'" />
  <input type="hidden" name="MESSAGE_ID" value="'||pMESSAGE_ID||'" />
  <textarea id="response_text_'||pMESSAGE_ID||'" name="RESPONSE_TEXT" cols="50" rows="10">
Уважаемый дилер!
</textarea>
  <br /><br />
  <input type="submit" name="SEND_RESPONSE" value="Отправить"/>
</form>');
END;
/
