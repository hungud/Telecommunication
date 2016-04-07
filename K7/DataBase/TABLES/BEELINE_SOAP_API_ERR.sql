-- Create table
create table BEELINE_SOAP_API_ERR
(
  soap_err_id  INTEGER not null,
  err_code     VARCHAR2(6),
  err_eng_text VARCHAR2(2000),
  err_rus_text VARCHAR2(2000)
);
-- Create/Recreate indexes 
create index I_BSAE_ERR_CODE on BEELINE_SOAP_API_ERR (ERR_CODE);
-- Create/Recreate primary, unique and foreign key constraints 
alter table BEELINE_SOAP_API_ERR
  add constraint PK_BSAE primary key (SOAP_ERR_ID);
-- Grant/Revoke object privileges 
grant select, insert, update, delete on BEELINE_SOAP_API_ERR to CORP_MOBILE_ROLE;
grant select on BEELINE_SOAP_API_ERR to CORP_MOBILE_ROLE_RO;

ALTER TABLE BEELINE_SOAP_API_ERR ADD IS_BREAK_TOKEN NUMBER(1);

COMMENT ON COLUMN BEELINE_SOAP_API_ERR.IS_BREAK_TOKEN IS 'Признак, является ли такая ошибка признаком "испорченного" токена'; 