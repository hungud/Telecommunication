CREATE OR REPLACE PROCEDURE RECALC_PHONE_TARIF IS
  
  --Version 2
  --
  --v.2 Алексеев. 10.11.2015 Исправил обновление тарифа в таблице контрактов.
  --                                      До этого обновлялись все контракты по номеру и это не правильно.
  --                                      Ограничил обновление только неотмененным контрактом.
  --v.1
  
  pcurr_tariff_id INTEGER;
BEGIN
   /*DBMS_OUTPUT.PUT_LINE('0 '||to_char(sysdate,'dd.mm.yyyy hh:mi:ss'));
   DBMS_OUTPUT.PUT_LINE('-----------------');*/
   FOR recSERVICES IN (SELECT PHONE_NUMBER 
                         FROM PHONES_TARIF_FOR_RECALC RE)
   LOOP 
     --DBMS_OUTPUT.PUT_LINE('1 '||to_char(sysdate,'dd.mm.yyyy hh:mi:ss')|| ' - ' ||recSERVICES.PHONE_NUMBER);
     pCURR_TARIFF_ID:=GET_CURR_PHONE_TARIFF_ID(recSERVICES.PHONE_NUMBER);
     --DBMS_OUTPUT.PUT_LINE('2 '||to_char(sysdate,'dd.mm.yyyy hh:mi:ss'));
     --UPDATE CONTRACTS CON SET CON.CURR_TARIFF_ID=pCURR_TARIFF_ID WHERE CON.PHONE_NUMBER_FEDERAL = recSERVICES.PHONE_NUMBER;
     UPDATE CONTRACTS CON 
        SET CON.CURR_TARIFF_ID=pCURR_TARIFF_ID 
      WHERE CON.PHONE_NUMBER_FEDERAL = recSERVICES.PHONE_NUMBER
          AND NOT EXISTS (SELECT 1
                            FROM CONTRACT_CANCELS CC
                           WHERE CC.CONTRACT_ID = CON.CONTRACT_ID);
     --DBMS_OUTPUT.PUT_LINE('3 '||to_char(sysdate,'dd.mm.yyyy hh:mi:ss'));
     DELETE PHONES_TARIF_FOR_RECALC 
     WHERE PHONE_NUMBER=recSERVICES.PHONE_NUMBER;
     --DBMS_OUTPUT.PUT_LINE('4 '||to_char(sysdate,'dd.mm.yyyy hh:mi:ss'));
     COMMIT;
     --DBMS_OUTPUT.PUT_LINE('-----------------');
   END LOOP;

END;