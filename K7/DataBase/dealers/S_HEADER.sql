CREATE OR REPLACE PROCEDURE WWW_DEALER.S_HEADER(
  X_USERNAME IN VARCHAR2 DEFAULT NULL,
  X_PASSWORD IN VARCHAR2 DEFAULT NULL,
  SESSION_ID IN VARCHAR2 DEFAULT NULL,
  CLOSE_SESSION IN VARCHAR2 DEFAULT NULL
  ) IS
  gWindowCaption varchar2(500);
BEGIN
  IF G_STATE.NEED_PRINT_HEADERS THEN
    IF G_STATE.FULL_PAGE_TIME IS NULL THEN
      G_STATE.FULL_PAGE_TIME := dbms_utility.get_Time;
    END IF;
    HTP.PRN('
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html');
    IF G_STATE.PRINT_EXCEL_HEADERS THEN
      HTP.PRN(' xmlns:o="urn:schemas-microsoft-com:office:office"
  xmlns:x="urn:schemas-microsoft-com:office:excel"
  xmlns="http://www.w3.org/TR/REC-html40"');
    ELSE
      HTP.PRN(' xmlns="http://www.w3.org/1999/xhtml"');
    END IF;
    HTP.PRINT('>
  <head>');
    IF NOT G_STATE.PRINT_EXCEL_HEADERS THEN
      -- чарсет при выгузке в ексель (если его установить), показывает вьетнамские казюки
      -- поэтому при выгрузке в ексель не ставим чарсер
      HTP.PRINT('
      <meta http-equiv="Content-Type" content="' || G_STATE.CONTENT_TYPE || '; charset=' || G_STATE.PAGE_CHARSET || '" />');
    ELSE    
      HTP.PRINT('
      <meta http-equiv="Content-Type" content="' || G_STATE.CONTENT_TYPE || '; charset=windows-1251" />');
    
      HTP.PRINT('<meta name=ProgId content=Excel.Sheet>');
      IF G_STATE.EXCEL_FREEZE_ROWS IS NOT NULL THEN
      HTP.PRINT('<!--[if gte mso 9]><xml>
   <o:DocumentProperties>
    <o:Author>http://www.tarifer.ru</o:Author>
    <o:LastAuthor>http://www.tarifer.ru</o:LastAuthor>
    <o:Version>11.5606</o:Version>
   </o:DocumentProperties>
  </xml><![endif]-->
  <!--[if gte mso 9]><xml>
   <x:ExcelWorkbook>
    <x:ExcelWorksheets>
     <x:ExcelWorksheet>
      <x:Name>Sheet 1</x:Name>
      <x:WorksheetOptions>
       <x:Selected/>
       <x:FreezePanes/>
       <x:FrozenNoSplit/>
       <x:SplitHorizontal>'||G_STATE.EXCEL_FREEZE_ROWS||'</x:SplitHorizontal>
       <x:TopRowBottomPane>'||G_STATE.EXCEL_FREEZE_ROWS||'</x:TopRowBottomPane>
  '||--     <x:SplitVertical>1</x:SplitVertical>
  --     <x:LeftColumnRightPane>1</x:LeftColumnRightPane>
  '     <x:ActivePane>2</x:ActivePane>
       <x:Panes>
        <x:Pane>
         <x:Number>3</x:Number>
        </x:Pane>
        <x:Pane>
         <x:Number>2</x:Number>
         <x:ActiveRow>0</x:ActiveRow>
        </x:Pane>
       </x:Panes>
       <x:ProtectContents>False</x:ProtectContents>
       <x:ProtectObjects>False</x:ProtectObjects>
       <x:ProtectScenarios>False</x:ProtectScenarios>
      </x:WorksheetOptions>
     </x:ExcelWorksheet>
    </x:ExcelWorksheets>
    <x:ProtectStructure>False</x:ProtectStructure>
    <x:ProtectWindows>False</x:ProtectWindows>
   </x:ExcelWorkbook>
  </xml><![endif]-->');
      END IF;
    END IF;
  END IF;
  --
  GET_USER_ID(X_USERNAME=>X_USERNAME, X_PASSWORD=>X_PASSWORD, SESSION_ID=>SESSION_ID, CLOSE_SESSION=>CLOSE_SESSION);
  --
  IF G_STATE.NEED_PRINT_HEADERS THEN
    IF G_STATE.TITLE IS NOT NULL THEN
      gWindowCaption := G_STATE.TITLE || ' - ';
    END IF;
  -- Стили
    IF G_STATE.USE_EMBEDDED_STYLES THEN
      HTP.PRINT('<style type="text/css">');
      MAIN_CSS('1');
      HTP.PRINT('</style>');
    ELSE
      HTP.PRINT('   
    <link rel="stylesheet" type="text/css" media="screen" href="main_css" />');
    END IF;
    -- jquery ui
    HTP.PRINT('
    <!--<link type="text/css" href="jquery_ui_1_8_18_custom" rel="stylesheet" />-->
    <!--<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all">-->
    <!--<script type="text/javascript" src="jquery_1_7_1_min.js"></script>-->
    <!--<script type="text/javascript" src="jquery_ui_1_8_18_custom_min.js"></script>-->

    <link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/ui-lightness/jquery-ui.css" type="text/css" media="all">
    <link rel="stylesheet" href="http://static.jquery.com/ui/css/demo-docs-theme/ui.theme.css" type="text/css" media="all">
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>    
    <script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js" type="text/javascript"></script>
       
    <script type="text/javascript" src="jquery_ui_datepicker_ru.js"></script>
    <script type="text/javascript">
      $(function(){
        // Datepicker
        $(''.datepicker'').datepicker({});
      });
    </script>
    
    <style type="text/css">
      #ui-datepicker-div  { font: 62.5% "Trebuchet MS", sans-serif;}
    </style>
    
    ');   
    
    
    IF G_STATE.USE_LANDSCAPE_ORIENTATION THEN
      -- Почему-то всё равно не работает альбомная ориентация, нужно уточнять
      HTP.PRINT('<style>
  <!--
  @page
    {margin:1.0in .75in 1.0in .75in;
    mso-header-margin:.5in;
    mso-footer-margin:.5in;
    mso-page-orientation:landscape;}
  --></style>');
    END IF;
    --striper .js
    HTP.PRINT('<script type="text/javascript" src="striper.js"></script>');
    HTP.PRINT('<script type="text/javascript" src="main_script.js"></script>');
    HTP.PRINT('   
    <title>' || HTF.ESCAPE_SC(gWindowCaption) || 'Приветствуем вас! - Кабинет дилера GSM-Corp</title>
    <!--[if IE 6]>
      <script language="JavaScript" type="text/javascript" src="js_DD_belatedPNG"></script>
      <script language="JavaScript" type="text/javascript">
        DD_belatedPNG.fix(''#active_tab'');
      </script>
      <link rel="stylesheet" type="text/css" media="screen" href="main_ie6_css" />
    <![endif]-->');
  -- счётчик Google Analitycs
/*  HTP.PRINT('<script type="text/javascript">
  var _gaq = _gaq || [];
  _gaq.push([''_setAccount'', ''UA-8699466-6'']);
  _gaq.push([''_trackPageview'']);
  (function() {
    var ga = document.createElement(''script''); ga.type = ''text/javascript''; ga.async = true;
    ga.src = (''https:'' == document.location.protocol ? ''https://ssl'' : ''http://www'') + ''.google-analytics.com/ga.js'';
    var s = document.getElementsByTagName(''script'')[0]; s.parentNode.insertBefore(ga, s);
  })();
</script>');*/
  HTP.PRINT('  
  </head>');
  --
  END IF;
END;
/
