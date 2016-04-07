create or replace procedure captcha_test_2(
  captcha in varchar2,
  ID IN VARCHAR2,
  TEST IN VARCHAR2
  ) is
--#Version=1
--
  ParamKey constant varchar2(32) := 'C07EDBB8B4C64998A8EC203F7DA2CD4C';	-- Секретный ключ
  ParamEXOcaptchaTestURL constant varchar2(50) := 'http://www.e-xo.ru/cgi-bin/captchatest.dll'; -- Адрес для проверки введенного кода с картинки
  URL VARCHAR2(512 CHAR);
  vPARAM_TYPE VARCHAR2(1 CHAR) := '';
  vRESULT VARCHAR2(1024 CHAR);
begin
  NULL;
  HTP.PRINT('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1251">
<title>Проверка капчи</title>
</head>
<body>
');
  URL := ParamEXOcaptchaTestURL || '?captcha=' || Captcha || '&id=' || ID || '&key=' || ParamKey || '&type=' || vPARAM_TYPE || '&test=' || TEST;
  --HTP.PRINT(URL);
  BEGIN
    vRESULT := SUBSTR(UTL_HTTP.REQUEST(URL), 1, 1024);
  EXCEPTION WHEN OTHERS THEN
    vRESULT := -1;
  END;
  IF vRESULT = '0' THEN
    HTP.PRINT('Правильно!');
  ELSIF vRESULT = '1' THEN
    HTP.PRINT('Ошибка!');
  ELSE
    HTP.PRINT('Проверить не удалось!');
  END IF;
  --HTP.PRINT(vRESULT);
  HTP.PRINT('</body>
</html>
');
end;
/
