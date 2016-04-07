CREATE OR REPLACE PROCEDURE S_SHOW_NEWS_LIST(pPAGE IN INTEGER) IS
--#Version=1
  vCURRENT_PAGE BINARY_INTEGER := 1;
  vNEW_INDEX BINARY_INTEGER := 0;
  vNEWS_COUNT BINARY_INTEGER;
  cNEWS_ON_PAGE CONSTANT BINARY_INTEGER := 5;
BEGIN
  HTP.PRINT('
<h2>�������</h2>
<ul>');
  FOR rec IN (
    SELECT
      DATE_OF_NEW, NEW_HEADER, NEW_ANNOTATION, D_NEW_ID
    FROM
      D_NEWS
    WHERE
      D_NEWS.NEW_ENABLED=1
      AND D_NEWS.DATE_OF_NEW < SYSDATE
    ORDER BY
      D_NEWS.NEW_IS_ON_TOP DESC, 
      D_NEWS.DATE_OF_NEW DESC
    ) LOOP
    vNEW_INDEX := vNEW_INDEX + 1;
    IF vNEW_INDEX > cNEWS_ON_PAGE THEN
      vNEW_INDEX := 1;
      vCURRENT_PAGE := vCURRENT_PAGE + 1;
    END IF;
    EXIT WHEN vCURRENT_PAGE > pPAGE;
    IF vCURRENT_PAGE = pPAGE THEN
      HTP.PRINT('<li><h4>'||TO_CHAR(rec.DATE_OF_NEW, 'DD.MM.YYYY')||', '||HTF.ESCAPE_SC(rec.NEW_HEADER)||'</h4>');
      HTP.PRINT(S_PRINT_TEXT(rec.NEW_ANNOTATION));
      HTP.PRINT('<p align="left"><a href="SHOW_NEWS_TEXT?NEWS_ID='||rec.D_NEW_ID||G_STATE.SESSION_KEY_PARAM_2||'">�����</a></p></li>');
    END IF;
  END LOOP;
  HTP.PRINT('
</ul>
');
  -- ��������
  SELECT COUNT(*)
    INTO vNEWS_COUNT 
    FROM D_NEWS
    WHERE D_NEWS.NEW_ENABLED=1
    AND D_NEWS.DATE_OF_NEW < SYSDATE;
  --
  S_SHOW_PAGE_LIST(
    pPAGE,
    TRUNC((vNEWS_COUNT+cNEWS_ON_PAGE-1)/cNEWS_ON_PAGE),
    'MAIN');
--
END;
/