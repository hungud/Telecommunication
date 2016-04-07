CREATE OR REPLACE FUNCTION F_USSD_CHANGE_PP (pPHONE_NUMBER VARCHAR2, pUSSD_CODE VARCHAR2)
  RETURN VARCHAR2
  AS
--
--Version=2
--
--v.2 20.10.2015 Афросин включил поддержу смены для телетая
--v.1 09.07.2015 Афросин добавил функцию для обработки заявок на смену тарифа по USSD
  
  PRAGMA AUTONOMOUS_TRANSACTION;
  vRes varchar2(50 char);
  ct INTEGER;
begin

  vRes := 'Ваша заявка принята в работу.';
  
  select
    count(*) into ct
  from
    USSD_CHANGE_PP_QUEUE
  where 
    PHONE_NUMBER = pPHONE_NUMBER;
    --AND USSD_CODE = pUSSD_CODE;
        
  IF CT > 0 THEN
    vRes := 'Ваша предыдущая заявка еще не обработана.';
  ELSE   
    INSERT INTO USSD_CHANGE_PP_QUEUE (PHONE_NUMBER, USSD_CODE)
    VALUES (pPHONE_NUMBER, pUSSD_CODE);
  END IF;

  COMMIT;
  RETURN vRes;
end; 

GRANT EXECUTE on F_USSD_CHANGE_PP TO USSD_USER;
