CREATE OR REPLACE VIEW V_CONTRACTS
AS 
SELECT
--
--#Version = 4
-- v.4 15.02.2016 Ищейкин - добавил таблицу MOBILE_OPERATOR_NAMES и поля MON.MOBILE_OPERATOR_NAME_ID, MON.MOBILE_OPERATOR_NAME, MON.MOBILE_OPERATOR_NAME_FOR_URL, f.BRANCH
-- v.3 15.01.2016 Кочнев - добавил поля ph.PHONE_NUMBER, ph.REGION, ph.PHONE_FOR_VIEW,
--v.2 30.12.2015 Афросин - добавил полей для отобжажения
--v.1 17.12.2015 Афросин - создал виюху по контрактам
--
         c.CONTRACT_ID,
         c.CONTRACT_NUM,
         c.CONTRACT_DATE,
         c.PHONE_NUMBER_TYPE,
         c.VIRTUAL_ACCOUNTS_ID,
         VA.VIRTUAL_ACCOUNTS_NAME,
         c.PHONE_ON_ACCOUNTS_ID,
         PA.PHONE_ID,
         ph.PHONE_NUMBER,
         ph.REGION,
         ph.PHONE_FOR_VIEW,
         MON.MOBILE_OPERATOR_NAME_ID,
         MON.MOBILE_OPERATOR_NAME,
         MON.MOBILE_OPERATOR_NAME_FOR_URL,
         C.FILIAL_ID,
         F.FILIAL_NAME,
         f.BRANCH,
         c.TARIFF_ID,
         T.TARIFF_NAME,
         c.ABONENT_ID,
         A.SURNAME || ' ' || A.NAME || ' ' || A.PATRONYMIC FIO,
         c.SIM_NUMBER,
         c.SALE_COST,
         c.SALE_DATE,
         c.CONTRACT_DISCOUNT,
         c.AGENT_DATE_DISPATCH,
         AG.AGENT_ID,
         AG.AGENT_NAME,
         AG.EMAIL,
         AG.PAYABLE,
         AG.PHONE_NUMBER_1,
         AG.PHONE_NUMBER_2,
         AG.PHONE_NUMBER_3,
         AG.PHONE_NUMBER_4,
         AG.ADDRESS,
         OS.OPERATOR_PHONE_STATUSE_ID,
         OS.STATUS_NAME OPERATOR_PHONE_STATUSE_NAME,
         LS.LOCAL_PHONE_STATUSE_ID,
         LS.STATUS_NAME LOCAL_PHONE_STATUSE_NAME,
         OA.OPERATOR_ACCOUNT_NAME_ID,
         OA.ACCOUNT_NAME OPERATOR_ACCOUNT_NAME,
         pr.project_id,
         pr.project_name,
         osa.SUB_ACCOUNT_ID,
         osa.SUB_ACCOUNT_NUMBER,
         CASE NVL (un.USER_FIO, '0')
            WHEN '0' THEN 'Cистема; ' || c.USER_CREATED
            ELSE un.USER_FIO
         END
            USER_CREATED_FIO,
         c.DATE_CREATED DATE_CREATED_,
         CASE NVL (un2.USER_FIO, '0')
            WHEN '0' THEN 'Cистема; ' || c.USER_LAST_UPDATED
            ELSE un2.USER_FIO
         END
            USER_LAST_UPDATED_FIO,
         c.DATE_LAST_UPDATED DATE_LAST_UPDATED_
    FROM CONTRACTS c,
         filials f,
         abonents a,
         virtual_accounts va,
         phone_on_accounts pa,
         PHONES ph,
         tariffs t,
         agents ag,
         OPERATOR_PHONE_STATUSES os,
         LOCAL_PHONE_STATUSES ls,
         OPERATOR_ACCOUNT_NAMES oa,
         PROJECTS pr,
         OPERATOR_SUB_ACCOUNTS osa,
         USER_NAMES un,
         USER_NAMES un2,
         MOBILE_OPERATOR_NAMES mon
   WHERE     c.USER_CREATED = un.USER_NAME(+)
         AND c.USER_LAST_UPDATED = un2.USER_NAME(+)
         AND C.VIRTUAL_ACCOUNTS_ID = VA.VIRTUAL_ACCOUNTS_ID(+)
         AND C.FILIAL_ID = F.FILIAL_ID(+)
         AND C.ABONENT_ID = A.ABONENT_ID(+)
         AND C.PHONE_ON_ACCOUNTS_ID = PA.PHONE_ON_ACCOUNTS_ID(+)
         AND PA.PHONE_ID = ph.PHONE_ID(+)
         AND C.TARIFF_ID = T.TARIFF_ID(+)
         AND C.AGENT_ID = AG.AGENT_ID(+)
         AND C.OPERATOR_PHONE_STATUSE_ID = OS.OPERATOR_PHONE_STATUSE_ID(+)
         AND C.LOCAL_PHONE_STATUSE_ID = LS.LOCAL_PHONE_STATUSE_ID(+)
         AND C.OPERATOR_ACCOUNT_NAME_ID = oa.OPERATOR_ACCOUNT_NAME_ID(+)
         AND C.PROJECT_ID = pr.PROJECT_ID(+)
         AND C.SUB_ACCOUNT_ID = osa.SUB_ACCOUNT_ID(+)
         AND F.MOBILE_OPERATOR_NAME_ID = MON.MOBILE_OPERATOR_NAME_ID(+);


GRANT DELETE, INSERT, SELECT, UPDATE ON BUSINESS_COMM.V_CONTRACTS TO BUSINESS_COMM_ROLE;

GRANT SELECT, UPDATE ON BUSINESS_COMM.V_CONTRACTS TO BUSINESS_COMM_ROLE_RO;
