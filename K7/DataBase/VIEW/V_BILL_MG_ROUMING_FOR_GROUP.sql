CREATE OR REPLACE FORCE VIEW V_BILL_MG_ROUMING_FOR_GROUP
AS
--
--ВИЬХА ПО ВЫЗОВАМ В МЕЖДУГОРОДНЕМ РОУМИНГЕ
--
--
--Version=1
--
--v.1 28.01.2015 Афросин А.Ю. Добавил Виюху со звонками в Междугороднем роуминге
--
   SELECT MN.ACCOUNT_ID,
          MN.YEAR_MONTH,
          MN.PHONE_NUMBER,
          MN.DATE_BEGIN,
          MN.DATE_END,
          MN.ROUMING_COUNTRY,
          MN.ROUMING_CALLS,
          MN.ROUMING_GPRS,
          MN.ROUMING_SMS,
          MN.COMPANY_TAX,
          MN.ROUMING_SUM,
          C.CONTRACT_ID,
          C.CONTRACT_NUM,
          C.CONTRACT_DATE,
          C.GROUP_ID
     FROM DB_LOADER_FULL_BILL_MG_ROUMING MN, V_CONTRACTS C
    WHERE     MN.PHONE_NUMBER = C.PHONE_NUMBER_FEDERAL
          AND C.CONTRACT_DATE <
                 ADD_MONTHS (TO_DATE (MN.YEAR_MONTH || '01', 'yyyymmdd'), 1)
          AND (   C.CONTRACT_CANCEL_DATE IS NULL
               OR C.CONTRACT_CANCEL_DATE >=
                     TO_DATE (MN.YEAR_MONTH || '01', 'yyyymmdd'))
          AND C.GROUP_ID IS NOT NULL;


GRANT SELECT ON V_BILL_MG_ROUMING_FOR_GROUP TO CORP_MOBILE_ROLE;

GRANT SELECT ON V_BILL_MG_ROUMING_FOR_GROUP TO CORP_MOBILE_ROLE_RO;
