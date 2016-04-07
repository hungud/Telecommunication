create table RECEIVED_PAYMENTS_log (
  fdate_rec       date,
  
  CURR_SCHEMA       varchar2(100),
  CURR_USER         varchar2(100),
  HOST              varchar2(100),
  IP_ADDRESS        varchar2(100),
  OS_USER           varchar2(100),  
  
  faction         varchar2(20),
  
  received_payment_id      INTEGER,
  
  phone_number             VARCHAR2(10 CHAR),
  payment_sum              NUMBER(15,2) ,
  payment_date_time        DATE,
  contract_id              INTEGER,
  is_contract_payment      NUMBER(1) default 0,
  filial_id                INTEGER,
  payment_annul_flag       NUMBER(1) default 0,
  payment_annul_date_time  DATE,
  payment_annul_reason     VARCHAR2(200 CHAR),
  user_who_annulate        VARCHAR2(30 CHAR),

  remark                   VARCHAR2(500 CHAR),
  received_payment_type_id INTEGER,
  reverseschet             INTEGER default 0,
  parent_payment_id        INTEGER,
  is_distributed           NUMBER(1),
  payment_period           INTEGER,
  
  phone_number_new             VARCHAR2(10 CHAR),
  payment_sum_new               NUMBER(15,2) ,
  payment_date_time_new         DATE,
  contract_id_new               INTEGER,
  is_contract_payment_new       NUMBER(1) default 0,
  filial_id_new                 INTEGER,
  payment_annul_flag_new        NUMBER(1) default 0,
  payment_annul_date_time_new   DATE,
  payment_annul_reason_new      VARCHAR2(200 CHAR),
  user_who_annulate_new         VARCHAR2(30 CHAR),

  remark_new                    VARCHAR2(500 CHAR),
  received_payment_type_id_new  INTEGER,
  reverseschet_new              INTEGER default 0,
  parent_payment_id_new         INTEGER,
  is_distributed_new           NUMBER(1),
  payment_period_new            INTEGER
  
  );  

comment on table RECEIVED_PAYMENTS_LOG is 'протоколирование изменений в таблице Принятые платежи RECEIVED_PAYMENTS';
comment on column RECEIVED_PAYMENTS_LOG.fdate_rec is 'дата изменения';
comment on column RECEIVED_PAYMENTS_LOG.curr_schema is 'данные коннекта : схема';
comment on column RECEIVED_PAYMENTS_LOG.curr_user is 'данные коннекта : пользователь';
comment on column RECEIVED_PAYMENTS_LOG.host is 'данные коннекта : HOST';
comment on column RECEIVED_PAYMENTS_LOG.ip_address is 'данные коннекта : IP';
comment on column RECEIVED_PAYMENTS_LOG.os_user is 'данные коннекта : пользователь OS';
comment on column RECEIVED_PAYMENTS_LOG.faction is 'действие (INSERT, UPDATE, DELETE)';
comment on column RECEIVED_PAYMENTS_LOG.received_payment_id is 'Первичный ключ записи RECEIVED_PAYMENT';
comment on column RECEIVED_PAYMENTS_LOG.phone_number is 'Старое значение поля : Номер телефона';
comment on column RECEIVED_PAYMENTS_LOG.payment_sum is 'Старое значение поля : Оплаченная сумма';
comment on column RECEIVED_PAYMENTS_LOG.payment_date_time is 'Старое значение поля : Дата и время платежа';
comment on column RECEIVED_PAYMENTS_LOG.contract_id is 'Старое значение поля : Код договора';
comment on column RECEIVED_PAYMENTS_LOG.is_contract_payment is 'Старое значение поля : Признак, что платёж сделан при заключении контракта';
comment on column RECEIVED_PAYMENTS_LOG.filial_id is 'Старое значение поля : Код филиала (офиса), принявшего платёж';
comment on column RECEIVED_PAYMENTS_LOG.payment_annul_flag is 'Старое значение поля : Признак аннулирования';
comment on column RECEIVED_PAYMENTS_LOG.payment_annul_date_time is 'Старое значение поля : Дата и время аннулирования платежа';
comment on column RECEIVED_PAYMENTS_LOG.payment_annul_reason is 'Старое значение поля : Причина аннулирования';
comment on column RECEIVED_PAYMENTS_LOG.user_who_annulate is 'Старое значение поля : Пользователь, который аннулировал платёж';
comment on column RECEIVED_PAYMENTS_LOG.remark is 'Старое значение поля : Примечание к платежу';
comment on column RECEIVED_PAYMENTS_LOG.received_payment_type_id is 'Старое значение поля : Тип платежа(ссылка на RECEIVED_PAYMENT_TYPES)';
comment on column RECEIVED_PAYMENTS_LOG.reverseschet is 'Старое значение поля : если 1, то в расшифровке баланса - сумма дублируется с противоположным знаком для счетов включенных в баланс';
comment on column RECEIVED_PAYMENTS_LOG.parent_payment_id is 'Старое значение поля : Ссылка на родительский платеж (для группы номеров с распределением платежа)';
comment on column RECEIVED_PAYMENTS_LOG.is_distributed is 'Старое значение поля : ';
comment on column RECEIVED_PAYMENTS_LOG.payment_period is 'Старое значение поля : Период распределения затрат (для распределенных платежей по группе номеров) в формате YYYYMM';
comment on column RECEIVED_PAYMENTS_LOG.phone_number_new  is 'Новое значение поля : Номер телефона';
comment on column RECEIVED_PAYMENTS_LOG.payment_sum_new  is 'Новое значение поля : Оплаченная сумма';
comment on column RECEIVED_PAYMENTS_LOG.payment_date_time_new  is 'Новое значение поля : Дата и время платежа';
comment on column RECEIVED_PAYMENTS_LOG.contract_id_new is 'Новое значение поля : Код договора';
comment on column RECEIVED_PAYMENTS_LOG.is_contract_payment_new  is 'Новое значение поля : Признак, что платёж сделан при заключении контракта';
comment on column RECEIVED_PAYMENTS_LOG.filial_id_new is 'Новое значение поля : Код филиала (офиса), принявшего платёж';
comment on column RECEIVED_PAYMENTS_LOG.payment_annul_flag_new  is 'Новое значение поля : Признак аннулирования';
comment on column RECEIVED_PAYMENTS_LOG.payment_annul_date_time_new  is 'Новое значение поля : Дата и время аннулирования платежа';
comment on column RECEIVED_PAYMENTS_LOG.payment_annul_reason_new  is 'Новое значение поля : Причина аннулирования';
comment on column RECEIVED_PAYMENTS_LOG.user_who_annulate_new  is 'Новое значение поля : Пользователь, который аннулировал платёж';
comment on column RECEIVED_PAYMENTS_LOG.remark_new  is 'Новое значение поля : Примечание к платежу';
comment on column RECEIVED_PAYMENTS_LOG.received_payment_type_id_new  is 'Новое значение поля : Тип платежа(ссылка на RECEIVED_PAYMENT_TYPES)';
comment on column RECEIVED_PAYMENTS_LOG.reverseschet_new  is 'Новое значение поля : если 1, то в расшифровке баланса - сумма дублируется с противоположным знаком для счетов включенных в баланс';
comment on column RECEIVED_PAYMENTS_LOG.parent_payment_id_new  is 'Новое значение поля : Ссылка на родительский платеж (для группы номеров с распределением платежа)';
comment on column RECEIVED_PAYMENTS_LOG.is_distributed_new  is 'Новое значение поля : ';
comment on column RECEIVED_PAYMENTS_LOG.payment_period_new  is 'Новое значение поля : Период распределения затрат (для распределенных платежей по группе номеров) в формате YYYYMM';
