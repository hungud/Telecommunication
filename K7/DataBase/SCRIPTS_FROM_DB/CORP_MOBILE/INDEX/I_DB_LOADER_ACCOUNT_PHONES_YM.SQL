
  CREATE INDEX "CORP_MOBILE"."I_DB_LOADER_ACCOUNT_PHONES_YM" ON "CORP_MOBILE"."DB_LOADER_ACCOUNT_PHONES" ("YEAR_MONTH") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 1 
  STORAGE(INITIAL 12582912 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 