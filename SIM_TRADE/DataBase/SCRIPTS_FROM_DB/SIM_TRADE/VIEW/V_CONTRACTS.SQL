
  CREATE OR REPLACE FORCE VIEW "SIM_TRADE"."V_CONTRACTS" ("CONTRACT_ID", "CONTRACT_NUM", "CONTRACT_DATE", "FILIAL_ID", "OPERATOR_ID", "PHONE_NUMBER_FEDERAL", "PHONE_NUMBER_CITY", "PHONE_NUMBER_TYPE", "TARIFF_ID", "SIM_NUMBER", "CONTRACT_CHANGE_DATE", "SERVICE_ID", "DISCONNECT_LIMIT", "CONNECT_LIMIT", "CONFIRMED", "USER_CREATED", "DATE_CREATED", "USER_LAST_UPDATED", "DATE_LAST_UPDATED", "ABONENT_ID", "HAND_BLOCK", "HAND_BLOCK_DATE_END", "IS_CREDIT_CONTRACT", "CONTRACT_CANCEL_DATE", "DOP_STATUS", "BALANCE_NOTICE_HAND_BLOCK", "BALANCE_BLOCK_HAND_BLOCK", "DEALER_KOD", "GROUP_ID") AS 
  SELECT C.CONTRACT_ID, 
         C.CONTRACT_NUM, 
         C.CONTRACT_DATE, 
         NVL(CC.FILIAL_ID, C.FILIAL_ID) FILIAL_ID, 
         NVL(CC.OPERATOR_ID, C.OPERATOR_ID) OPERATOR_ID, 
         NVL(CC.PHONE_NUMBER_FEDERAL, C.PHONE_NUMBER_FEDERAL) PHONE_NUMBER_FEDERAL, 
         NVL(CC.PHONE_NUMBER_CITY, C.PHONE_NUMBER_CITY) PHONE_NUMBER_CITY, 
         NVL(CC.PHONE_NUMBER_TYPE, C.PHONE_NUMBER_TYPE) PHONE_NUMBER_TYPE, 
         NVL(CC.TARIFF_ID, C.TARIFF_ID) TARIFF_ID, 
         NVL(CC.SIM_NUMBER, C.SIM_NUMBER) SIM_NUMBER, 
         CC.CONTRACT_CHANGE_DATE,
         C.SERVICE_ID, 
         C.DISCONNECT_LIMIT, 
         C.CONNECT_LIMIT,
         C.CONFIRMED, 
         C.USER_CREATED, 
         C.DATE_CREATED, 
         C.USER_LAST_UPDATED, 
         C.DATE_LAST_UPDATED, 
         C.ABONENT_ID,
         CASE 
           WHEN (C.HAND_BLOCK=1) AND (C.HAND_BLOCK_DATE_END>SYSDATE) THEN 1
           ELSE 0
         END HAND_BLOCK,
         C.HAND_BLOCK_DATE_END,
         C.IS_CREDIT_CONTRACT,   
         (SELECT CCS.CONTRACT_CANCEL_DATE 
            FROM CONTRACT_CANCELS CCS 
            WHERE CCS.CONTRACT_ID = C.CONTRACT_ID 
              AND ROWNUM < 2) CONTRACT_CANCEL_DATE,
         DOP_STATUS,
         BALANCE_NOTICE_HAND_BLOCK,
         BALANCE_BLOCK_HAND_BLOCK,
         DEALER_KOD,
         GROUP_ID
    FROM CONTRACTS C, 
         V_CONTRACT_CHANGES CC
    WHERE C.CONTRACT_ID = CC.CONTRACT_ID (+)
/*      AND c.phone_number_federal IN (SELECT p1.phone_number
                                       FROM db_loader_account_phones p1
                                       WHERE p1.year_month =(SELECT MAX(p2.year_month)
                                                               FROM db_loader_account_phones p2
                                                               where p2.ACCOUNT_ID=p1.ACCOUNT_ID));*/ 