CREATE OR REPLACE VIEW V_PHONE_FOR_UNBLOCK_NO_CONTR AS
--Version=5
SELECT V.PHONE_NUMBER,
       GET_ABONENT_BALANCE(V.PHONE_NUMBER) BALANCE,
       'Без договора' FIO,
       V.ACCOUNT_ID
  FROM DB_LOADER_ACCOUNT_PHONES V
  WHERE v.YEAR_MONTH = (select max(ap.YEAR_MONTH)
                          from db_loader_account_phones ap)
    and V.PHONE_IS_ACTIVE = 0
    AND V.CONSERVATION = 0
    AND GET_ABONENT_BALANCE(V.PHONE_NUMBER) > 0
    and NOT EXISTS (SELECT 1 
                      FROM AUTO_UNBLOCKED_PHONE 
                      WHERE V.PHONE_NUMBER=AUTO_UNBLOCKED_PHONE.PHONE_NUMBER
                        AND  (AUTO_UNBLOCKED_PHONE.UNBLOCK_DATE_TIME > SYSDATE-6/24)
                        and AUTO_UNBLOCKED_PHONE.Note IS NULL);                         