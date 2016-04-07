CREATE OR REPLACE PROCEDURE S_TOP(
  STRANICA IN INTEGER DEFAULT 0
  ) IS
--#Version=1
  vPAGE_NAME VARCHAR2(40);
BEGIN
  IF G_STATE.NEED_PRINT_HEADERS THEN
    IF NOT G_STATE.NO_DISPLAY_PANELS THEN
      HTP.PRINT('
  <body>
    <div id="wrapper">
      <div id="header" class="row" onclick="window.location.assign(''http://www.gsmcorporacia.ru'');" style="cursor: pointer;">
        <h1>Личный кабинет</h1>');
      IF G_STATE.PREV_ACCESS_DATE_TIME IS NOT NULL THEN
        NULL;
--        HTP.PRINT('
--        <p class="phone_number"><center><br><br>Последний раз вы посещали нас '||to_char(G_STATE.PREV_ACCESS_DATE_TIME, 'dd.mm.yyyy hh24:mi:ss')||'.</center></p>');
      END IF;
      HTP.PRINT('
      </div>
      <div id="main">
        <div id="tab_menu">');      
      vPAGE_NAME := HTF.ESCAPE_URL(LOWER(SUBSTR(OWA_UTIL.GET_CGI_ENV('PATH_INFO'), 2)));
      IF SUBSTR(vPAGE_NAME, 1, 1) = '!' THEN
        vPAGE_NAME := SUBSTR(vPAGE_NAME, 2);
      END IF;              
      IF SUBSTR(vPAGE_NAME, LENGTH(vPAGE_NAME), 1) = '/' THEN
        vPAGE_NAME := SUBSTR(vPAGE_NAME, 1, LENGTH(vPAGE_NAME)-1);
      END IF;  
      IF (vPAGE_NAME='main') AND (G_STATE.USER_ID IS NULL) THEN
        vPAGE_NAME:='';
      END IF;
      IF G_STATE.USER_ID IS NOT NULL THEN
        IF STRANICA=1 THEN
          HTP.PRINT('
          <span class="left" id="active_tab"><span>Данные абонента</span></span>');
        ELSE
          HTP.PRINT('
          <a href="main?' ||G_STATE.SESSION_KEY_PARAM_1 || '" title="Главная страница" class="left">Данные абонента</a>');
        END IF; 
        IF STRANICA=2 THEN
          HTP.PRINT('
          <span class="left" id="active_tab"><span>Расшифровка баланса</span></span>');
        ELSE
          HTP.PRINT('
          <a href="balance?' ||G_STATE.SESSION_KEY_PARAM_1 || '" title="" class="left">Расшифровка баланса</a>');
        END IF;  
        IF STRANICA=3 THEN
          HTP.PRINT('
          <span class="left" id="active_tab"><span>Детализация</span></span>');
        ELSE
          HTP.PRINT('
          <a href="detail?' ||G_STATE.SESSION_KEY_PARAM_1 || '" title="" class="left">Детализация</a>');
        END IF;  
        IF STRANICA=4 THEN
          HTP.PRINT('
          <span class="left" id="active_tab"><span>Управление услугами</span></span>');
        ELSE
          HTP.PRINT('
          <a href="services?' ||G_STATE.SESSION_KEY_PARAM_1 || '" title="" class="left">Управление услугами</a>');
        END IF; 
        HTP.PRINT('
          <a href="main?' ||G_STATE.SESSION_KEY_PARAM_1 || '&' || 'close_session=1" title="Безопасное завершение работы" id="exit_link" class="right">Выход</a>
          <a href="h_' || vPAGE_NAME || '" onclick="var url=''h_' || vPAGE_NAME || ''';
            window.open(url, ''_blank'', ''toolbar=no,location=no,directories=no,menubar=no,scrollbars=yes,resizable=yes'');
            return false;" title="Справка" id="help_link" class="right">Помощь</a>
        </div>');
      ELSE
        HTP.PRINT('
          <a title="" class="left">Данные абонента</a>
          <a title="" class="left">Расшифровка баланса</a>
          <a title="" class="left">Детализация</a>
          <a title="" class="left">Управление услугами</a>
          <span title="Безопасное завершение работы" id="exit_link" class="right">Выход</span>
          <a href="h_' || vPAGE_NAME || '" onclick="var url=''h_' || vPAGE_NAME || ''';
            window.open(url, ''_blank'', ''toolbar=no,location=no,directories=no,menubar=no,scrollbars=yes,resizable=yes'');
            return false;" title="Справка" id="help_link" class="right">Помощь</a>
        </div>');
      END IF;
    END IF;
  END IF;
END; 
/

