CREATE OR REPLACE PROCEDURE send_sys_mail (MESSAGE_TITLE   IN VARCHAR2,
                                           MAIL_TEXT       IN CLOB,
                                           PARAM_NAME      IN VARCHAR2)
IS
--
--Version=1
--
--v1. 21.04.2015 Афросин Добавил процедуру
--
   CURSOR curp
   IS
          SELECT REGEXP_SUBSTR (str,
                                '[^,]+',
                                1,
                                LEVEL)
                    str
            FROM (SELECT MS_params.GET_PARAM_VALUE (PARAM_NAME) str FROM DUAL) t
      CONNECT BY INSTR (str,
                        ',',
                        1,
                        LEVEL - 1) > 0;

   mail_ad   VARCHAR2 (100);
BEGIN
   OPEN curp;

   LOOP
      FETCH curp INTO mail_ad;

      EXIT WHEN curp%NOTFOUND;
      send_mail1 (mail_ad, MESSAGE_TITLE, MAIL_TEXT);
      DBMS_LOCK.SLEEP (5);
   END LOOP;

   CLOSE curp;
END;
/