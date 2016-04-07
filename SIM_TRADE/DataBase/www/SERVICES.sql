CREATE OR REPLACE PROCEDURE SERVICES(
  SESSION_ID IN VARCHAR2 DEFAULT NULL
  ) IS
--#Version=1
  vPHONE_NUMBER VARCHAR2(20 CHAR);
  vCELL_PLAN_NAME VARCHAR2(100 CHAR);
  vUSER_NAME VARCHAR2(100 CHAR);
  vBALANCE NUMBER;
  vDISCONNECT_LIMIT NUMBER;
  vPHONE_STATUS_CODE INTEGER; -- 0 - Заблокирован, 1-Активный
  vACTUAL_DATE DATE; -- Дата и время актуальности
  vNAME_OPT_ROWS DBMS_SQL.VARCHAR2_TABLE;
  vDATE_ROWS DBMS_SQL.DATE_TABLE;
  vMONTHLY_COST_ROWS DBMS_SQL.NUMBER_TABLE;
--
BEGIN
  S_BEGIN(SESSION_ID=>SESSION_ID, STRANICA=>4);
  IF G_STATE.USER_ID IS NOT NULL THEN
    SQL_GET_USER_INFO(
      G_STATE.USER_ID,
      vPHONE_NUMBER,
      vCELL_PLAN_NAME,
      vUSER_NAME,
      vBALANCE,
      vDISCONNECT_LIMIT,
      vPHONE_STATUS_CODE,
      vACTUAL_DATE
      );
    HTP.PRINT('
        <div id="content">');
    HTP.PRINT('
          <p class="phone_number"><b>Абонент:</b> ' || SQL_GET_USER_PHONE(G_STATE.USER_ID) || '</p>
          <h2>Подключенные услуги</h2>');
    SQL_GET_TURNED_SERVICES(
      G_STATE.USER_ID,
      vNAME_OPT_ROWS,
      vDATE_ROWS
--      vMONTHLY_COST_ROWS
      );
    IF vNAME_OPT_ROWS.COUNT=0 THEN
      HTP.PRINT('
          <i><b>Услуги не подключены</b></i>');
    ELSE
      HTP.PRINT('
          <table>
						<thead>
							<tr>
								<td class="first_cell_service">Дата подключения</td>		
                <td class="last_cell">Услуга</td>																
<!-- 								<td class="last_cell">Стоимость (руб.)</td>-->							
							</tr>
						</thead>					
						<tbody>');
      FOR I IN vNAME_OPT_ROWS.FIRST..vNAME_OPT_ROWS.LAST LOOP
        HTP.PRINT('
              <tr>
                <td class="first_cell_service" align="center">' || TO_DATE(vDATE_ROWS(I), 'DD.MM.YYYY') || '</td>
                <td>' || vNAME_OPT_ROWS(I) || '</td>' ||
                
--                <td class="last_cell">' || TO_CHAR(vMONTHLY_COST_ROWS(I)) || '</td>-->	
              '</tr>');
      END LOOP;
      HTP.PRINT('
            </tbody>
					</table>');
    END IF;
    HTP.PRINT('
          </br>
          <h2><i>Для управления услугам звоните: (495) 788-79-08.</i></h2>');
    HTP.PRINT('
        </div>');    
  END IF;
  S_END;
END;
/
