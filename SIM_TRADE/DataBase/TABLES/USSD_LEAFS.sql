CREATE SEQUENCE S_NEW_LEAF_ID
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;

CREATE TABLE USSD_LEAFS (
       LEAF_ID INTEGER PRIMARY KEY,
       USSD    VARCHAR2(50),
       USSD_LVL integer,
       SERVICE integer,
       RESPONSE VARCHAR2(50),
       TEXT_RU varchar2(200),
       TEXT_TR varchar2(200),
       TEXT_EN varchar2(200),
       USSD_END number(1),
       SQL_T varchar2(200)
);

CREATE OR REPLACE FUNCTION NEW_LEAF_ID RETURN NUMBER IS
--#Version=1
  vRES NUMBER;
BEGIN
  SELECT S_NEW_LEAF_ID.NEXTVAL
    INTO vRES
    FROM DUAL;
  RETURN vRES;
END;

CREATE OR REPLACE TRIGGER TI_USSD_LEAFS
  BEFORE INSERT ON USSD_LEAFS FOR EACH ROW
--#Version=1
BEGIN
    :NEW.LEAF_ID := NEW_LEAF_ID;
END;

--GRANT DELETE, INSERT, SELECT, UPDATE ON USSD_LEAFS TO CORP_MOBILE_ROLE;

--GRANT SELECT ON USSD_LEAFS TO CORP_MOBILE_ROLE_RO;  

ALter table USSD_LEAFS Add (DESCRPTION varchar2(200));
COMMENT ON TABLE USSD_LEAFS IS '������� ������� �� USSD- �������';
COMMENT ON COLUMN USSD_LEAFS.LEAF_ID IS 'ID �������';
COMMENT ON COLUMN USSD_LEAFS.USSD IS 'USSD �������';
COMMENT ON COLUMN USSD_LEAFS.USSD_LVL IS '������� ����, ��� ������������ �������';
COMMENT ON COLUMN USSD_LEAFS.SERVICE IS '';
COMMENT ON COLUMN USSD_LEAFS.RESPONSE IS '';
COMMENT ON COLUMN USSD_LEAFS.TEXT_RU IS '����� ������ �� ������� �����';
COMMENT ON COLUMN USSD_LEAFS.TEXT_TR IS '����� ������ � ���������';
COMMENT ON COLUMN USSD_LEAFS.TEXT_EN IS '����� ������ �� ���������� �����';
COMMENT ON COLUMN USSD_LEAFS.SQL_T IS '������, ����������� ��� �������';
COMMENT ON COLUMN USSD_LEAFS.CHECK_NUMBER IS '';