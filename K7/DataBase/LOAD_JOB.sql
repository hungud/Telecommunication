DECLARE
  X NUMBER;
BEGIN
  SYS.DBMS_JOB.SUBMIT
  ( job       => X 
   ,what      => 'LOADER2_PCKG.LOAD_ACCOUNT_DATA(5);'
   ,next_date => SYSDATE
   ,interval  => 'sysdate + 8/24' /* ������ 8 �����*/
   ,no_parse  => FALSE
  );
  SYS.DBMS_OUTPUT.PUT_LINE('Job Number is: ' || to_char(x));
COMMIT;
END;
/


BEGIN
LOADER2_PCKG.LOAD_ACCOUNT_DATA(5);
END;



    SELECT '"'||DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER||'", _' 
    FROM DB_LOADER_ACCOUNT_PHONES
    WHERE DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID=5
    AND DB_LOADER_ACCOUNT_PHONES.PHONE_IS_ACTIVE = 1


SELECT * FROM  DB_LOADER_ACCOUNT_PHONES
WHERE PHONE_NUMBER='9037786212'