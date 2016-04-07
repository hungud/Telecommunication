CREATE OR REPLACE TYPE K7_LK.T_PHONE_STATS                                          
AS OBJECT
(
  ROW_IDENT NUMBER(1, 0),
  NAME      VARCHAR2(100),
  VALUE     VARCHAR2(20)
)
/