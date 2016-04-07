CREATE OR REPLACE VIEW V_PAYMENTS_WITHOUT_CONTRACTS AS 
-- Version = 1
  SELECT P.*,
         (SELECT MAX(C.CONTRACT_DATE)
            FROM CONTRACTS C
            WHERE C.PHONE_NUMBER_FEDERAL=P.PHONE_NUMBER
              AND C.CONTRACT_ID NOT IN (
                    SELECT CC.CONTRACT_ID
                     FROM CONTRACT_CANCELS CC
                   )) CONTRACT_DATE,
         (SELECT AP.CELL_PLAN_CODE
            FROM DB_LOADER_ACCOUNT_PHONES AP
            WHERE AP.PHONE_NUMBER = P.PHONE_NUMBER
              AND AP.YEAR_MONTH = (SELECT MAX(AP2.YEAR_MONTH)
                                     FROM DB_LOADER_ACCOUNT_PHONES AP2
                                     WHERE AP2.PHONE_NUMBER = AP.PHONE_NUMBER)
              AND ROWNUM = 1) TARIFF_CODE                                
    FROM DB_LOADER_PAYMENTS P
    WHERE P.PAYMENT_DATE>=SYSDATE-4
      AND (P.PHONE_NUMBER NOT IN (
             SELECT C.PHONE_NUMBER_FEDERAL
               FROM CONTRACTS C
               WHERE C.CONTRACT_ID NOT IN (
                       SELECT CC.CONTRACT_ID
                         FROM CONTRACT_CANCELS CC))
        OR P.PHONE_NUMBER IN (
             SELECT PH.PHONE_NUMBER
               FROM DB_LOADER_ACCOUNT_PHONES PH
               WHERE PH.CONSERVATION=1
                 AND PH.LAST_CHECK_DATE_TIME>P.PAYMENT_DATE
                 AND PH.PHONE_NUMBER IN (
                       SELECT C1.PHONE_NUMBER_FEDERAL
                         FROM CONTRACTS C1
                         WHERE C1.CONTRACT_DATE>SYSDATE-4))
          );
          
GRANT SELECT ON V_PAYMENTS_WITHOUT_CONTRACTS TO LONTANA_ROLE;          