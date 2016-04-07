CREATE OR REPLACE PROCEDURE WWW_DEALER.CONTRAGENT_PERCENTS(
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
    PERCENT_1C_HISTORY VARCHAR2(4000 CHAR),
    PERCENT_HAND NUMBER,
    PERCENT_HAND_ACTUAL NUMBER,
    PERCENT_HAND_HISTORY VARCHAR2(4000 CHAR)    
  );  
  -- проценты одного контрагента (индекс - код оператора, значение - значение процента)
  TYPE T_CONTRAGENT_PERCENTS IS TABLE OF T_PERCENT INDEX BY BINARY_INTEGER;
  -- контрагент (наименование, код, проценты)
  TYPE T_CONTRAGENT IS RECORD (
    USER_ID INTEGER,
    USER_NAME VARCHAR2(255 CHAR),
    PERCENTS T_CONTRAGENT_PERCENTS
  );
  -- список контрагентов, код - порядковый номер контрагента
  TYPE T_CONTRAGENTS IS TABLE OF T_CONTRAGENT INDEX BY BINARY_INTEGER;
  --
  TYPE T_CACHE_ITEM IS TABLE OF VARCHAR2(2000 CHAR) INDEX BY BINARY_INTEGER;
  TYPE T_CACHE_ITEM_CHAR_ID IS TABLE OF VARCHAR2(20 CHAR) INDEX BY BINARY_INTEGER;
  TYPE T_CACHE_ITEM_ID IS TABLE OF BINARY_INTEGER INDEX BY BINARY_INTEGER;
  --
  vCONTRAGENTS T_CONTRAGENTS;
  vOPERATORS DBMS_SQL.VARCHAR2S; -- список операторов (индекс - код, значение - наименование)
  vLINE VARCHAR2(4000 CHAR);
  vPERIOD_SAVE VARCHAR2(200 CHAR);
  vPERIOD_SAVE_DATE DATE;
  vPERIOD_OPEN VARCHAR2(200 CHAR);
  vPERIOD_OPEN_DATE DATE;
  vOPERATOR_ID PLS_INTEGER;
  vCONTRAGENT_POS PLS_INTEGER;
  --  
  CURSOR CUR_OPERATORS IS
    SELECT * FROM D_OPERATORS
    WHERE CAN_CHANGE_PERCENTS = 1;
  --
  CURSOR C_PERCENTS(pMANAGER_ID INTEGER, pPERIOD_DATE DATE) IS
    SELECT D_U.USER_ID
          ,D_U.DESCRIPTION CONTRAGENT_NAME
          ,OP.OPERATOR_ID
          ,OP.OPERATOR_NAME
          -- сортировка делается тут (это порядковый номер контрагента)
          ,ROW_NUMBER() OVER (PARTITION BY OP.OPERATOR_ID ORDER BY D_U.DESCRIPTION) R_NUM
          /*,(
             SELECT P_1C.PERCENT PERCENT_1C
               FROM D_CONTRAGENT_PERCENTS P_1C
              WHERE (V_USER.USER_ID = P_1C.USER_ID)
                AND (OP.OPERATOR_ID = P_1C.OPERATOR_ID)
                AND (P_1C.PERIOD IS NULL)
                AND ROWNUM < 2
            ) PERCENT_1C
            */
          ,S_GET_CONTRAGENT_PERCENT_1C(OP.OPERATOR_ID, V_USER.USER_ID, pPERIOD_DATE) PERCENT_1C
          ,S_GET_CONTRAGENT_PERC_1C_HIST(OP.OPERATOR_ID, V_USER.USER_ID) PERCENT_1C_HISTORY
          ,(
             SELECT P_HAND.PERCENT PERCENT_HAND
               FROM D_CONTRAGENT_PRC_HANDS P_HAND
              WHERE (V_USER.USER_ID = P_HAND.USER_ID)
                AND (OP.OPERATOR_ID = P_HAND.OPERATOR_ID)
                AND (P_HAND.PERIOD = pPERIOD_DATE)
                AND ROWNUM < 2
            ) PERCENT_HAND
          ,S_GET_CONTRAGENT_PERCENT_HAND(OP.OPERATOR_ID, V_USER.USER_ID, pPERIOD_DATE) PERCENT_HAND_ACTUAL
          ,S_GET_CONTRAGENT_PERC_H_HIST(OP.OPERATOR_ID, V_USER.USER_ID) PERCENT_HAND_HISTORY
      FROM V_USERS_BY_MANAGER V_USER
          ,D_USER_NAMES D_U
          ,D_OPERATORS OP
     WHERE (V_USER.MANAGER_ID = pMANAGER_ID)
       --AND (:pCONTRAGENT_ID IS NULL OR V_USER.USER_ID = :pCONTRAGENT_ID)
       AND (V_USER.USER_ID = D_U.USER_ID (+))
       AND NVL(D_U.IS_MANAGER, 0) <> 1
     ORDER BY D_U.DESCRIPTION, OP.ORDER_NUMBER;
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
      HTP.P('Content-Disposition: attachment; filename="CONTRAGENT_PERCENTS.txt"');
--      HTP.P('Pragma: public');
      OWA_UTIL.HTTP_HEADER_CLOSE;
    ELSIF vEXCEL THEN
      PRINT_EXCEL_HEADER('CONTRAGENT_PERCENTS.xls', TRUE);
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
              SET_CONTRAGENT_PERCENT(REPLACE(NAME_ARRAY(I), 'PERC', ''), VALUE_ARRAY(I), vPERIOD_SAVE);
            END IF;
          END LOOP;
        EXCEPTION WHEN OTHERS THEN
          OUT_ERROR(dbms_utility.format_error_stack ||CHR(13)||CHR(10)||
                    dbms_utility.format_error_backtrace);
        END;
        
        FOR REC_OPERATORS IN CUR_OPERATORS LOOP
          vOPERATORS(REC_OPERATORS.OPERATOR_ID) := REC_OPERATORS.OPERATOR_NAME; 
        END LOOP;        
        
        FOR REC IN C_PERCENTS(G_STATE.USER_ID, vPERIOD_OPEN_DATE) LOOP
          vCONTRAGENTS(REC.R_NUM).USER_ID := REC.USER_ID;
          vCONTRAGENTS(REC.R_NUM).USER_NAME := REC.CONTRAGENT_NAME;
          vCONTRAGENTS(REC.R_NUM).PERCENTS(REC.OPERATOR_ID).PERCENT_1C := REC.PERCENT_1C;
          vCONTRAGENTS(REC.R_NUM).PERCENTS(REC.OPERATOR_ID).PERCENT_1C_HISTORY := REC.PERCENT_1C_HISTORY;
          vCONTRAGENTS(REC.R_NUM).PERCENTS(REC.OPERATOR_ID).PERCENT_HAND := REC.PERCENT_HAND;
          vCONTRAGENTS(REC.R_NUM).PERCENTS(REC.OPERATOR_ID).PERCENT_HAND_ACTUAL := REC.PERCENT_HAND_ACTUAL;
          vCONTRAGENTS(REC.R_NUM).PERCENTS(REC.OPERATOR_ID).PERCENT_HAND_HISTORY := REC.PERCENT_HAND_HISTORY;
          
        END LOOP; 
        
        --IF vMODE = 'SELF' OR vMODE = 'SELF_EMPTY' THEN
        IF vTEXT THEN          
          -- собираем заголовок
          vLINE := '№' || cTAB || 'Контрагент'; 
          vOPERATOR_ID := vOPERATORS.FIRST;
          WHILE vOPERATOR_ID IS NOT NULL LOOP
            vLINE := cTAB || vLINE || vOPERATORS(vOPERATOR_ID) || ' (ручн)';
            vLINE := cTAB || vLINE || vOPERATORS(vOPERATOR_ID) || ' (1C)';
            vOPERATOR_ID := vOPERATORS.NEXT(vOPERATOR_ID);
          END LOOP;
          HTP.PRN(vLINE || cCRLF);
            
          -- идем по списку контрагентов
          IF vCONTRAGENTS.COUNT > 0 THEN
            vCONTRAGENT_POS := vCONTRAGENTS.FIRST;
            WHILE vCONTRAGENT_POS IS NOT NULL LOOP
                
              vLINE := '"' || vCONTRAGENT_POS || cQUOTED_TAB || vCONTRAGENTS(vCONTRAGENT_POS).USER_NAME;
                
              vOPERATOR_ID := vOPERATORS.FIRST;
              WHILE vOPERATOR_ID IS NOT NULL LOOP
                IF vCONTRAGENTS(vCONTRAGENT_POS).PERCENTS.COUNT > 0 AND vCONTRAGENTS(vCONTRAGENT_POS).PERCENTS.EXISTS(vOPERATOR_ID) THEN
                  vLINE := cQUOTED_TAB || vLINE || vCONTRAGENTS(vCONTRAGENT_POS).PERCENTS(vOPERATOR_ID).PERCENT_HAND_ACTUAL;
                  vLINE := cQUOTED_TAB || vLINE || vCONTRAGENTS(vCONTRAGENT_POS).PERCENTS(vOPERATOR_ID).PERCENT_1C;
                ELSE
                  vLINE := cQUOTED_TAB || vLINE;
                  vLINE := cQUOTED_TAB || vLINE;
                END IF;

                vOPERATOR_ID := vOPERATORS.NEXT(vOPERATOR_ID);
              END LOOP;
              HTP.PRN(vLINE || cLEFT_QUOTED_CRLF);
              
              vCONTRAGENT_POS := vCONTRAGENTS.NEXT(vCONTRAGENT_POS);
            END LOOP;
          END IF;
        ELSE
          IF vEXCEL THEN
            HTP.PRINT('<H3>Проценты контрагентов (в период - '||vPERIOD_OPEN||')</H3><br>');
          END IF;
      
          IF NOT vEXCEL THEN
          /*
            HTP.PRINT('
            <form id="search_form" method="post" action="!contragent_percents">
            <div id="search" align="center" valign="top">
              <input class="text" type="hidden" name="SESSION_ID" VALUE="'||G_STATE.SESSION_ID||'">
              <table class="search_table"><tbody>
                <tr>
                  <!--<td align="left"><input class="text" type="submit" value="Обновить"></td>-->
                  <td align="left"><input class="text" type="SUBMIT" name="XLS" title="Выгрузить проценты контрагентов в MS Excel" value="Выгрузить в Excel"></td>
                </tr>
              </tbody></table>  
            </div>
            </form>');          
          */
--            HTP.PRINT('
--<a href="!CONTRAGENT_PERCENTS?'||'XLS=1'||G_STATE.SESSION_KEY_PARAM_2||'">Открыть в Excel</a>,
--<a href="!CONTRAGENT_PERCENTS?'||'XTEXT=1'||G_STATE.SESSION_KEY_PARAM_2||'">сохранить в текстовый файл</a><br><br>');
            HTP.PRINT('
<FORM METHOD="POST" ACTION="!contragent_percents" id="CONTRAGENT_PERCENTS">
<INPUT TYPE="HIDDEN" NAME="SESSION_ID" VALUE="'||G_STATE.SESSION_ID||'">
<INPUT TYPE="HIDDEN" NAME="PERIOD_SAVE" VALUE="'||vPERIOD_OPEN||'">');
           
            HTP.PRINT('
              <table class="search_table"><tbody>
                <tr>
                  <td align="left"><INPUT CLASS=text TYPE=SUBMIT VALUE="Сохранить"></td>
                  <td align="left"><input class="text" type="SUBMIT" name="XLS" title="Выгрузить проценты контрагентов в MS Excel" value="Выгрузить в Excel"></td>
                  <td align="right">Период:
                    <select name="PERIOD_OPEN" id="PERIOD_OPEN" onchange="submit();">
                      '||GET_PERIOD_OPTIONS(vPERIOD_OPEN_DATE, TO_DATE('01.01.2010', 'DD.MM.YYYY'))||' 
                    </select>
                  </td>
                </tr>
              </tbody></table>');  
/*
            HTP.PRINT('<INPUT CLASS=text TYPE=SUBMIT VALUE="Сохранить">');
            HTP.PRINT('<input class="text" type="SUBMIT" name="XLS" title="Выгрузить проценты контрагентов в MS Excel" value="Выгрузить в Excel"><br>');
*/            
            HTP.PRINT('Внимание: Все изменения будут сохранены только после нажатия кнопки "Сохранить" (или при изменении периода)!<br>');
          END IF;
            
          -- собираем заголовок
          vLINE := '<TABLE class="table_data"><tr><th>№</th><th>Контрагент</th>'; 
          vOPERATOR_ID := vOPERATORS.FIRST;
          WHILE vOPERATOR_ID IS NOT NULL LOOP
            vLINE := vLINE || '<th>' ||vOPERATORS(vOPERATOR_ID) || ' (ручн)</th>';
            vLINE := vLINE || '<th>' || vOPERATORS(vOPERATOR_ID) || ' (1C)</th>';
            vOPERATOR_ID := vOPERATORS.NEXT(vOPERATOR_ID);
          END LOOP;
          HTP.PRN(vLINE || '</tr>' ||cCRLF);
          
          vLINE := '<tr>
                      <td></td>
                      <td></td>'; 
          vOPERATOR_ID := vOPERATORS.FIRST;
          WHILE vOPERATOR_ID IS NOT NULL LOOP
            vLINE := vLINE ||'
                      <td>   
                          <input type = "text" id = "value_'|| vOPERATOR_ID ||'" maxlength="10" size="3" />
                          <input type = "button" value = "Установить всем" id = "'|| vOPERATOR_ID ||'" onclick="setValue(this)"/> 
                      </td>';
            vLINE := vLINE || '<td></td>';
            vOPERATOR_ID := vOPERATORS.NEXT(vOPERATOR_ID);
          END LOOP;
          HTP.PRN(vLINE || '</tr>' ||cCRLF);
            
          --HTP.PRINT('<TABLE border=0 class=content><tr><th>№</th><th>Номер</th><th>Имя</th><th>Организация</th><th>Группа компенсаций</th><th>Тип</th><th>E-Mail</th><th>Примечание</th></tr>');
          IF vEXCEL THEN
            -- идем по списку контрагентов
            IF vCONTRAGENTS.COUNT > 0 THEN
              vCONTRAGENT_POS := vCONTRAGENTS.FIRST;
              WHILE vCONTRAGENT_POS IS NOT NULL LOOP
                  
                vLINE := '<tr><td>'||vCONTRAGENT_POS||'</td><td>'||vCONTRAGENTS(vCONTRAGENT_POS).USER_NAME||'</td>';
                  
                vOPERATOR_ID := vOPERATORS.FIRST;
                WHILE vOPERATOR_ID IS NOT NULL LOOP
                  IF vCONTRAGENTS(vCONTRAGENT_POS).PERCENTS.COUNT > 0 AND vCONTRAGENTS(vCONTRAGENT_POS).PERCENTS.EXISTS(vOPERATOR_ID) THEN
                    vLINE := vLINE || '<td>' || vCONTRAGENTS(vCONTRAGENT_POS).PERCENTS(vOPERATOR_ID).PERCENT_HAND_ACTUAL || '</td>';
                    vLINE := vLINE || '<td>' || vCONTRAGENTS(vCONTRAGENT_POS).PERCENTS(vOPERATOR_ID).PERCENT_1C || '</td>';
                  ELSE
                    vLINE := vLINE || '<td></td>';
                    vLINE := vLINE || '<td></td>';
                  END IF;

                  vOPERATOR_ID := vOPERATORS.NEXT(vOPERATOR_ID);
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
                  
                vOPERATOR_ID := vOPERATORS.FIRST;
                WHILE vOPERATOR_ID IS NOT NULL LOOP
                  IF vCONTRAGENTS(vCONTRAGENT_POS).PERCENTS.COUNT > 0 AND vCONTRAGENTS(vCONTRAGENT_POS).PERCENTS.EXISTS(vOPERATOR_ID) THEN
                    vLINE := vLINE || '<td>' 
                                   || '<input CLASS="text operator_'|| vOPERATOR_ID ||'" pattern="\d+([,\.]{1}\d{1,2})?" '||
                                        'placeholder="' || vCONTRAGENTS(vCONTRAGENT_POS).PERCENTS(vOPERATOR_ID).PERCENT_HAND_ACTUAL || '" '||
                                        'maxlength="10" size="3" '||
                                        'title = "'||vCONTRAGENTS(vCONTRAGENT_POS).PERCENTS(vOPERATOR_ID).PERCENT_HAND_HISTORY||'" '||
                                        'name="PERC' || vCONTRAGENTS(vCONTRAGENT_POS).USER_ID || '_' || vOPERATOR_ID || '" '||
                                        'id="PERC'   || vCONTRAGENTS(vCONTRAGENT_POS).USER_ID || '_' || vOPERATOR_ID || '" type=edit '||
                                        'value="' || vCONTRAGENTS(vCONTRAGENT_POS).PERCENTS(vOPERATOR_ID).PERCENT_HAND || '" ' ||
                                        --'onblur="SaveContragentPercent(''' || vCONTRAGENTS(vCONTRAGENT_POS).USER_ID || '_' || vOPERATOR_ID || ''', $(this).val());" '|| 
                                        '"/>' 
                                   || '</td>';
                    vLINE := vLINE || '<td title = "'||vCONTRAGENTS(vCONTRAGENT_POS).PERCENTS(vOPERATOR_ID).PERCENT_1C_HISTORY||'">' 
                                   || vCONTRAGENTS(vCONTRAGENT_POS).PERCENTS(vOPERATOR_ID).PERCENT_1C 
                                   || '</td>';
                  ELSE
                    vLINE := vLINE || '<td>' 
                                   || '<input CLASS=text pattern="\d+([,\.]{1}\d{1,2})?" '||
                                        'placeholder="" '||
                                        'maxlength="10" size="3" '||
                                        --'title = "" '||
                                        'name="PERC' || vCONTRAGENTS(vCONTRAGENT_POS).USER_ID || '_' || vOPERATOR_ID || '" '||
                                        'id="PERC'   || vCONTRAGENTS(vCONTRAGENT_POS).USER_ID || '_' || vOPERATOR_ID || '" type=edit '||
                                        'value="" ' ||
                                        --'onblur="SaveContragentPercent(''' || vCONTRAGENTS(vCONTRAGENT_POS).USER_ID || '_' || vOPERATOR_ID || ''', $(this).val());" '|| 
                                        '"/>' 
                                   || '</td>';
                    vLINE := vLINE || '<td></td>';
                  END IF;

                  vOPERATOR_ID := vOPERATORS.NEXT(vOPERATOR_ID);
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
      HTP.PRINT('
        <script type="text/javascript">
            function setValue(elem){
              
               var id = $(elem).attr("id");
               var id_in = "#value_" + id;
               var id_out = "input[class=''text " + "operator_" + id + "'']"; 
               var t = $(id_in).val();
               $(''#CONTRAGENT_PERCENTS'').find(id_out).val(t);
              
            };
        </script>      
      ');
      S_END;
    END IF;
  END IF;
EXCEPTION WHEN OTHERS THEN
  OUT_ERROR(dbms_utility.format_error_stack ||CHR(13)||CHR(10)||
            dbms_utility.format_error_backtrace);
END ;
/
