CREATE OR REPLACE PROCEDURE WWW_DEALER.S_SHOW_LOG_LIST(
  pPAGE_NUM IN BINARY_INTEGER DEFAULT 1,
  pROWS_COUNT IN BINARY_INTEGER DEFAULT 30,
  pDATE_BEGIN IN VARCHAR2 DEFAULT TO_CHAR(TRUNC(SYSDATE-1), 'DD.MM.YYYY'),
  pDATE_END IN VARCHAR2 DEFAULT TO_CHAR(TRUNC(SYSDATE), 'DD.MM.YYYY'),
  pRESOURCE_TYPE IN VARCHAR2 DEFAULT 'ALL', 
  pCHANGE_TYPE IN VARCHAR2 DEFAULT 'ALL',
  pPHONE_SEARCH IN VARCHAR2 DEFAULT NULL,
  pORDER_BY IN VARCHAR2 DEFAULT 'D_LOG_EXCHANGE_ID DESC'
  ) IS
--#Version=1
--
  I PLS_INTEGER := 0; 
  vSTART_ROW_NUM PLS_INTEGER;
  vEND_ROW_NUM PLS_INTEGER;
  vURL VARCHAR2(2000 CHAR);
  vDATE_BEGIN DATE;
  vDATE_END DATE;
  vENTIRE_ROWS_COUNT PLS_INTEGER;
  vHREF VARCHAR2(4000 CHAR); 

  CURSOR CUR IS
    SELECT /*+RIRST_ROWS*/ COUNT(*) OVER () CNT
          ,TO_CHAR(D.CHANGE_DATE, 'DD.MM.YYYY HH24:MI:SS') CHANGE_DATE
          ,D.CHANGE_DATE CHANGE_DATE_D 
          ,DECODE(D.CHANGE_TYPE, 
            'E', 'Ошибка',  
            'B', 'Начало загрузки',  
            'L', 'Сводка по загрузке',  
            'I', 'Добавлен', 
            'R', 'Восстановлен', 
            'U', 'Изменен', 
            'D', 'Удален', 
            'O', 'Номер с отриц колич',  
            'Y', 'без изменений',
            D.CHANGE_TYPE) CHANGE_TYPE 
          ,DECODE(D.RESOURCE_TYPE, 
            'PHONE_NUMBERS', 'Номера телефонов',
            'CONTRAGENTS', 'Контрагенты',
            'BONUSES', 'Бонусы',
            'ACTIVATIONS', 'Активированные номера',
            'CONTRAGENT_RESTS', 'Остатки на складах контрагентов',
            'BALANCE_CHANGES', 'Изменения баланса контрагентов',
            'PHONE_RETURNS', 'Возвраты',
            'TARIFF_CHANGE_RULES', 'Правила изменения тарифов',
            'CONTRAGENT_PERCENTS', 'Проценты контрагентов',
            'TARIFF_PERCENTS', 'Проценты по тарифам',   
            'CONTR_TARIFF_PERCENTS', 'Проценты контрагентов по тарифам',         
            D.RESOURCE_TYPE) RESOURCE_TYPE
          ,D.ID, D.USER_NAME
          ,REPLACE(D.TEXT, CHR(13)||CHR(10), '<BR>') TEXT
          ,D.PHONE_NUMBER
          ,D.D_LOG_EXCHANGE_ID
      FROM D_LOG_EXCHANGE D
     WHERE D.CHANGE_DATE >= TRUNC(vDATE_BEGIN)
       AND D.CHANGE_DATE < (TRUNC(vDATE_END)+1)
       AND (
             (pRESOURCE_TYPE = 'ALL')
             OR
             (pRESOURCE_TYPE = D.RESOURCE_TYPE)
           )
       AND (
             (pCHANGE_TYPE = 'ALL')
             OR 
             (pCHANGE_TYPE = D.CHANGE_TYPE)
           )
       AND ((REPLACE(pPHONE_SEARCH, ' ', '') IS NULL) OR (TO_CHAR(D.PHONE_NUMBER) LIKE '%'||REPLACE(pPHONE_SEARCH, ' ', '')||'%'))
     --ORDER BY D.D_LOG_EXCHANGE_ID DESC;
     ORDER BY
        CASE 
          WHEN pORDER_BY = 'CHANGE_DATE ASC' THEN TO_CHAR(CHANGE_DATE_D, 'YYYY.MM.DD HH24:MI:SS')          
          WHEN pORDER_BY = 'CHANGE_TYPE ASC' THEN CHANGE_TYPE        
          WHEN pORDER_BY = 'RESOURCE_TYPE ASC' THEN RESOURCE_TYPE        
          WHEN pORDER_BY = 'TEXT ASC' THEN TEXT
          WHEN pORDER_BY = 'PHONE_NUMBER ASC' THEN TO_CHAR(PHONE_NUMBER)
          ELSE NULL
        END,
        CASE 
          WHEN pORDER_BY = 'CHANGE_DATE DESC' THEN TO_CHAR(CHANGE_DATE_D, 'YYYY.MM.DD HH24:MI:SS')          
          WHEN pORDER_BY = 'CHANGE_TYPE DESC' THEN CHANGE_TYPE          
          WHEN pORDER_BY = 'RESOURCE_TYPE DESC' THEN RESOURCE_TYPE        
          WHEN pORDER_BY = 'TEXT DESC' THEN TEXT
          WHEN pORDER_BY = 'PHONE_NUMBER DESC' THEN TO_CHAR(PHONE_NUMBER)
          ELSE NULL
        END DESC NULLS FIRST,
        D.D_LOG_EXCHANGE_ID DESC;
     
BEGIN
  IF G_STATE.USER_ID IS NOT NULL THEN
    vHREF := 'ADMIN_LOGS?' ||
          'SESSION_ID='||G_STATE.SESSION_ID||'&amp;'||
          'pROWS_COUNT='||pROWS_COUNT||'&amp;'||
          'pPHONE_SEARCH='||pPHONE_SEARCH||'&amp;'||
          'pDATE_BEGIN='||pDATE_BEGIN||'&amp;'||
          'pDATE_END='||pDATE_END||'&amp;'||
          'pCHANGE_TYPE='||pCHANGE_TYPE||'&amp;'||
          'pRESOURCE_TYPE='||pRESOURCE_TYPE; 
  
    HTP.PRINT('
          <div id="page_select_first" align="center"></div>');      
  
    HTP.PRINT('
          <div id="logs_table" align="center" valign="top">
            <table class="table_data"><tbody>
              <tr>
                <th>№</th>
                '||S_GET_TABLE_HEADER('Дата2', 'CHANGE_DATE', pORDER_BY, vHREF)||'                              
                '||S_GET_TABLE_HEADER('Тип', 'CHANGE_TYPE', pORDER_BY, vHREF)||'                              
                '||S_GET_TABLE_HEADER('Ресурс', 'RESOURCE_TYPE', pORDER_BY, vHREF)||'                              
                '||S_GET_TABLE_HEADER('Текст', 'TEXT', pORDER_BY, vHREF)||'                              
                '||S_GET_TABLE_HEADER('Телефон', 'PHONE_NUMBER', pORDER_BY, vHREF)||'                              
              </tr>');

    vSTART_ROW_NUM := 1 + pROWS_COUNT * (pPAGE_NUM - 1);
    vEND_ROW_NUM := vSTART_ROW_NUM + pROWS_COUNT - 1;

    vDATE_BEGIN := TO_DATE(pDATE_BEGIN, 'DD.MM.YYYY');
    vDATE_END := TO_DATE(pDATE_END, 'DD.MM.YYYY');

    vENTIRE_ROWS_COUNT := 0;
    --OUT_ERROR(vDATE_BEGIN||'-'||vDATE_END||'-'||vSTART_ROW_NUM||'-'||vEND_ROW_NUM||'-'||pRESOURCE_TYPE||'-'||pCHANGE_TYPE||'-'||pPHONE_SEARCH||'-');

    FOR REC IN CUR LOOP
      I := I + 1;
      IF I >= vSTART_ROW_NUM AND I <= vEND_ROW_NUM THEN
        
        vENTIRE_ROWS_COUNT := REC.CNT;

        HTP.PRINT('
              <tr>              
                <td align="center">'||TO_CHAR(I)||'</td>
                <td align="center">'||TO_CHAR(REC.CHANGE_DATE)||'</td>
                <td align="center">'||TO_CHAR(REC.CHANGE_TYPE)||'</td>
                <td align="center">'||TO_CHAR(REC.RESOURCE_TYPE)||'</td>
                <td align="left">'||TO_CHAR(REC.TEXT)||'</td>
                <td align="center">'||TO_CHAR(REC.PHONE_NUMBER)||'</td>
              </tr>');
      END IF;
      
      EXIT WHEN I >= vEND_ROW_NUM; 
    END LOOP;
      HTP.PRINT('
            </tbody></table>  
          </div>');
          
    HTP.PRINT('
          <div id="page_select_second" align="center">');      
    S_SHOW_PAGE_SELECT(pPAGE_NUM, pROWS_COUNT, vENTIRE_ROWS_COUNT,  vHREF||'%&amp;pPAGE_NUM=%PAGE_NUM%&amp;pORDER_BY='||pORDER_BY||'&amp;');

    HTP.PRINT('
          </div>');
   
    HTP.PRINT('
    <script>
      document.getElementById(''page_select_first'').innerHTML = document.getElementById(''page_select_second'').innerHTML;      
    </script>
    ');
  END IF;
END;
/
