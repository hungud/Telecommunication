CREATE OR REPLACE PROCEDURE MAIN_IE6_CSS IS
--#Version=1
--
BEGIN
  IF G_STATE.STATIC_CACHE_PERIOD > 0 THEN
    OWA_CACHE.SET_EXPIRES(10, owa_cache.system_level);
  END IF;
  HTP.PRINT('
#auth_form .col_190 {margin-right: 50px;}
#tab_menu #active_tab {width: 0px;}
');
END; 
/

