
  CREATE OR REPLACE FORCE VIEW "LONTANA"."V_BALANCES_ON_END_MONTHS" ("ACCOUNT_ID", "YEAR_MONTH", "PHONE_NUMBER", "DATE_BALANCE", "BALANCE", "PHONE_IS_ACTIVE", "BEGIN_DATE", "SUBSCRIBER_PAYMENT_NEW", "ACTIV", "ALL_CALLS", "DISCOUNT_CALL", "DILER_CALLS", "BILL_SUM_NEW", "DILER_SUM", "TARIFF_NAME") AS 
  SELECT PH.ACCOUNT_ID,
         PH.YEAR_MONTH,
         PH.PHONE_NUMBER,
         LAST_DAY(TO_DATE(TO_CHAR(PH.YEAR_MONTH)||'01','YYYYMMDD')) AS DATE_BALANCE,
         GET_ABONENT_BALANCE(PH.PHONE_NUMBER, LAST_DAY(TO_DATE(TO_CHAR(PH.YEAR_MONTH)||'01','YYYYMMDD'))) AS BALANCE,
         HI.PHONE_IS_ACTIVE,
         HI.BEGIN_DATE,
         vb.ABON_TP_NEW subscriber_payment_new,
         CASE
           WHEN (st.calls_count > 0) OR (st.mms_count > 0) OR (st.sms_count > 0)
                 OR (st.internet_mb > 0) OR (st.zerocost_outcome_count > 0) OR (bl.CALLS_LOCAL > 0) 
                 OR (bl.CALLS_SITY > 0) OR (bl.CALLS_COUNTRY > 0) OR (bl.CALLS_SMS_MMS > 0) 
                 OR (bl.CALLS_GPRS > 0) OR (bl.ROUMING_INTERNATIONAL > 0) OR (bl.ROUMING_NATIONAL > 0) 
                 OR (bl.CALLS_RUS_RPP > 0)
             THEN 1
           ELSE 
             CASE
               WHEN DBMS_LOB.getlength(loader3_pckg.get_phone_detail(TRUNC(vb.year_month/100), vb.year_month - TRUNC(vb.year_month/100)*100,vb.phone_number)) > 100
                 THEN 1
               ELSE 0
             END
         END activ,
         BL.CALLS_ALL + BL.ROUMING_NATIONAL + BL.ROUMING_INTERNATIONAL ALL_CALLS,
         BL.DISCOUNT_CALL,
         DC.DILER_CALLS,
         VB.BILL_SUM_NEW,
         VB.BILL_SUM_NEW - BL.CALLS_ALL - BL.ROUMING_NATIONAL - BL.ROUMING_INTERNATIONAL + DC.DILER_CALLS DILER_SUM,
         (SELECT AP.TARIFF_NAME
            FROM V_BILL_ABON_PER_FOR_CLIENT AP
            WHERE AP.ACCOUNT_ID = VB.ACCOUNT_ID
              AND AP.YEAR_MONTH = VB.YEAR_MONTH
              AND AP.PHONE_NUMBER = VB.PHONE_NUMBER
              AND AP.TARIFF_NAME IS NOT NULL
              AND AP.DATE_END = (SELECT MAX(AP2.DATE_END)
                                   FROM V_BILL_ABON_PER_FOR_CLIENT AP2
                                   WHERE AP2.ACCOUNT_ID = AP.ACCOUNT_ID
                                     AND AP2.YEAR_MONTH = AP.YEAR_MONTH
                                     AND AP2.PHONE_NUMBER = AP.PHONE_NUMBER
                                     AND AP2.TARIFF_NAME IS NOT NULL)
              AND ROWNUM = 1) TARIFF_NAME
    FROM DB_LOADER_ACCOUNT_PHONES PH,
         DB_LOADER_ACCOUNT_PHONE_HISTS HI,
         CONTRACTS,
         CONTRACT_CANCELS,
         V_BILL_FINANCE_FOR_CLIENTS VB,
         db_loader_phone_stat st,
         DB_LOADER_FULL_FINANCE_BILL bl,
         DILER_CALL_FOR_PHONE DC
    WHERE vb.account_id = st.account_id(+)
      AND vb.year_month = st.year_month(+)
      AND vb.phone_number = st.phone_number(+)
      AND vb.account_id = bl.account_id(+)
      AND vb.year_month = bl.year_month(+)
      AND vb.phone_number = bl.phone_number(+)
      AND PH.PHONE_NUMBER=CONTRACTS.PHONE_NUMBER_FEDERAL(+)
      AND PH.YEAR_MONTH>=TO_NUMBER(TO_CHAR(CONTRACTS.CONTRACT_DATE,'YYYYMM'))
      AND CONTRACTS.CONTRACT_ID=CONTRACT_CANCELS.CONTRACT_ID(+)
      AND PH.YEAR_MONTH<=NVL(TO_NUMBER(TO_CHAR(CONTRACT_CANCELS.CONTRACT_CANCEL_DATE,'YYYYMM')),205012)
      AND PH.PHONE_NUMBER=HI.PHONE_NUMBER(+)
      AND HI.END_DATE>=SYSDATE
      AND PH.PHONE_NUMBER=VB.PHONE_NUMBER(+)
      AND PH.YEAR_MONTH=VB.YEAR_MONTH(+)
      AND PH.ACCOUNT_ID=VB.ACCOUNT_ID(+)
      AND vb.year_month = DC.YEAR_MONTH (+)
      AND vb.phone_number = DC.PHONE_NUMBER (+) 