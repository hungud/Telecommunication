CREATE OR REPLACE PROCEDURE REPORT_DETAIL(
  SESSION_ID IN VARCHAR2,
  YEAR_MONTH IN VARCHAR2,
  PHONE_NUMBER IN VARCHAR2
  ) IS
--#Version=3
--
-- 1. Крайнов. Создал 22.08.11.
--    
  pDATE DBMS_SQL.VARCHAR2_TABLE;
  pTIME DBMS_SQL.VARCHAR2_TABLE;
  pSOBESEDNIK DBMS_SQL.VARCHAR2_TABLE;
  pTYPE DBMS_SQL.VARCHAR2_TABLE;
  pLENGTH DBMS_SQL.VARCHAR2_TABLE;
  pCOST DBMS_SQL.NUMBER_TABLE;
  pROUMING DBMS_SQL.VARCHAR2_TABLE; 
  pZONA_ROUMINGA DBMS_SQL.VARCHAR2_TABLE; 
  pINFO DBMS_SQL.VARCHAR2_TABLE; 
--
BEGIN
  G_STATE.PRINT_EXCEL_HEADERS:=TRUE;
  IF SESSION_ID IS NOT NULL THEN
    G_STATE.TITLE:='Подробная детализация ' || PHONE_NUMBER 
                      || ' за ' || TO_CHAR(TO_DATE(YEAR_MONTH,'YYYYMM'),'Month YYYY');  
    PRINT_EXCEL_HEADER(G_STATE.TITLE || '.xls');                  
      -- 3 замороженных строки
    G_STATE.EXCEL_FREEZE_ROWS := 2;
    S_BEGIN(SESSION_ID=>SESSION_ID);
    IF G_STATE.USER_ID IS NOT NULL THEN
      HTP.PRINT('<h2>' || G_STATE.TITLE || '</h2><br>');   
      IF GET_HOT_BILLING_MONTH(TO_NUMBER(SUBSTR(YEAR_MONTH,1,4)), TO_NUMBER(SUBSTR(YEAR_MONTH,5,2)))=0 THEN 
       SQL_GET_ABONENT_DETAIL_TEXT(
        G_STATE.USER_ID,
        TO_NUMBER(YEAR_MONTH),
        pDATE,
        pTIME,
        pSOBESEDNIK,
        pTYPE,
        pLENGTH,
        pCOST,
        pROUMING, 
        pZONA_ROUMINGA, 
        pINFO
        );
       ELSE 
       /* HTP.PRINT('
            <center><i><b>PHONE_NUMBER='||substr(replace(PHONE_NUMBER,'-',''),2,10)||'</b></i></center>');
        HTP.PRINT('
            <center><i><b>YEAR_MONTH='||YEAR_MONTH||'</b></i></center>');*/
         
        SQL_GET_ABONENT_DETAIL_TEXT_B(
        substr(replace(PHONE_NUMBER,'-',''),2,10),
        TO_NUMBER(YEAR_MONTH),
        pDATE,
        pTIME,
        pSOBESEDNIK,
        pTYPE,
        pLENGTH,
        pCOST,
        pROUMING, 
        pZONA_ROUMINGA, 
        pINFO
        );
       END IF;
      IF pDATE.COUNT = 0 THEN
        HTP.PRINT('
            <center><i><b>Нет данных.</b></i></center>');
      ELSE
        HTP.PRINT('

                    <td>Длит.</td>
                    <td>Стоим.</td>
                    <td>Роуминг</td>
                    <td>Зона</td>
                    <td class="last_cell">Доп.инф</td>
                  </tr>
<BR>
<TABLE BORDER=1 WIDTH=1000>
  <COLGROUP SPAN=5 ALIGN=CENTER>
  <COLGROUP SPAN=1 ALIGN=RIGHT>
  <COLGROUP SPAN=3 ALIGN=LEFT>
  <TR>
    <TH align=center WIDTH=100>Дата</TH>
    <TH align=center WIDTH=100>Время</TH>
    <TH align=center WIDTH=100>Собеседник</TH>
    <TH align=center WIDTH=100>Услуга</TH>
    <TH align=center WIDTH=100>Длительность</TH>
    <TH align=center WIDTH=100>Стоимость</TH>
    <TH align=center WIDTH=100>Роуминг</TH>
    <TH align=center WIDTH=100>Зона роуминга</TH>
    <TH align=center>Дополнительная информация</TH>
  </TR>');
        FOR I IN pDATE.FIRST..pDATE.LAST LOOP
          HTP.PRINT('
  <TR>
    <TD>'||pDATE(I)||'</TD>
    <TD>'||pTIME(I)||'</TD>
    <TD>'||pSOBESEDNIK(I)||'</TD>
    <TD>'||pTYPE(I)||'</TD>
    <TD>'||pLENGTH(I)||'</TD>
    <TD>'||TO_CHAR(pCOST(I))||'</TD>
    <TD>'||pROUMING(I)||'</TD>
    <TD>'||pZONA_ROUMINGA(I)||'</TD>
    <TD>'||pINFO(I)||'</TD>
  </TR>'); 
        END LOOP;
        HTP.PRINT('
</TABLE>');
      END IF;
    END IF;
  END IF;
  S_END;
  G_STATE.PRINT_EXCEL_HEADERS:=FALSE;
END;
/
