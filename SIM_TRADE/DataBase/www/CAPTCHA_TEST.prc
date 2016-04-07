create or replace procedure captcha_test is
--#Version=1
--
  ParamCaptcha constant varchar2(32) := 'C9CF53FCE96549A8AB703D7ADD481007'; -- Публичный ключ EXOCAPTCHA
  ParamEXOcaptchaURL constant varchar2(50) := 'http://www.e-xo.ru/cgi-bin/captcha.dll'; -- Адрес для формирования картинки EXOCAPTCHA
  new_id VARCHAR2(32);
begin
  for i in 1..32 loop
    new_id := new_id || TRUNC(dbms_random.VALUE(0, 10)); -- случайное 32-значное 16-ричное число
  end loop;
  htp.print('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1251">
<title>Ввод капчи</title>
</head>
<script language="JavaScript" type="text/javascript">
<!--// Функция обновления картинки с кодом
function exonew() {
var rnd = "";
for (var i = 0; i < 32; i++)
  rnd += parseInt(Math.random() * 10).toString(16);
  document.images["exocaptcha"].src="' || ParamEXOcaptchaURL || '?captcha=' || ParamCaptcha || '&id=' || New_ID || '&rnd=" + rnd;
//document.images["exocaptcha"].src="' || ParamEXOcaptchaURL || '?captcha=' || ParamCaptcha || '&id=' || New_ID || '";
//document.getElementById("id").value = rnd;
}
//-->
</script>
<body>
<table border="0" cellpadding="2" cellspacing="2" bgcolor="#F0F0F0">
  <form name="form1" method="get" action="captcha_test_2">
    <tr>
      <td align="right" valign="middle"><a href="javascript:exonew()"><img src="http://www.e-xo.ru/images/refresh.gif" alt="обновить" width="17" height="17" border="0"></a></td>
      <td align="left"><img src="' || ParamEXOcaptchaURL || '?captcha=' || ParamCaptcha || '&id=' || New_ID || '" alt="EXOCAPTCHA" name="exocaptcha" border="0" id="exocaptcha"> </td>
    </tr>
    <tr valign="middle">
      <td align="right">Код:</td>
      <td align="left"><input name="test" type="text" size="10">
        (указанный на картинке) </td>
    </tr>
    <tr>
      <td align="center"><input name="captcha" type="hidden" value="' || ParamCaptcha || '">
        <input id="id" name="id" type="hidden" value="' || New_ID || '"></td>
      <td align="left"><input type="submit" value="Проверить"></td>
    </tr>
  </form>
</table>
</body>
</html>
');
end;
/
