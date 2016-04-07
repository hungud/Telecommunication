CREATE OR REPLACE PROCEDURE REPORT_BALANCE(
  SESSION_ID IN VARCHAR2,
  PHONE_NUMBER IN VARCHAR2
  ) IS
--#Version=1
--
-- 1. Крайнов. Создал 22.08.11.
--    
  pDATE_ROWS DBMS_SQL.DATE_TABLE;
  pCOST_ROWS DBMS_SQL.NUMBER_TABLE;
  pDESCRIPTION_ROWS DBMS_SQL.VARCHAR2_TABLE;
  PRIXOD NUMBER;
  RASXOD NUMBER;
--
BEGIN
  G_STATE.PRINT_EXCEL_HEADERS:=TRUE;
  IF SESSION_ID IS NOT NULL THEN
    G_STATE.TITLE := 'Расшифровка баланса ' || PHONE_NUMBER || ' на ' || TO_CHAR(SYSDATE,'DD.MM.YY');   
    PRINT_EXCEL_HEADER(G_STATE.TITLE || '.xls');     
        -- 3 замороженных строки
    G_STATE.EXCEL_FREEZE_ROWS := 2;
    S_BEGIN(SESSION_ID=>SESSION_ID);
    IF G_STATE.USER_ID IS NOT NULL THEN
      HTP.PRINT('<h2>' || G_STATE.TITLE || '</h2><br>');   
      PRIXOD:=0;
      RASXOD:=0;
      SQL_GET_ABONENT_BALANCE_ROWS(
        G_STATE.USER_ID,
        SYSDATE,
        pDATE_ROWS, 
        pCOST_ROWS, 
        pDESCRIPTION_ROWS
        );
      IF pDATE_ROWS.COUNT = 0 THEN
        HTP.PRINT('
            <center><i><b>Нет данных.</b></i></center>');
      ELSE
        HTP.PRINT('
<BR>
<TABLE BORDER=1 WIDTH=1000>
  <COLGROUP SPAN=1 ALIGN=CENTER>
  <COLGROUP SPAN=2 ALIGN=RIGHT>
  <COLGROUP SPAN=1 ALIGN=LEFT>
  <TR>
    <TH align=center WIDTH=100>Дата</TH>
    <TH align=center WIDTH=100>Приход</TH>
    <TH align=center WIDTH=100>Расход</TH>
    <TH align=center>Примечания</TH>
  </TR>');
        FOR I IN pDATE_ROWS.FIRST..pDATE_ROWS.LAST LOOP
          IF pCOST_ROWS(I)<0 
          THEN
            HTP.PRINT('
  <TR>
    <TD>' || TO_CHAR(pDATE_ROWS(I), 'DD.MM.YYYY') || '</TD>
    <TD></TD>
    <TD>' || COST_TO_CHAR(pCOST_ROWS(I)) || '</TD>
    <TD>' || pDESCRIPTION_ROWS(I) || '</TD>
  </TR>');
            RASXOD:=RASXOD+pCOST_ROWS(I); 
          ELSE 
            HTP.PRINT('
  <TR>
    <TD>' || TO_CHAR(pDATE_ROWS(I), 'DD.MM.YYYY') || '</TD>
    <TD>' || COST_TO_CHAR(pCOST_ROWS(I)) || '</TD>
    <TD></TD>
    <TD>' || pDESCRIPTION_ROWS(I) || '</TD>
  </TR>');                      
            PRIXOD:=PRIXOD+pCOST_ROWS(I); 
          END IF;   
        END LOOP;
        HTP.PRINT('
  <TR>
    <TD><b>ИТОГО:</b></TD>
    <TD><b>' || COST_TO_CHAR(PRIXOD) || '</b></TD>
    <TD><b>' || COST_TO_CHAR(RASXOD) || '</b></TD>
    <TD></TD>
  </TR>
  <TR>
    <TD COLSPAN=><b>ИТОГО:</b></TD>
    <TD><b>' || COST_TO_CHAR(PRIXOD+RASXOD) || '</b></TD>
  </TR>
</TABLE>');
      END IF;
    END IF;
  END IF;
  S_END;
  G_STATE.PRINT_EXCEL_HEADERS:=FALSE;
END;
/

