CREATE OR REPLACE VIEW V_PHONE_NUMBER_FOR_BLOCK_SAVE AS 
--Version=6
--Version=5 ���������� ����� �������� ��� ����������� ������� ������ ������ �� �������� �������. + SYSDATE-1 - ��� ���� �� ������ �7 - ���-�� �� �������.
--Version=6. �������� ��������� ������ ���� ����� description � dop_status

  SELECT P.ACCOUNT_ID,
         P.YEAR_MONTH,
         P.PHONE_NUMBER,
         DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE,
         GET_ABONENT_BALANCE(P.PHONE_NUMBER) BALANCE,
         V.SURNAME
          || ' '
          || V.NAME
          || ' '
          || V.PATRONYMIC FIO,
         V.DESCRIPTION,
         V.DOP_STATUS
    FROM DB_LOADER_ACCOUNT_PHONES P,
         DB_LOADER_ACCOUNT_PHONE_HISTS,
         V_ABONENT_BALANCES_2 V       
    WHERE P.YEAR_MONTH=(SELECT MAX(P2.YEAR_MONTH)
                          FROM DB_LOADER_ACCOUNT_PHONES P2
                          WHERE P2.ACCOUNT_ID=P.ACCOUNT_ID)
      AND P.PHONE_NUMBER=DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_NUMBER(+)
      AND P.PHONE_IS_ACTIVE=0
      AND P.CONSERVATION=0   
      AND DB_LOADER_ACCOUNT_PHONE_HISTS.END_DATE>SYSDATE
      AND DB_LOADER_ACCOUNT_PHONE_HISTS.BEGIN_DATE<SYSDATE-1
      AND DB_LOADER_ACCOUNT_PHONE_HISTS.PHONE_IS_ACTIVE=0
      AND P.PHONE_NUMBER=V.PHONE_NUMBER_FEDERAL(+);
    
GRANT SELECT ON V_PHONE_NUMBER_FOR_BLOCK_SAVE TO CORP_MOBILE_ROLE;   

GRANT SELECT ON V_PHONE_NUMBER_FOR_BLOCK_SAVE TO CORP_MOBILE_ROLE_RO;  