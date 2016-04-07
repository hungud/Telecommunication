CREATE OR REPLACE PROCEDURE WWW_DEALER.ADMIN_DELIVERY_TYPE_LIST(
  SESSION_ID IN VARCHAR2 DEFAULT NULL,
  pORDER_BY IN VARCHAR2 DEFAULT 'DELIVERY_NAME ASC',
  DO_DELETE IN VARCHAR2 DEFAULT NULL,
  pID IN INTEGER DEFAULT NULL
) IS
--
--#Version=1
--
  I PLS_INTEGER := 0; 
  vHREF VARCHAR2(4000 CHAR);
  vTEMP VARCHAR2(4000 CHAR);
BEGIN
  IF SESSION_ID IS NOT NULL THEN
    vHREF := 'ADMIN_DELIVERY_TYPE_LIST?' ||
            'SESSION_ID='||SESSION_ID;
      
  
    S_BEGIN(SESSION_ID=>SESSION_ID);
    -- И пользователь является администратором!
    IF (G_STATE.USER_ID IS NOT NULL) AND (G_STATE.IS_ADMIN = 1) THEN
    --IF (G_STATE.USER_ID = 13614) AND (G_STATE.IS_ADMIN = 1) THEN
          
      IF DO_DELETE = 'YES' THEN
        BEGIN
          --DELETE FROM D_DELIVERY_TYPES D
          --WHERE D.DELIVERY_TYPE_ID = pID;
          -- проставляем признак удаления 
          UPDATE D_DELIVERY_TYPES D
             SET D.IS_DELETED = 1 
           WHERE D.DELIVERY_TYPE_ID = pID; 
          
          S_OUT_MESSAGE('Удалено '||SQL%ROWCOUNT||' способов доставки.');
        EXCEPTION
          WHEN OTHERS THEN
            OUT_ERROR('Ошибка удаления способа доставки.'||CHR(13)||CHR(10)||
            dbms_utility.format_error_stack ||CHR(13)||CHR(10)||
            dbms_utility.format_error_backtrace);
        END;
      END IF;
      
      
      HTP.PRINT('
    <div id="content">
      <div><A HREF="ADMIN_NEW_DELIVERY_TYPE?' ||G_STATE.SESSION_KEY_PARAM_1 || '">Добавить способ доставки</A></div>
      <br>
      <TABLE CLASS="table_data">
        <TR>
          <TH>№</TH>                                                           
          '||S_GET_TABLE_HEADER('Наименование', 'DELIVERY_NAME', pORDER_BY, vHREF)||'
          '||S_GET_TABLE_HEADER('Указывать адрес', 'NEED_ADDRESS', pORDER_BY, vHREF)||'                                                          
          <TH>Удалить</TH>
        </TR>');
      FOR rec IN (
        SELECT D.DELIVERY_TYPE_ID, D.DELIVERY_NAME, D.NEED_ADDRESS, D.IS_DELETED
        FROM D_DELIVERY_TYPES D
         ORDER BY
            CASE 
              WHEN pORDER_BY = 'DELIVERY_NAME ASC' THEN DELIVERY_NAME
              WHEN pORDER_BY = 'NEED_ADDRESS ASC' THEN TO_CHAR(NEED_ADDRESS)   
              ELSE NULL
            END,
            CASE 
              WHEN pORDER_BY = 'DELIVERY_NAME DESC' THEN DELIVERY_NAME
              WHEN pORDER_BY = 'NEED_ADDRESS DESC' THEN TO_CHAR(NEED_ADDRESS)
              ELSE NULL
            END DESC NULLS FIRST,
            D.DELIVERY_NAME
        ) 
      LOOP
        I := I + 1;
        
        HTP.PRINT('
        <TR>
          <TD>' || TO_CHAR(I) ||'</TD>');
          
          IF NVL(REC.IS_DELETED, 0)=0  THEN
            HTP.PRINT('
          <TD><A HREF="ADMIN_NEW_DELIVERY_TYPE?pID=' || rec.DELIVERY_TYPE_ID  || '&'||'SESSION_ID=' ||SESSION_ID||  '">' || NVL(rec.DELIVERY_NAME, '-') ||'</A></TD>
          <TD align="center">'|| CASE NVL(REC.NEED_ADDRESS, 0) WHEN 1 THEN 'Да' ELSE 'Нет' END ||'</TD>
          <TD><A HREF="ADMIN_DELIVERY_TYPE_LIST?pID=' || rec.DELIVERY_TYPE_ID || '&'||'SESSION_ID=' ||SESSION_ID||  '&'||'DO_DELETE=YES'||'">' || 'Удалить' ||'</A></TD>'
                     );
          ELSE
            HTP.PRINT('
          <TD>' || NVL(rec.DELIVERY_NAME, '-') ||'</TD>
          <TD align="center">'|| CASE NVL(REC.NEED_ADDRESS, 0) WHEN 1 THEN 'Да' ELSE 'Нет' END ||'</TD>
          <TD>Удалено</TD>'
                     );
          END IF;
          
          HTP.PRINT(
          '
        </TR>'); 
      END LOOP;
      HTP.PRINT('
        </TABLE>
      </div>');
    END IF;
    S_END;
  END IF;
END ADMIN_DELIVERY_TYPE_LIST;
/
