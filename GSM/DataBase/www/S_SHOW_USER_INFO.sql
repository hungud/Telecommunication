CREATE OR REPLACE PROCEDURE S_SHOW_USER_INFO(
  FIRST_WORK IN BOOLEAN DEFAULT FALSE
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
    IF FIRST_WORK THEN 
      HTP.PRINT('
          <center><b>Вас приветствует ДжиЭсЭм Корпорация!</b></center><br>');
    END IF;  
    HTP.PRINT('
          <table class="info_table">
            <tbody>
              <tr>
                <td class="first_cell"><b>Абонент:</b></td>
                <td class="last_cell">' || SQL_GET_USER_PHONE(G_STATE.USER_ID) || '</td>
              </tr>
              <tr>
                <td class="first_cell"><b>Тарифный план:</b></td>
                <td class="last_cell">' || vCELL_PLAN_NAME || '</td>
              </tr>
              <tr>
                <td class="first_cell"><b>ФИО абонента:</b></td>
                <td class="last_cell">' || vUSER_NAME || '</td>								
              </tr>
              <tr>
                <td class="first_cell"><b>Баланс:</b></td>
                <td class="last_cell">' || 
                  CASE WHEN vBALANCE<0 THEN '<span class="red">' || COST_TO_CHAR(vBALANCE) || '</span>'
                       ELSE COST_TO_CHAR(vBALANCE) 
                  END 
                  || '<a href="balance?' ||G_STATE.SESSION_KEY_PARAM_1 || '" title="" class="balance_info button">Расшифровка баланса</a></td>
              </tr>
              <tr>
                <td class="first_cell"><b>Порог отключения:</b></td>
                <td class="last_cell">' || 
                  CASE WHEN vDISCONNECT_LIMIT IS NULL THEN 'Не задан.' 
                       ELSE vDISCONNECT_LIMIT || 'руб.' 
                  END
                  || '</td>
              </tr>
							<tr>
                <td class="first_cell"><b>Статус номера:</b></td>
                <td class="last_cell">' || 
                  CASE WHEN vPHONE_STATUS_CODE = 0 THEN '<span class="red">Заблокирован.</span>' 
                    ELSE 'Активный.' 
                  END 
                  || '</td>
              </tr>
              <tr>
                <td class="first_cell"><b>Актуальность данных:</b></td>
                <td class="last_cell">' || TO_CHAR(vACTUAL_DATE, 'dd.mm.yyyy hh24:mi') || '</td>
              </tr>
            </tbody>
          </table>');                    
    HTP.PRINT('
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
        </div>');    
  END IF;
END;
/
