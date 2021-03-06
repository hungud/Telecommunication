CREATE OR REPLACE FUNCTION GET_LIST_PHONE_NO_BL_FROM_SYTE RETURN CLOB IS
-- Version = 2
  PIECES UTL_HTTP.HTML_PIECES;
  ITOG CLOB;
  URL VARCHAR2(500 CHAR);
  CURSOR C IS
    SELECT *
      FROM BLOCK_NO_CONTRACTS_SETTINGS;
  DUMMY C%ROWTYPE;    
BEGIN
  OPEN C;
  FETCH C INTO DUMMY;
  URL:=DUMMY.URL_ACCESS_LIST;
  ITOG:='000 ';
  IF C%FOUND THEN
    PIECES:=UTL_HTTP.REQUEST_PIECES(URL);
    FOR I IN 1 .. PIECES.COUNT LOOP
      ITOG:=ITOG || TO_CLOB(PIECES(I));
    END LOOP;
    IF DBMS_LOB.GETLENGTH(ITOG) > 10 THEN
      UPDATE BLOCK_NO_CONTRACTS_SETTINGS
        SET BLOCK_NO_CONTRACTS_SETTINGS.LIST_NO_BLOCK = ITOG;
      COMMIT;  
    ELSE
      IF DBMS_LOB.GETLENGTH(DUMMY.LIST_NO_BLOCK) > 10 THEN
        ITOG:=DUMMY.LIST_NO_BLOCK;
      ELSE
        UPDATE BLOCK_NO_CONTRACTS_SETTINGS
          SET BLOCK_NO_CONTRACTS_SETTINGS.LIST_NO_BLOCK = ITOG;
        COMMIT;
      END IF;
    END IF;
  END IF;  
  CLOSE C;
  RETURN ITOG;
END;

--grant execute on GET_LIST_PHONE_NO_BL_FROM_SYTE to corp_mobile_role;

--grant execute on GET_LIST_PHONE_NO_BL_FROM_SYTE to SIM_TRADE_role;