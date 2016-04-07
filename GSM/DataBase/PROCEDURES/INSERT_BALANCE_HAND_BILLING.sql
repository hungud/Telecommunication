CREATE OR REPLACE PROCEDURE INSERT_BALANCE_HAND_BILLING AS
begin

merge into balance_hand_billing bhb
 using (
        SELECT 
          to_date(to_char(c.CONTRACT_DATE, 'dd')||'.'||to_char(sysdate, 'mm.yyyy'),'dd.mm.yyyy') dt, 
          case 
          when nvl(TR.MONTHLY_PAYMENT,0) = 0 then nvl(TR.DAYLY_PAYMENT,0) * to_number(to_char(last_day(sysdate), 'dd')) 
          else nvl(TR.MONTHLY_PAYMENT,0) end PAY,
          c.PHONE_NUMBER_FEDERAL,    
          c.CONTRACT_ID,
          nvl(cbc.PHONE_NUMBER_CLIENT,0) PHONE_NUMBER_CLIENT
        FROM CONTRACTS c,
             tariffs tr,
             CRM_BEELINE_CONFORMITY cbc
       where c.HANDS_BILLING = 1
         and TR.TARIFF_ID = GET_CURR_PHONE_TARIFF_ID(c.PHONE_NUMBER_FEDERAL)
         and cbc.PHONE_NUMBER_TARIFER(+) = c.PHONE_NUMBER_FEDERAL  
       ) dd on 
       (dd.dt = bhb.DATE_BILLING and 
        dd.PHONE_NUMBER_FEDERAL = bhb.PHONE_NUMBER_TARIFER and
        dd.CONTRACT_ID = bhb.CONTRACT_ID 
       )  
 when matched then update set 
  bhb.cost = dd.PAY,
  bhb.PHONE_NUMBER_CLIENT = dd.PHONE_NUMBER_CLIENT
 when not matched then insert 
 (bhb.DATE_BILLING, bhb.cost, bhb.PHONE_NUMBER_TARIFER, bhb.CONTRACT_ID, bhb.PHONE_NUMBER_CLIENT     
 ) values
 (
   dd.dt, dd.PAY, dd.PHONE_NUMBER_FEDERAL, dd.CONTRACT_ID, dd.PHONE_NUMBER_CLIENT 
 );
      
 commit;
end;
/
