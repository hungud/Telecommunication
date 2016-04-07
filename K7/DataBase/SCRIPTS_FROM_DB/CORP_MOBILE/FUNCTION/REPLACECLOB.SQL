
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."REPLACECLOB" (p_clob clob, p_find varchar2, p_replace varchar2)
    return clob as
    language java name 'OUT_CSV_REESTR.replaceClob(oracle.sql.CLOB, java.lang.String,java.lang.String)   return clob';
