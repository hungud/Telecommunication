CREATE OR REPLACE PROCEDURE RECALC_BANS_AND_PHONE_STATUS IS
--
--VERSION=2
--
--v.2 ������� 17.05.2015 ��������������� ��������� �������� ���������� �������
--��������� ������� ��� �������������� ������

   ERR VARCHAR2(1000);
BEGIN
  FOR  rec IN (SELECT ACCOUNT_ID    
                 FROM ACCOUNTS
                 WHERE IS_COLLECTOR=1) 
  LOOP
    
    ERR := BEELINE_API_PCKG.Collect_account_BANS(rec.ACCOUNT_ID);
    
    IF ERR='' THEN        
      ERR := BEELINE_API_PCKG.Collect_account_phone_status;--(rec.ACCOUNT_ID);
    END IF;
    
  END LOOP;
END;
/