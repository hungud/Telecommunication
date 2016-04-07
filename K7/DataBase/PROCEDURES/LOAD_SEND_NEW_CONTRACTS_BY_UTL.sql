CREATE OR REPLACE PROCEDURE LOAD_SEND_NEW_CONTRACTS_BY_UTL is
--
--Version= 1
--
--v.1 Афросин 04.03.2015 - Процедура для загрузки новых контрактов по ссылке и отправки сообщений по EMAIL 
--
  conneccRes varchar2(500);
  
  load_result_K7 clob;
  load_result_TELETIE clob;
  
  lengthFirstLine Integer;
 
begin
  
  DBMS_LOB.CREATETEMPORARY(load_result_K7, TRUE);
  DBMS_LOB.CREATETEMPORARY(load_result_TELETIE, TRUE);
  
  conneccRes := LOAD_NEW_CONTRACTS_BY_UTL(sysdate, load_result_K7, load_result_TELETIE);
  --dbms_output.put_line('conneccRes='||conneccRes);
  
  lengthFirstLine := nvl(length(MS_PARAMS.GET_PARAM_VALUE('MAIL_NEW_CONTRACTS_FIRST_LINE')), 0);
  
  if nvl(dbms_lob.getlength (load_result_K7), 0) > lengthFirstLine then
    send_sys_mail ('Загрузка контрактов на ' || TO_CHAR (SYSDATE, 'DD.MM.YYYY'),
                    load_result_K7,
                    'MAIL_NEW_CONTRACTS_K7'
              );
  end if;
  
  if nvl(dbms_lob.getlength (load_result_TELETIE),0) > lengthFirstLine then
    send_sys_mail ('Загрузка контрактов на ' || TO_CHAR (SYSDATE, 'DD.MM.YYYY'),
                    load_result_TELETIE,
                    'MAIL_NEW_CONTRACTS_TELETIE'
              );
  end if;
  
  if instr(conneccRes, 'Ошибка') > 0 then
    send_sys_mail ('Ошибка загрузки контрактов' || TO_CHAR (SYSDATE, 'DD.MM.YYYY'),
                    conneccRes,
                    'MAIL_CHECK_STANDBY'
              );
  end if;
 
  if DBMS_LOB.getLength(load_result_K7) > 0 then
    DBMS_LOB.FREETEMPORARY (load_result_K7);
  end if;
  if DBMS_LOB.getLength(load_result_TELETIE) > 0 then
    DBMS_LOB.FREETEMPORARY (load_result_TELETIE);
  end if;
  
end;  