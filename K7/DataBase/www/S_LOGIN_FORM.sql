CREATE OR REPLACE procedure LONTANA_WWW.s_login_form(
  pPHONE_NUMBER IN VARCHAR2 DEFAULT NULL,
  LOGIN_ERROR_TEXT IN VARCHAR2 DEFAULT NULL
  ) is
PHONE_NUMBER VARCHAR2(20 CHAR);  
begin
  IF pPHONE_NUMBER IS NULL THEN
    PHONE_NUMBER:='+7';
  ELSE
    PHONE_NUMBER:=pPHONE_NUMBER;
  END IF;
  HTP.PRINT('
        <div id="content_login">
          <div class="right" id="info_form_container">
            <img src="IMG_INFO_FORM_TOP" title="" alt="" />
            <form id="info_form">
              <h5  class="align_center">Тех. поддержка<br>для клиентов<br></h5>
              <ul id="support_ul">
                <li id="support_li">
                  Телефон службы <br> по работе с клиентами <br> <b>8-495-788-7908</b> <b>8-495-648-7888</b>
                </li>
                <li id="support_li">
                  Факс службы <br> по работе с клиентами <br> <b>8-495-788-7908</b>
                </li>
                <li id="support_li">
                  E-mail службы <br> по работе с клиентами <br>
                  <a id="support_a" href="mailto:info@gsmcorporacia.ru">info@gsm<br>corporacia.ru</a>
                </li>
              </ul>
            </form>
            <img src="IMG_INFO_FORM_BOTTOM" title="" alt="" />
          </div>
          <div id="auth_form_container">
            <img src="IMG_AUTH_FORM_TOP" title="" alt="" />
            <form id="auth_form" action="MAIN" method="POST">
              <h2>Авторизация</h2>');
  IF LOGIN_ERROR_TEXT IS NOT NULL THEN
    HTP.PRINT('
              <p class="phone_number"><b>' || LOGIN_ERROR_TEXT || '</b></p>');
  END IF;
  HTP.PRINT('
              <div class="col_130 left">
                <label><b>Номер телефона:</b></label>
                <label><b>Пароль:</b></label>
              </div>
              <div class="col_190 right">
                <input type="text" title="Введите номер телефона в формате +7xxxxxxxxxx. Например +79012345678" placeholder="+7xxxxxxxxxx" name="X_username" value="'||PHONE_NUMBER||'" style="border: 0px" />
                <input type="password" name="X_password" style="border: 0px" />                
                <a href="restore_password" title="" id="forgot_password_link">Забыли пароль?</a>
                <input type="submit" id="auth_form_enter_button" value="Войти" />
              </div>
            </form>
            
            <img src="IMG_AUTH_FORM_BOTTOM" title="" alt="" style="border: 0px" />
          </div>
        </div>');
END;
/
