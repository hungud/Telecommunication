CREATE OR REPLACE procedure hot_billing_save_call1 is
begin
  -- Call the procedure
  hot_billing_PCKG.SAVE_CALL(1,0,0);  
    
  -- ����� � �������� ������ �� ��� � ��
  DELETE_DOUBLE_DETAIL (sysdate);
end;
/
