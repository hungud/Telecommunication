CREATE OR REPLACE VIEW V_CONTRACTS AS 
--#Version=11
-- 11. ������� ������� ����� �������� GSM
-- 10. �������� ��������� ������ ���� COMMENTS
-- 9.  �������� ��������� ������ ���� GROUP_ID
-- 8.  �������� ��������� ������ ���� DEALER_KOD
-- 7.  �������� ��������� ������ ����� BALANCE_NOTICE_HAND_BLOCK � BALANCE_BLOCK_HAND_BLOCK
-- 6.  �������� ��������� ������ ���� dop_status
-- 5.  �������� ��������� ������ ���� hand_block_date_end

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
         C.HAND_BLOCK,
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
         GROUP_ID,
         COMMENTS
    FROM CONTRACTS C, 
         V_CONTRACT_CHANGES CC
    WHERE C.CONTRACT_ID = CC.CONTRACT_ID (+)
/*      AND c.phone_number_federal IN (SELECT p1.phone_number
                                       FROM db_loader_account_phones p1
                                       WHERE p1.year_month =(SELECT MAX(p2.year_month)
                                                               FROM db_loader_account_phones p2
                                                               where p2.ACCOUNT_ID=p1.ACCOUNT_ID));*/