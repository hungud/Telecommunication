CREATE OR REPLACE procedure LONTANA_WWW.S_RESTORE_PASSWORD_FORM(
  x_username in varchar2 DEFAULT NULL,
  captcha in varchar2 DEFAULT NULL,
  ID IN VARCHAR2 DEFAULT NULL,
  TEST IN VARCHAR2 DEFAULT NULL
  ) is
--  
-- 
--Version#3
--
-- Внимание! если перестала работать каптча, то возможно сервис поменял ключи. Для этого достаточно на сайте получить новые.
-- 
-- 3. 19.11.2015 - Матюнин И.-  Изменились ключи при работе с каптчей. 
-- 2 Крайнов. Установка не более 3-х попыток в сутки.
-- 1 Крайнов. Создание
  ParamCaptcha constant varchar2(32) := 'E10DA9977BB14DA9A5FA45B33AECA66E'; --'6A2EA9E0CA6541DDBD2F0EAAE108FF22';-- новый публичный ключ --'C9CF53FCE96549A8AB703D7ADD481007'; -- Публичный ключ EXOCAPTCHA
  ParamEXOcaptchaURL constant varchar2(50) := 'http://www.e-xo.ru/cgi-bin/captcha.dll'; -- Адрес для формирования картинки EXOCAPTCHA
  new_id VARCHAR2(32);
  ParamKey constant varchar2(32) := 'F67D5DA9FFB04156BBBFDCFBAD7C8069'; --'C07EDBB8B4C64998A8EC203F7DA2CD4C';  -- ????????? ????
  ParamEXOcaptchaTestURL constant varchar2(50) := 'www.e-xo.ru/cgi-bin/captchatest.dll'; -- ????? ??? ???????? ?????????? ???? ? ????????
  URL VARCHAR2(512 CHAR);
  vPARAM_TYPE VARCHAR2(1 CHAR) := '';
  vRESULT VARCHAR2(1024 CHAR);
  VARIANT INTEGER;
  VARSTR VARCHAR2(30);
  PASSW VARCHAR2(100);
  ITOG VARCHAR2(2000);

  v_username VARCHAR2(100 CHAR);
begin
  v_username := REPLACE(SUBSTR(x_username, 1, 100), '+7', '');  

  VARSTR:='';
    --URL := ParamEXOcaptchaTestURL || '?captcha=' || Captcha || '=' || ID || '=' || ParamKey || '=' || vPARAM_TYPE || '=' || TEST;
    URL := ParamEXOcaptchaTestURL || '?captcha=' || Captcha || '&id=' || ID || '&test=' || TEST || '&key=' || ParamKey;
  --HTP.PRINT(URL);
  BEGIN
    vRESULT := SUBSTR(UTL_HTTP.REQUEST(URL), 1, 1024);
  EXCEPTION WHEN OTHERS THEN
    vRESULT := -1;
  END;
   
  --------------------------------------------------------------------
  --убрать этот блок! сделан для проверки!
--  IF v_username = '9035523338' THEN  -- тестовый номер
--    vRESULT :='0';
--  END IF;
  --------------------------------------------------------------------
  
  IF v_username IS NULL THEN 
    VARIANT:=1;
  ELSE 
    IF LONTANA.WWW_GET_RESTORE_PASSWORD(v_username)=1 THEN
      IF vRESULT='0' THEN
        VARIANT:=0;
      ELSIF vRESULT = '1' THEN
        VARIANT:=2;
      END IF;
    ELSE  
      VARIANT:=3; 
    END IF;
  END IF;
  
  HTP.PRINT('
        <div id="content">
          <div id="auth_form_container">
            <img src="IMG_AUTH_FORM_TOP" title="" alt="" />
            <a href="main" id="auth_from_close_button"></a>                      
            <form id="auth_form">
              <h2>Восстановление пароля</h2>');
  IF VARIANT=0 THEN 
    VARIANT:=0;---------------------------------------
    PASSW:=SQL_SET_USER_PASSWORD(v_username);
    IF PASSW='Ошибка доступа' THEN
      HTP.PRINT('
              <p><b>Вы использовали все 3 попытки.<br> Доступ к сервису <font color=red><b>закрыт</b></font> до завтра.</b></p>');
    ELSE
      ITOG:=LONTANA.LOADER3_PCKG.SEND_SMS(v_username,'Новый пароль','Новый пароль к личному кабинету для вашего сотового:'||PASSW);
      IF ITOG IS NULL THEN
        HTP.PRINT('
              <p><b>Новый пароль отправлен в СМС на телефон +7' || v_username || '</b></p>
              <a href="main" title="" class="balance_info">Войти</a>');
  --      S_LOGIN_FORM(v_username);      
      ELSE
        HTP.PRINT('
              <p><b>Ошибка отправки СМС на ваш телефон.</b></p>');
      END IF;
    END IF;
  
  ELSIF VARIANT IS NULL THEN 
  -- это когда каптча вдруг начинает работать криво (или ,например, когда слетает доступ в ACL для сайта каптчи) 
    HTP.PRINT('
              <p><b>Сервис получения нового пароля временно недоступен. Обратитесь в службу поддержки!</b></p>');
  
  ELSIF VARIANT=1 THEN  
  -- не указали номер, просим указать номер
    HTP.PRINT('
              <p><b>Пожалуйста, укажите номер телефона!</b></p>');
  
  ELSE
    IF VARIANT=2 THEN
      HTP.PRINT('
              <p><b>Код с картинки указан неправильно.<br/>Попробуйте ещё раз.</b></p>');
    END IF;
    IF VARIANT=3 THEN
      HTP.PRINT('
              <p><b>Данный номер не обслуживается.</b></p>');
    END IF;    
    FOR I IN 1..32 LOOP
      NEW_ID := NEW_ID || TRUNC(DBMS_RANDOM.VALUE(0, 10)); -- СЛУЧАЙНОЕ 32-ЗНАЧНОЕ 16-РИЧНОЕ ЧИСЛО
    END LOOP;
    HTP.PRINT('
                <script language="JavaScript" type="text/javascript">
                <!--// Функция обновления картинки с кодом
                function exonew() {
                var rnd = "";
                for (var i = 0; i < 32; i++)
                  rnd += parseInt(Math.random() * 10).toString(16);
                document.images["exocaptcha"].src="' || ParamEXOcaptchaURL || '?captcha=' || ParamCaptcha || '&id="+ rnd;
                //document.images["exocaptcha"].src="' || ParamEXOcaptchaURL || '?captcha=' || ParamCaptcha || '&id=' || New_ID || '=" + rnd;
                //document.images["exocaptcha"].src="' || ParamEXOcaptchaURL || '?captcha=' || ParamCaptcha || '=' || New_ID || '";
                //document.getElementById("id").value = rnd;
                }
                //-->
                </script>');
    htp.print('
              <div class="col_130 left">
                <label><b>Номер телефона:</b></label>
                <img src="' || ParamEXOcaptchaURL || '?captcha=' || ParamCaptcha || '&id=' || New_ID || '" alt="EXOCAPTCHA" name="exocaptcha" border="0" id="auth_captcha" class="left"/>
                <a href="javascript:exonew()" title="" id="reload_captcha"><span>Другую картинку</span></a>
                <input name="captcha" type="hidden" value="' || ParamCaptcha || '">
                <input id="id" name="id" type="hidden" value="' || New_ID || '">
              </div>
              <div class="col_190 right">
                <input type="text" title="Введите номер телефона в формате +7xxxxxxxxxx. Например +79012345678" placeholder="+7xxxxxxxxxx" name="x_username" value="+7" style="border: 0px"/>
                <input name="test" type="text" size="10" class="captcha" style="border: 0px" />
                <p id="enter_captcha_text">Введите код с картинки</p>
                <input type="submit" id="auth_form_send_pass_button" class="button" value="Выслать пароль" />
              </div>');              
  END IF;
  HTP.PRINT('
            </form>
            <img src="IMG_AUTH_FORM_BOTTOM" title="" alt="" />
          </div>
        </div>');
END;
/
