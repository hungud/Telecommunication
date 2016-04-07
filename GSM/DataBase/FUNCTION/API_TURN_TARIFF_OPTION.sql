CREATE OR REPLACE FUNCTION API_TURN_TARIFF_OPTION(
  pPHONE_NUMBER IN VARCHAR2,   -- Номер
  pOPTION_CODE IN VARCHAR2,   -- Код услуги
  pTURN_ON IN INTEGER,   -- Тип операции ( 0 - откл. / 1 - подкл.)
  pEFF_DATE IN DATE DEFAULT NULL,   -- Дата операции подкл./откл. услуги
  pEXP_DATE IN DATE DEFAULT NULL   -- Дата будущего откл. (только для подкл. услуг)
  ) RETURN VARCHAR2 IS
  ITOG VARCHAR2(2000 CHAR);
  cursor c is
    select o.*, rowid 
      from DB_LOADER_ACCOUNT_PHONE_OPTS O
      WHERE O.YEAR_MONTH = TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMM'))
        AND O.PHONE_NUMBER = pPHONE_NUMBER
        and pTURN_ON = 1
        AND NVL(O.ADDED_FOR_RETARIF, 0) = 1
        and o.TURN_ON_DATE <= sysdate
        and nvl(o.TURN_OFF_DATE, trunc(sysdate + 1)) > sysdate
        AND EXISTS (SELECT 1 
                      FROM TARIFF_OPTIONS TAR
                      WHERE TAR.OPTION_CODE = pOPTION_CODE
                        AND NVL(TAR.IS_ROAMING_DISCOUNT, 0) = 1); 
  dummy c%rowtype;     
  zapros_id varchar2(30 char);                                             
BEGIN
  OPEN C;
  FETCH C INTO DUMMY;
  IF C%FOUND THEN
    itog:=BEELINE_API_PCKG.TURN_TARIFF_OPTION(pPHONE_NUMBER, dummy.OPTION_CODE, 0, null, null, 'USER');
    dbms_lock.sleep(5);
    if instr(itog, 'Заявка') = 0 then
      return 'Error autooption';
    else 
      zapros_id:=replace(itog, 'Заявка № ');
      update DB_LOADER_ACCOUNT_PHONE_OPTS o
        set o.TURN_ON_DATE = o.TURN_ON_DATE + 1/24/60/60,
            o.TURN_OFF_DATE = sysdate
        where o.rowid = DUMMY.rowid;
      UPDATE ROAMING_RETARIF_PHONES RRP
        SET RRP.END_DATE_TIME = SYSDATE,
            RRP.SERVICE_OFF_TICKET_ID = zapros_id
        WHERE RRP.PHONE_NUMBER = pPHONE_NUMBER
          AND RRP.OPTION_CODE = pOPTION_CODE
          AND RRP.END_DATE_TIME IS NULL;
      commit;
    end if;  
  END IF;
  CLOSE C;
  ITOG:=BEELINE_API_PCKG.TURN_TARIFF_OPTION(pPHONE_NUMBER, pOPTION_CODE, pTURN_ON, pEFF_DATE, pEXP_DATE, 'USER');
  RETURN ITOG;
END;

--GRANT EXECUTE ON API_TURN_TARIFF_OPTION TO CORP_MOBILE_ROLE;

--GRANT EXECUTE ON API_TURN_TARIFF_OPTION TO CORP_MOBILE_ROLE_RO;