CREATE OR REPLACE PROCEDURE WWW_DEALER.TARIFF_PERCENTS(
  NAME_ARRAY IN OWA.VC_ARR,
  VALUE_ARRAY IN OWA.VC_ARR
  ) IS
--#Version=1
--
  vSESSION_ID VARCHAR2(100 CHAR);
  --vMODE VARCHAR2(20 CHAR);
  vEXCEL BOOLEAN;
  vTEXT BOOLEAN;
  vPAGE BINARY_INTEGER;
  vPAGE_SIZE CONSTANT BINARY_INTEGER := 400;
  --
  cTAB CONSTANT VARCHAR2(1 CHAR) := CHR(9);
  cQUOTED_TAB CONSTANT VARCHAR2(3 CHAR) := '"' || CHR(9) || '"';
  cCRLF CONSTANT VARCHAR2(2 CHAR) := CHR(13) || CHR(10);
  cLEFT_QUOTED_CRLF CONSTANT VARCHAR2(3 CHAR) := '"' || CHR(13) || CHR(10);
  --
  -- проценты одного контрагента ля одного оператора
  TYPE T_PERCENT IS RECORD (
    PERCENT_1C NUMBER,
    PERCENT_HAND NUMBER,
    PERCENT_HAND_ACTUAL NUMBER,
    PERCENT_HISTORY VARCHAR2(4000 CHAR)    
  );  
  -- проценты одного контрагента (индекс - код оператора, значение - значение процента)
  TYPE T_TARIFF_PERCENTS IS TABLE OF T_PERCENT INDEX BY BINARY_INTEGER;
  -- контрагент (наименование, код, проценты)
  TYPE T_CONTRAGENT IS RECORD (
    USER_ID INTEGER,
    USER_NAME VARCHAR2(255 CHAR),
    PERCENTS T_TARIFF_PERCENTS
  );
  -- список контрагентов, код - порядковый номер контрагента
  TYPE T_CONTRAGENTS IS TABLE OF T_CONTRAGENT INDEX BY BINARY_INTEGER;
  --
  TYPE T_CACHE_ITEM IS TABLE OF VARCHAR2(2000 CHAR) INDEX BY BINARY_INTEGER;
  TYPE T_CACHE_ITEM_CHAR_ID IS TABLE OF VARCHAR2(20 CHAR) INDEX BY BINARY_INTEGER;
  TYPE T_CACHE_ITEM_ID IS TABLE OF BINARY_INTEGER INDEX BY BINARY_INTEGER;
  --
  vCONTRAGENTS T_CONTRAGENTS;
  vTARIFFS DBMS_SQL.VARCHAR2S; -- список операторов (индекс - код, значение - наименование)
  vLINE VARCHAR2(32000 CHAR);
  vTARIFF_ID PLS_INTEGER;
  vCONTRAGENT_POS PLS_INTEGER;
  vPERIOD_SAVE VARCHAR2(200 CHAR);
  vPERIOD_SAVE_DATE DATE;
  vPERIOD_OPEN VARCHAR2(200 CHAR);
  vPERIOD_OPEN_DATE DATE;
  
  --  берем те тарифы для которых загружены значения из 1с или внечены рукаим
  CURSOR CUR_TARIFFS IS
    SELECT TR.TARIFF_ID, TR.TARIFF_NAME
      FROM D_TARIFFS TR
     WHERE EXISTS
     (SELECT P1.TARIFF_ID FROM D_TARIFF_PERCENTS P1 WHERE NVL(PERCENT, 0) > 0 AND P1.TARIFF_ID = TR.TARIFF_ID  
       UNION ALL
      SELECT P2.TARIFF_ID FROM D_TARIFF_PRC_HANDS P2 WHERE P2.TARIFF_ID = TR.TARIFF_ID
     )
     AND TR.IS_ACTIVE = 1;
  --
  CURSOR C_PERCENTS(pMANAGER_ID INTEGER, pPERIOD_DATE DATE) IS
    SELECT D_U.USER_ID
          ,D_U.DESCRIPTION CONTRAGENT_NAME
          ,TR.TARIFF_ID
          ,TR.TARIFF_NAME
          -- сортировка делается тут (это порядковый номер контрагента)
          ,ROW_NUMBER() OVER (PARTITION BY TR.TARIFF_ID ORDER BY D_U.DESCRIPTION) R_NUM
          /*,(
             SELECT P_1C.PERCENT PERCENT_1C
               FROM D_TARIFF_PERCENTS P_1C
              WHERE (TR.TARIFF_ID = P_1C.TARIFF_ID)
                AND ROWNUM < 2
            ) PERCENT_1C*/
          ,S_GET_TARIFF_PERCENT_1C(TR.TARIFF_ID, pPERIOD_DATE) PERCENT_1C
          ,(
             SELECT P_HAND.PERCENT PERCENT_HAND
               FROM D_TARIFF_PRC_HANDS P_HAND
              WHERE (V_USER.USER_ID = P_HAND.USER_ID)
                AND (TR.TARIFF_ID = P_HAND.TARIFF_ID)
                AND (P_HAND.PERIOD = pPERIOD_DATE)
                AND ROWNUM < 2
            ) PERCENT_HAND
          ,S_GET_TARIFF_PERCENT_HAND(TR.TARIFF_ID, V_USER.USER_ID, pPERIOD_DATE) PERCENT_HAND_ACTUAL
          ,S_GET_TARIFF_PERC_HIST(TR.TARIFF_ID, V_USER.USER_ID) PERCENT_HISTORY
      FROM V_USERS_BY_MANAGER V_USER
          ,D_USER_NAMES D_U
          ,D_TARIFFS TR
     WHERE (V_USER.MANAGER_ID = pMANAGER_ID)
       --AND (:pCONTRAGENT_ID IS NULL OR V_USER.USER_ID = :pCONTRAGENT_ID)
       AND (V_USER.USER_ID = D_U.USER_ID (+))
       AND NVL(D_U.IS_MANAGER, 0) <> 1
       AND TR.TARIFF_ID IN 
         (SELECT P1.TARIFF_ID FROM D_TARIFF_PERCENTS P1 WHERE NVL(PERCENT, 0) > 0 AND P1.TARIFF_ID = TR.TARIFF_ID  
           UNION ALL
          SELECT P2.TARIFF_ID FROM D_TARIFF_PRC_HANDS P2 WHERE P2.TARIFF_ID = TR.TARIFF_ID
         )       
     ORDER BY D_U.DESCRIPTION, TR.TARIFF_NAME;
BEGIN
  IF NAME_ARRAY.COUNT > 0 THEN
    vEXCEL := FALSE;
    vTEXT := FALSE;
    -- Определяем статические параметры
    FOR I IN NAME_ARRAY.FIRST..NAME_ARRAY.LAST LOOP
      IF UPPER(NAME_ARRAY(I)) = 'SESSION_ID' THEN
        vSESSION_ID := SUBSTR(VALUE_ARRAY(I), 1, 100);
      --ELSIF UPPER(NAME_ARRAY(I)) = 'MODE' THEN
      --  vMODE := SUBSTR(VALUE_ARRAY(I), 1, 20);
      ELSIF UPPER(NAME_ARRAY(I)) = 'PAGE' THEN
        vPAGE := TO_NUMBER(VALUE_ARRAY(I));
      ELSIF UPPER(NAME_ARRAY(I)) = 'XLS' THEN
        vEXCEL := TRUE;
      ELSIF UPPER(NAME_ARRAY(I)) = 'XTEXT' THEN
        vTEXT := TRUE;
      END IF;
    END LOOP;
    IF vTEXT THEN
      G_STATE.NO_DISPLAY_PANELS := TRUE;
      G_STATE.NEED_PRINT_HEADERS := FALSE;
      OWA_UTIL.MIME_HEADER('text/txt', FALSE);
      -- Make sure that IE can download the attachments under https.
      HTP.P('Content-Disposition: attachment; filename="TARIFF_PERCENTS.txt"');
--      HTP.P('Pragma: public');
      OWA_UTIL.HTTP_HEADER_CLOSE;
    ELSIF vEXCEL THEN
      PRINT_EXCEL_HEADER('TARIFF_PERCENTS.xls', TRUE);
      -- 3 замороженных строки
      G_STATE.EXCEL_FREEZE_ROWS := 3;
    END IF;
    IF vSESSION_ID IS NOT NULL THEN
      S_BEGIN(SESSION_ID=>vSESSION_ID);
      IF G_STATE.USER_ID IS NOT NULL THEN
        HTP.PRINT('        <div id="content">');
        -- Если есть номера телефонов и записи, то сохраняем их
        BEGIN
          -- сначала определяем период
          FOR I IN NAME_ARRAY.FIRST..NAME_ARRAY.LAST LOOP
            IF NAME_ARRAY(I) = 'PERIOD_SAVE' THEN
              vPERIOD_SAVE := VALUE_ARRAY(I);
            ELSIF NAME_ARRAY(I) = 'PERIOD_OPEN' THEN
              vPERIOD_OPEN := VALUE_ARRAY(I);
            END IF;
          END LOOP;
          
          IF vPERIOD_SAVE IS NULL THEN
            vPERIOD_SAVE := TO_CHAR(TRUNC(SYSDATE, 'MM'), 'DD.MM.YYYY');
          END IF;          
          BEGIN
            vPERIOD_SAVE_DATE := TO_DATE(vPERIOD_SAVE, 'DD.MM.YYYY');
          EXCEPTION WHEN OTHERS THEN
            vPERIOD_SAVE_DATE := TRUNC(SYSDATE, 'MM');
          END;
          
          IF vPERIOD_OPEN IS NULL THEN
            vPERIOD_OPEN := TO_CHAR(TRUNC(SYSDATE, 'MM'), 'DD.MM.YYYY');
          END IF;          
          BEGIN
            vPERIOD_OPEN_DATE := TO_DATE(vPERIOD_OPEN, 'DD.MM.YYYY');
          EXCEPTION WHEN OTHERS THEN
            vPERIOD_OPEN_DATE := TRUNC(SYSDATE, 'MM');
          END;
        
          FOR I IN NAME_ARRAY.FIRST..NAME_ARRAY.LAST LOOP
            IF SUBSTR(NAME_ARRAY(I), 1, 4) = 'PERC' THEN
              -- процент контрагента 
              -- За начальной N следует код контрагента, через подчеркивание код оператора, читаем его
  --            HTP.PRINT('NUMBER='||vNUMBER ||', NAME=' || VALUE_ARRAY(I) || '<BR>');
              SET_TARIFF_PERCENT(REPLACE(NAME_ARRAY(I), 'PERC', ''), VALUE_ARRAY(I), vPERIOD_SAVE);
            END IF;
          END LOOP;
        EXCEPTION WHEN OTHERS THEN
          OUT_ERROR(dbms_utility.format_error_stack ||CHR(13)||CHR(10)||
                    dbms_utility.format_error_backtrace);
        END;
        
        FOR REC_TARIFFS IN CUR_TARIFFS LOOP
          vTARIFFS(REC_TARIFFS.TARIFF_ID) := REC_TARIFFS.TARIFF_NAME; 
        END LOOP;        
        
        FOR REC IN C_PERCENTS(G_STATE.USER_ID, vPERIOD_OPEN_DATE) LOOP
          vCONTRAGENTS(REC.R_NUM).USER_ID := REC.USER_ID;
          vCONTRAGENTS(REC.R_NUM).USER_NAME := REC.CONTRAGENT_NAME;
          vCONTRAGENTS(REC.R_NUM).PERCENTS(REC.TARIFF_ID).PERCENT_1C := REC.PERCENT_1C;
          vCONTRAGENTS(REC.R_NUM).PERCENTS(REC.TARIFF_ID).PERCENT_HAND := REC.PERCENT_HAND;
          vCONTRAGENTS(REC.R_NUM).PERCENTS(REC.TARIFF_ID).PERCENT_HAND_ACTUAL := REC.PERCENT_HAND_ACTUAL;
          vCONTRAGENTS(REC.R_NUM).PERCENTS(REC.TARIFF_ID).PERCENT_HISTORY := REC.PERCENT_HISTORY;
        END LOOP; 
        
        --IF vMODE = 'SELF' OR vMODE = 'SELF_EMPTY' THEN
        IF vTEXT THEN          
          -- собираем заголовок
          vLINE := '№' || cTAB || 'Контрагент'; 
          vTARIFF_ID := vTARIFFS.FIRST;
          WHILE vTARIFF_ID IS NOT NULL LOOP
            vLINE := cTAB || vLINE || vTARIFFS(vTARIFF_ID) || ' (ручн)';
            vLINE := cTAB || vLINE || vTARIFFS(vTARIFF_ID) || ' (1C)';
            vTARIFF_ID := vTARIFFS.NEXT(vTARIFF_ID);
          END LOOP;
          HTP.PRN(vLINE || cCRLF);
            
          -- идем по списку контрагентов
          IF vCONTRAGENTS.COUNT > 0 THEN
            vCONTRAGENT_POS := vCONTRAGENTS.FIRST;
            WHILE vCONTRAGENT_POS IS NOT NULL LOOP
                
              vLINE := '"' || vCONTRAGENT_POS || cQUOTED_TAB || vCONTRAGENTS(vCONTRAGENT_POS).USER_NAME;
                
              vTARIFF_ID := vTARIFFS.FIRST;
              WHILE vTARIFF_ID IS NOT NULL LOOP
                IF vCONTRAGENTS(vCONTRAGENT_POS).PERCENTS.COUNT > 0 AND vCONTRAGENTS(vCONTRAGENT_POS).PERCENTS.EXISTS(vTARIFF_ID) THEN
                  vLINE := cQUOTED_TAB || vLINE || vCONTRAGENTS(vCONTRAGENT_POS).PERCENTS(vTARIFF_ID).PERCENT_HAND_ACTUAL;
                  /*vLINE := cQUOTED_TAB || vLINE || vCONTRAGENTS(vCONTRAGENT_POS).PERCENTS(vTARIFF_ID).PERCENT_1C;*/
                ELSE
                  vLINE := cQUOTED_TAB || vLINE;
                  /*vLINE := cQUOTED_TAB || vLINE;*/
                END IF;

                vTARIFF_ID := vTARIFFS.NEXT(vTARIFF_ID);
              END LOOP;
              HTP.PRN(vLINE || cLEFT_QUOTED_CRLF);
              
              vCONTRAGENT_POS := vCONTRAGENTS.NEXT(vCONTRAGENT_POS);
            END LOOP;
          END IF;
        ELSE
          IF vEXCEL THEN
            HTP.PRINT('<H3>Проценты контрагентов(в период - '||vPERIOD_OPEN||')</H3><br>');
          END IF;
      
          IF NOT vEXCEL THEN
            HTP.PRINT('
<FORM METHOD="POST" ACTION="!TARIFF_PERCENTS" id="TARIFF_PERCENTS">
<INPUT TYPE="HIDDEN" NAME="SESSION_ID" VALUE="'||G_STATE.SESSION_ID||'">
<INPUT TYPE="HIDDEN" NAME="PERIOD_SAVE" VALUE="'||vPERIOD_OPEN||'">');
            HTP.PRINT('
              <table class="search_table"><tbody>
                <tr>
                  <td align="left"><INPUT CLASS=text TYPE=SUBMIT VALUE="Сохранить"></td>
                  <td align="left"><input class="text" type="SUBMIT" name="XLS" title="Выгрузить проценты по тарифам в MS Excel" value="Выгрузить в Excel"></td>
                  <td align="right">Период:
                    <select name="PERIOD_OPEN" id="PERIOD_OPEN" onchange="submit();">
                      '||GET_PERIOD_OPTIONS(vPERIOD_OPEN_DATE, TO_DATE('01.01.2010', 'DD.MM.YYYY'))||' 
                    </select>
                  </td>
                </tr>
              </tbody></table>');  

/*
            HTP.PRINT('<INPUT CLASS=text TYPE=SUBMIT VALUE="Сохранить">');
            HTP.PRINT('<input class="text" type="SUBMIT" name="XLS" title="Выгрузить проценты по тарифам в MS Excel" value="Выгрузить в Excel"><br>');              
*/            
            HTP.PRINT('Внимание: Все изменения будут сохранены только после нажатия кнопки "Сохранить" (или при изменении периода)!<br>');
          END IF;
            
          -- собираем заголовок
          vLINE := '<TABLE class="table_data"><tr><th>№</th><th>Контрагент</th>'; 
          vTARIFF_ID := vTARIFFS.FIRST;
          WHILE vTARIFF_ID IS NOT NULL LOOP
            vLINE := vLINE || '<th>' ||vTARIFFS(vTARIFF_ID) || /*' (ручн)'||*/'</th>';
            /*vLINE := vLINE || '<th>' || vTARIFFS(vTARIFF_ID) || ' (1C)</th>';*/
            vTARIFF_ID := vTARIFFS.NEXT(vTARIFF_ID);
          END LOOP;
          HTP.PRN(vLINE || '</tr>' ||cCRLF);
          
          vLINE := '<tr><td></td><td></td>'; 
          vTARIFF_ID := vTARIFFS.FIRST;
          WHILE vTARIFF_ID IS NOT NULL LOOP
            vLINE := vLINE || '
                      <td>   
                        <input type = "text" id = "value_'|| vTARIFF_ID ||'" maxlength="10" size="3" />
                        <input type = "button" value = "Установить всем" id = "'|| vTARIFF_ID ||'" onclick="setValue(this)"/> 
                      </td>';
            /*vLINE := vLINE || '<th>' || vTARIFFS(vTARIFF_ID) || ' (1C)</th>';*/
            vTARIFF_ID := vTARIFFS.NEXT(vTARIFF_ID);
          END LOOP;
          HTP.PRN(vLINE || '</tr>' ||cCRLF);          
            
          --HTP.PRINT('<TABLE border=0 class=content><tr><th>№</th><th>Номер</th><th>Имя</th><th>Организация</th><th>Группа компенсаций</th><th>Тип</th><th>E-Mail</th><th>Примечание</th></tr>');
          IF vEXCEL THEN
            -- идем по списку контрагентов
            IF vCONTRAGENTS.COUNT > 0 THEN
              vCONTRAGENT_POS := vCONTRAGENTS.FIRST;
              WHILE vCONTRAGENT_POS IS NOT NULL LOOP
                  
                vLINE := '<tr><td>'||vCONTRAGENT_POS||'</td><td>'||vCONTRAGENTS(vCONTRAGENT_POS).USER_NAME||'</td>';
                  
                vTARIFF_ID := vTARIFFS.FIRST;
                WHILE vTARIFF_ID IS NOT NULL LOOP
                  IF vCONTRAGENTS(vCONTRAGENT_POS).PERCENTS.COUNT > 0 AND vCONTRAGENTS(vCONTRAGENT_POS).PERCENTS.EXISTS(vTARIFF_ID) THEN
                    vLINE := vLINE || '<td>' || vCONTRAGENTS(vCONTRAGENT_POS).PERCENTS(vTARIFF_ID).PERCENT_HAND_ACTUAL || '</td>';
                    /*vLINE := vLINE || '<td>' || vCONTRAGENTS(vCONTRAGENT_POS).PERCENTS(vTARIFF_ID).PERCENT_1C || '</td>';*/
                  ELSE
                    vLINE := vLINE || '<td></td>';
                    /*vLINE := vLINE || '<td></td>';*/
                  END IF;

                  vTARIFF_ID := vTARIFFS.NEXT(vTARIFF_ID);
                END LOOP;
                HTP.PRN(vLINE || '</tr>' || cCRLF);
                
                vCONTRAGENT_POS := vCONTRAGENTS.NEXT(vCONTRAGENT_POS);
              END LOOP;
            END IF;
          ELSE            

            -- идем по списку контрагентов
            IF vCONTRAGENTS.COUNT > 0 THEN
              vCONTRAGENT_POS := vCONTRAGENTS.FIRST;
              WHILE vCONTRAGENT_POS IS NOT NULL LOOP
                  
                vLINE := '<tr><td>'||vCONTRAGENT_POS||'</td><td>'||vCONTRAGENTS(vCONTRAGENT_POS).USER_NAME||'</td>';
                  
                vTARIFF_ID := vTARIFFS.FIRST;
                WHILE vTARIFF_ID IS NOT NULL LOOP
                  IF vCONTRAGENTS(vCONTRAGENT_POS).PERCENTS.COUNT > 0 AND vCONTRAGENTS(vCONTRAGENT_POS).PERCENTS.EXISTS(vTARIFF_ID) THEN
                    vLINE := vLINE || '<td>' 
                                   || '<input CLASS="text tariff_' || vTARIFF_ID || '" pattern="\d+([,\.]{1}\d{1,2})?" '||
                                        'placeholder="' || vCONTRAGENTS(vCONTRAGENT_POS).PERCENTS(vTARIFF_ID).PERCENT_HAND_ACTUAL || '" '||
                                        'title = "'||vCONTRAGENTS(vCONTRAGENT_POS).PERCENTS(vTARIFF_ID).PERCENT_HISTORY||'" '||
                                        'maxlength="10" size="3" '||
                                        'name="PERC' || vCONTRAGENTS(vCONTRAGENT_POS).USER_ID || '_' || vTARIFF_ID || '" '||
                                        'id="PERC'   || vCONTRAGENTS(vCONTRAGENT_POS).USER_ID || '_' || vTARIFF_ID || '" type=edit '||
                                        'value="' || vCONTRAGENTS(vCONTRAGENT_POS).PERCENTS(vTARIFF_ID).PERCENT_HAND || '" ' ||
                                        --'onblur="SaveContragentPercent(''' || vCONTRAGENTS(vCONTRAGENT_POS).USER_ID || '_' || vTARIFF_ID || ''', $(this).val());" '|| 
                                        '"/>' 
                                   || '</td>';
                    /*vLINE := vLINE || '<td>' || vCONTRAGENTS(vCONTRAGENT_POS).PERCENTS(vTARIFF_ID).PERCENT_1C || '</td>';*/
                  ELSE
                    vLINE := vLINE || '<td>' 
                                   || '<input CLASS=text pattern="\d+([,\.]{1}\d{1,2})?" '||
                                        'placeholder="" '||
                                        'maxlength="10" size="3" '||
                                        'name="PERC' || vCONTRAGENTS(vCONTRAGENT_POS).USER_ID || '_' || vTARIFF_ID || '" '||
                                        'id="PERC'   || vCONTRAGENTS(vCONTRAGENT_POS).USER_ID || '_' || vTARIFF_ID || '" type=edit '||
                                        'value="" ' ||
                                        --'onblur="SaveContragentPercent(''' || vCONTRAGENTS(vCONTRAGENT_POS).USER_ID || '_' || vTARIFF_ID || ''', $(this).val());" '|| 
                                        '"/>' 
                                   || '</td>';
                    /*vLINE := vLINE || '<td></td>';*/
                  END IF;

                  vTARIFF_ID := vTARIFFS.NEXT(vTARIFF_ID);
                END LOOP;
                HTP.PRN(vLINE || '</tr>' || cCRLF);
                
                vCONTRAGENT_POS := vCONTRAGENTS.NEXT(vCONTRAGENT_POS);
              END LOOP;
            END IF;
          END IF;            
          HTP.PRINT('</TABLE>');
          IF NOT vEXCEL THEN
            HTP.PRINT('<BR><INPUT CLASS=text TYPE=SUBMIT VALUE="Сохранить"></FORM>');
          END IF;
        END IF;
        HTP.PRINT('        </div>');
      END IF;
      S_END;
      HTP.PRINT('
        <script type="text/javascript">
            function setValue(elem){
              
               var id = $(elem).attr("id");
               var id_in = "#value_" + id;
               var id_out = "input[class=''text " + "tariff_" + id + "'']";
               var t = $(id_in).val();
               $(''#TARIFF_PERCENTS'').find(id_out).val(t);
                             
            };
        </script>      
      ');  
    END IF;
  END IF;
EXCEPTION WHEN OTHERS THEN
  OUT_ERROR(dbms_utility.format_error_stack ||CHR(13)||CHR(10)||
            dbms_utility.format_error_backtrace);
END ;
/
