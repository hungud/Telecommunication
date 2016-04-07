-- Create table
create table PROMISED_PAYMENTS_CHANGE_LOG(
  account_id              INTEGER,
  year_month              INTEGER,
  phone_number            VARCHAR2(10 CHAR),
  payment_date            DATE,
  payment_sum             NUMBER(15,2),
  payment_status_is_valid NUMBER(1),
  payment_number          VARCHAR2(30 CHAR),
  payment_status_text     VARCHAR2(200 CHAR),
  contract_id             INTEGER,
  date_created            DATE,
  comm_txt                VARCHAR2(200 CHAR)
  );
  
  
-- Add comments to the table 
comment on table PROMISED_PAYMENTS_CHANGE_LOG is 'лог добавления обещанного платежа';
-- Add comments to the columns 
comment on column PROMISED_PAYMENTS_CHANGE_LOG.account_id is 'ID КЛИЕНТА';
comment on column PROMISED_PAYMENTS_CHANGE_LOG.year_month is 'ГОД И МЕСЯЦ';
comment on column PROMISED_PAYMENTS_CHANGE_LOG.phone_number is 'НОМЕР ТЕЛЕФОНА';
comment on column PROMISED_PAYMENTS_CHANGE_LOG.payment_date is 'ДАТА ПЛАТЕЖА';
comment on column PROMISED_PAYMENTS_CHANGE_LOG.payment_sum is 'СУММА ПЛАТЕЖА';
comment on column PROMISED_PAYMENTS_CHANGE_LOG.payment_status_is_valid is 'СТАТУС ПЛАТЕЖА';
comment on column PROMISED_PAYMENTS_CHANGE_LOG.payment_number is 'НОМЕР ПЛАТЕЖА';
comment on column PROMISED_PAYMENTS_CHANGE_LOG.payment_status_text is 'ОПИСАНИЕ СТАТУСА ПЛАТЕЖА';
comment on column PROMISED_PAYMENTS_CHANGE_LOG.contract_id is 'Ссылка на контракт, к которому относится платёж';
comment on column PROMISED_PAYMENTS_CHANGE_LOG.date_created is 'Дата загрузки платежа в БД';
comment on column PROMISED_PAYMENTS_CHANGE_LOG.comm_txt is 'комментарий';
