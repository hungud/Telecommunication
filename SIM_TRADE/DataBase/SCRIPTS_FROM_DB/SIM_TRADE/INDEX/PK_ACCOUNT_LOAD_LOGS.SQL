
  CREATE UNIQUE INDEX "SIM_TRADE"."PK_ACCOUNT_LOAD_LOGS" ON "SIM_TRADE"."ACCOUNT_LOAD_LOGS" ("ACCOUNT_LOAD_LOG_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 2097152 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 