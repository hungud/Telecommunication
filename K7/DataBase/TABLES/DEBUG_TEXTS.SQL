CREATE SEQUENCE S_DEBUG_TEXTS;

CREATE TABLE DEBUG_TEXTS
(
  ID        INTEGER,
  OUT_DATE  DATE,
  TEXT      VARCHAR2(4000 BYTE)
)
;

COMMENT ON TABLE DEBUG_TEXTS IS '������������ � �������� �������� ���������� � PL/SQL';

-- ��� ������������:
-- BEGIN 
--   DEBUG_OUT('����������=' || 0); -- ������� � �������
-- END;
--
-- �������� �������:
-- SELECT * FROM debug_texts  ORDER BY   id;
--
-- �������:
-- TRUNCATE TABLE debug_texts;
