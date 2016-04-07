CREATE OR REPLACE VIEW V_INV_OBJ AS
SELECT
--#Version=1
--
--v.1 01.09.2015 Афросин создал вьюху отображаюущую инвалиндые объекты 
   *
FROM
  dba_objects tab1
WHERE
  tab1.STATUS <> 'VALID'
  AND tab1.OWNER IN ('BUSINESS_COMM')
  AND tab1.OBJECT_TYPE <> 'MATERIALIZED VIEW'
  