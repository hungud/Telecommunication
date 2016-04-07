
  CREATE OR REPLACE TYPE "LONTANA"."T_LINE_CLOB" AS object (
    start_time date,
    call_type varchar2(1),
    dur number,
    costc number
)
