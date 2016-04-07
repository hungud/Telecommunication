CREATE OR REPLACE procedure p_new_tarif(
  pTARIFF_ID in INTEGER
  ) is --идентификатор тарифа
--
begin
  INSERT INTO QUEUE_CURRENT_BALANCES(PHONE_NUMBER, QUEUE_TYPE)
    select distinct(C.PHONE_NUMBER_FEDERAL) phone_NUMBER, 51 QUEUE_TYPE 
      from contracts c, 
           contract_cancels cc       
      where c.CONTRACT_ID = cc.CONTRACT_ID(+)
        and C.CURR_TARIFF_ID = pTARIFF_ID;
  commit;
end p_new_tarif;
/
