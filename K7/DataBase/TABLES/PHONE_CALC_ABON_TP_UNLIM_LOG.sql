CREATE TABLE PHONE_CALC_ABON_TP_UNLIM_LOG
(
  YEAR_MONTH    NUMBER(38),
  PHONE_NUMBER  VARCHAR2(10 CHAR),
  TARIFF_ID     INTEGER,
  DATE_INSERT   DATE,
  DATE_DELETE   DATE,
  NOTE          VARCHAR2(50 CHAR)
)
TABLESPACE USERS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          9M
            NEXT             8K
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON TABLE PHONE_CALC_ABON_TP_UNLIM_LOG IS 'Лог номеров, у которых было недостаточно средств для списания абонки и у которых измененно списание абонки';

COMMENT ON COLUMN PHONE_CALC_ABON_TP_UNLIM_LOG.YEAR_MONTH IS 'Год/месяц';

COMMENT ON COLUMN PHONE_CALC_ABON_TP_UNLIM_LOG.PHONE_NUMBER IS 'Номер';

COMMENT ON COLUMN PHONE_CALC_ABON_TP_UNLIM_LOG.TARIFF_ID IS 'Код тарифного плана';

COMMENT ON COLUMN PHONE_CALC_ABON_TP_UNLIM_LOG.DATE_INSERT IS 'Дата создания записи';

COMMENT ON COLUMN PHONE_CALC_ABON_TP_UNLIM_LOG.DATE_DELETE IS 'Дата удаления записи';

alter table PHONE_CALC_ABON_TP_UNLIM_LOG ADD BALANCE Number(15,2);
COMMENT ON COLUMN PHONE_CALC_ABON_TP_UNLIM_LOG.BALANCE IS 'Реальный баланс(исп. в тарифере)';

alter table PHONE_CALC_ABON_TP_UNLIM_LOG ADD VIRT_BALANCE Number(15,2);
COMMENT ON COLUMN PHONE_CALC_ABON_TP_UNLIM_LOG.VIRT_BALANCE IS 'Виртуальный баланс';