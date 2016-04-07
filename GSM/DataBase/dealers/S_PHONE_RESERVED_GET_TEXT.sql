CREATE OR REPLACE FUNCTION S_PHONE_RESERVED_GET_TEXT(
  psPHONE_NUMBER VARCHAR2, -- номер телефона
  psUSER_ID integer,
  psDATELU date,
  psCAPTION OUT VARCHAR2,
  psOUT_ERROR OUT VARCHAR2
  ) RETURN VARCHAR2 AS
  
-- текст письма по случаю бронирования номера

  vCAPTION VARCHAR2(255 CHAR);
  vTEXT VARCHAR2(32000 CHAR);
--

  FUNCTION TO_HTML(s VARCHAR2) RETURN VARCHAR2 IS
  BEGIN
    RETURN REPLACE(REPLACE(REPLACE(REPLACE(s, '&', '&'||'amp;'), '<', '&'||'lt;'), '>', '&'||'gt;'), '"', '&'||'quot;');
  END TO_HTML;
  --
  PROCEDURE ADD_LINE(pSTR VARCHAR2) IS
  BEGIN
    IF vTEXT IS NULL THEN
      vTEXT := pSTR;
    ELSE
      vTEXT := vTEXT || CHR(13) || CHR(10) || pSTR;
    END IF;
  END;
--
BEGIN
  psOUT_ERROR := NULL;
    begin
      select NVL(U.USER_NAME, U.DESCRIPTION) into vCAPTION from D_USER_NAMES U
      where u.user_id=psUSER_ID;
     exception
      when others then 
        vCAPTION := '-NULL-';
    end;
    if vCAPTION is null then
      vCAPTION := '-NULL-';
    end if;
    vCAPTION := 'Бронирование номера '||psPHONE_NUMBER||' контрагентом '||vCAPTION;
    vCAPTION := HTF.ESCAPE_SC(vCAPTION);
    
    ADD_LINE('<html>');

    ADD_LINE('<b><big>'||vCAPTION||'</big></b><br>');
    ADD_LINE('Дата            : <b>'||TO_CHAR(psDATELU, 'DD.MM.YYYY hh24:mi:ss')||'</b><br>');

    ADD_LINE('</html>');
  --
  psCAPTION := vCAPTION;
  RETURN vTEXT;  
END; 