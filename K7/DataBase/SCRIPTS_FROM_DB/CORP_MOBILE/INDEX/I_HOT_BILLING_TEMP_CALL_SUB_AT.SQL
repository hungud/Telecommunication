
  CREATE INDEX "CORP_MOBILE"."I_HOT_BILLING_TEMP_CALL_SUB_AT" ON "CORP_MOBILE"."HOT_BILLING_TEMP_CALL" ("DBF_ID", "SUBSCR_NO", "AT_FT_CODE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 3 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "HOT_BILLING" 