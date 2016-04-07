CREATE OR REPLACE PROCEDURE LOAD_PAYMENTS_FILES (pDirectory VARCHAR2, pFileName VARCHAR2) AS
--Version = 1
--
  f utl_file.file_type;
  s VARCHAR2(1000 CHAR);
  sName VARCHAR2(30 CHAR);
  sValue VARCHAR2(500 CHAR);
  vNumber VARCHAR2(10 CHAR);
  vDate VARCHAR2(10 CHAR);
  vSum VARCHAR2(18 CHAR);
  vInn VARCHAR2(12 CHAR);
  vPurpose VARCHAR2(500 CHAR);        
BEGIN
  f := utl_file.fopen(pDirectory, pFileName, 'R');
  LOOP
    BEGIN
      utl_file.get_line(f,s);
      IF ( SUBSTR(s, 1, INSTR(s, '=')-1) = 'СекцияДокумент' ) AND ( SUBSTR(s, INSTR(s, '=')+1, LENGTH(s) ) = 'Платежное поручение' ) THEN
        LOOP
          utl_file.get_line(f,s);          
          EXIT WHEN s = 'КонецДокумента';
          sName := TRIM(SUBSTR(s, 1, INSTR(s, '=')-1));
          sValue := TRIM(SUBSTR(s, INSTR(s, '=')+1, LENGTH(s)));
          IF  sName = 'Номер' THEN
            vNumber := sValue;
          ELSIF sName = 'Дата' THEN
            vDate := sValue;
          ELSIF sName = 'Сумма' THEN
            vSum := sValue;
          ELSIF sName = 'ПлательщикИНН' THEN
            vInn := sValue;
          ELSIF sName = 'НазначениеПлатежа' THEN
            vPurpose := sValue;
          END IF;
        END LOOP;
        INSERT INTO PAYMENTS (INN, DATE_PAY, SUM_PAY, DOC_NUMBER, PAYMENT_PURPOSE) VALUES (vInn, vDate, TO_NUMBER(vSum, '999999999999999.99'), vNumber, vPurpose);
        COMMIT;        
      END IF;  
    EXCEPTION
      WHEN no_data_found THEN
        EXIT;
    END;
  END LOOP;
  utl_file.fclose(f);
END;
