CREATE OR REPLACE PACKAGE SHOW_MESSAGE IS
--#Version=1
  PROCEDURE JS;
END;
/
CREATE OR REPLACE PACKAGE BODY SHOW_MESSAGE IS
--
PROCEDURE JS IS
--
--  cVERSION CONSTANT VARCHAR2(5) := '1';
--  cEXPIRES_MINUTES CONSTANT BINARY_INTEGER := 5;
NEW_TEXT varchar2(4000 char);
BEGIN
  -- Устаревает через час
  NEW_TEXT:=MS_PARAMS.GET_PARAM_VALUE('MESSAGE_ON_SITE'); ---Текст сообщения
  OWA_UTIL.MIME_HEADER('text/javascript', FALSE);
  HTP.P('Expires: ' || to_char(sysdate + 1/24, 'FMDy, DD Month YYYY HH24:MI:SS') || ' GMT'); 
  OWA_UTIL.HTTP_HEADER_CLOSE;
  HTP.PRINT('
function showMessage()
{
  $(''body'').append("<div id=''darkbg''></div>");
    $(''#darkbg'').css({"opacity":"0","background":"#232d3b","z-index":"4900","position":"absolute","top":"0px","left":"0px","width":$(''body'').width()+''px'',"height":$(''body'').height()+''px''}).animate({opacity: 0.7}, ''slow'', function(){
    $(''body'').append("<div id=''imgzoom''><div style=''position:relative;margin:170px auto auto auto ;height:325px;width:505px; background-color:#ffffff''>'
     || '<div style=''padding: 20px 20px 0px 20px;  color: #000000''><p style=''white-space: pre-wrap; font-size: 13pt;''>' || (NEW_TEXT) || '</p></div>'  
     || '<div style=''padding: 0px 20px 0px 220px;''>' 
      || '<div style=''width:74px; height:28px; background-image:url(img_auth_form_enter_button); cursor:pointer'' type''button'' class=''close'' onclick=''close_w(); return false;''>'
       || '<p align=''center'' style=''padding: 5px 0px 0px 0px; color:#ffffff''><b>Закрыть</b></p></div></div></div></div>");
		$(''#imgzoom'').css({"position":"absolute","z-index":"5000","top":"0px","left":"0px","width":$(''body'').width()+''px'',"height":$(''body'').height()+''px''});
		if($.browser.msie && $.browser.version<7){
		$(''#imgzoom a:first'').css("margin-left","170px")	
		}
	});
}
function close_w(){
	$(''#imgzoom'').animate({opacity: ''hide''},''slow'',function(){$(''#darkbg'').animate({opacity: ''hide''},''slow'',function(){$(''#darkbg'').remove();})
	$(''#imgzoom'').remove();
	});
}
');
--  END IF;
END JS;
END;
/



