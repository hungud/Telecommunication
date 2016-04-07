CREATE OR REPLACE PROCEDURE OUT_ERROR(S IN VARCHAR2) IS
BEGIN
  HTP.PRINT('<div style="color: white; background-color: red; padding: 5px 5px 15px 15px; text-align: center">' || S || '</div><br />');
END;
/
