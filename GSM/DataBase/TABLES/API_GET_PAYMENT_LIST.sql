CREATE GLOBAL TEMPORARY TABLE API_GET_PAYMENT_LIST(
  ctn VARCHAR2(15 CHAR),
  paymentDate VARCHAR2(25 char),
  paymentStatus VARCHAR2(200 CHAR),
  paymentType VARCHAR2(200 char),
  paymentOriginalAmt VARCHAR2(15 CHAR),
  paymentCurrentAmt VARCHAR2(15 char),
  bankPaymentID VARCHAR2(30 CHAR),
  paymentActivateDate VARCHAR2(25 char)
  );
  
COMMENT ON TABLE API_GET_PAYMENT_LIST IS 'Временная таблица для загрузки API.getPaymentList'; 
COMMENT ON COLUMN API_GET_PAYMENT_LIST.ctn IS 'Номер телефона';
COMMENT ON COLUMN API_GET_PAYMENT_LIST.paymentDate IS 'Дата платежа';
COMMENT ON COLUMN API_GET_PAYMENT_LIST.paymentStatus IS 'Статус платежа';
COMMENT ON COLUMN API_GET_PAYMENT_LIST.paymentType IS 'Тип платежа';
COMMENT ON COLUMN API_GET_PAYMENT_LIST.paymentOriginalAmt IS 'Сумма платежа (внесенная)';
COMMENT ON COLUMN API_GET_PAYMENT_LIST.paymentCurrentAmt IS 'Сумма платежа (зачисленная)';
COMMENT ON COLUMN API_GET_PAYMENT_LIST.bankPaymentID IS 'ID платежа';
COMMENT ON COLUMN API_GET_PAYMENT_LIST.paymentActivateDate IS 'Дата активации платежа';

GRANT SELECT, INSERT, UPDATE, DELETE ON API_GET_CTN_INFO_LIST TO SIM_TRADE_ROLE;
