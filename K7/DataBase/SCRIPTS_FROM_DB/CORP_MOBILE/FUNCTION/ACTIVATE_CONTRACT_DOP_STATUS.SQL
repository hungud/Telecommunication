
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."ACTIVATE_CONTRACT_DOP_STATUS" (
    pPHONE_NUMBER IN VARCHAR2, 
    pCONTRACT_DATE IN DATE
--    ,
--    pDESCRIPTION IN VARCHAR2,
--    pSURNAME IN VARCHAR2,    
--    pPROMISED_SUM IN NUMBER,
--    pPAYMENT_DATE IN DATE,
--    pPROMISED_DATE IN DATE,
--    PROMISED_DATE_END IN DATE,
--    TEMP_PHONE_NUMBER IN VARCHAR2,
--    pDEALER_KOD in DEALERS.DEALER_KOD%TYPE          
  ) RETURN VARCHAR2 is
-- VERSION=2
-- 2. Матюнин И. Доработана "отвязка" корректировок,сделанных до даты активации (новой даты контракта) в рамках контракта.   
-- 1. Матюнин И. Функция предназначена для активации номеров переведенных в первоначальную блокировку (DOP_STATUS_ID = 222), либо предпродажную блокировку (DOP_STATUS_ID = 242)
--               При активации снимается доп.статус и обновляется дата договора на загружаемую. 
--               Активация проводится только для тех номеров, дата контрактов которых была раньше, чем дата указанная в загрузке.   
  vCONTRACT_ID INTEGER;
  vDOP_STATUS_ID INTEGER;
  vRESULT VARCHAR2(200 CHAR);
  vRes VARCHAR2(1000 CHAR);
  vTARIFF_ID TARIFFS.TARIFF_CODE_CRM%TYPE;
  vSTART_BALANCE NUMBER;
  vABONENT_ID INTEGER;
  CURSOR CUR IS    
    SELECT V.CONTRACT_ID
          ,V.DOP_STATUS  
          ,V.ABONENT_ID
      INTO vCONTRACT_ID
          ,vDOP_STATUS_ID 
          ,vABONENT_ID
    FROM V_CONTRACTS v
    WHERE  v.CONTRACT_CANCEL_DATE IS NULL
      and (v.PHONE_NUMBER_FEDERAL = pPHONE_NUMBER  or  v.PHONE_NUMBER_CITY = substr(pPHONE_NUMBER,-7))
      and V.DOP_STATUS in (222, 242)
      and V.CONTRACT_DATE <= pCONTRACT_DATE
  ;
  /* пока что эту логику опускаем
  CURSOR CUR_FIND_TARIFF(pTARIFF_CODE_CRM TYPE%TARIFFS.TARIFF_CODE_CRM) IS
    SELECT TF.TARIFF_ID
          ,TF.START_BALANCE 
      INTO vTARIFF_ID, vSTART_BALANCE
      FROM TARIFFS TF 
     WHERE TF.TARIFF_CODE_CRM = pTARIFF_CODE_CRM
  ;
  
  CURSOR CUR_MNP IS
    SELECT PHONE_NUMBER, TEMP_PHONE_NUMBER, DATE_ACTIVATE, USER_CREATED, DATE_CREATED, IS_ACTIVE 
    FROM MNP_REMOVE 
   WHERE PHONE_NUMBER = pPHONE_NUMBER
  ;
 */
  
BEGIN
  OPEN CUR;
  FETCH CUR INTO vCONTRACT_ID, vDOP_STATUS_ID, vABONENT_ID;
  IF CUR%NOTFOUND THEN
    -- ЕСЛИ НИЧЕГО НЕ НАШЛИ, ТО ЛОГИКА ТА ЖЕ, ЧТО И В DELPHI
    vRESULT := 'Ошибка, контракт с таким номером уже заведен ' || TO_CHAR(pCONTRACT_DATE, 'DD.MM.YYYY')||'!' || CHR(9);
  ELSE
    
    -- ЗДЕСЬ ПО ПОРЯДКУ ПРОВЕРЯЕМ ВСЕ ТО, ЧТО РЕАЛИЗОВАНО В DELPHI. ЕСЛИ ВОЗНИКАЕТ ОШИБКА, ТО ВОЗВРАЩАЕМ СООБЩЕНИЕ С ОШИБКОЙ 
    
    -- 1. ПРОВЕРЯЕМ НАЛИЧИЕ ТАРИФА В СПРАВОЧНИКЕ -- пока что эту логику опускаем 
    
    /* OPEN CUR_FIND_TARIFF(pTARIFF_CODE_CRM);
    FETCH CUR_FIND_TARIFF INTO vTARIFF_ID, vSTART_BALANCE;      
    IF CUR_FIND_TARIFF%NOTFOUND THEN -- ЕСЛИ НЕ НАШЛИ, ТОВЫДАЕМ ОШИБКУ
      vRESULT := 'Ошибка, тариф не найден!'
    ELSE
      
      -- ОБНОВЛЯЕМ ДАННЫЕ В ABONENTS 
      UPDATE ABONENTS AB
         SET AB.DESCRIPTION = pDESCRIPTION
            ,AB.SURNAME = pSURNAME
            ,AB.NAME = pNAME
            ,AB.PATRONYMIC = pPATRONYMIC
       WHERE AB.ABONENT_ID = vABONENT_ID
      ;
   */ 
      -- ЕСЛИ НАШЛИ ТАКОЙ ДОГОВОР, ТО ОБНОВЛЯЕМ ЕМУ ДАТУ ДОГОВОРА И СНИМАЕМ ДОПСТАТУС
      UPDATE CONTRACTS C
         SET C.CONTRACT_DATE = pCONTRACT_DATE
            ,C.DOP_STATUS = NULL
       WHERE C.CONTRACT_ID = vCONTRACT_ID
      ;      
    /*  пока что эту логику опускаем  
      -- Если передан обещанный платеж, то регистрирем его
      IF NVL(pPROMISED_SUM,0) <> 0 THEN        
        INSERT INTO PROMISED_PAYMENTS (PHONE_NUMBER, PAYMENT_DATE, PROMISED_DATE, PROMISED_SUM, PROMISED_DATE_END)
        VALUES (pPHONE_NUMBER, pPAYMENT_DATE, pPROMISED_DATE, pPROMISED_SUM, pPROMISED_DATE_END);                          
      END IF;
            
      -- Номер MNP ?
      -- проверяем есть ли данный номер в списке MNP номеров      
      OPEN CUR_MNP;
      FETCH INTO ;
      IF CUR_MNP%FOUND THEN
        -- если есть номер MNP, то переносим его в историю и удаляем запись
        -- номер может быть только один, так как поле PHONE_NUMBER уникально
        INSERT INTO MNP_REMOVE_HISTORY (PHONE_NUMBER, TEMP_PHONE_NUMBER, DATE_ACTIVATE, USER_CREATED, DATE_CREATED, DATE_INSERTED) 
               VALUES ( pPHONE_NUMBER, pTEMP_PHONE_NUMBER, pDATE_ACTIVATE, pUSER_CREATED, pDATE_CREATED, sysdate);
        
        -- удаляем запись
        DELETE FROM MNP_REMOVE WHERE PHONE_NUMBER = pPHONE_NUMBER;
        
        -- вставляем запись в таблицу MNP номеров
        INSERT INTO MNP_REMOVE (PHONE_NUMBER, TEMP_PHONE_NUMBER)
               VALUES (PHONE_NUMBER, TEMP_PHONE_NUMBER);       
      END IF;  
      CLOSE CUR_MNP;
      
      -- Заполнение справочника дилеров
      OPEN CUR_DEALERS;
      FETCH CUR_DEALERS INTO vCNT;
      CLOSE 
   */   
      -- ВСТАВЛЯЕМ ЗАПИСЬВ ЛОГ СМЕНЫ ДОПСТАТУСА, ДЛЯ ОТЧЕТА О АКТИВАЦИЯХ
      INSERT INTO LOG_CHANGE_CONTRACT_DOP_STATUS ( PHONE_NUMBER, DATE_CREATED, DOP_STATUS_ID)
                                            VALUES ( pPHONE_NUMBER, trunc(sysdate), vDOP_STATUS_ID) ;            
      
      -- Возвращаем сообщение об успешно выполненном действии         
      vRESULT := 'Ок! Дата контракта обновлена на '||TO_CHAR(pCONTRACT_DATE, 'DD.MM.YYYY')||', доп.статус снят!' || CHR(9);    
    -- END IF; пока что эту логику опускаем
      
      -- отвязываем корректировки от контракта сделанные до активации
      update RECEIVED_PAYMENTS rp
         set RP.CONTRACT_ID = 0
       where RP.CONTRACT_ID = vCONTRACT_ID
         and RP.PAYMENT_DATE_TIME < pCONTRACT_DATE
         and upper(RP.REMARK) like '%КОРРЕКТИРОВКА%'
      ;   
    
      COMMIT;
  END IF;     
  CLOSE CUR;  
  
  RETURN vRESULT;
END;