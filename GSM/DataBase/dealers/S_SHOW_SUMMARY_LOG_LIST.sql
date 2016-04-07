CREATE OR REPLACE PROCEDURE WWW_DEALER.S_SHOW_SUMMARY_LOG_LIST(
  X_USERNAME IN VARCHAR2 DEFAULT NULL,
  X_PASSWORD IN VARCHAR2 DEFAULT NULL,
  SESSION_ID IN VARCHAR2 DEFAULT NULL,
  CLOSE_SESSION IN VARCHAR2 DEFAULT NULL
) IS
--#Version=3
-- v3. 04.08.2015 - Матюнин И. - Добавлен JavaScript для возможности загрузки данных из пришедших из 1С файлов.  

  vTEXT_ORACLE VARCHAR2(32000 CHAR);
  vTEXT_1C VARCHAR2(32000 CHAR);
  RELOAD_FILE_NAME VARCHAR2(50 CHAR);
  
  vDAYS_MAX INTEGER := 5; -- за такое количество дней назад смотрим логи
  
  -- текст загрузки из 1С
  PROCEDURE GET_LAST_LOG(pRESOURCE_TYPE VARCHAR2, pDAYS INTEGER DEFAULT 30, pTEXT OUT VARCHAR2) IS
    CURSOR CUR_START(pRESOURCE_TYPE VARCHAR2, pDAYS INTEGER) IS 
      SELECT L.CHANGE_DATE, L.CHANGE_TYPE, L.TEXT, L.D_LOG_EXCHANGE_ID
        FROM D_LOG_EXCHANGE L
      WHERE L.RESOURCE_TYPE = pRESOURCE_TYPE 
        AND L.CHANGE_DATE > TRUNC(SYSDATE) - pDAYS
        AND L.CHANGE_TYPE IN ('B')
      ORDER BY L.CHANGE_DATE DESC NULLS LAST, L.D_LOG_EXCHANGE_ID DESC;

    CURSOR CUR_END(pRESOURCE_TYPE VARCHAR2, pDAYS INTEGER, pSTART_ID INTEGER DEFAULT NULL) IS 
      SELECT L.CHANGE_DATE, L.CHANGE_TYPE, L.TEXT
        FROM D_LOG_EXCHANGE L
      WHERE L.RESOURCE_TYPE = pRESOURCE_TYPE 
        AND L.CHANGE_DATE > TRUNC(SYSDATE) - pDAYS
        AND L.CHANGE_TYPE IN ('L', 'E')
        AND (pSTART_ID IS NULL OR L.D_LOG_EXCHANGE_ID > pSTART_ID)
      ORDER BY L.CHANGE_DATE DESC NULLS LAST, L.D_LOG_EXCHANGE_ID DESC;

    REC_START CUR_START%ROWTYPE;
    REC_END CUR_END%ROWTYPE;
  BEGIN
    OPEN CUR_START(pRESOURCE_TYPE, pDAYS);
    FETCH CUR_START INTO REC_START;
    IF CUR_START%FOUND THEN
      OPEN CUR_END(pRESOURCE_TYPE, pDAYS, REC_START.D_LOG_EXCHANGE_ID);
      FETCH CUR_END INTO REC_END;
      IF CUR_END%FOUND THEN
        IF REC_END.CHANGE_TYPE = 'E' THEN
          pTEXT := TO_CHAR(REC_END.CHANGE_DATE, 'DD.MM.YYYY HH24:MI:SS')||'<br>(длит '||S_GET_DELTA_TIME_STR(REC_START.CHANGE_DATE, REC_END.CHANGE_DATE)||')'||
            '<br>'||REC_END.TEXT||'.';
        ELSE
          pTEXT := TO_CHAR(REC_END.CHANGE_DATE, 'DD.MM.YYYY HH24:MI:SS')||'<br>(длит '||S_GET_DELTA_TIME_STR(REC_START.CHANGE_DATE, REC_END.CHANGE_DATE)||').';
        END IF;
      ELSE
        pTEXT := 'Загрузка в работе '||S_GET_DELTA_TIME_STR(REC_START.CHANGE_DATE, SYSDATE)||'. Начата '||TO_CHAR(REC_START.CHANGE_DATE, 'DD.MM.YYYY HH24:MI:SS')||'.';
      END IF;
      CLOSE CUR_END;
    ELSE
      OPEN CUR_END(pRESOURCE_TYPE, pDAYS);
      FETCH CUR_END INTO REC_END;
      IF CUR_END%FOUND THEN
        pTEXT := TO_CHAR(REC_END.CHANGE_DATE, 'DD.MM.YYYY HH24:MI:SS');
      ELSE
        pTEXT := 'Загрузка за последние '||pDAYS||' суток не производилась.';
      END IF;
      CLOSE CUR_END;
    END IF;
    CLOSE CUR_START;
    
    pTEXT := pTEXT || ' <a href="ADMIN_LOGS?pRESOURCE_TYPE='||pRESOURCE_TYPE||'&SESSION_ID='||SESSION_ID||'">Дополнительно</a> ';
  END;

  PROCEDURE ADD_DATA_STR(I INTEGER, pTYPE_DESCRIPTION VARCHAR2, pTYPE_STR VARCHAR2, pTEXT_1C VARCHAR2, pTEXT_ORACLE VARCHAR2) IS
    vRELLOAD_ORACLE VARCHAR2(2000 CHAR);
  BEGIN
    vRELLOAD_ORACLE := chr(13) || chr(10)||
      --'<input class=text type=submit title="Запустить загрузку из 1С выбранного вида загрузки." name="'||pTYPE_STR||'" value="Перезагрузить">';
      '<input type = "button" value = "Перезагрузить" id = "'|| pTYPE_STR ||'" onclick="RunLOAD(this)"/>';
      --'<a href=ADMIN_SUMMARY_LOGS'||'?' ||G_STATE.SESSION_KEY_PARAM_1 || '&RELOAD_FILE_NAME='||pTYPE_STR||'>Перезагрузить</a>'; 
      --'<a href="ADMIN_LOGS?pRESOURCE_TYPE='||pTYPE_STR||'&SESSION_ID='||SESSION_ID||'&DO_RELOAD=1">Перезагрузить</a>';
    HTP.PRINT('
              <tr>              
                <td align="center">'||TO_CHAR(I)||'</td>
                <td align="left">'||pTYPE_DESCRIPTION || ' (' || pTYPE_STR||')'||'</td>
                <td align="left">'||pTEXT_1C||'</td>
                <td align="left">'||pTEXT_ORACLE|| vRELLOAD_ORACLE ||' </td>                
              </tr>');
  
  END; 

BEGIN
  IF G_STATE.USER_ID IS NOT NULL THEN
    HTP.PRINT('
          <div id="page_select_first" align="center"></div>');      
  
    HTP.PRINT('
          <div id="logs_table" align="center" valign="top">
            <table class="table_data"><tbody>
              <tr>
                <th>№</th>
                <th>Ресурс</th>
                <th>Загрузка из 1С</th>
                <th>Загрузка в Oracle</th>
              </tr>');
    GET_LAST_LOG('LOAD_CONTRAGENT', vDAYS_MAX, vTEXT_1C);
    GET_LAST_LOG('CONTRAGENTS', vDAYS_MAX, vTEXT_ORACLE);
    ADD_DATA_STR(1, 'Список контрагентов', 'CONTRAGENTS', vTEXT_1C, vTEXT_ORACLE);

    GET_LAST_LOG('LOAD_PHONE_NUMBER', vDAYS_MAX, vTEXT_1C);
    GET_LAST_LOG('PHONE_NUMBERS', vDAYS_MAX, vTEXT_ORACLE);
    ADD_DATA_STR(2, 'Остатки центрального склада', 'PHONE_NUMBERS', vTEXT_1C, vTEXT_ORACLE);

    GET_LAST_LOG('LOAD_BONUS', vDAYS_MAX, vTEXT_1C);
    GET_LAST_LOG('BONUSES', vDAYS_MAX, vTEXT_ORACLE);
    ADD_DATA_STR(3, 'Вознаграждения', 'BONUSES', vTEXT_1C, vTEXT_ORACLE);

    GET_LAST_LOG('LOAD_CONTRAGENT_REST', vDAYS_MAX, vTEXT_1C);
    GET_LAST_LOG('CONTRAGENT_RESTS', vDAYS_MAX, vTEXT_ORACLE);
    ADD_DATA_STR(4, 'Остатки на складах контрагентов', 'CONTRAGENT_RESTS', vTEXT_1C, vTEXT_ORACLE);

    GET_LAST_LOG('LOAD_BALANCE_CHANGE', vDAYS_MAX, vTEXT_1C);
    GET_LAST_LOG('BALANCE_CHANGES', vDAYS_MAX, vTEXT_ORACLE);
    ADD_DATA_STR(5, 'Изменения баланса', 'BALANCE_CHANGES', vTEXT_1C, vTEXT_ORACLE);

    GET_LAST_LOG('LOAD_ACTIVATION', vDAYS_MAX, vTEXT_1C);
    GET_LAST_LOG('ACTIVATIONS', vDAYS_MAX, vTEXT_ORACLE);
    ADD_DATA_STR(6, 'Активации', 'ACTIVATIONS', vTEXT_1C, vTEXT_ORACLE);

    GET_LAST_LOG('LOAD_PHONE_RETURN', vDAYS_MAX, vTEXT_1C);
    GET_LAST_LOG('PHONE_RETURNS', vDAYS_MAX, vTEXT_ORACLE);
    ADD_DATA_STR(7, 'Возвраты', 'PHONE_RETURNS', vTEXT_1C, vTEXT_ORACLE);

    GET_LAST_LOG('LOAD_TARIFF_CHANGE_RULE', vDAYS_MAX, vTEXT_1C);
    GET_LAST_LOG('TARIFF_CHANGE_RULES', vDAYS_MAX, vTEXT_ORACLE);
    ADD_DATA_STR(8, 'Правила изменения тарифов', 'TARIFF_CHANGE_RULES', vTEXT_1C, vTEXT_ORACLE);

    GET_LAST_LOG('LOAD_CONTRAGENT_PERCENT', vDAYS_MAX, vTEXT_1C);
    GET_LAST_LOG('CONTRAGENT_PERCENTS', vDAYS_MAX, vTEXT_ORACLE);
    ADD_DATA_STR(9, 'Проценты контрагентов', 'CONTRAGENT_PERCENTS', vTEXT_1C, vTEXT_ORACLE);

    GET_LAST_LOG('LOAD_TARIFF_PERCENT', vDAYS_MAX, vTEXT_1C);
    GET_LAST_LOG('TARIFF_PERCENTS', vDAYS_MAX, vTEXT_ORACLE);
    ADD_DATA_STR(10, 'Проценты по тарифам', 'TARIFF_PERCENTS', vTEXT_1C, vTEXT_ORACLE);

    GET_LAST_LOG('LOAD_CONTRAGENT_TARIFF_PERCENT', vDAYS_MAX, vTEXT_1C);
    GET_LAST_LOG('CONTR_TARIFF_PERCENTS', vDAYS_MAX, vTEXT_ORACLE);
    ADD_DATA_STR(11, 'Проценты контрагентов по тарифам', 'CONTR_TARIFF_PERCENTS', vTEXT_1C, vTEXT_ORACLE);

    HTP.PRINT('
            </tbody></table>  
          </div>
        <script type="text/javascript">
            function RunLOAD(elem){              
               var id = $(elem).attr("id");
               ReloadFrom1C(id);               
            };
        </script>  
            ');
          
  END IF;
END;
/
