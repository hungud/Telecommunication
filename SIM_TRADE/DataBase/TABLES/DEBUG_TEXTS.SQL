CREATE SEQUENCE S_DEBUG_TEXTS;

CREATE TABLE DEBUG_TEXTS
(
  ID        INTEGER,
  OUT_DATE  DATE,
  TEXT      VARCHAR2(4000 BYTE)
)
;

COMMENT ON TABLE DEBUG_TEXTS IS 'Формирование и просмотр значений переменных в PL/SQL';

-- как пользоваться:
-- BEGIN 
--   DEBUG_OUT('Переменная=' || 0); -- Запишем в отладку
-- END;
--
-- Просмотр отладки:
-- SELECT * FROM debug_texts  ORDER BY   id;
--
-- Очистка:
-- TRUNCATE TABLE debug_texts;
