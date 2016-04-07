
  CREATE OR REPLACE FORCE VIEW "LONTANA"."CRM_V_USERS" ("USER_NAME_ID", "USER_NAME", "USER_NAME_OKTEL", "PASSWORD_OKTEL", "USER_FIO", "RIGHTS_TYPE", "RESPONSIBLE_STATUS", "LAST_ACTIVE", "WORK_WITH_IVR", "LAST_CRM_PHONEUNREF_ID", "VIEW_OPERATOR_LOG", "CRM_ADMIN", "CONTRACT_ACTIVE_CHAT", "WORK_WITH_CHAT", "IS_NOT_BREAK_CHAT", "TICKETS_PER_PAGE", "WORK_WITH_TARIFF_ACTIVATION") AS 
  SELECT
--
--#Version=3
--
--v.3 Афросин - 09.12.2015 Добавил поле work_with_tariff_activation
--                        убрал поле encrypted_password
--v.2 Афросин - 27.11.2015 Добавил поле encrypted_password
--   
         USER_NAME_ID,
          USER_NAME,
          USER_NAME_OKTEL,
          PASSWORD_OKTEL,
          USER_FIO,
          RIGHTS_TYPE,
          RESPONSIBLE_STATUS,
          LAST_ACTIVE,
          work_with_ivr,
          LAST_CRM_PHONEUNREF_ID,
          VIEW_OPERATOR_LOG,
          CRM_ADMIN,
          CONTRACT_ACTIVE_CHAT,
          WORK_WITH_CHAT,
		  IS_NOT_BREAK_CHAT,
		  TICKETS_PER_PAGE,
      work_with_tariff_activation
      
     FROM USER_NAMES