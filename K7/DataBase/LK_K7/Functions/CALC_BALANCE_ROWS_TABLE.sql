CREATE OR REPLACE FUNCTION K7_LK.CALC_BALANCE_ROWS_TABLE (
   pPHONE_NUMBER   IN VARCHAR2)
   RETURN BALANCE_ROW_TAB
   PIPELINED
AS
   --#Version=1
   vDATE_ROWS          DBMS_SQL.DATE_TABLE;
   vCOST_ROWS          DBMS_SQL.NUMBER_TABLE;
   vDESCRIPTION_ROWS   DBMS_SQL.VARCHAR2_TABLE;
   I                   BINARY_INTEGER;
  procedure calc_balance_row(ppPHONE_NUMBER IN VARCHAR2,
              pDATE_ROWS          IN OUT NOCOPY DBMS_SQL.DATE_TABLE,
              pCOST_ROWS          IN OUT NOCOPY DBMS_SQL.NUMBER_TABLE,
              pDESCRIPTION_ROWS   IN OUT NOCOPY DBMS_SQL.VARCHAR2_TABLE)
  as
    PRAGMA AUTONOMOUS_TRANSACTION;
   
   PROCEDURE APPEND_ROW (pDATE DATE, pCOST NUMBER, pDESCRIPTION VARCHAR2)
   IS
      C   BINARY_INTEGER;
   
   BEGIN
      
      IF pCOST <> 0 THEN
         C := pDATE_ROWS.COUNT + 1;
         pDATE_ROWS (C) := pDATE;
         pCOST_ROWS (C) := pCOST;
         pDESCRIPTION_ROWS (C) := pDESCRIPTION;
      END IF;

   END;
  begin
    corp_mobile.CALC_BALANCE_ROWS_NO_CREDIT (pPHONE_NUMBER);
  
    for cur in (select * from corp_mobile.ABONENT_BALANCE_ROWS)
    loop
       APPEND_ROW (cur.row_date, cur.row_cost, cur.row_comment);
    end loop;
    commit;       
  end;
   
BEGIN
/*   corp_mobile.CALC_BALANCE_ROWS2 (pPHONE_NUMBER,
                       vDATE_ROWS,
                       vCOST_ROWS,
                       vDESCRIPTION_ROWS);
   --
   I := vDATE_ROWS.FIRST;

   WHILE I IS NOT NULL
   LOOP
      PIPE ROW (corp_mobile.BALANCE_ROW_TYPE (vDATE_ROWS (I),
                                  vCOST_ROWS (I),
                                  vDESCRIPTION_ROWS (I)));
      I := vDATE_ROWS.NEXT (I);
   END LOOP;
*/
  vDATE_ROWS.delete;
  vCOST_ROWS.delete;
  vDESCRIPTION_ROWS.delete;
  calc_balance_row (pPHONE_NUMBER, vDATE_ROWS, vCOST_ROWS, vDESCRIPTION_ROWS);
  
  for i in vDATE_ROWS.FIRST..vDATE_ROWS.LAST
  loop
    PIPE ROW (
                 BALANCE_ROW_TYPE (
                                    vDATE_ROWS (I),
                                    vCOST_ROWS (I),
                                    vDESCRIPTION_ROWS (I)
                                  )
             );
  end loop;  
  
  
END;
/
