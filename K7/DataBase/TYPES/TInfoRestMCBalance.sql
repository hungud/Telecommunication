CREATE OR REPLACE type TInfoRestMCBalance as object
    (
      phone varchar2(10 char)
      ,bsasValue number(10, 2)
      ,bmkValue number(10, 2)
    );
/