
  CREATE OR REPLACE PACKAGE "CORP_MOBILE"."LOBUTILS2" as

procedure BLOB2File (
    p_BLOB BLOB
  , p_file_name varchar2
) as
    language java
    name 'LOBUtils2.blob2file(oracle.sql.BLOB, java.lang.String)';
end;

