CREATE OR REPLACE PROCEDURE S_TOP IS
--#Version=1
BEGIN
  IF G_STATE.NEED_PRINT_HEADERS THEN
    IF NOT G_STATE.NO_DISPLAY_PANELS THEN
      HTP.PRINT('
<body>
  <div id="wrapper">
    <div id="header" class="row">
      <h1>Кабинет дилера GSM-Corp</h1>');
      IF G_STATE.PREV_ACCESS_DATE_TIME IS NOT NULL THEN
        NULL;
--        HTP.PRINT('
--        <p class="phone_number"><center><br><br>Последний раз вы посещали нас '||to_char(G_STATE.PREV_ACCESS_DATE_TIME, 'dd.mm.yyyy hh24:mi:ss')||'.</center></p>');
      END IF;
  HTP.PRINT('
  </div><!--header-->');
      S_PRINT_MENU;
    END IF;
  END IF;
END; 
/

