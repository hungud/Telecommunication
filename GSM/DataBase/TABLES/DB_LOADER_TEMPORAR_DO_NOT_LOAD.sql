CREATE TABLE DB_LOADER_TEMPORAR_DO_NOT_LOAD (
  PHONE_NUMBER VARCHAR2(10 CHAR)
  );
  
COMMENT ON TABLE DB_LOADER_TEMPORAR_DO_NOT_LOAD IS 'Список телефонов, для которых нельзя загружать детализации (на очень больщих детализациях сайт виснет).';

COMMENT ON COLUMN DB_LOADER_TEMPORAR_DO_NOT_LOAD.PHONE_NUMBER IS 'Номер телефона.';