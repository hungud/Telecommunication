CREATE OR REPLACE VIEW V_TARIFF_VIOLATIONS AS
--Version=6
  SELECT D.ACCOUNT_ID,
         D.YEAR_MONTH,
         D.PHONE_NUMBER,
         D.CELL_PLAN_CODE,
         (SELECT TARIFF_NAME
            FROM TARIFFS
           WHERE TARIFFS.TARIFF_CODE = D.CELL_PLAN_CODE
             AND ROWNUM <= 1) TARIFF_NAME_FROM_OPERATOR,
         TARIFFS.TARIFF_CODE,
         TARIFFS.TARIFF_NAME,
         BSC.STATUS_CODE,
         D.LAST_CHANGE_STATUS_DATE,
         CASE
           WHEN NVL(D.CONSERVATION, 0) = 1 THEN 'Сохр.'
           WHEN NVL(D.PHONE_IS_ACTIVE, 0) = 1 THEN 'Акт.'
           ELSE 'Блок.'
         END AS STATUS,
         CDS.DOP_STATUS_NAME,
         (SELECT MAX(L.DATE_LAST_UPDATED)
            FROM LOG_DOP_STATUS L
            WHERE L.PHONE_NUMBER = D.PHONE_NUMBER) DOP_STATUS_DATE
    FROM DB_LOADER_ACCOUNT_PHONES D, 
         TARIFFS, 
         CONTRACTS C, 
         BEELINE_STATUS_CODE BSC,
         CONTRACT_DOP_STATUSES CDS
    WHERE D.YEAR_MONTH = to_number(to_char(sysdate, 'YYYYMM'))
      AND GET_ID_LAST_CONTRACT_BY_PHONE(D.PHONE_NUMBER) = C.CONTRACT_ID(+)
      AND D.STATUS_ID = BSC.STATUS_ID(+)
      AND C.DOP_STATUS = CDS.DOP_STATUS_ID(+)
      AND NOT EXISTS (SELECT 1 
                        FROM CONTRACT_CANCELS 
                        WHERE CONTRACT_CANCELS.CONTRACT_ID = C.CONTRACT_ID)
      AND GET_ID_LAST_TARIFF_BY_CONTRACT(C.CONTRACT_ID, C.TARIFF_ID) = TARIFFS.TARIFF_ID(+)
      AND TARIFFS.TARIFF_CODE <> D.CELL_PLAN_CODE
      AND NVL(D.SYSTEM_BLOCK, 0) <> 1
      and ((D.Phone_Is_Active = 0 and
          (not exists
           (select 1
                from fraud_blocked_phone fb, AUTO_BLOCKED_PHONE
               where fb.phone_number = AUTO_BLOCKED_PHONE.PHONE_NUMBER
                 and fb.status = 1
                 and AUTO_BLOCKED_PHONE.PHONE_NUMBER =
                     D.PHONE_NUMBER
                 AND TO_NUMBER(TO_CHAR(AUTO_BLOCKED_PHONE.BLOCK_DATE_TIME,
                                       'YYYYMM')) =
                     D.YEAR_MONTH
                 and fb.date_block between AUTO_BLOCKED_PHONE.BLOCK_DATE_TIME and
                     nvl((select min(abp.block_date_time)
                           from AUTO_BLOCKED_PHONE abp
                          where abp.phone_number =
                                AUTO_BLOCKED_PHONE.PHONE_NUMBER
                            and abp.block_date_time >
                                AUTO_BLOCKED_PHONE.BLOCK_DATE_TIME),
                         sysdate)))) or
          (D.Phone_Is_Active = 1));
 
--grant select on V_TARIFF_VIOLATIONS to sim_trade_role;
 
--grant select on V_TARIFF_VIOLATIONS to corp_mobile_role;
 
--grant select on V_TARIFF_VIOLATIONS to lontana_role;