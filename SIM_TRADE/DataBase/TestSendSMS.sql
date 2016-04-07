declare 
sms varchar2(300 char);
begin
  sms:=loader3_pckg.SEND_SMS('9276561268', 'AgSvyazi','Баланс Вашего счета менее 400р Во избежание блокировки пополните счет. Проверка баланса *132*11# вызов. Абонентский отдел +74957378081');
  dbms_output.PUT_LINE(sms);
end;  