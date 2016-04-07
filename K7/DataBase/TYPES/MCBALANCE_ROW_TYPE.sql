CREATE TYPE MCBALANCE_ROW_TYPE AS OBJECT
(
    phone varchar2(10 char)
    ,bsasValue number(10, 2)
    ,bmkValue number(10, 2)
);
/

CREATE OR REPLACE TYPE MCBALANCE_ROW_TYPE_TAB AS TABLE OF MCBALANCE_ROW_TYPE;
/