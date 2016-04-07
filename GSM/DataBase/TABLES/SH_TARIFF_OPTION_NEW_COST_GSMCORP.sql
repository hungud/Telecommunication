CREATE TABLE SH_TARIFF_OPTION_NEW_COST
(
  TARIFF_OPTION_NEW_COST_ID  INTEGER,
  TARIFF_OPTION_COST_ID      INTEGER            NOT NULL,
  TARIFF_ID                  INTEGER,
  TURN_ON_COST               NUMBER(12,2),
  MONTHLY_COST               NUMBER(12,2),
  USER_CREATED               VARCHAR2(30 CHAR),
  DATE_CREATED               DATE,
  USER_LAST_UPDATED          VARCHAR2(30 CHAR),
  DATE_LAST_UPDATED          DATE,
  TURN_ON_COST_FOR_BILLS     NUMBER(15,4),
  MONTHLY_COST_FOR_BILLS     NUMBER(15,4),
  UPDATE_USER                VARCHAR2(50 BYTE),
  UPDATE_TIME                DATE
)