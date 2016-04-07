CREATE OR REPLACE VIEW V_IVIDEION_USERS
AS
  SELECT
  --
  --#V.1
  --
  --v.1 Афросин - 09.02.2016 - вьюха для отображения всех пользователей системы IVIDEON
  --
    IA.ABONENT_ID,
    IA.E_MAIL,
    IA.FIO,
    IA.IVIDEON_PASSWORD,
    IA.IVIDEON_USER_ID,
    IA.PASSWORD
  from IVIDEON_ABONENTS ia;
  
GRANT SELECT ON V_IVIDEION_USERS TO WWW_DEALER;   