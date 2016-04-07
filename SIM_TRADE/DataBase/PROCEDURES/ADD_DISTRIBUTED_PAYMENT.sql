CREATE OR REPLACE PROCEDURE ADD_DISTRIBUTED_PAYMENT
        (PHONE_NUMBER VARCHAR2, -- мнлеп рекетнмю 
         PAYMEN_SUM NUMBER,   -- нокювеммюъ ясллю
         PAYMENT_DATE_TIME DATE,  -- дюрю х бпелъ окюрефю
         pREMARK VARCHAR2,  -- опхлевюмхъ й окюрефс 
         RECEIVED_PAYMENT_TYPE_ID INTEGER,  -- рхо окюрефю (яяшкйю мю RECEIVED_PAYMENT_TYPES)
         YEAR_MONTH  NUMBER, -- оепхнд пюяопедекемхъ гюрпюр
         RUN_MODE VARCHAR2,
         pRECEIVED_PAYMENT_ID INTEGER default null
        ) IS  
-- #Version 5
-- 5. - лЮРЧМХМ. хЯОПЮБКЕМ ЙНЯЪЙ: б ЯКСВЮЕ ЙНЦДЮ НЯМНБМНИ ОКЮРЕФ АШК МЮ МНЛЕП, ЙНРНПШИ ХЛЕК МСКЕБШЕ ГЮРПЮРШ ГЮ ОЕПХНД - ДКЪ МЕЦН МЕ ПЕЦЯХРПХПНБЮКНЯЭ СДЕПФЮМХЕ! 
-- 4. - лЮРЧМХМ. рЕОЕПЭ ЯВХРЮЕЛ ГЮРПЮРШ Х ОН РЕЛ ВРН МЕР Б АЮКЮМЯЕ
-- 3. - лЮРЧМХМ. хЯОПЮБКЕМ ЕЫЕ НДХМ ЙНЯЪЙ Б ПЮЯВЕРЕ ГЮРПЮР ОН РЕЙСЫХЛ ГЮРПЮРЮЛ + ОН ГЮРПЮРЮЛ Б ГЮЙПШРШЕ ОЕПХНДШ.
-- 2. - лЮРЧМХМ. хЯОПЮБКЕМ ЙНЯЪЙ Б ПЮЯВЕРЕ ГЮРПЮР ОН РЕЙСЫХЛ ГЮРПЮРЮЛ.  
-- 1. - лЮРЧМХМ. оПНЖЕДСПЮ ДКЪ ЯНГДЮМХЪ ОКЮРЕФЕИ ПЮЯОПЕДЕКЕММШУ ОН ЦПСООЕ МНЛЕПНБ.   
  vCONTR INTEGER;
  vCOUNT_IN_GROUP INTEGER;
  vGROUP_ID INTEGER;
  vALL_SUM_CALLS NUMBER(12,2);
  vALL_SUM_ABONENT NUMBER(12,2);
  vDISTRIBUTE_SUM NUMBER(12,2);
  vCUR_PAY NUMBER(12,2);
  vCUR_SUM_PAY NUMBER(12,2);
  vMSG VARCHAR2(200);
  vRECEIVED_PAYMENT_ID INTEGER;
  vCORRECT_RECEIVED_PAYMENT_ID INTEGER;  -- id йнппейрхпсчыецн окюрефю дкъ PHONE_NUMBER 
    -- нопедекъел яохянй деиярбсчыху йнмрпюйрнб он цпсоое йнмрпюйрнб
    CURSOR CONTRACT_LIST (pGROUP_ID CONTRACT_GROUPS.GROUP_ID%TYPE, pYEAR_MONTH NUMBER) IS            
      SELECT CON.CONTRACT_ID,
             CON.PHONE_NUMBER_FEDERAL  
        FROM CONTRACTS CON
            ,V_CONTRACTS VC
            ,CONTRACT_GROUPS CG          
       WHERE CON.GROUP_ID = CG.GROUP_ID
         AND VC.CONTRACT_ID = CON.CONTRACT_ID
         and to_number(to_char(CON.CONTRACT_DATE, 'YYYYMM')) <= pYEAR_MONTH
         AND 
             (
              VC.CONTRACT_CANCEL_DATE IS NULL 
             or 
              to_number(to_char(VC.CONTRACT_CANCEL_DATE, 'YYYYMM')) >= pYEAR_MONTH
             ) 
         AND CG.GROUP_ID = pGROUP_ID
    ;
    
    CURSOR PAYMENT_LIST (pPARENT_PAYMENT_ID INTEGER) IS            
      SELECT RP.RECEIVED_PAYMENT_ID, RP.CONTRACT_ID, RP.PHONE_NUMBER
        FROM RECEIVED_PAYMENTS RP
       WHERE RP.PARENT_PAYMENT_ID = pPARENT_PAYMENT_ID
    ; 
    
  FUNCTION GET_SUMM_ALL_CALLS(pGROUP_ID CONTRACT_GROUPS.GROUP_ID%TYPE, pYEAR_MONTH INTEGER, pCONTRACT_ID INTEGER) RETURN NUMBER IS
    vSUM_ALL_CALS_ACCOUNT NUMBER(12, 2);
    vSUM_ALL_CALS_REPORT NUMBER(12, 2);
       
    -- нопедекъел наысч ясллс гюрпюр, опедярюбкеммше б яверюу, он бяел юанмемрюл гю оепхнд
    CURSOR CUR_ALL_ACCOUNT_CALLS(pGROUP_ID CONTRACT_GROUPS.GROUP_ID%TYPE, pYEAR_MONTH INTEGER, pCONTRACT_ID INTEGER) IS            
      SELECT SUM(FFB.BILL_SUM_NEW)
        INTO vALL_SUM_CALLS
        FROM CONTRACTS CON
            ,V_CONTRACTS VC
            ,CONTRACT_GROUPS CG
            ,V_BILL_FINANCE_FOR_CLIENTS FFB
            --,DB_LOADER_FULL_FINANCE_BILL FFB
            ,ACCOUNT_LOADED_BILLS ALB
      WHERE CON.GROUP_ID = CG.GROUP_ID
        AND VC.CONTRACT_ID = CON.CONTRACT_ID
        AND VC.CONTRACT_CANCEL_DATE IS NULL
        AND CG.GROUP_ID = pGROUP_ID
        AND FFB.PHONE_NUMBER = CON.PHONE_NUMBER_FEDERAL
        AND FFB.ACCOUNT_ID = ALB.ACCOUNT_ID
        AND FFB.YEAR_MONTH = ALB.YEAR_MONTH
--        AND ALB.LOAD_BILL_IN_BALANCE = 1
        AND ALB.YEAR_MONTH = pYEAR_MONTH
        AND 
             (
              ( pCONTRACT_ID IS NOT NULL AND CON.CONTRACT_ID = pCONTRACT_ID)
              OR
              ( pCONTRACT_ID IS NULL)
             )                    
    ;
    
    -- рейсыхе гюрпюрш юанмемрю ме опедярюбкеммше б явере    
    CURSOR CUR_ALL_REPORT_CALLS (pGROUP_ID CONTRACT_GROUPS.GROUP_ID%TYPE, pYEAR_MONTH INTEGER, pCONTRACT_ID INTEGER) IS      
      SELECT SUM(
                 GREATEST(
                          NVL(LRD.DETAIL_SUM,0), 
                          NVL(LPS.ESTIMATE_SUM,0)
                         )
                )
        INTO vALL_SUM_ABONENT  
        FROM CONTRACTS CON    
            ,DB_LOADER_REPORT_DATA LRD
            ,DB_LOADER_PHONE_STAT LPS
       WHERE CON.GROUP_ID = pGROUP_ID
         AND CON.PHONE_NUMBER_FEDERAL = LRD.PHONE_NUMBER
         AND 
             (
              ( pCONTRACT_ID IS NOT NULL AND CON.CONTRACT_ID = pCONTRACT_ID)
              OR
              ( pCONTRACT_ID IS NULL)
             )
         AND LRD.PHONE_NUMBER = CON.PHONE_NUMBER_FEDERAL
         AND LRD.YEAR_MONTH = pYEAR_MONTH
         and LRD.YEAR_MONTH = LPS.YEAR_MONTH (+)
         AND LRD.PHONE_NUMBER = LPS.PHONE_NUMBER (+)
         AND NOT EXISTS
                ( -- бяе врн ме оноюкн б яверю
                  SELECT *
                    FROM CONTRACTS CON
                        ,V_CONTRACTS VC
                        ,CONTRACT_GROUPS CG
                        ,DB_LOADER_FULL_FINANCE_BILL FFB
                        ,ACCOUNT_LOADED_BILLS ALB
                  WHERE CON.GROUP_ID = CG.GROUP_ID
                    AND VC.CONTRACT_ID = CON.CONTRACT_ID
                    AND VC.CONTRACT_CANCEL_DATE IS NULL
                    AND CG.GROUP_ID = pGROUP_ID
                    AND FFB.PHONE_NUMBER = CON.PHONE_NUMBER_FEDERAL
                    AND FFB.ACCOUNT_ID = ALB.ACCOUNT_ID
--                    AND ALB.LOAD_BILL_IN_BALANCE = 1
                    AND ALB.YEAR_MONTH = pYEAR_MONTH                  
                )
    ;     
    
  BEGIN
      --наыюъ ясллю рнкэйн он гбнмйюл дкъ бяеу юанмемрнб
      OPEN CUR_ALL_ACCOUNT_CALLS(vGROUP_ID, YEAR_MONTH, pCONTRACT_ID);
      FETCH CUR_ALL_ACCOUNT_CALLS INTO vSUM_ALL_CALS_ACCOUNT;
      CLOSE CUR_ALL_ACCOUNT_CALLS; 
      
      OPEN CUR_ALL_REPORT_CALLS(vGROUP_ID, YEAR_MONTH, pCONTRACT_ID);
      FETCH CUR_ALL_REPORT_CALLS INTO vSUM_ALL_CALS_REPORT;
      CLOSE CUR_ALL_REPORT_CALLS;
        
      RETURN (nvl(vSUM_ALL_CALS_ACCOUNT,0) + nvl(vSUM_ALL_CALS_REPORT,0));
  END;
  
  PROCEDURE GET_CONTRACT(pPHONE_NUM VARCHAR2, 
                         vCONTR IN OUT INTEGER, 
                         vGROUP_ID IN OUT INTEGER
                        ) IS  
    -- нопедекъел деиярбсчыхи йнмрпюйр х цпсоос йнмрпюйрнб он мнлепс рекетнмю         
    CURSOR CUR_CONTRACT(pPHONE_NUM VARCHAR2) IS 
      SELECT VC.CONTRACT_ID, CN.GROUP_ID
        INTO vCONTR, vGROUP_ID 
        FROM CONTRACTS CN
            ,V_CONTRACTS VC
       WHERE CN.CONTRACT_ID = VC.CONTRACT_ID
         AND VC.CONTRACT_CANCEL_DATE IS NULL -- онйю рюй, онгфе ядекюрэ врнаш нопедекъкяъ деиярбсчыхи йнмрпюйр мю сйюгюммсч дюрс
         AND VC.PHONE_NUMBER_FEDERAL = pHONE_NUMBER
    ;          
  BEGIN
    OPEN CUR_CONTRACT(PHONE_NUMBER);
    FETCH CUR_CONTRACT INTO vCONTR, vGROUP_ID;
    CLOSE CUR_CONTRACT;
  END;    
    
  
BEGIN
  
  -- 1. нопедекъел деиярбсчыхи йнмрпюйр дкъ мнлепю рекетнмю
  GET_CONTRACT(PHONE_NUMBER, vCONTR, vGROUP_ID);
  
  -- НАЫЮЪ ЯСЛЛЮ ГЮРПЮР 
  vALL_SUM_CALLS := GET_SUMM_ALL_CALLS(vGROUP_ID, YEAR_MONTH, NULL);  
  IF NVL(vALL_SUM_CALLS, 0) = 0 THEN
    
    SELECT COUNT(*)
      INTO vCOUNT_IN_GROUP
      FROM CONTRACTS CN
          ,CONTRACT_GROUPS CG
     WHERE CN.GROUP_ID = CG.GROUP_ID
       AND CG.GROUP_ID = vGROUP_ID
    ;
    
  END IF;  
  
  --2. янгдюел окюрефх б рюакхже RECEIVED_PAYMENTS
  --2.1 нопедекъел яохянй мнлепнб дкъ цпсоош
  
  vCUR_SUM_PAY := 0;
  vMSG := ' оЕПЕБНД Я МНЛЕПЮ '|| PHONE_NUMBER || ' НР ' || to_char(PAYMENT_DATE_TIME, 'dd.mm.yyyy') ||' МЮ МНЛЕПЮ ЦПСООШ ';
  
  IF RUN_MODE = 'INSERT' THEN
      -- пЕЦХЯРПХПСЕЛ НЯМНБМНИ ОКЮРЕФ МЮ МНЛЕП  
      vRECEIVED_PAYMENT_ID := NEW_RECEIVED_PAYMENT_ID;
      INSERT INTO RECEIVED_PAYMENTS (RECEIVED_PAYMENT_ID, PHONE_NUMBER, PAYMENT_SUM, PAYMENT_DATE_TIME, CONTRACT_ID, FILIAL_ID, REMARK, RECEIVED_PAYMENT_TYPE_ID, IS_DISTRIBUTED, PAYMENT_PERIOD)
             VALUES (vRECEIVED_PAYMENT_ID, PHONE_NUMBER, PAYMEN_SUM, PAYMENT_DATE_TIME, vCONTR, 49, pREMARK, RECEIVED_PAYMENT_TYPE_ID, 1, YEAR_MONTH);
      
      FOR REC IN CONTRACT_LIST(VGROUP_ID, YEAR_MONTH) LOOP
            
        VALL_SUM_ABONENT := GET_SUMM_ALL_CALLS(VGROUP_ID, YEAR_MONTH, REC.CONTRACT_ID);
             
        -- нйпсцкъел дн йноеийх гювхякъелши окюреф дкъ юанмемрю б яннрберярбхх я ецн гюрпюрюлх
        -- б яксвюе еякх наыюъ ясллю гюрпюр пюбмю мскч, декхл лефкс бяелх свюрямхйюлх онпнбмс 
        IF NVL(VALL_SUM_CALLS, 0) <> 0 THEN  
          VCUR_PAY := TRUNC(VALL_SUM_ABONENT*PAYMEN_SUM/VALL_SUM_CALLS*100)/100;
        ELSE 
          VCUR_PAY := TRUNC(1*PAYMEN_SUM/vCOUNT_IN_GROUP*100)/100;            
        END IF;  
        
        -- дкъ нямнбмнцн мнлепю пюявхршбюел окюреф нрдекэмн б йнмже     
        IF (REC.PHONE_NUMBER_FEDERAL <> PHONE_NUMBER) THEN
              
          -- ондявхршбюел рейсысч ясллс гювхякъелшу окюрефеи мю мнлепю цпсоош, йпнле рнцн мю йнрнпши опхьек нямнбмни окюреф
          VCUR_SUM_PAY := VCUR_SUM_PAY + VCUR_PAY;  
              
          --б яксвюе оепеанпю хрнцнбни ясллш окюрефеи, дкъ онякедмецн окюрефю гювхякъел нярюбьсчяъ ясллс 
          -- б РЮЙНЛ ЯКСВЮЕ ЯСЛЛЮ БЯЕУ ОКЮРЕФЕИ ПЮБМЮ ЯСЛЛЕ ОКЮРЕФЮ 
          IF VCUR_SUM_PAY > PAYMEN_SUM THEN
            VCUR_PAY := PAYMEN_SUM - (VCUR_SUM_PAY-VCUR_PAY);
            VCUR_SUM_PAY := PAYMEN_SUM;
          END IF;      
                
          INSERT INTO RECEIVED_PAYMENTS (PHONE_NUMBER, PAYMENT_SUM, PAYMENT_DATE_TIME, CONTRACT_ID, FILIAL_ID, REMARK, RECEIVED_PAYMENT_TYPE_ID, PARENT_PAYMENT_ID, PAYMENT_PERIOD)
                 VALUES (REC.PHONE_NUMBER_FEDERAL, VCUR_PAY, PAYMENT_DATE_TIME, REC.CONTRACT_ID, 49, PREMARK||VMSG, RECEIVED_PAYMENT_TYPE_ID, vRECEIVED_PAYMENT_ID, YEAR_MONTH);
                         
        END IF;
      END LOOP;
      
      -- пюявхршбюел окюреф (сдепфюмхе) дкъ нямнбмнцн мнлепю      
      VMSG := ' сДЕПФЮМХЕ Я МНЛЕПЮ ГЮ ПЮЯОПЕДЕКЕМХЕ ОН МНЛЕПЮЛ ЦПСООШ НР '|| TO_CHAR(PAYMENT_DATE_TIME, 'dd.mm.yyyy');
      --IF VCUR_SUM_PAY < PAYMEN_SUM THEN
        INSERT INTO RECEIVED_PAYMENTS (PHONE_NUMBER, PAYMENT_SUM, PAYMENT_DATE_TIME, CONTRACT_ID, FILIAL_ID, REMARK, RECEIVED_PAYMENT_TYPE_ID, PARENT_PAYMENT_ID, PAYMENT_PERIOD)
                               VALUES (PHONE_NUMBER,  (0-VCUR_SUM_PAY), PAYMENT_DATE_TIME, VCONTR, 49, PREMARK||VMSG, RECEIVED_PAYMENT_TYPE_ID, vRECEIVED_PAYMENT_ID, YEAR_MONTH);
      --END IF;  
  ELSIF RUN_MODE = 'EDIT' THEN
      -- 1. нопедекъел яохянй мювхякеммшу днвепмху окюрефеи дкъ дюммнцн окюрефю (бяе с йнцн PARENT_PAYMENT_ID = pRECEIVED_PAYMENT_ID)
      -- 2. оепепюявхршбюел дкъ йюфднцн окюрефю ясллс гювхякемхъ 
      -- 3. намнбкъел ясллс окюрефю дкъ окюрефеи хг яохяйю
      
      FOR REC IN PAYMENT_LIST(pRECEIVED_PAYMENT_ID) LOOP
        -- ясллю гюрпювеммюъ юанмемрнл б оепхнде
        vALL_SUM_ABONENT := GET_SUMM_ALL_CALLS(VGROUP_ID, YEAR_MONTH, REC.CONTRACT_ID);
        
        -- дкъ нямнбмнцн мнлепю намнбкъел окюреф нрдекэмн б йнмже 
        IF REC.PHONE_NUMBER <> PHONE_NUMBER THEN  
          
          -- нйпсцкъел дн йноеийх гювхякъелши окюреф дкъ юанмемрю б яннрберярбхх я ецн гюрпюрюлх
          -- б яксвюе еякх наыюъ ясллю гюрпюр пюбмю мскч, декхл лефкс бяелх свюрямхйюлх онпнбмс 
          IF NVL(VALL_SUM_CALLS, 0) <> 0 THEN  
            VCUR_PAY := TRUNC(VALL_SUM_ABONENT*PAYMEN_SUM/VALL_SUM_CALLS*100)/100;
          ELSE 
            VCUR_PAY := TRUNC(1*PAYMEN_SUM/vCOUNT_IN_GROUP*100)/100;            
          END IF; 
          
          -- ондявхршбюел рейсысч ясллс гювхякъелшу окюрефеи мю мнлепю цпсоош, йпнле рнцн мю йнрнпши опхьек нямнбмни окюреф
          VCUR_SUM_PAY := VCUR_SUM_PAY + VCUR_PAY;
          
          --б яксвюе оепеанпю хрнцнбни ясллш окюрефеи, дкъ онякедмецн окюрефю гювхякъел нярюбьсчяъ ясллс 
          -- б РЮЙНЛ ЯКСВЮЕ ЯСЛЛЮ БЯЕУ ОКЮРЕФЕИ ПЮБМЮ ЯСЛЛЕ ОКЮРЕФЮ 
          IF VCUR_SUM_PAY > PAYMEN_SUM THEN
            VCUR_PAY := PAYMEN_SUM - (VCUR_SUM_PAY-VCUR_PAY);
            VCUR_SUM_PAY := PAYMEN_SUM;
          END IF;                
          
          UPDATE RECEIVED_PAYMENTS RP 
             SET RP.PAYMENT_SUM = vCUR_PAY
                ,RP.PAYMENT_PERIOD = YEAR_MONTH
           WHERE RP.RECEIVED_PAYMENT_ID = REC.RECEIVED_PAYMENT_ID;             
        ELSE 
          -- гюонлхмюел ID йнппейрхпсчыецн окюрефю, яюл окюреф ондявхршбюел б йнмже
          vCORRECT_RECEIVED_PAYMENT_ID := REC.RECEIVED_PAYMENT_ID; 
        END IF;
      END LOOP;
      
      -- намнбкъел окюреф (сдепфюмхе) дкъ нямнбмнцн мнлепю      
      VMSG := ' сДЕПФЮМХЕ Я МНЛЕПЮ ГЮ ПЮЯОПЕДЕКЕМХЕ ОН МНЛЕПЮЛ ЦПСООШ НР '|| TO_CHAR(PAYMENT_DATE_TIME, 'dd.mm.yyyy');
      -- IF VCUR_SUM_PAY < PAYMEN_SUM THEN       v5
        UPDATE RECEIVED_PAYMENTS RP 
           SET RP.PAYMENT_SUM = (0-VCUR_SUM_PAY)
              ,RP.PAYMENT_PERIOD = YEAR_MONTH
         WHERE RP.RECEIVED_PAYMENT_ID = vCORRECT_RECEIVED_PAYMENT_ID;
      --END IF;   v5     
      
      -- намнбкъел нямнбмни окюреф 
      UPDATE RECEIVED_PAYMENTS RP 
         SET RP.PAYMENT_SUM = PAYMEN_SUM
            ,RP.PAYMENT_PERIOD = YEAR_MONTH
       WHERE RP.RECEIVED_PAYMENT_ID = pRECEIVED_PAYMENT_ID;
      
  ELSIF RUN_MODE = 'DELETE' THEN
      -- 1. нопедекъел яохянй мювхякеммшу днвепмху окюрефеи дкъ дюммнцн окюрефю (бяе с йнцн PARENT_PAYMENT_ID = pRECEIVED_PAYMENT_ID)
      -- 2. сдюкъел днвепхе окюрефх х нямнбмни окюреф
      DELETE 
        FROM RECEIVED_PAYMENTS RP 
       WHERE RP.PARENT_PAYMENT_ID = pRECEIVED_PAYMENT_ID;
      -- сдюкъел нямнбмни окюреф 
      DELETE 
        FROM RECEIVED_PAYMENTS RP 
       WHERE RP.RECEIVED_PAYMENT_ID = pRECEIVED_PAYMENT_ID; 
  END IF;    
       
END ADD_DISTRIBUTED_PAYMENT;
/