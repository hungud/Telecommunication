CREATE OR REPLACE PROCEDURE S_FOOTER IS
BEGIN
  IF G_STATE.NEED_PRINT_HEADERS THEN
/*    HTP.PRINT('
<script type="text/javascript">
    striper(''table'',''content'',''tr'',''odd,even''); 
    striper(''table'',''report'',''tr'',''odd,even''); 
</script>
<!-- ¬рем€ подготовки страницы: ' || ((dbms_utility.get_Time-G_STATE.FULL_PAGE_TIME)/100) || ' сек-->
</body>*/
HTP.PRINT('
  <div class="footer">
    <span>
      »нформаци€, приводима€ в Ћичном кабинете, носит справочный характер. 
      ќтображаемое состо€ние Ћицевого счета может отличатьс€ от реальных данных, 
      хранимых в финансовых системах ќќќ"ƒжиЁсЁм  орпораци€". © ќќќ"ƒжиЁсЁм  орпораци€". Ѓ ¬се права защищены.
      <br>
    </span>
	</div>
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
</html>');
  END IF;
END S_FOOTER; 
/

