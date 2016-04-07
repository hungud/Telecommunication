CREATE OR REPLACE PROCEDURE S_FOOTER IS
BEGIN
  IF G_STATE.NEED_PRINT_HEADERS THEN
/*    HTP.PRINT('
<script type="text/javascript">
    striper(''table'',''content'',''tr'',''odd,even''); 
    striper(''table'',''report'',''tr'',''odd,even''); 
</script>
<!-- Время подготовки страницы: ' || ((dbms_utility.get_Time-G_STATE.FULL_PAGE_TIME)/100) || ' сек-->
</body>*/
/*HTP.PRINT('
<!--LiveInternet counter--><script type="text/javascript"><!--
document.write("<a href=''http://www.liveinternet.ru/click'' "+
"target=_blank><img src=''//counter.yadro.ru/hit?t45.6;r"+
escape(document.referrer)+((typeof(screen)=="undefined")?"":
";s"+screen.width+"*"+screen.height+"*"+(screen.colorDepth?
screen.colorDepth:screen.pixelDepth))+";u"+escape(document.URL)+
";"+Math.random()+
"'' alt='''' title=''LiveInternet'' "+
"border=''0'' width=''31'' height=''31''><\/a>")
//--></script><!--/LiveInternet-->
</html>');*/
    HTP.PRINT('</html>');
  END IF;
END S_FOOTER; 
/

