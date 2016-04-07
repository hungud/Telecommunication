CREATE OR REPLACE
type TINFOREST as object
    (
      load_date timestamp
     ,phone varchar2(10 char)
     ,unitType varchar2(32 char)
     ,restType varchar2(16 char)
     ,initialSize number(18,2)
     ,currValue number(18,2)
     ,nextValue number(18,2)
     ,frequency varchar2(16 char)
     ,soc varchar2(16 char)
     ,socName varchar2(1024 char)
     ,restName varchar2(2048 char)
    );
/