
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."GET_INOUT_CALLBACK_TEST" (pPHONEA IN VARCHAR2)
  RETURN varchar2 IS
  --#Version=1
 -- PRAGMA AUTONOMOUS_TRANSACTION;
  INOUT_CALLBACK_TXT  VARCHAR2(300 CHAR);
  SMS varchar2(2000);
 -- ussd_text varchar2(16);

BEGIN
    begin
    --SMS := loader3_pckg.SEND_SMS('9276093052','TELETIE_PAY_SMS','Тест 130');
    
     INOUT_CALLBACK_TXT:='Тест. У Вас подключена опция "Тест" *132*130#. ';
    exception
      when others then
      INOUT_CALLBACK_TXT:='Неверный запрос. *132*130# ';
    end;
  return INOUT_CALLBACK_TXT;

end;
