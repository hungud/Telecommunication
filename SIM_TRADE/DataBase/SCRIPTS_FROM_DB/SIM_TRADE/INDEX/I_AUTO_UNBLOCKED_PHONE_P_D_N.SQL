
  CREATE INDEX "SIM_TRADE"."I_AUTO_UNBLOCKED_PHONE_P_D_N" ON "SIM_TRADE"."AUTO_UNBLOCKED_PHONE" ("PHONE_NUMBER", "UNBLOCK_DATE_TIME", "NOTE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 1 
  STORAGE(INITIAL 20971520 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 