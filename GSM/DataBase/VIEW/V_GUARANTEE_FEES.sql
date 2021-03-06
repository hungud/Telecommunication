CREATE OR REPLACE VIEW V_GUARANTEE_FEES
as
--
--Version=1
--
--v1  ������� 23.05.2015 ����� ����� � ����������� �� ����������� ������
--

  SELECT 
    GF.ACCOUNT_ID, 
    GF.BILL_NUMBER, 
    GF.DATE_CREATED,
    GF.DATE_UPDATE,
    GF.GUARANTEE_FEES_ID,
    GF.NOT_PAID, GF.PAID,
    GF.PHONE_NUMBER,
    GF.RETURNED,
    GF.STATUS_GUARANT_FEE,
    GF.SUM_GUARANT_FEE,
    GF.USER_CREATED,
    GF.USER_UPDATE,
    GF.WITHDRAWN,
    GF.YEAR_MONTH,
    AC.ACCOUNT_NUMBER,
    AC.LOGIN
    FROM  GUARANTEE_FEES gf, ACCOUNTS ac
  where gf.account_id = ac.account_id;
  
GRANT SELECT ON V_GUARANTEE_FEES TO LONTANA_ROLE;
GRANT SELECT ON V_GUARANTEE_FEES TO LONTANA_ROLE_RO;   
  
  