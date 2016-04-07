CREATE OR REPLACE VIEW CRM_V_USERS
AS
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
      
     FROM USER_NAMES;


DROP SYNONYM CRM_USER.OPERATORS;

CREATE SYNONYM CRM_USER.OPERATORS FOR LONTANA.CRM_V_USERS;


GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE, ON COMMIT REFRESH, QUERY REWRITE, DEBUG, FLASHBACK ON CRM_V_USERS TO CRM_USER;