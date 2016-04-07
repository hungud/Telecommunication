
  CREATE OR REPLACE FUNCTION "LONTANA"."CRM_ADD_REQUEST" 
(
  pPHONE_NUMBER IN VARCHAR2,
  pOPerator IN VARCHAR2,
  pTYPE_REQUEST_ID in integer
  )
 RETURN NUMBER IS
--#Version=1
  vRES NUMBER;
  SMS        VARCHAR2(2000);
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  insert into CRM_REQUESTS(PHONE_NUMBER, DATE_CREATED, USER_CREATED, USER_LAST_UPDATED, ID_STATUS_REQUEST, RESPONSIBLE_USER, TYPE_REQUEST_ID) 
                  values (pPHONE_NUMBER, sysdate,      pOPerator,    pOPerator,         1,                 pOPerator,        pTYPE_REQUEST_ID) 
    returning REQUEST_ID INTO vRES;
  commit;
  -- pTYPE_REQUEST_ID = 1   ЭТО АКТИВАЦИЯ НОМЕРА
  IF pTYPE_REQUEST_ID = 1 THEN
    INSERT INTO CRM_EVENTS (REQUEST_ID, EVENT_PATH, USER_CREATED, USER_LAST_UPDATED) VALUES (vRES, 'REQUESTS\CREATE', pOPerator, pOPerator);
    commit;
    IF MS_params.GET_PARAM_VALUE('SEND_SMS_CREATE_REQUEST')='1' THEN
      SMS := LOADER3_pckg.SEND_SMS('9276561268',
                                  'Заявка',
                                  'Номер вашей заявки: '|| to_char(vRES) ||' ,заявка принита в работу. ');
    END IF;
  END IF;
  RETURN vRES;
END;