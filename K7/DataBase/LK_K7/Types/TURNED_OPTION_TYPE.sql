CREATE OR REPLACE TYPE K7_LK.TURNED_OPTION_TYPE AS OBJECT
(
  TARIFF_OPTION_ID INTEGER,
  NAME VARCHAR2(100 CHAR),
  TURN_ON_DATE DATE,
  TURN_OFF_DATE DATE,
  CAN_BE_TURNED_BY_ABONENT INTEGER,
  MONTHLY_COST NUMBER(15, 2)
);
/