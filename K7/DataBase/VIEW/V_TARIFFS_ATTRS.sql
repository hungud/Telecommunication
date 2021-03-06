DROP VIEW V_TARIFFS_ATTRS;

CREATE OR REPLACE VIEW V_TARIFFS_ATTRS AS
SELECT TARIFFS_ATTRIBUTES_ID,
          NOTE,
          (CASE USED_TYPE
              WHEN 1 THEN TO_CHAR (MONEY_TYPE)
              WHEN 2 THEN TO_CHAR (KOEF_TYPE)
              WHEN 3 THEN VARCHAR_TYPE_50
              WHEN 4 THEN TO_CHAR (INT_TYPE)
              WHEN 5 THEN TO_CHAR (DATE_TYPE, 'dd.mm.yyyy')
           END)
             AS ATTRIBUTES_VALUE,
          (CASE USED_TYPE
              WHEN 1 THEN 'NUMBER(15,2)'
              WHEN 2 THEN 'NUMBER(12,8)'
              WHEN 3 THEN 'VARCHAR2(50 CHAR)'
              WHEN 4 THEN 'INTEGER'
              WHEN 5 THEN 'DATE'
           END)
             AS ATTRIBUTES_TYPE
     FROM TARIFFS_ATTRS
    WHERE SYSDATE BETWEEN LIFETIME_FROM AND LIFETIME_TO;
