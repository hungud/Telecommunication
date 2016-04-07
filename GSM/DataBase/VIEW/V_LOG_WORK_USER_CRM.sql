CREATE OR REPLACE FORCE VIEW V_LOG_WORK_USER_CRM
AS
   SELECT cr.USER_NAME_ID,
          cr.CRM_PHONEUNREF_ID,
          cr.BEGIN_DATE,
          CASE
             WHEN ( (SYSDATE + 1 / 24) - cr.END_DATE >= 40 / 24 / 60 / 60)
                  OR (cr.BEGIN_DATE <>
                         (SELECT MAX (LGW.BEGIN_DATE)
                            FROM LOG_WORK_USER_CRM lgw
                           WHERE LGW.USER_NAME_ID = CR.USER_NAME_ID))
             THEN
                cr.END_DATE
             ELSE
                NULL
          END
             END_DATE
     FROM LOG_WORK_USER_CRM cr;
   
CREATE SYNONYM CRM_USER.V_LOG_WORK_USER_CRM FOR V_LOG_WORK_USER_CRM;

GRANT SELECT ON V_LOG_WORK_USER_CRM TO CRM_USER;   