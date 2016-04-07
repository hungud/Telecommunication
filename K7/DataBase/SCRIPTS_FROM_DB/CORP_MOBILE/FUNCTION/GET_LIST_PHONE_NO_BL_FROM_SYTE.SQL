
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."GET_LIST_PHONE_NO_BL_FROM_SYTE" RETURN CLOB IS
-- Version = 3
--12.03.2015 Алексеев. Кто то изменил данную функцию и номера перестали грузиться (эти изменения закоменчены). Сейчас вернул ссылку в старое состояние
  PIECES UTL_HTTP.HTML_PIECES;
  ITOG CLOB;
  URL VARCHAR2(500 CHAR);
  CURSOR C IS
    SELECT *
      FROM BLOCK_NO_CONTRACTS_SETTINGS;
  DUMMY C%ROWTYPE;
      
BEGIN
  /*URL := MS_PARAMS.GET_PARAM_VALUE('GET_NEW_CONTRACTS_URL');
  if URL is not null then
    URL := REPLACE(URL, '%CONTRACT_DATE%', to_char(sysdate, 'yyyy.mm.dd'));   
  else
    ITOG := null;  
  end if; */
  
 
 OPEN C;
  FETCH C INTO DUMMY;
  URL:=DUMMY.URL_ACCESS_LIST;
  ITOG:='000 ';
  IF C%FOUND THEN
    IF DUMMY.DATE_LAST_CHECK_SYTE + 3/24/60 < SYSDATE THEN -- Дата посл проверки более 3х мин назад. 
      PIECES:=UTL_HTTP.REQUEST_PIECES(URL);
      FOR I IN 1 .. PIECES.COUNT LOOP
        ITOG:=ITOG || TO_CLOB(PIECES(I));
      END LOOP;
      IF (DBMS_LOB.GETLENGTH(ITOG) > 10) 
          and (not( (dbms_lob.instr(ITOG, '<html>') > 0) 
                      or (dbms_lob.instr(ITOG, 'Gateway Time-out') > 0) 
                      or (dbms_lob.instr(ITOG, 'error') > 0)) ) THEN
        UPDATE BLOCK_NO_CONTRACTS_SETTINGS
          SET BLOCK_NO_CONTRACTS_SETTINGS.LIST_NO_BLOCK = ITOG,
              BLOCK_NO_CONTRACTS_SETTINGS.DATE_LAST_CHECK_SYTE = sysdate;
        COMMIT;  
      ELSE
        ITOG:=DUMMY.LIST_NO_BLOCK;
      END IF;
    ELSE
      ITOG:=DUMMY.LIST_NO_BLOCK;
    END IF;
  END IF;  
  CLOSE C;
 
  RETURN ITOG;
END;