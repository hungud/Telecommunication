CREATE TABLE MOB_PAY_REQUEST
(
  PHONE        VARCHAR2(11 BYTE),
  SUM_PAY      NUMBER,
  REQ_COUNT    INTEGER,
  DATE_INSERT  DATE,
  DATE_UPDATE  DATE
)
TABLESPACE USERS
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          16K
            NEXT             8K
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON TABLE MOB_PAY_REQUEST IS '������� ��������';

COMMENT ON COLUMN MOB_PAY_REQUEST.PHONE IS '����� ��������';

COMMENT ON COLUMN MOB_PAY_REQUEST.SUM_PAY IS '����� �������';

COMMENT ON COLUMN MOB_PAY_REQUEST.REQ_COUNT IS '���������� ��������';

COMMENT ON COLUMN MOB_PAY_REQUEST.DATE_INSERT IS '���� ����������';

COMMENT ON COLUMN MOB_PAY_REQUEST.DATE_UPDATE IS '���� ���������';



CREATE OR REPLACE TRIGGER TIU_MOB_PAY_REQUEST
--#Version=1
  BEFORE INSERT OR UPDATE ON  MOB_PAY_REQUEST FOR EACH ROW
BEGIN
   IF INSERTING THEN
     :NEW.date_insert := sysdate;
     :NEW.date_update := sysdate;
     :NEW.req_count := 0;
   else
     :NEW.date_update := sysdate;
   end if;
END;
/


ALTER TABLE MOB_PAY_REQUEST add USER_CREATED varchar2(30);
COMMENT ON COLUMN MOB_PAY_REQUEST.USER_CREATED IS '��������� ������������';


GRANT DELETE, INSERT, SELECT, UPDATE ON MOB_PAY_REQUEST TO CORP_MOBILE_ROLE;

GRANT SELECT ON MOB_PAY_REQUEST TO CORP_MOBILE_ROLE_RO;
