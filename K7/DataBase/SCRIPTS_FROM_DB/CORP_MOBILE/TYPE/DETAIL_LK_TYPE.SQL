
  CREATE OR REPLACE TYPE "CORP_MOBILE"."DETAIL_LK_TYPE" AS OBJECT
(SUBSCR_NO varchar2(11),
CALL_DATE varchar2(10),
CALL_TIME varchar2(8),
SERVICE_NAME  VARCHAR2(20),
ServiceDirection number(1),
CALLING_NO varchar2(21),
DURATION varchar2(8),
call_cost number,
IsRoaming        varchar2(1),
RoamingZone      varchar2(6),
AT_FT_DE varchar2(240)
);
