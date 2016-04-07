CREATE OR REPLACE PROCEDURE CLOSE_ALIEN_OPTS_PREV_MONTH IS
  
  --Version 1
  --
  --v.1 Алексеев А.П. 20.01.2016 Процедара закрытия старых чужих подключений (подключений предыдущего месяца)
  
BEGIN
  --на номерах, которые были загружены в прошлом месяце, устанавливаем признак обработки записи
  update GPRS_ALIEN_OPTS gp 
     set gp.is_checked = 1
   where nvl(gp.is_checked,0) = 0
     and to_number(to_char(GP.LOAD_DATE, 'YYYYMM')) = to_number(TO_CHAR(ADD_MONTHS(sysdate, -1), 'YYYYMM'));
  commit;
END;