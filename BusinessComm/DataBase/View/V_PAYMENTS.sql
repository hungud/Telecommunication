CREATE OR REPLACE FORCE VIEW V_PAYMENTS
(
   YEAR_MONTH,
   DATE_PAY,
   VIRTUAL_ACCOUNTS_NAME,
   INN,
   PHONE_ID,
   SUM_PAY,
   DOC_NUMBER,
   PAYMENT_PURPOSE,
   FILE_NAME,
   VIRTUAL_ACCOUNT_ID,
   PAYER_BIK,
   PAYMENT_ID
)
AS
   SELECT                                                                   
    --
    --#Version=2
    --
    --
    --v.2 Кочнев 26.11.2015 Добавил поле p.PAYMENT_ID
    --v.1 Афросин 16.11.2015 Вьюха по счетам
                                                                            --
         P.YEAR_MONTH,
         P.DATE_PAY,
         VA.VIRTUAL_ACCOUNTS_NAME,
         P.INN,
         P.PHONE_ID,
         P.SUM_PAY,
         P.DOC_NUMBER,
         P.PAYMENT_PURPOSE,
         pf.file_name,
         P.VIRTUAL_ACCOUNT_ID,
         p.PAYER_BIK,
         p.PAYMENT_ID
    FROM PAYMENTS p, VIRTUAL_ACCOUNTS va, PAYMENTS_FILES pf
   WHERE     P.VIRTUAL_ACCOUNT_ID = VA.VIRTUAL_ACCOUNTS_ID(+)
         AND P.PAYMENT_FILE_ID = pf.FILE_ID(+);


GRANT SELECT ON V_PAYMENTS TO BUSINESS_COMM_ROLE;

GRANT SELECT ON V_PAYMENTS TO BUSINESS_COMM_ROLE_RO;