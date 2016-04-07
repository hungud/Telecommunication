CREATE OR REPLACE PROCEDURE S_SHOW_SEARCH(
  pPAGE_NUM IN BINARY_INTEGER DEFAULT 1,
  pROWS_COUNT IN BINARY_INTEGER DEFAULT 50,
  pPHONE_SEARCH IN VARCHAR2 DEFAULT NULL,
  pSHOW_EXTENDED IN NUMBER DEFAULT NULL,
  pPHONE_TYPES VARCHAR2 DEFAULT 'ALL',
  pMIN_PRICE NUMBER DEFAULT NULL,
  pMAX_PRICE NUMBER DEFAULT NULL,
  pHLR NUMBER DEFAULT NULL,
  pOPERATOR_ID NUMBER DEFAULT NULL,
  pTARIFF_ID NUMBER DEFAULT NULL,
  pMAIN_STORE_ID NUMBER DEFAULT NULL,
  pORDER_BY IN VARCHAR2 DEFAULT 'PHONE_NUMBER ASC'
  ) IS
--#Version=1
--
  vSHOW_EXTENDED NUMBER;
  
  FUNCTION GET_PRICE_OPTIONS(pSELECTED_VALUE VARCHAR2) RETURN VARCHAR2 IS
  BEGIN
   RETURN '
                    '||GET_OPTION_ITEM('', pSELECTED_VALUE)||'
                    '||GET_OPTION_ITEM('300', pSELECTED_VALUE)||'
                    '||GET_OPTION_ITEM('500', pSELECTED_VALUE)||'
                    '||GET_OPTION_ITEM('700', pSELECTED_VALUE)||'
                    '||GET_OPTION_ITEM('1000', pSELECTED_VALUE)||'
                    '||GET_OPTION_ITEM('1500', pSELECTED_VALUE)||'
                    '||GET_OPTION_ITEM('2000', pSELECTED_VALUE)||'
                    '||GET_OPTION_ITEM('2500', pSELECTED_VALUE)||'
                    '||GET_OPTION_ITEM('3000', pSELECTED_VALUE)||'
                    '||GET_OPTION_ITEM('3500', pSELECTED_VALUE)||'
                    '||GET_OPTION_ITEM('4000', pSELECTED_VALUE)||'
                    '||GET_OPTION_ITEM('4500', pSELECTED_VALUE)||'
                    '||GET_OPTION_ITEM('5000', pSELECTED_VALUE)||'
                    '||GET_OPTION_ITEM('6000', pSELECTED_VALUE)||'
                    '||GET_OPTION_ITEM('7000', pSELECTED_VALUE)||'
                    '||GET_OPTION_ITEM('8000', pSELECTED_VALUE)||'
                    '||GET_OPTION_ITEM('9000', pSELECTED_VALUE)||'
                    '||GET_OPTION_ITEM('10000', pSELECTED_VALUE)||'
                    '||GET_OPTION_ITEM('20000', pSELECTED_VALUE)||'
                    '||GET_OPTION_ITEM('30000', pSELECTED_VALUE)||'
                    '||GET_OPTION_ITEM('40000', pSELECTED_VALUE)||'
                    '||GET_OPTION_ITEM('50000', pSELECTED_VALUE)||'
                    '||GET_OPTION_ITEM('60000', pSELECTED_VALUE)||'
                    '||GET_OPTION_ITEM('70000', pSELECTED_VALUE)||'
                    '||GET_OPTION_ITEM('80000', pSELECTED_VALUE)||'
                    '||GET_OPTION_ITEM('90000', pSELECTED_VALUE)||'
                    '||GET_OPTION_ITEM('100000', pSELECTED_VALUE);   
  END;
BEGIN
  IF G_STATE.USER_ID IS NOT NULL THEN
--    document.getElementById("pPHONE_SEARCH2").innerHTML = "123321";
    /*
    IF (pPHONE_TYPES = 'ALL') AND (pMIN_PRICE IS NULL) AND (pMAX_PRICE IS NULL) AND (pHLR IS NULL) AND (pOPERATOR_ID IS NULL) AND (pTARIFF_ID IS NULL) THEN
      vSHOW_EXTENDED := NULL; 
    ELSE
      vSHOW_EXTENDED := 1;
    END IF;
    */
    -- всегда показываем расширенный поиск
    vSHOW_EXTENDED := 1;
    
    --HTP.PRINT(TO_CHAR(SYSDATE, 'DD.MM.YYYY HH24:MI:SS'));
    HTP.PRINT('
          <FORM id="search_form" method="post" action="store" accept-charset="windows-1251">
          <div id="search" align="center" valign="top">
            <input class=text type="hidden" name=SESSION_ID value="' || G_STATE.SESSION_ID || '"/>
            <input class=text type="hidden" name=pORDER_BY value="' || pORDER_BY || '"/>
            <table class="search_table"><tbody>
              <tr>
                <td align="left" style="width:126px">Поиск по номеру</td>
                <td align="left" style="width:126px"><input class=text type=edit id="pPHONE_SEARCH" name=pPHONE_SEARCH title="Номер телефона, часть номера телефона или маска типа aaa, aabb, ababa, abcdabc." placeholder="Введите номер телефона " value="'||REPLACE(REPLACE(pPHONE_SEARCH, CHR(10), ''), CHR(13), '')||'"></td>
                <td align="left" style="width:50px"><input class=text type=submit value="Искать"></td>
                <td align="right"><INPUT CLASS=text TYPE="SUBMIT" NAME="SUBMIT_EXCEL" VALUE="Открыть в Excel" /></td>
                <td align="left" valign="middle">
                  <div id="search_extended_link" style="display: '||CASE NVL(TO_CHAR(vSHOW_EXTENDED), 'NULL') WHEN 'NULL' THEN 'block' ELSE 'none' END||';">
                     <a href="#" onclick="document.getElementById(''search_extended'').style.display='''||CASE NVL(TO_CHAR(vSHOW_EXTENDED), 'NULL') WHEN 'NULL' THEN 'block' ELSE 'none' END||''';
                     document.getElementById(''search_extended_link'').style.display='''||CASE NVL(TO_CHAR(vSHOW_EXTENDED), 'NULL') WHEN 'NULL' THEN 'none' ELSE 'block' END||''';">Расширенный поиск</a>         
                  </div>          
                </td>
                <td align="right">Показывать по:</td>
                <td align="right" style="width:60px">
                  <select name="pROWS_COUNT" onchange="submit();">
                    '||GET_OPTION_ITEM('50', pROWS_COUNT)||'
                    '||GET_OPTION_ITEM('100', pROWS_COUNT)||'
                    '||GET_OPTION_ITEM('200', pROWS_COUNT)||'
                    '||GET_OPTION_ITEM('500', pROWS_COUNT)||'
                  </select>
                </td>
              </tr>
              <tr>
                <td></td>
                <td colspan="7"><small>Поиск по номеру, части номера или маске вида aaa, aabb, aabbcc, aabbccdd или bacdbacd и тп.</small></td>
              </tr>
            </tbody></table>  
          </div>
          <div id="search_extended" align="center" valign="top" style="display: '||CASE NVL(TO_CHAR(vSHOW_EXTENDED), 'NULL') WHEN 'NULL' THEN 'none' ELSE 'block' END||';">
            <table class="search_table"><tbody>
              <!--<tr>
                <a href="#" 
                  onclick="document.getElementById(''search_extended'').style.display='''||CASE NVL(TO_CHAR(vSHOW_EXTENDED), 'NULL') WHEN 'NULL' THEN 'none' ELSE 'block' END||''';
                           document.getElementById(''search_extended_link'').style.display='''||CASE NVL(TO_CHAR(vSHOW_EXTENDED), 'NULL') WHEN 'NULL' THEN 'block' ELSE 'none' END||''';
                           document.getElementsByName(''pPHONE_TYPES'')[0].selectedIndex = 0;
                           document.getElementsByName(''pMIN_PRICE'')[0].selectedIndex = 0;
                           document.getElementsByName(''pMAX_PRICE'')[0].selectedIndex = 0;
                           document.getElementsByName(''pHLR'')[0].value = '''';
                           document.getElementsByName(''pOPERATOR_ID'')[0].selectedIndex = 0;
                           document.getElementsByName(''pTARIFF_ID'')[0].selectedIndex = 0;
                           ">Расширенный поиск</a>         
              </tr>-->
              <tr>
                <td align="left">
                  Показывать: <select name="pPHONE_TYPES">
                    '||GET_OPTION_ITEM('ALL', pPHONE_TYPES, 'Все')||'
                    '||GET_OPTION_ITEM(D_CONSTANTS_PKG.IS_DIRECT, pPHONE_TYPES, 'Только прямые')||'
                    '||GET_OPTION_ITEM(D_CONSTANTS_PKG.IS_FEDERAL, pPHONE_TYPES, 'Только федеральные')||'
                  </select>
                </td>
                <td align="left">
                  По цене с: <select name="pMIN_PRICE">'||GET_PRICE_OPTIONS(pMIN_PRICE)||'</select>
                  по: <select name="pMAX_PRICE">'||GET_PRICE_OPTIONS(pMAX_PRICE)||'</select>
                </td>
                <td align="left">
                  Выбрать склад :
                  <select name="pMAIN_STORE_ID" id="pMAIN_STORE_ID" onchange="submit();">
                    '||GET_MAIN_STORES_OPTIONS(pMAIN_STORE_ID)||' 
                  </select>
                </td>
                <td align="left">HLR:<input class=text type=edit name=pHLR value="'||REPLACE(REPLACE(pHLR, CHR(10), ''), CHR(13), '')||'" size="5"></td>
              </tr>
              <tr>
                <td align="left">
                  Выбрать оператора :
                  <!--<select name="pOPERATOR_ID"  onchange="submit();">-->
                  <select name="pOPERATOR_ID" id="pOPERATOR_ID" onchange="ReloadTariffs(null, this.value);">
                    '||GET_OPERATORS_OPTIONS(pOPERATOR_ID)||' 
                  </select>
                </td>
                <td align="left">
                  Выбрать тариф :
                  <span id="TARIFFS_SELECT">'||GET_TARIFF_OPTIONS(pTARIFF_ID, pOPERATOR_ID)||'</span> 
                </td>
                <td align="left"><input class=text type=submit value="Искать"></td>
              </tr>
            </tbody></table>  
          </div>
          </FORM>
          ');
  END IF;
END;
/
