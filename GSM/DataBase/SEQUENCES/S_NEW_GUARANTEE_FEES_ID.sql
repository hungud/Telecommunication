DROP SEQUENCE S_NEW_GUARANTEE_FEES_ID;

CREATE SEQUENCE S_NEW_GUARANTEE_FEES_ID
  START WITH 0
  MAXVALUE 999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;
