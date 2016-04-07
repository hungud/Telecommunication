--
-- BILL_BLOB  (Table)
--
create table BILL_BLOB
(
  filename VARCHAR2(200),
  data     BLOB,
  smonth   VARCHAR2(7),
  slogin   VARCHAR2(20),
  state    NUMBER
);
GRANT SELECT,UPDATE,DELETE ON BILL_BLOB TO CORP_MOBILE_ROLE;
GRANT SELECT ON BILL_BLOB TO CORP_MOBILE_ROLE_RO;