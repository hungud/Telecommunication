CREATE OR REPLACE PROCEDURE PRINT_EXCEL_HEADER(
  pFILE_NAME IN VARCHAR2 DEFAULT NULL,
  pUSE_LANDSCAPE_ORIENTATION IN BOOLEAN DEFAULT FALSE
  ) IS
--Version=1
BEGIN
  G_STATE.NO_DISPLAY_PANELS := TRUE;
  G_STATE.USE_EMBEDDED_STYLES := TRUE;
  G_STATE.PRINT_EXCEL_HEADERS := TRUE;
  G_STATE.USE_LANDSCAPE_ORIENTATION := pUSE_LANDSCAPE_ORIENTATION;
--      G_STATE.CONTENT_TYPE := 'application/vnd.ms-excel';
  IF G_STATE.CAN_MODIFY_HTTP_HEADERS THEN
    OWA_UTIL.MIME_HEADER('application/vnd.ms-excel', FALSE);
    -- Make sure that IE can download the attachments under https.
    HTP.P('Content-Disposition: attachment; filename="' || HTF.ESCAPE_URL(pFILE_NAME) ||'"');
    HTP.P('Pragma: public');
    --HTP.P('Content-Length: ' || DBMS_LOB.GETLENGTH(vBLOB_CONTENT)); 
    OWA_UTIL.HTTP_HEADER_CLOSE;
  END IF;
END;
/