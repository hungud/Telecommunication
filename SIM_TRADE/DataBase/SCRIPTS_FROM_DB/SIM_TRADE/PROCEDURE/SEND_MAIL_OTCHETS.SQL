
  CREATE OR REPLACE PROCEDURE "SIM_TRADE"."SEND_MAIL_OTCHETS" IS
--Version#1
NOW_MONTH VARCHAR2(300 CHAR);
NOW_MONTH_INT INTEGER;
BEGIN
  NOW_MONTH_INT:=TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMM'));
  SEND_MAIL('darkelf522@hotmail.ru',
      'Отчет по нарушениям в тарифах за ' || TO_CHAR(SYSDATE, 'Month YYYY') || ' на ' || TO_CHAR(SYSDATE, 'DD.MM.YYYY'), 
      GET_MAIL_TARIFF_VIOLATIONS(NOW_MONTH_INT));
END; 