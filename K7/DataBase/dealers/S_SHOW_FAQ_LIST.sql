CREATE OR REPLACE PROCEDURE S_SHOW_FAQ_LIST IS
--#Version=1
  vINDEX BINARY_INTEGER := 1;
BEGIN
  HTP.PRINT('
<h2>Частые вопросы</h2>
');
  FOR rec IN (
    SELECT * 
    FROM D_FAQS 
    WHERE D_FAQS.FAQ_ENABLED=1
    ORDER BY D_FAQS.ORDER_NUMBER
    ) LOOP
    HTP.PRINT('<h4>
      <a href="#" onclick=''javascript: var v=document.getElementById("FAQ'||vINDEX||'"); if (v.style.display=="none") {v.style.display="";} else {v.style.display="none";};''>'||
      HTF.ESCAPE_SC(rec.FAQ_HEADER)||'</a></h4>');
    IF rec.FAQ_REQUEST IS NOT NULL THEN 
      HTP.PRINT(rec.FAQ_REQUEST || '<br />');
    END IF;
    HTP.PRINT('<span id="FAQ'||vINDEX||'" style="display: none"><b>Ответ:</b><br/>'||rec.FAQ_RESPONSE||'<br /></span>
      <br />');
    vINDEX := vINDEX + 1;
  END LOOP;
  HTP.PRINT('

');
--
END;
/
