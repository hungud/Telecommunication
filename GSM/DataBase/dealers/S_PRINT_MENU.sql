CREATE OR REPLACE PROCEDURE WWW_DEALER.S_PRINT_MENU IS
--#Version=2
-- v2. Матюнин И. 2015.06.17 - Добавлена новая вкладка в кабинете менеджера "%КТ" - проценты контрагентов по тарифам. 
  vPAGE_NAME VARCHAR2(40);
  vURL VARCHAR2(250 CHAR);
--
  PROCEDURE PRINT_MENU_ITEM(
    pURL IN VARCHAR2,
    pTEXT IN VARCHAR2,
    pPAGE_NAME IN VARCHAR2,
    pADD_TEXT IN VARCHAR2 DEFAULT NULL,
    pTITLE IN VARCHAR2 DEFAULT NULL
    ) IS
  BEGIN
    IF vPAGE_NAME = pURL OR '!'||vPAGE_NAME= pURL THEN
      HTP.PRINT('
        <span class="left" id="active_tab"><span>'||pTEXT||'</span></span>');
    ELSE
      HTP.PRINT('
        <a href="'||pURL||'?' ||G_STATE.SESSION_KEY_PARAM_1 || '" title="'||NVL(pTITLE, pTEXT)||'" class="left">'||pADD_TEXT||pTEXT||'</a>');
    END IF;
  END;
--
BEGIN
  HTP.PRINT('
    <div id="tab_menu2"></div>
      <div id="main">
        <div id="tab_menu">');      
  vPAGE_NAME := HTF.ESCAPE_URL(LOWER(SUBSTR(OWA_UTIL.GET_CGI_ENV('PATH_INFO'), 2)));
  IF SUBSTR(vPAGE_NAME, 1, 1) = '!' THEN
    vPAGE_NAME := SUBSTR(vPAGE_NAME, 2);
  END IF;              
  IF SUBSTR(vPAGE_NAME, LENGTH(vPAGE_NAME), 1) = '/' THEN
    vPAGE_NAME := SUBSTR(vPAGE_NAME, 1, LENGTH(vPAGE_NAME)-1);
  END IF;  
  --IF (vPAGE_NAME='main') AND (G_STATE.USER_ID IS NULL) THEN
  --  vPAGE_NAME:='';
  --END IF;
  --htp.print(G_STATE.IS_ADMIN);
  IF G_STATE.USER_ID IS NOT NULL THEN
    IF G_STATE.IS_ADMIN = 1 THEN 
      PRINT_MENU_ITEM('main', 'Новости', vPAGE_NAME);
      --PRINT_MENU_ITEM('admin_messages', 'Вопросы', vPAGE_NAME); -- вопросы задает контрагент, отвечает оператор, админу это не надо
      --PRINT_MENU_ITEM('admin_logs', 'Лог загрузок', vPAGE_NAME); -- вызывается из сводки загрузок
      PRINT_MENU_ITEM('admin_summary_logs', 'Сводка загрузок', vPAGE_NAME);
      PRINT_MENU_ITEM('admin_user_list', 'Пользователи', vPAGE_NAME);
      PRINT_MENU_ITEM('admin_news', 'Новости (админ)', vPAGE_NAME);
      PRINT_MENU_ITEM('admin_faq', 'ЧаВо', vPAGE_NAME);
      PRINT_MENU_ITEM('ADMIN_TARIFF_ORDER_LIST', 'Тарифы', vPAGE_NAME);
      PRINT_MENU_ITEM('ADMIN_DELIVERY_TYPE_LIST', 'Сп. доставки', vPAGE_NAME, null, 'Способы доставки');
      PRINT_MENU_ITEM('ADMIN_OPTIONS_SIM_CARD_ORDER', 'Заказ SIM', vPAGE_NAME, null, 'Заказ сим-карт');
    ELSIF G_STATE.IS_MANAGER = 1 THEN
      PRINT_MENU_ITEM('main', 'Новости', vPAGE_NAME);
      --PRINT_MENU_ITEM('store', 'Склад GSM', vPAGE_NAME);
      PRINT_MENU_ITEM('my_store2', 'Мой склад', vPAGE_NAME);
      PRINT_MENU_ITEM('my_bonuses', 'Вознагр', vPAGE_NAME, null, 'Список вознаграждений, которые начислены контрагентам которые закреплены за вами');
      PRINT_MENU_ITEM('my_pays', 'Выплаты', vPAGE_NAME, null, 'Список выплат, которые были произведены контрагентам которые закреплены за вами');
      PRINT_MENU_ITEM('my_balance_changes', 'Баланс', vPAGE_NAME);
      PRINT_MENU_ITEM('contragent_balances', 'Контр-ы', vPAGE_NAME, NULL, 'Список контрагентов, которые закреплены за вами с указанием баланса');      
      PRINT_MENU_ITEM('!contragent_percents', '%ОП', vPAGE_NAME, NULL, 'Проценты по операторам');
      PRINT_MENU_ITEM('!tariff_percents', '%ТР', vPAGE_NAME, NULL, 'Проценты по тарифам');
      PRINT_MENU_ITEM('!contragent_tatriff_percents', '%КТ', vPAGE_NAME, NULL, 'Проценты контрагентов по тарифам');
      --PRINT_MENU_ITEM('messages', 'Вопрос', vPAGE_NAME, 
          --'<span id="contragent_new_messages" style="display:none;" title="Есть непрочитанные сообщения">! </span>');
      PRINT_MENU_ITEM('!CONTRAGENT_NEW_SIM_CARD_ORD', 'Заказ SIM', vPAGE_NAME); --CONTRAGENT_NEW_SIM_CARD_ORD  CONTRAGENT_SIM_CARD_ORDERS
      
      PRINT_MENU_ITEM('contragent_edit_user', 'Пароль', vPAGE_NAME);
      
      --HTP.PRINT('
      --<script>
      --   IntervalIDCheckNewMessages = self.setInterval("ContragentCheckNewMessages('||G_STATE.USER_ID||');", 3000);
      --</script>');     
      
    ELSIF G_STATE.IS_CONTRAGENT = 1 THEN
      PRINT_MENU_ITEM('main', 'Новости', vPAGE_NAME);
      PRINT_MENU_ITEM('store', 'Склад GSM', vPAGE_NAME);
      PRINT_MENU_ITEM('my_store2', 'Мой склад', vPAGE_NAME);
      PRINT_MENU_ITEM('my_bonuses', 'Вознагр', vPAGE_NAME);
      PRINT_MENU_ITEM('my_pays', 'Выплаты', vPAGE_NAME);
      PRINT_MENU_ITEM('my_balance_changes', 'Баланс', vPAGE_NAME);
      PRINT_MENU_ITEM('messages', 'Вопрос', vPAGE_NAME 
        , /*'<img id="contragent_new_messages" style="display : none;" src="IMG_NEW_MESSAGE" title="Есть непрочитанные сообщения" alt="Есть непрочитанные сообщения">'*/
          '<span id="contragent_new_messages" style="display:none;" title="Есть непрочитанные сообщения">! </span>'
        );
      PRINT_MENU_ITEM('contragent_edit_user', 'Смена пароля', vPAGE_NAME);
      
      PRINT_MENU_ITEM('!CONTRAGENT_NEW_SIM_CARD_ORD', 'Заказ SIM', vPAGE_NAME);
      
      HTP.PRINT('        
      <script>
         IntervalIDCheckNewMessages = self.setInterval("ContragentCheckNewMessages('||G_STATE.USER_ID||');", 3000);
      </script>');     
      
    ELSE
      PRINT_MENU_ITEM('main', /*S_GET_USER_DESCRIPTION(G_STATE.USER_ID)*/ 'Список номеров', vPAGE_NAME);
      PRINT_MENU_ITEM('activations', 'Статистика активаций', vPAGE_NAME);
      PRINT_MENU_ITEM('status_changes', 'Статистика изменений статусов', vPAGE_NAME);
      PRINT_MENU_ITEM('OPERATOR_SIM_CARD_ORDERS', 'Заказанные тарифы', vPAGE_NAME);
      
    END IF; 
    
    vURL := 'h_' || vPAGE_NAME || CASE UPPER(vPAGE_NAME) WHEN 'MAIN' THEN '?SESSION_ID='||G_STATE.SESSION_ID||'' ELSE '' END ||'';
    HTP.PRINT('
        <a href="main?' ||G_STATE.SESSION_KEY_PARAM_1 || '&' || 'amp;close_session=1" title="Безопасное завершение работы" id="exit_link" class="right">Выход</a>
        <a href="'||vURL||'" onclick="var url='''||vURL||''';
          window.open(url, ''_blank'', ''toolbar=no,location=no,directories=no,menubar=no,scrollbars=yes,resizable=yes'');
          return false;" title="Справка" id="help_link" class="right">Помощь</a>
      </div>');
      
    IF G_STATE.IS_CONTRAGENT = 1 THEN
      HTP.PRINT('<div id="support_info">По вопросам дилерского обслуживания: <b>8-903-778-74-63</b> Александр <b>8-964-556-82-23</b>. 
                      <img src="http://wwp.icq.com/scripts/online.dll?icq=252072858&'||'img=5" border="0" /> ICQ: <b>607-290-902</b></div>');
    END IF;
  ELSE
    HTP.PRINT('
        <!--<a title="" class="left">Данные абонента</a>
        <a title="" class="left">Расшифровка баланса</a>
        <a title="" class="left">Детализация</a>
        <a title="" class="left">Управление услугами</a>-->
        <span title="Безопасное завершение работы" id="exit_link" class="right">Выход</span>
        <a href="h_main_nologin" onclick="var url=''h_main_nologin'';
          window.open(url, ''_blank'', ''toolbar=no,location=no,directories=no,menubar=no,scrollbars=yes,resizable=yes'');
          return false;" title="Справка" id="help_link" class="right">Помощь</a>
      </div>');
  END IF;
END;
/
