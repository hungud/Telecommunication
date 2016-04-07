-- Create sequence 
create sequence S_NEW_PHONE_REPORT_COLUMNS_ID nocache;

-- Create table
create table PHONE_REPORT_COLUMNS
(
  phone_report_column_id NUMBER(10) 
    CONSTRAINT PK_PHONE_REPORT_COLUMNS PRIMARY KEY,
  fsql                   VARCHAR2(3000),
  fname                  VARCHAR2(50),
  order_number           NUMBER(5),
  user_created           VARCHAR2(30),
  date_created           DATE,
  user_last_updated      VARCHAR2(30),
  date_last_updated      DATE
);
-- Add comments to the columns 
comment on column PHONE_REPORT_COLUMNS.phone_report_column_id
  is 'PK';
comment on column PHONE_REPORT_COLUMNS.user_created
  is 'пользователь создавший запись';
comment on column PHONE_REPORT_COLUMNS.date_created
  is 'дата создания';
comment on column PHONE_REPORT_COLUMNS.user_last_updated
  is 'пользователь изменивший запись';
comment on column PHONE_REPORT_COLUMNS.date_last_updated
  is 'дата изменения';
comment on column PHONE_REPORT_COLUMNS.fsql
  is 'текст sql запроса';
comment on column PHONE_REPORT_COLUMNS.fname
  is 'наименование поля';
comment on column PHONE_REPORT_COLUMNS.order_number
  is 'порядок сортировки';


create or replace trigger TBIU_PHONE_REP_COL
  before insert OR UPDATE on phone_report_columns
  for each row
begin
  select S_NEW_PHONE_REPORT_COLUMNS_ID.Nextval
    into :NEW.PHONE_REPORT_COLUMN_ID
    from dual;
  IF INSERTING THEN
    :NEW.USER_CREATED := USER;
    :NEW.DATE_CREATED := SYSDATE;
  else
    :NEW.USER_LAST_UPDATED := USER;
    :NEW.DATE_LAST_UPDATED := SYSDATE;
  end if;
end;

create or replace trigger TBI_PHONE_REP_COL
  before insert on phone_report_columns  
  for each row
begin
  :NEW.PHONE_REPORT_COLUMN_ID := S_NEW_PHONE_REPORT_COLUMNS_ID.Nextval;
end;

GRANT DELETE, INSERT, SELECT, UPDATE ON PHONE_REPORT_COLUMNS TO CORP_MOBILE_ROLE;

insert into PHONE_REPORT_COLUMNS (FNAME, FSQL)
( 
  select 'Текущий баланс', 'SELECT get_abonent_balance(:PHONE_NUMBER) FROM DUAL' from dual
  union all
  select 'Статус номера', 'SELECT case when h.PHONE_IS_ACTIVE = 1 then ''Акт.'' else ''Блок.'' end is_active
      from db_loader_account_phones h
      where h.YEAR_MONTH = to_char(sysdate, ''yyyymm'')
        and h.PHONE_NUMBER = :PHONE_NUMBER
        and rownum <=1' from dual
  union all
  select 'Тарифный план', '
    SELECT r.tariff_name
      from db_loader_account_phones h, tariffs r
      where h.YEAR_MONTH = to_char(sysdate, ''yyyymm'')
        and h.PHONE_NUMBER = :PHONE_NUMBER
        and get_phone_tariff_id(h.PHONE_NUMBER,  h.CELL_PLAN_CODE, sysdate) = r.tariff_id (+)
        and rownum <=1' from dual
  union all
  select 'Бан', '
    SELECT r.ACCOUNT_NUMBER
      from db_loader_account_phones h, accounts r
      where h.YEAR_MONTH = to_char(sysdate, ''yyyymm'')
        and h.PHONE_NUMBER = :PHONE_NUMBER
        and h.ACCOUNT_ID = r.ACCOUNT_ID(+)
        and rownum <=1' from dual

 
);
commit;
