-- Create table
create table SH_CONTRACTS
(
  contract_id                    INTEGER not null,
  contract_num                   INTEGER,
  contract_date                  DATE,
  filial_id                      INTEGER,
  operator_id                    INTEGER,
  phone_number_federal           VARCHAR2(10 CHAR) not null,
  phone_number_city              VARCHAR2(7 CHAR),
  phone_number_type              NUMBER(1),
  tariff_id                      INTEGER,
  sim_number                     VARCHAR2(20 CHAR),
  service_id                     INTEGER,
  disconnect_limit               NUMBER,
  confirmed                      NUMBER(1),
  user_created                   VARCHAR2(30 CHAR),
  date_created                   DATE,
  user_last_updated              VARCHAR2(30 CHAR),
  date_last_updated              DATE,
  abonent_id                     INTEGER,
  received_sum                   NUMBER(15,2),
  start_balance                  NUMBER(15,2) not null,
  gold_number_sum                NUMBER(15,2),
  hand_block                     NUMBER,
  user_password                  VARCHAR2(30 CHAR),
  connect_limit                  NUMBER(12,2),
  hand_block_date_end            DATE,
  is_credit_contract             NUMBER(1),
  comments                       VARCHAR2(300 CHAR),
  send_activ                     NUMBER(1),
  curr_tariff_id                 INTEGER,
  dop_status                     NUMBER,
  balance_notice_hand_block      INTEGER,
  balance_block_hand_block       INTEGER,
  abon_tp_discount               INTEGER,
  installment_payment_date       DATE,
  installment_payment_sum        NUMBER(15,4),
  installment_payment_months     INTEGER,
  dealer_kod                     INTEGER,
  installment_advanced_repayment DATE,
  group_id                       INTEGER,
  option_group_id                INTEGER,
  mn_roaming                     INTEGER,
  paramdisable_sms               VARCHAR2(50),
  update_user                    VARCHAR2(50),
  update_time                    DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Grant/Revoke object privileges 
grant select, insert, update, delete, references, alter, index on SH_CONTRACTS to PUBLIC;
