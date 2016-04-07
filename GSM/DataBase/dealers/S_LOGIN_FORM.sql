CREATE OR REPLACE procedure WWW_DEALER.s_login_form(
  pPHONE_NUMBER IN VARCHAR2 DEFAULT NULL,
  LOGIN_ERROR_TEXT IN VARCHAR2 DEFAULT NULL
  ) is
PHONE_NUMBER VARCHAR2(20 CHAR);  
begin
  PHONE_NUMBER:=pPHONE_NUMBER;
  HTP.PRINT('
        <div id="content_login">
          <div class="right" id="info_form_container">
            <img src="IMG_INFO_FORM_TOP" title="" alt="" />
            <div id="info_form">
              <h5  class="align_center">Тех. поддержка для дилеров</h5>
              <ul id="support_ul">
                <li id="support_li_phone">
                  Телефон службы по работе с клиентами<br /><b>8-495-788-7908<br />8-495-648-7888</b>
                </li>
                <li id="support_li_email">
                  E-mail службы по работе с клиентами<br />
                  <a id="support_a" href="mailto:info@gsmcorporacia.ru">info@<br/>gsmcorporacia.ru</a>
                </li>
              </ul>
            </div>
            <img src="IMG_INFO_FORM_BOTTOM" title="" alt="" />
          </div>
          <div id="auth_form_container">
            <img src="IMG_AUTH_FORM_TOP" title="" alt="" />
            <form id="auth_form" method="post" action="MAIN" accept-charset="windows-1251">
              <h2>Вход</h2>');
  IF LOGIN_ERROR_TEXT IS NOT NULL THEN
    OUT_ERROR(LOGIN_ERROR_TEXT);
  END IF;
  HTP.PRINT('
              <div class="col_130 left">
                <label><b>Пользователь:</b></label>
                <label><b>Пароль:</b></label>
              </div>
              <div class="col_190 right">
                <input type="text" name="X_username" value="'||PHONE_NUMBER||'" style="border: 0px" />
                <input type="password" name="X_password" style="border: 0px" />
                <!--a href="restore_password" title="" id="forgot_password_link">Забыли пароль?</a-->
                <input type="submit" id="auth_form_enter_button" value="Войти" style="border: 0px" />
              </div>
            </form>
            <img src="IMG_AUTH_FORM_BOTTOM" title="" alt="" style="border: 0px" />
          </div>
        </div>');
END;
/
