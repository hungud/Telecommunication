CREATE OR REPLACE FORCE VIEW V_USER_NAME_RO AS
  SELECT
--#Version=1
         UPPER (USER_NAME) USER_NAME
     FROM USER_NAMES
    WHERE RIGHTS_TYPE = 2;  -- ������ ��������;

GRANT SELECT ON V_USER_NAME_RO TO CORP_MOBILE_ROLE;

GRANT SELECT ON V_USER_NAME_RO TO CORP_MOBILE_ROLE_RO;