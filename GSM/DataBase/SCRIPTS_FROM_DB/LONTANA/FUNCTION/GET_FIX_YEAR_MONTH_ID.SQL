
  CREATE OR REPLACE FUNCTION "LONTANA"."GET_FIX_YEAR_MONTH_ID" (
  pACCOUNT_ID IN INTEGER,
  pFIX_YEAR_MONTH IN INTEGER
  ) RETURN INTEGER IS
--Version=1  
CURSOR C IS
  SELECT FIX_YEAR_MONTHS.FIX_YEAR_MONTH_ID
    FROM FIX_YEAR_MONTHS
    WHERE FIX_YEAR_MONTHS.ACCOUNT_ID=pACCOUNT_ID
      AND FIX_YEAR_MONTHS.FIX_YEAR_MONTH=pFIX_YEAR_MONTH;
rec INTEGER;      
BEGIN   
  rec:=-1;
  OPEN C;
  FETCH C INTO rec;
  CLOSE C;
  RETURN rec;
END; 