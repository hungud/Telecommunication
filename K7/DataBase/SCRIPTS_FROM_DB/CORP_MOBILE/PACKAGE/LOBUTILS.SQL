
  CREATE OR REPLACE PACKAGE "CORP_MOBILE"."LOBUTILS" as

function BLOB2File (
    p_BLOB BLOB
  , p_file_name varchar2
) return number as
    language java
    name 'LOBUtils.BLOB2File(oracle.sql.BLOB, java.lang.String) return long';

function CLOB2File (
    p_clob clob
  , p_file_name varchar2
) return number as
    language java
    name 'LOBUtils.CLOB2File(oracle.sql.CLOB, java.lang.String) return long';
end;

