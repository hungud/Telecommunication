CREATE TABLE AGENTS_AND_SUBAGENTS
(
  AGENTS_AND_SUBAGENT_ID           INTEGER PRIMARY KEY NOT NULL,
  AGENT_ID         INTEGER NOT NULL,
  SUB_AGENT_ID      INTEGER NOT NULL,
  USER_CREATED       VARCHAR2(30 Char) NOT NULL,
  DATE_CREATED       DATE NOT NULL,
  USER_LAST_UPDATED  VARCHAR2(30 Char) NOT NULL,
  DATE_LAST_UPDATED  DATE NOT NULL,
  
  CONSTRAINT FK_AGENT_ID
  FOREIGN KEY (AGENT_ID) 
  REFERENCES AGENTS (AGENT_ID)
  ENABLE VALIDATE,
  CONSTRAINT FK_SUB_AGENT_ID 
  FOREIGN KEY (SUB_AGENT_ID) 
  REFERENCES SUB_AGENTS (SUB_AGENT_ID)
  ENABLE VALIDATE
);

COMMENT ON TABLE AGENTS_AND_SUBAGENTS IS '����������� ����������� ������ � ���������';

COMMENT ON COLUMN AGENTS_AND_SUBAGENTS.AGENTS_AND_SUBAGENT_ID IS '��������� ����';

COMMENT ON COLUMN AGENTS_AND_SUBAGENTS.AGENT_ID IS '������������� ������ �� ����������� ������ (AGENTS.AGENT_ID)';

COMMENT ON COLUMN AGENTS_AND_SUBAGENTS.SUB_AGENT_ID IS '������������� ������ �� ����������� ��������� (SUB_AGENTS.SUB_AGENT_ID)';

COMMENT ON COLUMN AGENTS_AND_SUBAGENTS.USER_CREATED IS '������������, ��������� ������';

COMMENT ON COLUMN AGENTS_AND_SUBAGENTS.DATE_CREATED IS '����/����� �������� ������';

COMMENT ON COLUMN AGENTS_AND_SUBAGENTS.USER_LAST_UPDATED IS '������������, ��������������� ������ ���������';

COMMENT ON COLUMN AGENTS_AND_SUBAGENTS.DATE_LAST_UPDATED IS '����/����� ��������� �������� ������';

CREATE SEQUENCE S_AGENTS_AND_SUBAGENT_ID
  START WITH 0
  MAXVALUE 9999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;

GRANT SELECT ON S_AGENTS_AND_SUBAGENT_ID TO BUSINESS_COMM_ROLE;

CREATE OR REPLACE TRIGGER TIU_AGENTS_AND_SUBAGENTS
--
--#Version=1
--
  BEFORE INSERT OR UPDATE ON AGENTS_AND_SUBAGENTS FOR EACH ROW
BEGIN
  IF INSERTING THEN
    IF NVL(:NEW.AGENTS_AND_SUBAGENT_ID, 0) = 0 THEN
      :NEW.AGENTS_AND_SUBAGENT_ID := S_AGENTS_AND_SUBAGENT_ID.NEXTVAL ;
    END IF;
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
  END IF;

  :NEW.USER_LAST_UPDATED := USER;
  :NEW.DATE_LAST_UPDATED := SYSDATE;

  
END;
/

GRANT DELETE, INSERT, SELECT, UPDATE ON AGENTS_AND_SUBAGENTS TO BUSINESS_COMM_ROLE;

GRANT SELECT, UPDATE ON AGENTS_AND_SUBAGENTS TO BUSINESS_COMM_ROLE_RO;