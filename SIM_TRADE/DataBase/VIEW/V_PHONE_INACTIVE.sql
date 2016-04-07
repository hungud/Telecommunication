CREATE OR REPLACE FORCE VIEW V_PHONE_INACTIVE
AS
--
--#Version=3
--
--v3. Алексеев. Добавил поле T.TRAFFIC_NOT_IGNOR_FOR_INACTIVE
--v2.Афросин - Добавили столбец T.TARIFF_NAME
--
   SELECT A.LOGIN,
          C.PHONE_NUMBER_FEDERAL,
          C.CONTRACT_DATE,
          B.BALANCE,
          CASE
             WHEN DB.PHONE_IS_ACTIVE = 0
             THEN
                CASE
                   WHEN DB.CONSERVATION = 1 THEN 'По сохранению'
                   ELSE 'По желанию'
                END
             ELSE
                'Активный'
          END
             AS PHONE_IS_ACTIVE,
          DS.DOP_STATUS_NAME,
          DB.LAST_CHECK_DATE_TIME,
          C.DATE_CREATED,
          CC.CURR_TARIFF_ID,
          T.TARIFF_NAME,
		  T.TRAFFIC_NOT_IGNOR_FOR_INACTIVE
     FROM V_CONTRACTS C,
          DB_LOADER_ACCOUNT_PHONES DB,
          ACCOUNTS A,
          IOT_CURRENT_BALANCE B,
          CONTRACT_DOP_STATUSES DS,
          CONTRACTS CC,
          TARIFFS T
    WHERE     C.PHONE_NUMBER_FEDERAL = DB.PHONE_NUMBER(+)
          AND DB.ACCOUNT_ID = A.ACCOUNT_ID(+)
          AND DB.YEAR_MONTH = (SELECT MAX (YEAR_MONTH)
                                 FROM DB_LOADER_ACCOUNT_PHONES
                                WHERE DB.PHONE_NUMBER = PHONE_NUMBER)
          AND C.PHONE_NUMBER_FEDERAL = B.PHONE_NUMBER(+)
          AND C.DOP_STATUS = DS.DOP_STATUS_ID(+)
          AND C.CONTRACT_ID = CC.CONTRACT_ID(+)
          AND CC.CURR_TARIFF_ID = T.TARIFF_ID(+)
          /*AND CC.CURR_TARIFF_ID NOT IN
                 (1840, 1841, 1842, 1843, 1844, 1845, 1846, 1847)*/;


GRANT SELECT ON CORP_MOBILE.V_PHONE_INACTIVE TO CORP_MOBILE_ROLE;

GRANT SELECT ON CORP_MOBILE.V_PHONE_INACTIVE TO CORP_MOBILE_ROLE_RO;                 