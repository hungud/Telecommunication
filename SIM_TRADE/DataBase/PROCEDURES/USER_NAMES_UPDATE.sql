--#IF GETVERSION("USER_NAMES_UPDATE") < 6 THEN
CREATE OR REPLACE PROCEDURE USER_NAMES_UPDATE(
  p_OLD_USER_NAME_ID IN NUMBER, 
  p_USER_NAME_ID IN NUMBER, 
  p_USER_FIO IN VARCHAR2, 
  p_USER_NAME IN VARCHAR2, 
  p_PASSWORD IN VARCHAR2, 
  p_FILIAL_ID IN NUMBER, 
  p_RIGHTS_TYPE IN NUMBER,
  p_CHECK_ALLOW_ACCOUNT IN NUMBER,
  p_ENCRYPT_PWD IN NUMBER,
  user_oktel in varchar2 default null,
  p_PASSWORD_OKTEL in varchar2 default null,
  p_MAX_PROMISED_PAYMENT IN NUMBER default null
  ) IS

--#Version=7
-- 7. �������� ��������� ��������� ���� MAX_PROMISED_PAYMENT
-- 6. ���������� ��������� ��������� ���� PASSWORD_OKTEL
-- 5. �������� ��������� ��������� ���� ENCRYPT_PWD
-- 4. �������� ��������� ��������� ���� CHECK_ALLOW_ACCOUNT

BEGIN
  CHECK_CREATE_USER(p_USER_NAME, p_PASSWORD, p_USER_NAME_ID, p_RIGHTS_TYPE); 
  --
  UPDATE USER_NAMES
  SET
    USER_NAME_ID = p_USER_NAME_ID,
    USER_FIO = p_USER_FIO,
    USER_NAME = p_USER_NAME,
    --PASSWORD = p_PASSWORD,
    FILIAL_ID = p_FILIAL_ID,
    RIGHTS_TYPE = p_RIGHTS_TYPE,
    CHECK_ALLOW_ACCOUNT = p_CHECK_ALLOW_ACCOUNT,
    ENCRYPT_PWD = p_ENCRYPT_PWD,
    user_name_oktel=user_oktel,
    PASSWORD_OKTEL=p_PASSWORD_OKTEL,
	MAX_PROMISED_PAYMENT = p_MAX_PROMISED_PAYMENT
  WHERE
    USER_NAME_ID = p_OLD_USER_NAME_ID;  
END;
/

--#end if
