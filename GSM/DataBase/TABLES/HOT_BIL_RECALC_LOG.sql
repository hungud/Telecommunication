create table HOT_BIL_RECALC_LOG
(
  subscr_no   VARCHAR2(11 CHAR),
  start_time  DATE,
  dbf_id      NUMBER(38),
  duration    INTEGER,
  tariff_id   INTEGER,
  cost_min    INTEGER,
  cnt_podkl   INTEGER,
  name_opcion VARCHAR2(15 CHAR),
  record_time DATE default sysdate not null,
  ticket_id   NVARCHAR2(15),
  CONTRACT_ID  INTEGER,
  DURATION2    INTEGER
);
 
comment on table HOT_BIL_RECALC_LOG
  is 'Журнал пересчета данных пакета HOT_BILLING_RECALC_ROW_PСKG';
comment on column HOT_BIL_RECALC_LOG.subscr_no
  is 'Номер телефона ';
comment on column HOT_BIL_RECALC_LOG.start_time
  is 'Время звонка';
comment on column HOT_BIL_RECALC_LOG.dbf_id
  is 'Id файла источника';
comment on column HOT_BIL_RECALC_LOG.duration
  is 'Длительность';
comment on column HOT_BIL_RECALC_LOG.tariff_id
  is 'Id тарифа';
comment on column HOT_BIL_RECALC_LOG.cost_min
  is ' Стоимость минуты';
comment on column HOT_BIL_RECALC_LOG.cnt_podkl
  is 'Была ли подключена опция';
comment on column HOT_BIL_RECALC_LOG.name_opcion
  is 'Имя подключаемой опции';
comment on column HOT_BIL_RECALC_LOG.record_time
  is 'Время записи в эту таблицу';
comment on column HOT_BIL_RECALC_LOG.ticket_id
  is 'Номер отправленной заявки в Билайн, ссылка на табл. BEELINE_TICKETS
(  ticket_id)';

COMMENT ON COLUMN HOT_BIL_RECALC_LOG.CONTRACT_ID IS 'Ссылка на первичный ключ CONTRACTS.contract_id';

COMMENT ON COLUMN HOT_BIL_RECALC_LOG.DURATION2 IS 'Длительность предыдущих звонков';
