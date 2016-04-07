CREATE OR REPLACE FUNCTION GET_login_BY_PHONE_M(
  pPHONE_NUMBER IN VARCHAR2,
  mont date) RETURN varchar2 IS
--Vesion=2
--
--v.2 Афросин переделал получение account_id c DB_LOADER_ACCOUNT_PHONES на db_loader_phone_stat
--
CURSOR C IS
  SELECT acs.login
    FROM DB_LOADER_PHONE_STAT, accounts acs
    WHERE DB_LOADER_PHONE_STAT.PHONE_NUMBER=pPHONE_NUMBER
    and acs.account_id=DB_LOADER_PHONE_STAT.ACCOUNT_ID
    and  DB_LOADER_PHONE_STAT.YEAR_MONTH=to_char(mont,'yyyymm');
DUMMY varchar2(30);
ITOG varchar2(30);
BEGIN
  OPEN C;
  FETCH C INTO DUMMY;
  IF C%FOUND THEN
    ITOG:=DUMMY;
  ELSE
    ITOG:='';
  END IF;
  CLOSE C;
  RETURN ITOG;
END;
/