create table MN_ROAMING_CALL_DESC
(
  MN_ROAMING_CALL_DESC_ID INTEGER primary key,
  CALL_DESC varchar2(250 char),
  ROAMING_PROVIDER_ID INTEGER,
  DATE_CREATED DATE,
  USER_CREATED varchar2(30 char),
  DATE_UPDATED DATE,
  USER_UPDATED varchar2(30 char),
  
  CONSTRAINT ROAMING_PROVIDER_ID
    FOREIGN KEY (ROAMING_PROVIDER_ID)
    REFERENCES ROAMING_PROVIDERS(ROAMING_PROVIDER_ID)
  
);

comment on table MN_ROAMING_CALL_DESC is '������� ������������ ����������� ������ � ROAMING_PROVIDERS.ROAMING_PROVIDER_ID';

comment on column MN_ROAMING_CALL_DESC.MN_ROAMING_CALL_DESC_ID is 'ID ������';
comment on column MN_ROAMING_CALL_DESC.CALL_DESC is '����������� ������ �� CALL_* ���� at_ft_de';

comment on column MN_ROAMING_CALL_DESC.ROAMING_PROVIDER_ID is '�� ���������� �� ROAMING_PROVIDERS.ROAMING_PROVIDER_ID';
comment on column MN_ROAMING_CALL_DESC.DATE_CREATED is '���� ��������';
comment on column MN_ROAMING_CALL_DESC.USER_CREATED is '��������� ������������';
comment on column MN_ROAMING_CALL_DESC.DATE_CREATED is '���� ����������';
comment on column MN_ROAMING_CALL_DESC.USER_CREATED is '���������� ������������';


CREATE SEQUENCE S_MN_ROAMING_CALL_DESC_ID
  START WITH 1
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;




CREATE OR REPLACE TRIGGER TIU_MN_ROAMING_CALL_DESC
--#Version=1
  BEFORE INSERT OR UPDATE ON MN_ROAMING_CALL_DESC FOR EACH ROW
BEGIN
  IF INSERTING THEN
    :NEW.DATE_CREATED := SYSDATE;  
    :NEW.USER_CREATED := USER;
    IF NVL(:NEW.MN_ROAMING_CALL_DESC_ID, 0) = 0 THEN
      :NEW.MN_ROAMING_CALL_DESC_ID := S_MN_ROAMING_CALL_DESC_ID.NEXTVAL; 
    END IF;
  END IF;
  
  IF UPDATING THEN
    :NEW.DATE_UPDATED := SYSDATE;  
    :NEW.USER_UPDATED := USER;
  END IF;
  
END;
/
