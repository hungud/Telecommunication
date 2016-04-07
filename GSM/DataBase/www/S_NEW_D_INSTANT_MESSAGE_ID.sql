CREATE SEQUENCE S_NEW_D_INSTANT_MESSAGE_ID
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;
  
CREATE SYNONYM CRM_USER.S_NEW_D_INSTANT_MESSAGE_ID FOR LONTANA_WWW.S_NEW_D_INSTANT_MESSAGE_ID;

GRANT SELECT ON S_NEW_D_INSTANT_MESSAGE_ID TO CRM_USER;