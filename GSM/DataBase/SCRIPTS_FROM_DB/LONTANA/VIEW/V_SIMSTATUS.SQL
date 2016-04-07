
  CREATE OR REPLACE FORCE VIEW "LONTANA"."V_SIMSTATUS" ("ID", "NAME") AS 
  SELECT 1 ID, 'Новая' NAME
     FROM DUAL
   UNION ALL
   SELECT 2 ID, 'Блокирована' NAME
     FROM DUAL
   UNION ALL
   SELECT 3 ID, 'Активирована' NAME
     FROM DUAL
   UNION ALL
   SELECT 4 ID, 'Передана абоненту(активна)' NAME
     FROM DUAL
   UNION ALL
   SELECT 5 ID, 'Передана абоненту(блокирована)' NAME
     FROM DUAL
   UNION ALL
   SELECT 6 ID, 'Списана' NAME
     FROM DUAL
   UNION ALL
   SELECT 7 ID, 'Отгружена субагенту' NAME
     FROM DUAL
   UNION ALL
   SELECT 8 ID, 'Возвращена на склад' NAME
     FROM DUAL 