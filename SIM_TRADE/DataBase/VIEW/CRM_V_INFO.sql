/* Formatted on 16.01.2015 12:00:34 (QP5 v5.252.13127.32867) */
CREATE OR REPLACE FORCE VIEW CRM_V_INFO
AS
--
--Version=2
--
--v2.Афроосин 16.01.2015 - Добавил номер счета в возвращаемый ответ
--
   SELECT DB.PHONE_NUMBER PHONE_NUMBER,
          GET_ABONENT_BALANCE (DB.PHONE_NUMBER) balance,
          CASE
             WHEN DB.PHONE_IS_ACTIVE = 1
             THEN
                'Активный'
             WHEN NVL (DB.PHONE_IS_ACTIVE, 0) = 0 AND DB.CONSERVATION = 1
             THEN
                'На сохранении'
             WHEN NVL (DB.PHONE_IS_ACTIVE, 0) = 0 AND DB.CONSERVATION = 0
             THEN
                'Неактивный'
          END
             is_active,
          DOP.DOP_STATUS_NAME dop_status,
          TAR.TARIFF_NAME TARIFF_NAME,
          HIST.DATE_LAST_UPDATED UPDATED,
          CRM_CONNECT_LIMIT (DB.PHONE_NUMBER) POSSIBLE_TO_UNLOCK,
          ac.account_number ban
          
     FROM db_loader_account_phones db,
          db_loader_account_phone_hists hist,
          contracts con,
          tariffs tar,
          CONTRACT_DOP_STATUSES dop,
          accounts ac
    WHERE     year_month = TO_CHAR (SYSDATE, 'yyyymm')
          AND DB.PHONE_NUMBER = HIST.PHONE_NUMBER
          AND HIST.END_DATE = TO_DATE ('01.01.3000', 'dd.mm.yyyy')
          AND CON.PHONE_NUMBER_FEDERAL(+) = DB.PHONE_NUMBER
          AND CON.CONTRACT_ID NOT IN (SELECT CAN.CONTRACT_ID
                                        FROM contract_cancels can)
          AND tar.tariff_id = CON.CURR_TARIFF_ID
          AND DOP.DOP_STATUS_ID(+) = CON.DOP_STATUS
          AND db.account_id = ac.account_id;



CREATE SYNONYM CRM_USER.V_INFO FOR CRM_V_INFO;


GRANT SELECT ON CRM_V_INFO TO CRM_USER;
