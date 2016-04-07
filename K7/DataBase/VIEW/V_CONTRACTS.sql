/* Formatted on 10/03/2015 16:47:27 (QP5 v5.252.13127.32867) */
CREATE OR REPLACE FORCE VIEW V_CONTRACTS
--#Version=13
--v13. Алексеев При определении тарифа первоочередность отдается C.CURR_TARIFF_ID
--v12. Алексеев Изменено получение тарифа. Добавленна проверка на C.CURR_TARIFF_ID
--v11. Афросин Добавлена выдача поля START_BALANCE
-- 10. Котенков Добавлена выдача поля COMMENTS
-- 9.  Котенков Добавлена выдача поля GROUP_ID
-- 8.  Котенков Добавлена выдача поля DEALER_KOD
-- 7.  Котенков Добавлена выдача полей BALANCE_NOTICE_HAND_BLOCK и BALANCE_BLOCK_HAND_BLOCK
-- 6.  Котенков Добавлена выдача поля dop_status
-- 5.  Котенков Добавлена выдача поля hand_block_date_end

AS
   SELECT C.CONTRACT_ID,
          C.CONTRACT_NUM,
          C.CONTRACT_DATE,
          NVL (CC.FILIAL_ID, C.FILIAL_ID) FILIAL_ID,
          NVL (CC.OPERATOR_ID, C.OPERATOR_ID) OPERATOR_ID,
          --NVL (CC.PHONE_NUMBER_FEDERAL, C.PHONE_NUMBER_FEDERAL)
          C.PHONE_NUMBER_FEDERAL PHONE_NUMBER_FEDERAL,
          NVL (CC.PHONE_NUMBER_CITY, C.PHONE_NUMBER_CITY) PHONE_NUMBER_CITY,
          NVL (CC.PHONE_NUMBER_TYPE, C.PHONE_NUMBER_TYPE) PHONE_NUMBER_TYPE,
          NVL (C.CURR_TARIFF_ID, NVL (CC.TARIFF_ID, C.TARIFF_ID)) TARIFF_ID,
          NVL (CC.SIM_NUMBER, C.SIM_NUMBER) SIM_NUMBER,
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
          --AC.START_BALANCE,
          CASE
             WHEN (C.HAND_BLOCK = 1) AND (C.HAND_BLOCK_DATE_END > SYSDATE)
             THEN
                1
             ELSE
                0
          END
             HAND_BLOCK,
          C.HAND_BLOCK_DATE_END,
          C.IS_CREDIT_CONTRACT,
          (SELECT CCS.CONTRACT_CANCEL_DATE
             FROM CONTRACT_CANCELS CCS
            WHERE CCS.CONTRACT_ID = C.CONTRACT_ID AND ROWNUM < 2)
             CONTRACT_CANCEL_DATE,
          DOP_STATUS,
          BALANCE_NOTICE_HAND_BLOCK,
          BALANCE_BLOCK_HAND_BLOCK,
          DEALER_KOD,
          GROUP_ID,
          COMMENTS,
          C.START_BALANCE
     FROM CONTRACTS C, V_CONTRACT_CHANGES CC
    WHERE C.CONTRACT_ID = CC.CONTRACT_ID(+);





GRANT SELECT ON V_CONTRACTS TO CORP_MOBILE_ROLE;

GRANT SELECT ON V_CONTRACTS TO CORP_MOBILE_ROLE_RO;

GRANT SELECT ON V_CONTRACTS TO CRM_USER;
