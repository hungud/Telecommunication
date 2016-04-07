CREATE TABLE TARIFFS(
  TARIFF_ID          INTEGER                    NOT NULL,
  TARIFF_CODE        VARCHAR2(30 CHAR),
  OPERATOR_ID        INTEGER,
  TARIFF_NAME        VARCHAR2(100 CHAR),
  IS_ACTIVE          NUMBER(1),
  START_BALANCE      NUMBER,
  CONNECT_PRICE      NUMBER,
  ADVANCE_PAYMENT    NUMBER,
  USER_CREATED       VARCHAR2(30 CHAR),
  DATE_CREATED       DATE,
  USER_LAST_UPDATED  VARCHAR2(30 CHAR),
  DATE_LAST_UPDATED  DATE
  );

ALTER TABLE TARIFFS ADD DAYLY_PAYMENT NUMBER(15, 2) DEFAULT 0;

COMMENT ON COLUMN TARIFFS.DAYLY_PAYMENT IS '����������� ����� �� ������';

ALTER TABLE TARIFFS ADD DAYLY_PAYMENT_LOCKED NUMBER(15, 2) DEFAULT 0;

COMMENT ON COLUMN TARIFFS.DAYLY_PAYMENT_LOCKED IS '����������� ����� �� ������ (�������������)';

ALTER TABLE TARIFFS ADD MONTHLY_PAYMENT NUMBER(15, 2) DEFAULT 0;

COMMENT ON COLUMN TARIFFS.MONTHLY_PAYMENT IS '����������� ����� �� ������ � ���.';

ALTER TABLE TARIFFS ADD MONTHLY_PAYMENT_LOCKED NUMBER(15, 2) DEFAULT 0;

COMMENT ON COLUMN TARIFFS.MONTHLY_PAYMENT_LOCKED IS '����������� ����� �� ������ � ���. (�������������)';

ALTER TABLE TARIFFS ADD FREE_MONTH_MINUTES_CNT_FOR_RPT NUMBER(6, 0);


COMMENT ON TABLE TARIFFS IS '�������� �����';

COMMENT ON COLUMN TARIFFS.TARIFF_ID IS '��������� ����';

COMMENT ON COLUMN TARIFFS.TARIFF_NAME IS '������������ ��������� �����';

COMMENT ON COLUMN TARIFFS.TARIFF_CODE IS '��� ��������� �����';

COMMENT ON COLUMN TARIFFS.OPERATOR_ID IS '��� ��������� ������� �����';

COMMENT ON COLUMN TARIFFS.IS_ACTIVE IS '�������� (����� ���������� ��������� �� ����)';

COMMENT ON COLUMN TARIFFS.START_BALANCE IS '��������� ������';

COMMENT ON COLUMN TARIFFS.CONNECT_PRICE IS '��������� �����������';

COMMENT ON COLUMN TARIFFS.ADVANCE_PAYMENT IS '��������� ������';

COMMENT ON COLUMN TARIFFS.USER_CREATED IS '������������, ��������� ������';

COMMENT ON COLUMN TARIFFS.DATE_CREATED IS '����/����� �������� ������';

COMMENT ON COLUMN TARIFFS.USER_LAST_UPDATED IS '������������, ��������������� ������ ���������';

COMMENT ON COLUMN TARIFFS.DATE_LAST_UPDATED IS '����/����� ��������� �������� ������';

COMMENT ON COLUMN TARIFFS.FREE_MONTH_MINUTES_CNT_FOR_RPT IS '���������� ���������� ����� � �����, ��� ���������� ������� ����� �������� �������� � ����� �� ���������� �������';

CREATE INDEX I_TARIFFS_OPERATOR_ID ON TARIFFS
(OPERATOR_ID)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX PK_TARIFFS ON TARIFFS
(TARIFF_ID)
LOGGING
NOPARALLEL;

CREATE SEQUENCE S_NEW_TARIFF_ID
  START WITH 61
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;


CREATE OR REPLACE FUNCTION NEW_TARIFF_ID RETURN NUMBER IS
--#Version=1
  vRES NUMBER;
BEGIN
  SELECT S_NEW_TARIFF_ID.NEXTVAL
  INTO vRES
  FROM DUAL;
  RETURN vRES;
END;
/

SHOW ERRORS;

CREATE OR REPLACE TRIGGER CORP_MOBILE.TU_TARIFFS
BEFORE UPDATE
ON CORP_MOBILE.TARIFFS
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  IF UPDATING THEN  
    p_new_tarif(:OLD.TARIFF_ID); 
  END IF;          
END;

CREATE OR REPLACE TRIGGER TIU_TARIFFS
  BEFORE INSERT OR UPDATE ON TARIFFS FOR EACH ROW
--#Version=1
BEGIN
  IF INSERTING THEN
    IF NVL(:NEW.TARIFF_ID, 0) = 0 then
      :NEW.TARIFF_ID := NEW_TARIFF_ID;
    END IF;
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
  END IF;
  :NEW.USER_LAST_UPDATED := USER;
  :NEW.DATE_LAST_UPDATED := SYSDATE;
END;
/
SHOW ERRORS;

ALTER TABLE TARIFFS ADD BALANCE_BLOCK NUMBER(12,2);

COMMENT ON COLUMN TARIFFS.BALANCE_BLOCK IS '����� ����������';

ALTER TABLE TARIFFS ADD BALANCE_UNBLOCK NUMBER(12,2);

COMMENT ON COLUMN TARIFFS.BALANCE_UNBLOCK IS '����� �������������';

ALTER TABLE TARIFFS ADD BALANCE_NOTICE NUMBER(12,2);

COMMENT ON COLUMN TARIFFS.BALANCE_NOTICE IS '����� ��������������';

ALTER TABLE TARIFFS ADD TARIFF_ADD_COST NUMBER(12,2);

COMMENT ON COLUMN TARIFFS.TARIFF_ADD_COST IS '���������� ��������� ��� ������';

ALTER TABLE TARIFFS ADD BALANCE_BLOCK_CREDIT NUMBER(12,2);

COMMENT ON COLUMN TARIFFS.BALANCE_BLOCK_CREDIT IS '����� ����������';

ALTER TABLE TARIFFS ADD BALANCE_UNBLOCK_CREDIT NUMBER(12,2);

COMMENT ON COLUMN TARIFFS.BALANCE_UNBLOCK_CREDIT IS '����� �������������';

ALTER TABLE TARIFFS ADD BALANCE_NOTICE_CREDIT NUMBER(12,2);

COMMENT ON COLUMN TARIFFS.BALANCE_NOTICE_CREDIT IS '����� ��������������';

ALTER TABLE TARIFFS ADD   TARIFF_CODE_CRM        VARCHAR2(50 CHAR);

COMMENT ON COLUMN TARIFFS.TARIFF_CODE_CRM IS '��� ��������� ����� �� CRM';

ALTER TABLE TARIFFS ADD TARIFF_PRIORITY INTEGER;

COMMENT ON COLUMN TARIFFS.TARIFF_PRIORITY IS '��������� ��������� �����';

ALTER TABLE TARIFFS ADD TARIFF_ABON_DAILY_PAY INTEGER;

COMMENT ON COLUMN TARIFFS.TARIFF_ABON_DAILY_PAY IS '������ ����������� �� ����(GSM)';

ALTER TABLE TARIFFS ADD TARIFF_ACTION_PLUS_SMS INTEGER;

COMMENT ON COLUMN TARIFFS.TARIFF_ACTION_PLUS_SMS IS '������� ����� + � ���300';

create unique index I_TARIFFS_CODE_PRIORITY_ID on TARIFFS (TARIFF_CODE, NVL(TARIFF_PRIORITY,9999), TARIFF_ID);

-- ������ ��� GSM 
CREATE UNIQUE INDEX UNQ_TRF_CODE_CRM ON TARIFFS
(TARIFF_CODE_CRM)
LOGGING
NOPARALLEL;

-- ������ ��� GSM 
ALTER TABLE TARIFFS
MODIFY(TARIFF_CODE_CRM  NOT NULL);

ALTER TABLE TARIFFS ADD FILIAL_ID INTEGER;

COMMENT ON COLUMN TARIFFS.FILIAL_ID IS '������';

ALTER TABLE TARIFFS ADD OPERATOR_MONTHLY_ABON_ACTIV NUMBER(13, 2);

COMMENT ON COLUMN TARIFFS.OPERATOR_MONTHLY_ABON_ACTIV IS '�������� ����. ��. ��� ��������';

ALTER TABLE TARIFFS ADD OPERATOR_MONTHLY_ABON_BLOCK NUMBER(13, 2);

COMMENT ON COLUMN TARIFFS.OPERATOR_MONTHLY_ABON_BLOCK IS '�������� ����. ��. � ����. ����������';

ALTER TABLE TARIFFS ADD DISCR_SPISANIE NUMBER(1, 0);

COMMENT ON COLUMN TARIFFS.DISCR_SPISANIE IS '���������� �������� ����������� �����';

ALTER TABLE TARIFFS ADD SDVIG_SPISANIY INTEGER;

COMMENT ON COLUMN TARIFFS.SDVIG_SPISANIY IS '����� �������� ����������� �����(1 - �� 1 ���� ������, -2 - �� 2 ��� �����)';

ALTER TABLE TARIFFS ADD TRAFFIC_NOT_IGNOR_FOR_INACTIVE INTEGER;	

COMMENT ON COLUMN TARIFFS.TRAFFIC_NOT_IGNOR_FOR_INACTIVE IS '�� ������������ �������� ������ (��� ������ - ������ � ������������� �����������)';

ALTER TABLE TARIFFS ADD SDVIG_DISCR_SPISANIE INTEGER;

COMMENT ON COLUMN TARIFFS.SDVIG_DISCR_SPISANIE IS '����� ����������� �������� ����������� �����(1 - ���������� ����� 1�� ������, 0 - ����� ����������)';

ALTER TABLE TARIFFS ADD SHOW_TO_USER_FOR_ADD_CONTR NUMBER(1);  

COMMENT ON COLUMN TARIFFS.SHOW_TO_USER_FOR_ADD_CONTR IS '���������� ����� �������������, ��� ��������� ����, ��� ��������� ������ ��������';

ALTER TABLE TARIFFS ADD ACCESS_UNLOCK_SAVE NUMBER(1) DEFAULT 1;  

COMMENT ON COLUMN TARIFFS.ACCESS_UNLOCK_SAVE IS '�������� �� ������� ������� ������ �� ����������.';

ALTER TABLE TARIFFS ADD NUMBER_TARIFF_IVR INTEGER;
COMMENT ON COLUMN TARIFFS.NUMBER_TARIFF_IVR IS '����� ������ � ��������� ���� IVR ��� ��������� ��������';

CREATE SYNONYM WWW_DEALER.TARIFFS FOR TARIFFS;