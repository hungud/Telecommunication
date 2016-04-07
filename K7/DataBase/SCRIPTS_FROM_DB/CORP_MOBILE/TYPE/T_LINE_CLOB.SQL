
  CREATE OR REPLACE TYPE "CORP_MOBILE"."T_LINE_CLOB" AS object (
    start_time date,
    call_type varchar2(1),
    dur number,
    costc number
)

