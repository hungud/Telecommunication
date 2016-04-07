
  CREATE OR REPLACE TYPE "SIM_TRADE"."T_DIRECTORY_ITEM" AS  OBJECT  (

    full_path  VARCHAR2(256),

    name  VARCHAR2(256),

    last_modified  DATE,

    is_directory  INTEGER

);
