CREATE OR REPLACE PROCEDURE OUT_ERROR(S IN VARCHAR2) IS
BEGIN
  HTP.PRINT('<div class="error">' || S || '</div>');
END; 
/

