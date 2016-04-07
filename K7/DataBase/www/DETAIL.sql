CREATE OR REPLACE PROCEDURE DETAIL(
  SESSION_ID IN VARCHAR2 DEFAULT NULL,
  YEAR_MONTH IN VARCHAR2 DEFAULT NULL
  ) IS
--#Version=1
--#Version=2 Овсянников оптимизация вызова SQL_GET_USER_PHONE 
  pYEAR_MONTH DBMS_SQL.NUMBER_TABLE;
  pSUMMA DBMS_SQL.NUMBER_TABLE;
  
  pDATE DBMS_SQL.VARCHAR2_TABLE;
  pTIME DBMS_SQL.VARCHAR2_TABLE;
  pSOBESEDNIK DBMS_SQL.VARCHAR2_TABLE;
  pTYPE DBMS_SQL.VARCHAR2_TABLE;
  pLENGTH DBMS_SQL.VARCHAR2_TABLE;
  pCOST DBMS_SQL.NUMBER_TABLE;
  pROUMING DBMS_SQL.VARCHAR2_TABLE; 
  pZONA_ROUMINGA DBMS_SQL.VARCHAR2_TABLE; 
  pINFO DBMS_SQL.VARCHAR2_TABLE; 
  USER_PHONE VARCHAR2(20);  
procedure print_time is
begin
  htp.print('<!-- ' || to_char(sysdate, 'hh:mi:ss') || '-->'); 
end;
  
FUNCTION MONTH_NAME (YEAR_MONTH IN INTEGER) RETURN VARCHAR2 IS 
BEGIN
  RETURN 
    CASE (YEAR_MONTH-TRUNC(YEAR_MONTH,-2))
      WHEN 01 THEN 'Январь ' || TO_CHAR(TRUNC(YEAR_MONTH/100))
      WHEN 02 THEN 'Февраль ' || TO_CHAR(TRUNC(YEAR_MONTH/100))
      WHEN 03 THEN 'Март ' || TO_CHAR(TRUNC(YEAR_MONTH/100))
      WHEN 04 THEN 'Апрель ' || TO_CHAR(TRUNC(YEAR_MONTH/100))
      WHEN 05 THEN 'Май ' || TO_CHAR(TRUNC(YEAR_MONTH/100))
      WHEN 06 THEN 'Июнь ' || TO_CHAR(TRUNC(YEAR_MONTH/100))
      WHEN 07 THEN 'Июль ' || TO_CHAR(TRUNC(YEAR_MONTH/100))
      WHEN 08 THEN 'Август ' || TO_CHAR(TRUNC(YEAR_MONTH/100))
      WHEN 09 THEN 'Сентябрь ' || TO_CHAR(TRUNC(YEAR_MONTH/100))
      WHEN 10 THEN 'Октябрь ' || TO_CHAR(TRUNC(YEAR_MONTH/100))
      WHEN 11 THEN 'Ноябрь ' || TO_CHAR(TRUNC(YEAR_MONTH/100))
      WHEN 12 THEN 'Декабрь ' || TO_CHAR(TRUNC(YEAR_MONTH/100))
    END;
END;
  
BEGIN
  S_BEGIN(SESSION_ID=>SESSION_ID,STRANICA=>3);
  IF G_STATE.USER_ID IS NOT NULL THEN    
    USER_PHONE:=SQL_GET_USER_PHONE(G_STATE.USER_ID);
    HTP.PRINT('
              <div id="content">
					      <p class="phone_number"><b>Абонент:</b> ' || USER_PHONE || '</p>');
    SQL_GET_ABONENT_DETAIL_MONTH(
      G_STATE.USER_ID,
      SYSDATE,
      pYEAR_MONTH, 
      pSUMMA 
      );
    IF pYEAR_MONTH.COUNT = 0 THEN
      HTP.PRINT('Нет данных');
    ELSE
      HTP.PRINT('
                <h2>Детализация звонков:</h2>
                <table>
                  <thead>
                    <tr>
                      <td class="first_cell_detail" align="center">Дата</td>
                      <td align="right">Сумма (руб.)</td>
                      <td class="last_cell" align="center">Операции</td>
                    </tr>
                  </thead>            
                  <tbody>');
      FOR I IN pYEAR_MONTH.FIRST..pYEAR_MONTH.LAST LOOP
        HTP.PRINT('
                  <tr>
								    <td class="first_cell_detail" align="center">'||MONTH_NAME(pYEAR_MONTH(I))||'</td>
                    <td width="140" align="right">' || COST_TO_CHAR (pSUMMA(I)) ||'</td>
                    <td class="last_cell">
                      <div class="w49 left" align="right"><a href="detail?' || G_STATE.SESSION_KEY_PARAM_1 
                        || '&YEAR_MONTH=' || TO_CHAR(pYEAR_MONTH(I)) || '" title="">Посмотреть</a></div>
                      <div class="w49 right" align="left"><a href="report_detail?' || G_STATE.SESSION_KEY_PARAM_1 || '&YEAR_MONTH=' || TO_CHAR(pYEAR_MONTH(I)) 
                        || '&PHONE_NUMBER=' || USER_PHONE || '" title="" class=""><img src="IMG_XLS_ICON" title="" alt="" /></a></div>
                    </td>
                  </tr>'); 
      END LOOP;
      HTP.PRINT('
                </tbody>						
					    </table>');
    END IF;
    IF YEAR_MONTH IS NOT NULL THEN  
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
        SQL_GET_ABONENT_DETAIL_TEXT_B(
        --USER_PHONE,
        substr(replace(USER_PHONE,'-',''),2,10),
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
              <center><i><b>Нет данных</b></i></center>');
      ELSE
        HTP.PRINT('
              <h2>Подробная информация: ' || MONTH_NAME(TO_NUMBER(YEAR_MONTH)) || '</h2>');
        HTP.PRINT('              
              <table class="small_table">
                <thead>
                  <tr>
                    <td class="first_cell">Дата</td>
                    <td>Время</td>
                    <td>Собеседник</td>
                    <td>Услуга</td>
                    <td>Длит.</td>
                    <td>Стоим.</td>
                    <td>Роуминг</td>
                    <td>Зона</td>
                    <td class="last_cell">Доп.инф</td>
                  </tr>
                </thead>					
                <tbody>');
        FOR I IN pDATE.FIRST..pDATE.LAST LOOP
          HTP.PRINT('
                  <tr>
                    <td class="first_cell">'||pDATE(I)||'</td>
                    <td>'||pTIME(I)||'</td>
                    <td>'||pSOBESEDNIK(I)||'</td>
                    <td>'||pTYPE(I)||'</td>
                    <td>'||pLENGTH(I)||'</td>
                    <td>'||TO_CHAR(pCOST(I))||'</td>
                    <td>'||pROUMING(I)||'</td>
                    <td>'||pZONA_ROUMINGA(I)||'</td>
                    <td class="last_cell">'||pINFO(I)||'</td>
                  </tr>'); 
        END LOOP;
        HTP.PRINT('
                </tbody>
              </table>');
      END IF;
    END IF;    
    HTP.PRINT('
            </div>');
  END IF;
  S_END;
END;
/
