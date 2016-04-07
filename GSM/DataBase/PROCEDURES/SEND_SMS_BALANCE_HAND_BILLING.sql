CREATE OR REPLACE PROCEDURE SEND_SMS_BALANCE_HAND_BILLING IS

 CURSOR C IS
   SELECT DATE_BILLING, COST, PHONE_NUMBER_TARIFER, PHONE_NUMBER_CLIENT, CONTRACT_ID, GET_ABONENT_BALANCE_K( PHONE_NUMBER_TARIFER, DATE_BILLING) bal 
       FROM BALANCE_HAND_BILLING 
     where SEND_SMS = 0
      and nvl(PHONE_NUMBER_CLIENT,0) <> 0;

 SMS       VARCHAR2 (2000);
 TXT       VARCHAR2 (2000);
 
BEGIN

  for vREC in C
  loop
   
     TXT := 'Ув.абонент! '|| to_char(vREC.DATE_BILLING,'dd.mm.yyyy')|| ' с Вашего счета была списана абон.плата в размере '||to_char (ROUND (vRec.COST, 2), 'fm99990.00')||
            ' р.  Баланс:'|| to_char (ROUND (vRec.bal, 2), 'fm99990.00')||' р. Напоминаем, что необходимо внести ежемесячный платёж за услуги доступа в интернет. т.05455. Пополняй баланс без комиссии на сайте www.gsmcorporacia.ru/oplata_uslug и через приложение www.gsmcorp.ru/m';
      
     SMS :=
               LOADER3_pckg.SEND_SMS (vREC.PHONE_NUMBER_CLIENT,
                                      'Смс-оповещение',TXT);
               
      update BALANCE_HAND_BILLING bhb
         set
             SEND_SMS = 1,
             DATA_SEND_SMS = sysdate
         where  bhb.CONTRACT_ID = vREC.CONTRACT_ID
       and  bhb.PHONE_NUMBER_TARIFER = vREC.PHONE_NUMBER_TARIFER;
                               
  end loop;
  commit;
 
END SEND_SMS_BALANCE_HAND_BILLING;
/
