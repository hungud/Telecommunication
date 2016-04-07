CREATE OR REPLACE PROCEDURE WWW_DEALER.MAIN_CSS(
  pNO_SET_MIME_TYPE_FLAG IN VARCHAR2 DEFAULT NULL
  ) IS
--#Version=1
--
--  cVERSION CONSTANT VARCHAR2(5) := '2';
--  cEXPIRES_MINUTES CONSTANT BINARY_INTEGER := 5;
BEGIN
/*  IF OWA_CACHE.GET_ETAG = cVERSION THEN
    OWA_CACHE.SET_NOT_MODIFIED;
  ELSE
  OWA_CACHE.SET_CACHE(cVERSION, owa_cache.system_level);*/
  IF pNO_SET_MIME_TYPE_FLAG IS NULL THEN
    IF G_STATE.CAN_MODIFY_HTTP_HEADERS THEN
      OWA_UTIL.MIME_HEADER('text/css', FALSE);
      -- Устаревает через час
      HTP.P('Expires: ' || to_char(sysdate + 2/24, 'FXDy, DD Mon YYYY HH24:MI:SS', 'NLS_DATE_LANGUAGE = AMERICAN') || ' GMT+0300'); 
      OWA_UTIL.HTTP_HEADER_CLOSE;
    END IF;
  END IF;
  HTP.PRINT('
* {margin: 0px; padding: 0px;}
html, body {width: 100%; height: 100%; background-color: #e4e4e4; font-family: Arial; font-size: 10.5pt; line-height: 140%;}
a:link, a:visited {text-decoration: underline;}
a:active, a:hover {text-decoration: none;}
ul {list-style-type: none; list-style-position: outside; margin-bottom: 20px;}
/*a img, input {border: 0px;}*/
/*input {outline: none;}*/
/* ----------- FONT FACE ------------- */
@font-face {
  font-family: ''Euros'';
  src: url("MagistralC.otf");
 
}
/* END FONT FACE*/
a {outline: none;}
img {display: block;}
h1 {font-size: 24pt; font-weight: normal;}
h2 {font-size: 15pt; margin-bottom: 15px; font-family: ''Euros'';}
h3 {font-size: 11.25pt; margin-bottom: 10px; color: #009696;}
h4 {font-size: 9.75pt; margin-bottom: 7px; color: #0F0E0E;}
h5 {font:bold 12px Verdana; margin:0px; padding:0px;}
p {margin-bottom: 15px;}

.left {float: left;}
.right {float: right;}
.row {overflow: hidden; clear: both;}
.red {color: #cd0007;}
.col_130 {width: 130px;}
.col_190 {width: 190px;}
.align_right {text-align: right;}
.align_left {text-align: left;}
.align_center {text-align: center;}
.w49 {width: 49%;}
.w74 {width: 74%;}

/* кнопки */
button:hover, input[type=submit]:hover, input[type=reset]:hover {
    background: #DC971E;
    background: -moz-linear-gradient(top, #FFCF61 0%, #F1B441 36%, #DC971E 100%);/**/
    background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#FFCF61),
                color-stop(36%,#F1B441), color-stop(100%,#DC971E));                    /**/
    background: -webkit-linear-gradient(top, #71EAEA 0%, #69C2C2 50%, #48B5B1 100%);/* #FFCF61 0%, #F1B441 36%, #DC971E 100% */
    background: -o-linear-gradient(top, #FFCF61 0%, #F1B441 36%, #DC971E 100%);/**/
    background: -ms-linear-gradient(top, #FFCF61 0%, #F1B441 36%, #DC971E 100%);/**/
    background: linear-gradient(top, #FFCF61 0%, #F1B441 36%, #DC971E 100%);/**/
}

button, button:active, input[type=submit], input[type=submit]:active, input[type=reset], input[type=reset]:active {
    background: #C87D0A;
    background: -moz-linear-gradient(top, #FCC546 0%, #DD9F26 36%, #C87D0A 100%);/**/
    background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#FCC546),
                color-stop(36%,#DD9F26), color-stop(100%,#C87D0A));                    /**/
    background: -webkit-linear-gradient(top, #6CC8C8 0%, #12A6A6 50%, #029090 100%);/* #FCC546 0%, #DD9F26 36%, #C87D0A  */
    background: -o-linear-gradient(top, #FCC546 0%, #DD9F26 36%, #C87D0A 100%);/**/
    background: -ms-linear-gradient(top, #FCC546 0%, #DD9F26 36%, #C87D0A 100%);/**/
    background: linear-gradient(top, #FCC546 0%, #DD9F26 36%, #C87D0A 100%);/**/
    font-weight: bold; /* Шрифт жирный */
    padding: 2px 14px; /* Поля вокруг текста */
    color: white; /* Цвет текста */
    border: 1px solid; /* Параметры рамки */
    /*border-color: #FCC546;*/
    border : none;
    border-radius: 14px; /* Радиус скругления */
}

input[type=edit]:read-only {
    background-color: #F0F0F0;
    border : none;
}

#wrapper {width: 960px; margin: 0px auto;}
#header {width: 960px; height: 115px; margin-bottom: 0px; background: url("IMG_GSM_CORP_LABEL") center top no-repeat; position: relative;}
#header h1 {position: absolute; left: 306px; top: 33px;  line-height: 100%; font-family: ''Euros'';}
/* главное меню-закладки */
#tab_menu {width: 960px; height: 36px; background: #fff url("IMG_TAB_MENU_BG5") center top no-repeat; padding: 0px 0px 15px 0px; font-size: 9pt; font-weight: bold;}
#tab_menu2 {width: 960px; height: 24px; background: #fff url("IMG_TAB_MENU_BG4") center top no-repeat; padding: 0px 0px 15px 0px; font-size: 9pt; font-weight: bold;}
#tab_menu a {display: block; height: 36px; color: #fff; text-decoration: none; padding: 0px 13px; line-height: 36px;}
#tab_menu a:hover {text-decoration: underline;}
#tab_menu a#help_link, #tab_menu a#exit_link {color: #000;}
#tab_menu a#exit_link {background: url("img_exit_link_icon") left center no-repeat; margin-left: 8px; padding-right: 24px;}
#tab_menu span#exit_link {background: url("img_exit_link_active_icon") left center no-repeat; color: #9c6309; display: block; height: 36px; line-height: 36px; margin-left: 8px; padding:0px 24px 0px 20px;}
/* активная закладка */
#tab_menu #active_tab {display: block; height: 31px; margin-top: 5px; background: url("img_active_tab_left_2") left bottom no-repeat; white-space: nowrap;}
#tab_menu #active_tab span {display: block; color: #000; height: 27px; padding: 4px 17px 0px 0px; margin-left: 17px; background:  url("img_active_tab_right_2") right bottom no-repeat;}
/* /активная закладка */
/* /главное меню-закладки */
#main {background-color: #fff;}
#content_login {padding: 0px 17px 60px 40px; background: url("img_content_bottom") center bottom no-repeat; position: relative;}
#content {padding: 0px 20px 40px 20px; background: url("img_content_bottom") center bottom no-repeat; position: relative;}
#content a {color: #009696; font-family: ''Euros''; letter-spacing: 1px; text-decoration: none;}
/* таблица без серой шапки */
#content table.info_table {margin-bottom: 20px;}
#content table.info_table tbody tr td {padding: 0px 0px 20px 0px; border-bottom: none;}
#content table.info_table tbody tr td:first-child{text-align: right; width: 160px; padding-right: 25px;}
#content table.info_table h4{border-top: 1px solid #CCC;}
#content table.info_table p {margin-bottom: 5px;}

/* /таблица без серой шапки */
#content table {width: 100%; border-collapse: collapse;}
#content table thead {background: url("img_content_table_head_pattern") center top repeat-x; height: 35px;}
#content table thead td {height: 35px; line-height: 35px; padding: 0px 10px; font-size: 12pt;}
#content table thead td.first_cell {background:  url("img_content_table_header") left top no-repeat;}
#content table thead td.last_cell {background:  url("img_content_table_header") right top no-repeat;}
/*#content table td {padding: 10px; border-bottom: 1px solid #cccccc;}*/
#content table td.first_cell {padding-left: 20px; width: 60px;}
#content table td.first_cell_detail {padding-left: 20px; width: 120px;}
#content table td.first_cell_service {padding-left: 20px; width: 150px;}
#content table td.last_cell {padding-right: 20px;}
/* таблица с большим количеством столбцов */
#content table.small_table thead td {font-size: 10.5pt;}
#content table.small_table td.first_cell {width: auto;}
#content table.small_table td {font-size: 9pt;}
/* /таблица с большим количеством столбцов */
#content table tfoot td {border-bottom: none; font-size: 12pt; font-weight: bold;}
/* кнопка Расшифровка баланса */
#content a.balance_info {display: inline-block; width: 168px; height: 28px; background: url("img_balance_info_bg") left top no-repeat; font-size: 9pt; font-weight: bold; color: #fff; text-align: center; line-height: 28px; text-decoration: none; margin-left: 20px;}
#content a.balance_info:hover {background-position: 0px -28px;}
#content a.balance_info:active {background-position: 0px -56px;}

/* /кнопка Расшифровка баланса */
/* ссылка на скачивание */
.xls_download_link {position: absolute; right: 70px; margin-top: -40px;}
.xls_download_link_detail {position: relative; right: 370px; margin-top: 0px;}
/* /ссылка на скачивание */
/* номер телефона на странице детилизации */
.phone_number {padding-left: 40px; margin-bottom: 40px;}
/* /номер телефона на странице детилизации */
/* форма аторизации */
/*Правый инфо блок*/
#info_form_container {width: 150px; background: url("img_info_form_center") right top repeat-y; margin: 0px 0px 50px auto; position: relative;}
#info_form {height: 270px; width: 130px; padding: 0px 10px 0px 10px; overflow: hidden; display: block; }
#info_form #support_ul {margin:15px 0px 0px 0px; padding:0px 5px 0px 15px; list-style-type:disc;}
#info_form #support_li {padding:0px 0px 10px 0px; font:11px Verdana;}
#info_form #support_a{color:#2525FF; font:12px Verdana;}
/*Правый инфо блок*/
/*Левый блок авторизации*/
#auth_form_container {width: 490px; background: url("img_auth_form_center") center top repeat-y; margin: 30px 307px 50px auto; position: relative;}
#auth_form_container #auth_from_close_button {width: 16px; height: 16px; position: absolute; top: 10px; right: 20px; background-image: url("img_auth_form_close_button"); background-position: 0px 0px;}
#auth_form_container #auth_from_close_button:hover {cursor: pointer;}
#auth_form_container #auth_from_close_button:active {background-position: 0px -16px;}
#auth_form {height: 270px; width: 430px; padding: 0px 30px 0px 30px; overflow: hidden; display: block; }
#auth_form h2 {margin-bottom: 30px;}
#auth_form input {width: 170px; height: 29px; background: url("img_auth_form_input_bg") left top no-repeat; line-height: 29px; clear: right; margin: 0px 0px 15px 0px; padding: 0px 10px; font-size: 10.5pt; font-family: Arial;}
#auth_form input:focus {background: url("img_auth_form_input_error_bg_2") left top no-repeat;}
#auth_form input#error_captcha {background: url("img_auth_form_input_error_bg_2") left top no-repeat;}
#auth_form input {outline: none;}
/* общие для кнопок */
#auth_form input.button {height: 28px; font-size: 9pt; font-weight: bold; color: #fff; background-position: 0px 0px;}
#auth_form input.button:hover {background-position: 0px -28px;}
#auth_form input.button:active {background-position: 0px -56px;}
/* /общие для кнопок  */
#auth_form label {display: block; height: 29px; margin-bottom: 15px; line-height: 29px; width: 126px; text-align: right;}
#auth_form #forgot_password_link {display: block; margin: -10px 0px 20px 10px; font-size: 9pt;}
#auth_form #auth_captcha {height: 40px; margin-top: -7px; width: 130px;}
#auth_form #enter_captcha_text {clear: both; margin: -10px 0px 20px 10px; font-size: 9pt;}
/* кнопка Другая картинка */
#auth_form #reload_captcha {font-size: 9pt; float: left; background: url("img_reload_captcha_icon") left top no-repeat; padding-left: 20px; text-decoration: none;}
#auth_form #reload_captcha span {border-bottom: 1px dotted #f5b93f;}
#auth_form #reload_captcha span:hover {border-bottom: none;}
/* кнопка Другая картинка */
#auth_form .col_190 {margin-right: 100px;}
/* кнопки */
#auth_form #auth_form_enter_button {width: 77px; height: 28px; background-image: url("IMG_AUTH_FORM_ENTER_BUTTON_2"); background-position: 0px 0px; color: #fff; font-weight: bold;}
#auth_form #auth_form_enter_button:hover {background-position: 0px -28px;}
#auth_form #auth_form_enter_button:active {background-position: 0px -56px;}
#auth_form #auth_form_enter_button_small {width: 74px; background-image: url("img_auth_form_enter_button_small");}
#auth_form #auth_form_send_pass_button {width: 186px; background-image: url("img_auth_form_send_pass_button");}
/* /кнопки */
/* /форма аторизации */
/* Нижнее предупреждение */
div.footer {width: 960px; border:1px solid #CBCBCB; margin:9px auto 0px auto; padding:2px 5px; background:#F4F3EF;}
div.footer span {font:11px Verdana; color:#C7C7C5;}
/* Нижнее предупреждение */

/* форма редактирования FAQ */ 
#content #table_edit_faq {margin-bottom: 10px;}
#content #table_edit_faq td {padding: 10px; border-bottom: 1px solid #cccccc;}
/*#content td {padding: 10px 2px 10px 2px; border-bottom: 1px solid #cccccc;}*/
#content td {padding: 10px 2px 10px 2px; border-bottom: 1px solid #cccccc;}

/* форма поиска */
#search_form td {padding: 0px 5px 0px 5px; border-bottom: none;}
table.search_table {margin-bottom: 10px;}
#search_extended {background-color: lightgray;}

/* заголовки таблиц */
#content th:first-child {border-radius: 14px 0px 0px 0px; border:none;}
#content th:last-child {border-radius: 0px 14px 0px 0px; border: none;}
#content th { 
    background: -moz-linear-gradient(top, #FCC546 0%, #DD9F26 36%, #C87D0A 100%);/**/
    background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#FCC546),
                color-stop(36%,#DD9F26), color-stop(100%,#C87D0A));                    /**/
    background: -webkit-linear-gradient(top, #6CC8C8 0%, #12A6A6 50%, #029090 100%);
    background: -o-linear-gradient(top, #FCC546 0%, #DD9F26 36%, #C87D0A 100%);/**/
    background: -ms-linear-gradient(top, #FCC546 0%, #DD9F26 36%, #C87D0A 100%);/**/
    background: linear-gradient(top, #FCC546 0%, #DD9F26 36%, #C87D0A 100%);/**/
    border: 1px solid #cccccc; padding: 2px;
    background-color: #FCC546; color: #EFEFEF;}

/*таблица с данными*/
#content .table_data td {border: 1px solid #cccccc; padding-top: 0px; padding-bottom: 0px; padding-left: 3px; padding-right: 3px;}
#content .table_data tr.even{background: #e6eae6;}

/* выбор страницы */ 
/*
#content .page_select a, .page_select span{padding:0px 3px; display: block; min-width:20px; float:left; font-family: Verdana; text-align: center;}
#content .page_select a:link, .page_select a:visited, .page_select a:hover, .page_select a:active {text-decoration:none; background:#F9F9F9; border:1px dashed #E6E6E6; margin:2px 2px;}
#content .page_select a:hover {background:#009696; color:#FFFFFF;}
#content .page_select b {float:left; min-width:20px; text-align:center; padding:0px 0px; display: block; vertical-align: bottom; color: gray;}
#content .page_select span {text-decoration:none; background:#DD9F26; margin:2px 2px; border:1px dashed #E6E6E6; color: #efefef; float:left; font-weight: bold;}
#content .page_select td {padding: 0px; border-bottom: none;}
#content .page_select {font-size: 8.5pt;}
*/

.page_select a, .page_select span{padding:0px 3px; display: block; min-width:20px; float:left; font-family: Verdana; text-align: center;}
.page_select a:link, .page_select a:visited, .page_select a:hover, .page_select a:active {text-decoration:none; background:#F9F9F9; border:1px dashed #E6E6E6; margin:2px 2px;}
.page_select a:hover {background:#FFFFFF; color:#009696;}
.page_select b {float:left; min-width:20px; text-align:center; padding:0px 0px; display: block; vertical-align: bottom; color: gray;}
.page_select span {text-decoration:none; background:#009696; margin:2px 2px; border:1px dashed #E6E6E6; color: #efefef; float:left; font-weight: bold;}
.page_select td {padding: 0px; border-bottom: none;}
.page_select {font-size: 8.5pt;}

/*аккордион*/
.ui-state-default { color: #009696; text-decoration: none; }
.ui-state-hover { color: #009696; text-decoration: none; }
.ui-state-active, .ui-widget-content .ui-state-active, .ui-widget-header .ui-state-active { border: 1px solid #009696; background: #ffffff url(images/ui-bg_glass_65_ffffff_1x400.png) 50% 50% repeat-x; font-weight: bold; color: #009696; }
.ui-state-active { color: #009696; text-decoration: none; }
.ui-widget :active { outline: none; }

/* подменю на странице Мой склад */
/*
#my_store_menu {background: #000; padding: 5px 10px 10px 10px; font-weight: bold; float : left; border-radius: 14px 14px 0px 0px; border: none; font-size: 9pt;}
#my_store_menu a, #my_store_menu span {display: block; text-decoration: none; padding: 2px 10px 3px 10px; float : left;}
#my_store_menu .my_menu_active_tab {background-color: #fff; color: #000; border-radius: 14px 14px 0px 0px; border: none;}
#my_store_menu a {color : #efefef}
#my_store_menu a:hover {text-decoration: underline;}
*/

#my_store_menu {padding: 5px 0px 5px 0px; font-weight: bold;}
#my_store_menu a, #my_store_menu span {display: block; text-decoration: none; padding: 2px 10px 3px 10px; float : left;}
#my_store_menu a:hover {text-decoration: underline;}
#my_store_menu .my_menu_active_tab {
    background: -moz-linear-gradient(top, #DC971E 0%, #F1B441 50%, #DC971E 100%);/**/
    background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#DC971E),
                color-stop(50%,#F1B441), color-stop(100%,#DC971E));                    /**/
    background: -webkit-linear-gradient(top, #6CC8C8 0%, #12A6A6 50%, #029090 100%);/**/ 
    background: -o-linear-gradient(top, #DC971E 0%, #F1B441 50%, #DC971E 100%);/**/
    background: -ms-linear-gradient(top, #DC971E 0%, #F1B441 50%, #DC971E 100%);/**/
    background: linear-gradient(top, #DC971E 0%, #F1B441 50%, #DC971E 100%);/**/
    border-radius: 8px 8px 8px 8px; border: none; background-color: #EC8500; color: #fff;}
  
#content .my_store_tariff {font-size: 8.5pt; text-align: left;}

/* Чат для оператора ГСМ корп */
#operator_chat_contragents {padding : 0px 0px 5px 0px;}
#operator_chat_contragents table {background-color: #FCC546;}

#operator_chat_messages #operator_chat_messages_text {max-height: 100px; overflow-y: auto; border : 1px solid;}
#operator_chat_messages .operator_chat_messages_contragent {font-size: 8pt; color : #ff0000; font-weight: bold;}
#operator_chat_messages .operator_chat_messages_operator {font-size: 8.5pt; color : #0000ff; font-weight: bold;}
#operator_chat_messages {position: fixed; top:100px; left:25%; width:50%; height:300; background-color: #FCC546;
                         padding: 14px; border: none; border-radius: 14px;
                         background: -moz-linear-gradient(left, #FCD67E 0%, #FCE7B7 100%);/**/
                         background: -webkit-gradient(linear, left top, right top, color-stop(0%,#FCD67E), color-stop(100%,#FCE7B7));/**/
                         background: -webkit-linear-gradient(left, #FCD67E 0%, #FCE7B7 100%);
                         background: -o-linear-gradient(left, #FCD67E 0%, #FCE7B7 100%);/**/
                         background: -ms-linear-gradient(left, #FCD67E 0%, #FCE7B7 100%);/**/
                         background: linear-gradient(left, #FCD67E 0%, #FCE7B7 100%);/**/
                         }
#operator_chat_messages h3 {color : black;}

/* редактирование номера */
#phone_number .phone_edit td.td_caption{background: #e6eae6;}
#phone_number .phone_edit td{border-top: 1px solid #CCC;}

#support_info {float : right; padding : 0px 30px 10px 30px;}
#support_info img {display : inline;}

@-moz-document url-prefix() {#support_info { float: none; } }

/*td {border: 1px; border-style: solid; border-color: black;}*/

/*color: #009696;*/
.news_letter_div {margin: 5px 5px 5px 5px;}
.news_letter_date {text-align: left; color: #009696; margin: 5px 0px 5px 0px; font-weight: bold; }
.news_letter_annotation {cursor: pointer; text-decoration: underline; text-align: left; color: #009696; margin: 5px 0px 5px 0px; }
.news_letter_text {padding: 5px 5px 5px 5px; background-color: #F0F0F0; border-radius: 7px;  -khtml-border-radius:7px; -webkit-border-radius: 7px; -moz-border-radius:7px; border-radius: 7px; -khtml-border-radius:7px; -webkit-border-radius: 7px; -moz-border-radius:7px;}
.news_letter_text p {margin-bottom : 10px;}


');
IF G_STATE.PRINT_EXCEL_HEADERS THEN
  HTP.PRINT('html, body {background-color: #FFFFFF}');
END IF;
--  END IF;
/*  IF G_STATE.STATIC_CACHE_PERIOD > 0 THEN
    OWA_CACHE.SET_EXPIRES(10, owa_cache.system_level);
  END IF;*/
END;
/
