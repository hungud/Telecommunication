
  CREATE OR REPLACE TYPE "CORP_MOBILE"."T_DIRECTORY_ITEM" AS  OBJECT  (

    full_path  VARCHAR2(256),

    name  VARCHAR2(256),

    last_modified  DATE,

    is_directory  INTEGER

);
