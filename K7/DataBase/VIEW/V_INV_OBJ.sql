CREATE OR REPLACE VIEW V_INV_OBJ AS
  SELECT
  --#Version=2
  --
  --v.2 14.12.2015 Афросин - Добавил в проверку еще и схему K7_LK
  --
  *
  FROM
    dba_objects tab1
  WHERE
    tab1.STATUS <> 'VALID'
    AND tab1.OWNER IN ('CORP_MOBILE', 'CORP_MOBILE_LK', 'K7_LK')
    AND tab1.OBJECT_TYPE <> 'MATERIALIZED VIEW'
    AND tab1.OBJECT_NAME not in ( 'SAVE_CALL_TEST' )