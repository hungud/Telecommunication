-- v1. 29.09.2014 Баукнов Константин - тип t_directory_item


CREATE OR REPLACE TYPE  t_directory_item  AS  OBJECT  (
    full_path  VARCHAR2(256),
    name  VARCHAR2(256),
    last_modified  DATE,
    is_directory  INTEGER
);
/
