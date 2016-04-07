CREATE TABLE ACCOUNTS
(
  ACCOUNT_ID               NUMBER               NOT NULL,
  MOBILE_OPERATOR_NAME_ID  NUMBER               NOT NULL,
  ACCOUNT_NUMBER           NUMBER               NOT NULL,
  LOGIN                    VARCHAR2(30 BYTE)    NOT NULL,
  PASSWORD                 VARCHAR2(30 BYTE)    NOT NULL,
  USER_CREATED             VARCHAR2(30 BYTE)    NOT NULL,
  DATE_CREATED             DATE                 NOT NULL,
  USER_LAST_UPDATED        VARCHAR2(30 BYTE)    NOT NULL,
  DATE_LAST_UPDATED        DATE                 NOT NULL
);

COMMENT ON TABLE ACCOUNTS IS '������� ����� �����������';
COMMENT ON COLUMN ACCOUNTS.ACCOUNT_ID IS '�� ������';
COMMENT ON COLUMN ACCOUNTS.MOBILE_OPERATOR_NAME_ID IS '��� ��������� ������� ����� MOBILE_OPERATOR_NAMES.MOBILE_OPERATOR_NAME_ID';
COMMENT ON COLUMN ACCOUNTS.ACCOUNT_NUMBER IS '����� �������� �����';
COMMENT ON COLUMN ACCOUNTS.LOGIN IS '����� (��� ����� ���������)';
COMMENT ON COLUMN ACCOUNTS.PASSWORD IS '������ (��� ����� ���������)';
COMMENT ON COLUMN ACCOUNTS.USER_CREATED IS '������������, ��������� ������';
COMMENT ON COLUMN ACCOUNTS.DATE_CREATED IS '����/����� �������� ������';
COMMENT ON COLUMN ACCOUNTS.USER_LAST_UPDATED IS '������������, ��������������� ������ ���������';
COMMENT ON COLUMN ACCOUNTS.DATE_LAST_UPDATED IS '����/����� ��������� �������� ������';



CREATE UNIQUE INDEX ACCOUNT_ID_PK ON ACCOUNTS
(ACCOUNT_ID);


CREATE SEQUENCE S_NEW_ACCOUNT_ID
  START WITH 2
  MAXVALUE 9999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE OR REPLACE TRIGGER TUI_ACCOUNT
BEFORE INSERT OR UPDATE
ON ACCOUNTS
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
BEGIN

 IF INSERTING THEN
    IF NVL(:NEW.ACCOUNT_ID, 0) = 0 then
      :NEW.ACCOUNT_ID := S_NEW_ACCOUNT_ID.NEXTVAL;
    END IF;
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
    :NEW.USER_LAST_UPDATED := USER;
    :NEW.DATE_LAST_UPDATED := SYSDATE;
  END IF;
  if UPDATING THEN
    :NEW.USER_LAST_UPDATED := USER;
    :NEW.DATE_LAST_UPDATED := SYSDATE;
  end if;
END ;
/


ALTER TABLE ACCOUNTS ADD (
  CONSTRAINT ACCOUNT_ID_PK
  PRIMARY KEY
  (ACCOUNT_ID)
  USING INDEX ACCOUNT_ID_PK
  ENABLE VALIDATE);

ALTER TABLE ACCOUNTS ADD (
  CONSTRAINT MOBILE_OPERATOR_NAME_ID_FK 
  FOREIGN KEY (MOBILE_OPERATOR_NAME_ID) 
  REFERENCES MOBILE_OPERATOR_NAMES (MOBILE_OPERATOR_NAME_ID)
  ENABLE VALIDATE);

ALTER TABLE BUSINESS_COMM.ACCOUNTS
 ADD CONSTRAINT UN_ACCOUNT_NUMBER
  UNIQUE (ACCOUNT_NUMBER)
  ENABLE VALIDATE
;

GRANT SELECT ON S_NEW_ACCOUNT_ID TO BUSINESS_COMM_ROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON ACCOUNTS TO BUSINESS_COMM_ROLE;

GRANT SELECT, UPDATE ON ACCOUNTS TO BUSINESS_COMM_ROLE_RO;

CREATE INDEX I_ACCOUNTS_LOGIN_ACC_NUMBER_mo ON ACCOUNTS
  (account_id, mobile_operator_name_id, ACCOUNT_NUMBER, LOGIN);
  
ALTER TABLE ACCOUNTS ADD(BRANCH VARCHAR2(15 CHAR));  
COMMENT ON COLUMN ACCOUNTS.BRANCH IS '������� ��� ������';

-- ��������� foreign key - ������ �� ������� ����������, ������� ������� mobile_operator_name_id. 
-- ������� branch, ������������ � filials
alter table accounts add filial_id number;
comment on column accounts.filial_id is '������ ��������� FILIALS.FILIAL_ID';
update accounts set filial_id = decode(mobile_operator_name_id,31,81,mobile_operator_name_id);
commit;
alter table ACCOUNTS modify filial_id not null;
alter table ACCOUNTS
  add constraint FK_FILIAL_ID foreign key (FILIAL_ID)
  references filials (FILIAL_ID);
select * from accounts; -- ��������� ������  
alter table ACCOUNTS drop constraint ACC_MOBILE_OPERATOR_NAME_ID_FK;    
alter table ACCOUNTS drop column mobile_operator_name_id;
alter table ACCOUNTS drop column branch;