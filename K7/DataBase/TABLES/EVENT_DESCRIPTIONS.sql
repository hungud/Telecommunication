CREATE TABLE EVENT_DESCRIPTIONS (
  EVENT_CODE VARCHAR2(50) CONSTRAINT PK_EVENT_DESCRIPTION PRIMARY KEY,
  DESCRIPTION VARCHAR2(100),
  IMAGE_BMP BLOB
);

COMMENT ON TABLE EVENT_DESCRIPTIONS IS '�������� ����� �������';

-- �����:
begin 
  EXECUTE IMMEDIATE 'GRANT SELECT ON EVENT_DESCRIPTIONS TO &MAIN_SCHEMA'||'_ROLE';
  EXECUTE IMMEDIATE 'GRANT SELECT ON EVENT_DESCRIPTIONS TO &MAIN_SCHEMA'||'_ROLE_RO'; 
end;
