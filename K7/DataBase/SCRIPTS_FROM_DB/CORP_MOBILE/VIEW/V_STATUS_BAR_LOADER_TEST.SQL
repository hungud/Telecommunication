
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_STATUS_BAR_LOADER_TEST" ("DATE_OF_TEST", "API", "E_CARE", "OLD_CAB") AS 
  select t.date_time date_of_test
 ,decode(t.err,0,1,0) api
 ,ms_constants.GET_CONSTANT_VALUE('TEST_e-Care_PASS_OK') e_care
 ,ms_constants.GET_CONSTANT_VALUE('TEST_Bee_Old_PASS_OK') old_cab
 from log_work_service t
 where t.log_spr_id=3
 and t.date_time=(select max(r.date_time) from log_work_service r where r.log_spr_id=3)
