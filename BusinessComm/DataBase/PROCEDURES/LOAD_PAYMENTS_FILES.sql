CREATE OR REPLACE PROCEDURE LOAD_PAYMENTS_FILES as
--  
--Version = 2
--
--v.2 17.11.2015 Виртуальный счет для тех платежей, ИНН которых не опредедяется в базе
--v.1 11.11.2015 Добавил процедуру загрузки платежей.
--  
  cDIR_PAYMENT_FILES_NEW CONSTANT VARCHAR2(500 char) := MS_CONSTANTS.GET_CONSTANT_VALUE('DIR_PAYMENT_FILES_NEW');
  cUNKNOWN_INN_ID  CONSTANT INTEGER := TO_NUMBER(NVL(MS_CONSTANTS.GET_CONSTANT_VALUE('UNKNOWN_INN_ID'), '0'));
  
  cursor new_file is
    select
       file_id,
       file_name
    from
      PAYMENTS_FILES
    where
      LOAD_END_DATE is null
    order by file_id;   
  
  procedure LOAD_PAYMENTS_FILE (pDirectory VARCHAR2, pFileName VARCHAR2, pFILE_ID PAYMENTS_FILES.FILE_ID%TYPE) AS
    PRAGMA AUTONOMOUS_TRANSACTION;
    f utl_file.file_type;
    s VARCHAR2(1000 CHAR);
    sName VARCHAR2(30 CHAR);
    sValue VARCHAR2(500 CHAR);

    TYPE PAYMENTS_ARR is table of PAYMENTS%ROWTYPE INDEX BY BINARY_INTEGER;
    rec  PAYMENTS_ARR;

    idx integer;
  --    vPHONE_ID PHONES.PHONE_ID%TYPE;
    
    --получение Идентификатора вирутального лицевого счета по INN
    function GET_VIRTUAL_ACCOUNT_ID_BY_INN (pInn PAYMENTS.INN%TYPE)
      return VIRTUAL_ACCOUNTS.VIRTUAL_ACCOUNTS_ID%TYPE as
      vRes Integer;
    begin
        
      begin
        select
          VIRTUAL_ACCOUNTS_ID into VRes
        from
          VIRTUAL_ACCOUNTS
        where
          inn = pInn;
       exception
        when OTHERS then
          VRes := cUNKNOWN_INN_ID;
      end;
        
      Return VRes;  
        
    end;
      
    function get_line (pFileTmp utl_file.file_type) return varchar2 as
      v_str varchar2 (1000 char);
    begin
      
      utl_file.get_line(pFileTmp, v_str);
      v_str := convert(v_str,'UTF8', 'CL8MSWIN1251');
        
      Return v_str;
    end;
              
  BEGIN
    f := utl_file.fopen(pDirectory, pFileName, 'R');
    idx := 1;
    DELETE FROM PAYMENTS_TEMP;
    LOOP
      BEGIN

        s := get_line(f);

        IF ( SUBSTR(s, 1, INSTR(s, '=')-1) = 'СекцияДокумент' ) AND ( SUBSTR(s, INSTR(s, '=')+1, LENGTH(s) ) = 'Платежное поручение' ) THEN
          LOOP
            s := get_line(f);
              
            EXIT WHEN s = 'КонецДокумента';
            sName := TRIM(SUBSTR(s, 1, INSTR(s, '=')-1));
            sValue := TRIM(SUBSTR(s, INSTR(s, '=')+1, LENGTH(s)));
              
            IF  sName = 'Номер' THEN
              rec(Idx).DOC_NUMBER := sValue;
            ELSIF sName = 'Дата' THEN
              rec(Idx).DATE_PAY := to_date(sValue, 'dd.mm.yyyy') ;
            ELSIF sName = 'Сумма' THEN
              rec(Idx).SUM_PAY := TO_NUMBER(sValue, '999999999999999.99');
            ELSIF sName = 'ПлательщикИНН' THEN
              rec(Idx).Inn := sValue;
            ELSIF sName = 'НазначениеПлатежа' THEN
              rec(Idx).PAYMENT_PURPOSE := sValue;
            ELSIF sName = 'ПлательщикБИК' then
              rec(Idx).PAYER_BIK := to_number(sValue);
            END IF;
          END LOOP;
            
  --          dbms_output.put_line('vInn ='||vInn);
  --          dbms_output.put_line('vDate ='||vDate);
  --          dbms_output.put_line('vSum ='||vSum);
  --          dbms_output.put_line('vNumber ='||vNumber);
  --          dbms_output.put_line('vPurpose ='||vPurpose);
          rec(Idx).VIRTUAL_ACCOUNT_ID := GET_VIRTUAL_ACCOUNT_ID_BY_INN(rec(Idx).Inn);
          
          idx := idx + 1;
        END IF;  
      EXCEPTION
        WHEN no_data_found THEN
          EXIT;
      END;
    END LOOP;
    
    if rec.count > 0 then
      FORALL i IN rec.FIRST..rec.LAST
        INSERT INTO PAYMENTS_TEMP (
                                     VIRTUAL_ACCOUNT_ID,
                                     INN,
                                     DATE_PAY,
                                     SUM_PAY,
                                     DOC_NUMBER,
                                     PAYMENT_PURPOSE,
                                     PAYER_BIK
                                    )
                          VALUES  (
                                    rec(i).VIRTUAL_ACCOUNT_ID,
                                    rec(i).Inn,
                                    rec(i).DATE_PAY,
                                    rec(i).SUM_PAY,
                                    rec(i).DOC_NUMBER,
                                    rec(i).PAYMENT_PURPOSE,
                                    rec(i).PAYER_BIK
                                 );
    end if;
    
    MERGE INTO PAYMENTS PP
    USING
      (
        SELECT 
          VIRTUAL_ACCOUNT_ID,
          INN,
          DATE_PAY,
          SUM_PAY,
          DOC_NUMBER,
          PAYMENT_PURPOSE,
          PAYER_BIK
        FROM
          PAYMENTS_TEMP
       ) TMP        
    ON
      (
        PP.DATE_PAY = TMP.DATE_PAY
        AND PP.DOC_NUMBER = TMP.DOC_NUMBER
        AND PP.SUM_PAY = TMP.SUM_PAY
        AND PP.INN = TMP.INN
        AND PP.PAYER_BIK = TMP.PAYER_BIK
      )
    WHEN NOT MATCHED THEN
      INSERT (
               VIRTUAL_ACCOUNT_ID,
               INN,
               DATE_PAY,
               SUM_PAY,
               DOC_NUMBER,
               PAYMENT_PURPOSE,
               PAYMENT_FILE_ID,
               YEAR_MONTH,
               PAYER_BIK
             )
      VALUES  (
                TMP.VIRTUAL_ACCOUNT_ID,
                TMP.Inn,
                TMP.DATE_PAY,
                TMP.SUM_PAY,
                TMP.DOC_NUMBER,
                TMP.PAYMENT_PURPOSE,
                pFILE_ID,
                to_number(to_char(TMP.DATE_PAY, 'yyyymm')),
                TMP.PAYER_BIK
              );      
    
    
    COMMIT;
    utl_file.fclose(f);
  END;
begin
   
  for rec in new_file loop
    
    update PAYMENTS_FILES
      set LOAD_START_DATE = sysdate
    where
      file_id = rec.file_id;
        
    LOAD_PAYMENTS_FILE (cDIR_PAYMENT_FILES_NEW, rec.file_name, rec.file_id);
    
    update PAYMENTS_FILES
      set LOAD_END_DATE = sysdate
    where
      file_id = rec.file_id;
      
  end loop; 
end;