CREATE OR REPLACE PROCEDURE SEND_SMS_PHONE_CONTRACT_VIP IS
 tmpVar NUMBER;
 CURSOR C IS
  select phone_number, contract_id  
    from TABLE(get_PHONE_CONTRACT_VIP()) ;
 
 CURSOR D IS
  select phone_number, contract_id 
    from VIP_SEND_SMS
   where  DATE_SEND_SMS is null;
   
 SMS       VARCHAR2 (2000);
 
BEGIN


  for vREC in C
  loop
    select count(*) into tmpVar
      from VIP_SEND_SMS vss      
     where  vss.CONTRACT_ID = vREC.CONTRACT_ID
       and  vss.PHONE_NUMBER = vREC.PHONE_NUMBER;
    if tmpVar = 0 then
      INSERT INTO VIP_SEND_SMS (CONTRACT_ID, PHONE_NUMBER)
                        VALUES (vREC.CONTRACT_ID, vREC.PHONE_NUMBER);
    end if;    
  end loop;
 
  for vREC in D
  loop
      SMS :=
               LOADER3_pckg.SEND_SMS (vREC.phone_number,
                                      'Смс-оповещение',
                                      'Уважаемый абонент! Рады сообщить, что теперь Вы являетесь VIP-клиентом GSMCORP. Подробности: http://www.gsmcorporacia.ru/vip/ или 05455');
      update VIP_SEND_SMS vss
         set
             DATE_SEND_SMS = sysdate()
         where  vss.CONTRACT_ID = vREC.CONTRACT_ID
       and  vss.PHONE_NUMBER = vREC.PHONE_NUMBER;
                               
  end loop;

 
END SEND_SMS_PHONE_CONTRACT_VIP;



/
