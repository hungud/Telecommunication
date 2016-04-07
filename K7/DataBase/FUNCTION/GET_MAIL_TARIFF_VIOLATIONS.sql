CREATE OR REPLACE FUNCTION GET_MAIL_TARIFF_VIOLATIONS(
  pYEAR_MONTH IN INTEGER
  ) RETURN CLOB IS
--Version#1
RESULT_CLOB CLOB;
LINE CLOB;
BEGIN
--  DBMS_LOB.CREATETEMPORARY(RESULT_CLOB, TRUE);
  RESULT_CLOB:='"�������"' || CHR(9) || '"��� ������ � ���������"' || CHR(9) || '"������ � ���������"'
       || CHR(9) || '"��� ������ � ��������"' || CHR(9) || '"����� � ��������"';  
  FOR rec IN(
    SELECT YEAR_MONTH,
           PHONE_NUMBER,
           CELL_PLAN_CODE,
           TARIFF_NAME_FROM_OPERATOR,
           TARIFF_CODE,
           TARIFF_NAME 
      FROM V_TARIFF_VIOLATIONS
      WHERE YEAR_MONTH=pYEAR_MONTH
  ) LOOP
    LINE:=CHR(10) || rec.PHONE_NUMBER || CHR(9) || rec.CELL_PLAN_CODE || CHR(9) || rec.TARIFF_NAME_FROM_OPERATOR
         || CHR(9) || rec.TARIFF_CODE || CHR(9) || rec.TARIFF_NAME;
    DBMS_LOB.APPEND(RESULT_CLOB, LINE);      
  END LOOP;       
  RETURN RESULT_CLOB;
  DBMS_LOB.FREETEMPORARY(RESULT_CLOB); 
END;
/