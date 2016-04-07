CREATE OR REPLACE PROCEDURE HELP_CSS(
  pNO_SET_MIME_TYPE_FLAG IN VARCHAR2 DEFAULT NULL
  ) IS
--#Version=1
--
--  cVERSION CONSTANT VARCHAR2(5) := '2';
--  cEXPIRES_MINUTES CONSTANT BINARY_INTEGER := 5;
BEGIN
--  OWA_CACHE.SET_EXPIRES(60, owa_cache.system_level);
  OWA_UTIL.MIME_HEADER('text/css', FALSE);
  -- Устаревает через час
  HTP.P('Expires: ' || to_char(sysdate + 1/24, 'FMDy, DD Month YYYY HH24:MI:SS') || ' GMT'); 
  OWA_UTIL.HTTP_HEADER_CLOSE;
  
  HTP.PRINT('/* CSS Document */
html, body, div, span, applet, object, iframe,
h1, h2, h3, h4, h5, h6, p, blockquote, pre,
a, abbr, acronym, address, big, cite, code,
del, dfn, em, font, img, ins, kbd, q, s, samp,
small, strike, strong, tt, var,
b, u, i, center,
dl, dt, dd, ol, ul, li,
fieldset, form, label, legend,
table, caption, tbody, tfoot, thead, tr, th, td {margin: 0; padding: 0; border: 0; outline: 0; font-size: 100%;
/*  vertical-align: baseline;*/ /*  background: transparent;*/}

body {line-height: 1.2em;}
ol, ul {list-style: none;}
blockquote, q {quotes: none;}
blockquote:before, blockquote:after, q:before, q:after {content: ''; content: none;}

/* remember to define focus styles! */
:focus {outline: 0;}

/* remember to highlight inserts somehow! */
ins {text-decoration: none;}
del {text-decoration: line-through;}

/* tables still need ''cellspacing="0"'' in the markup */
table {border-collapse: collapse;border-spacing: 0;}
/* ___________________________________________________________________________________________________ 01 */
a{color:#49479D; text-decoration:none;}
a:hover {color:#6966d4;text-decoration:underline;}
body,html {font-family:Tahoma,Verdana,Arial,Helvetica; font-size:8pt; color:#515161;}
table tr td{padding:2px 4px;}
#menuLine ul li{padding:5px 0; border-bottom:1px solid #e6eae6; font-weight:bold}
#lastMenuLine ul li{padding:5px 0; border-bottom:0px; font-weight:bold}
#head_title {FONT-WEIGHT: bold; FONT-SIZE: 14pt; COLOR: #008E0F; FONT-FAMILY: Tahoma,Arial,Verdana,Helvetica}
#small_caption {FONT-SIZE: 7.5pt; COLOR: #b2b2b2; FONT-FAMILY: Tahoma,Arial,Verdana,Helvetica}
#menuItem ul li{padding:2px 2px 5px; /*border-bottom:1px solid #e6eae6;*/}
#lastMenuItem ul li{padding:2px 2px 15px; /*border-bottom:0px;*/}
.content tr td{border-top:1px solid silver; vertical-align:middle; padding-left:6px; border-bottom:1px solid silver;}
.content tr th{border-top:1px solid silver; vertical-align:bottom; padding:4px 2px; background:#009900; color:#FFFFFF; border-right:1px solid #3cab3c;}
.content tr.even{background: #e6eae6;}
.report tr td{border-top:1px solid silver; vertical-align:middle; padding-left: 6px; border-bottom:1px solid silver;}
.report tr th{border-top:2px solid silver; vertical-align:middle; padding:4px 2px; background:#009900; color:#FFFFFF; font-weight:normal; border-right:1px solid #3cab3c;}
.report tr.even{background: #f9fcf9;}
.report tr.summary{background: #d4ffd4; font-weight:bold}
hr{height:2px; color:#009900; background:#009900}
h3.h3{padding:4px 2px; background:#009900; color:#FFFFFF; display:inline;}
.th{border-top:1px dashed silver; border-bottom:1px dashed silver; vertical-align:bottom; padding:2px 2px; background:#e6eae6;}
input.text {font-family:Tahoma,Verdana,Arial,Helvetica; font-size:8pt; color:#515161; border:1px solid silver;}  
select.text {font-family:Tahoma,Verdana,Arial,Helvetica; font-size:8pt; color:#515161; border:1px solid silver;}  
.warning {color:red; font-weight:bold;}
.message {background: #009900; color:#FFFFFF;/*  border-bottom:1px dashed silver;*/ padding:8px 8px; width:100%; text-align:center}
.copyright {text-align:right; font-size:6pt; font-weight:bold;}
.vtablesum {text-align:right;}
.vtablesumbold {text-align:right; font-weight:bold;}
.error {color:red; font-weight:bold;}
');
--
  HTP.PRINT('/* Help CSS Document */
ol, ul {
  list-style: disc;
}
');
END HELP_CSS;
/