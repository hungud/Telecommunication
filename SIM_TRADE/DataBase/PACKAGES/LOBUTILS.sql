CREATE OR REPLACE PACKAGE lobutils
AS
   FUNCTION BLOB2File (p_BLOB BLOB, p_file_name VARCHAR2)
      RETURN NUMBER
   AS
      LANGUAGE JAVA
      NAME 'LOBUtils.BLOB2File(oracle.sql.BLOB, java.lang.String) return long' ;

   PROCEDURE clob2file (p_clob            CLOB,
                        p_file_name       VARCHAR2,
                        p_characterset    VARCHAR2)
   AS
      LANGUAGE JAVA
      NAME 'LOBUtils.clob2file(oracle.sql.CLOB, java.lang.String, java.lang.String)' ;
END;
/