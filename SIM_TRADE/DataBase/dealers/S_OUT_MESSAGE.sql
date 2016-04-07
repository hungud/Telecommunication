CREATE OR REPLACE PROCEDURE S_OUT_MESSAGE(
  pMESSAGE IN VARCHAR2
  ) IS
--#Version=1
BEGIN
  HTP.PRINT('<div style="padding: 10px 10px 10px 10px; color: #0000ee">' || HTF.ESCAPE_SC(pMESSAGE) || '</div>');
END;
/
