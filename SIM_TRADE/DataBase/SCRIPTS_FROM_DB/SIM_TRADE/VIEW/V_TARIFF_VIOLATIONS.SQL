
  CREATE OR REPLACE FORCE VIEW "SIM_TRADE"."V_TARIFF_VIOLATIONS" ("ACCOUNT_ID", "YEAR_MONTH", "PHONE_NUMBER", "CELL_PLAN_CODE", "TARIFF_NAME_FROM_OPERATOR", "TARIFF_CODE", "TARIFF_NAME") AS 
  SELECT DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID,
       DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH,
       DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER,
       DB_LOADER_ACCOUNT_PHONES.CELL_PLAN_CODE,
       (SELECT TARIFF_NAME
          FROM TARIFFS
         WHERE TARIFFS.TARIFF_CODE = DB_LOADER_ACCOUNT_PHONES.CELL_PLAN_CODE
           AND ROWNUM <= 1) TARIFF_NAME_FROM_OPERATOR,
       TARIFFS.TARIFF_CODE,
       TARIFFS.TARIFF_NAME
  FROM DB_LOADER_ACCOUNT_PHONES, TARIFFS, CONTRACTS
 WHERE DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH =
       to_number(to_char(sysdate, 'YYYYMM'))
   AND CONTRACTS.CONTRACT_ID =
       GET_ID_LAST_CONTRACT_BY_PHONE(DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER)
   AND GET_ID_LAST_TARIFF_BY_CONTRACT(CONTRACTS.CONTRACT_ID,
                                      CONTRACTS.TARIFF_ID) =
       TARIFFS.TARIFF_ID
   AND TARIFFS.TARIFF_CODE <> DB_LOADER_ACCOUNT_PHONES.CELL_PLAN_CODE
   AND NVL(DB_LOADER_ACCOUNT_PHONES.SYSTEM_BLOCK, 0) <> 1
   and ((DB_LOADER_ACCOUNT_PHONES.Phone_Is_Active = 0 and
       (not exists
        (select 1
             from fraud_blocked_phone fb, AUTO_BLOCKED_PHONE
            where fb.phone_number = AUTO_BLOCKED_PHONE.PHONE_NUMBER
              and fb.status = 1
              and AUTO_BLOCKED_PHONE.PHONE_NUMBER =
                  DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER
              AND TO_NUMBER(TO_CHAR(AUTO_BLOCKED_PHONE.BLOCK_DATE_TIME,
                                    'YYYYMM')) =
                  DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH
              and fb.date_block between AUTO_BLOCKED_PHONE.BLOCK_DATE_TIME and
                  nvl((select min(abp.block_date_time)
                        from AUTO_BLOCKED_PHONE abp
                       where abp.phone_number =
                             AUTO_BLOCKED_PHONE.PHONE_NUMBER
                         and abp.block_date_time >
                             AUTO_BLOCKED_PHONE.BLOCK_DATE_TIME),
                      sysdate)))) or
       (DB_LOADER_ACCOUNT_PHONES.Phone_Is_Active = 1)) 