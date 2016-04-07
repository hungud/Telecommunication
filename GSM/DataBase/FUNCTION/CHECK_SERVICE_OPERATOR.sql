CREATE OR REPLACE FUNCTION CHECK_SERVICE_OPERATOR RETURN INTEGER IS 

  --Version 1
  --
  --v.1 Алексеев 28.10.2015 Функция проверки работы сервиса по определению оператора на номере
  
  vRESULT INTEGER;
  vOperName varchar2(2000 char);
BEGIN
  vRESULT := 0;
  begin
    vOperName := GET_OPERATOR_BY_PHONE('9035523338');
    
    if vOperName = 'Билайн' then
      vRESULT := 1;
    end if;   
  exception
    when others then
      vRESULT := 0;  
  end;
  
  return vRESULT;
END;