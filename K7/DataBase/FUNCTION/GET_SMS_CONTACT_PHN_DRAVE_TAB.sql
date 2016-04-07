CREATE OR REPLACE function GET_SMS_CONTACT_PHN_DRAVE_TAB return TAB_SMS_CONTACT_PHN_DRAVE PIPELINED AS
  
  --version 1
  --
  --v.1 06.10.2015 Алексеев Функцию выдает номера, на контрактные номера которых необходимо отправить смс
  
  CALL_ROW TYPE_SMS_CONTACT_PHN_DRAVE;  
  type t_phn_drave2 is record
    (
      PHONE_NUMBER  VARCHAR2(10 CHAR), 
      TARIFF_NAME varchar2(300),
      SMS_TYPE INTEGER,
      VALUE_TRAFFIC INTEGER
    );
  type t_phn_drave is table of t_phn_drave2 index by pls_integer;
  vt_phn_drave t_phn_drave;  
  
  procedure UPDATE_CONTRACT_PHONE_DRAVE IS
    PRAGMA AUTONOMOUS_TRANSACTION;
  begin
    UPDATE SMS_FOR_CONTRACT_PHONE_DRAVE
          SET IS_POSTED = 1
     WHERE nvl(IS_POSTED, 0) = 0;
    commit;   
  end;
   
BEGIN
  --отбираем номера, на контактные номера которых необходимо отпралять смс
  select 
    DR.PHONE_NUMBER,
    TR.TARIFF_NAME,
    DR.SMS_TYPE,
    DR.VALUE_TRAFFIC    
  bulk collect into vt_phn_drave     
  from SMS_FOR_CONTRACT_PHONE_DRAVE DR, 
          TARIFFS TR
  where DR.TARIFF_ID = TR.TARIFF_ID(+)
      and nvl(DR.IS_POSTED, 0) = 0;
    
  --устанавливаем признак того, что мы их забирали
  --выполняем в автономной транзакции
  UPDATE_CONTRACT_PHONE_DRAVE;  
  
  --выводим номера
  IF vt_phn_drave.COUNT > 0 THEN
    FOR I IN 1..vt_phn_drave.COUNT LOOP
      CALL_ROW := 
        TYPE_SMS_CONTACT_PHN_DRAVE
        (
          vt_phn_drave(I).PHONE_NUMBER, 
          vt_phn_drave(I).TARIFF_NAME,
          vt_phn_drave(I).SMS_TYPE,
          vt_phn_drave(I).VALUE_TRAFFIC
        );
                                 
      PIPE ROW(CALL_ROW);
    END LOOP;   
  END IF;
END;

GRANT EXECUTE ON GET_SMS_CONTACT_PHN_DRAVE_TAB TO  crm_user;