CREATE OR REPLACE PROCEDURE FORCE_UPD_HIST_STATUS_CHG_DATE(
  pCTN IN VARCHAR2,
  pSTATUSDATE IN DATE,
  pPHONE_IS_ACTIVE IN INTEGER,
  pPRICEPLAN IN VARCHAR2,
  pREASONSTATUS IN VARCHAR2,
  pDATE_REPORT IN DATE DEFAULT NULL
  ) IS
  CURSOR C(pDATE_BEGIN IN DATE, pDATE_END IN DATE) IS 
    SELECT H.*, H.ROWID
      FROM DB_LOADER_ACCOUNT_PHONE_HISTS H
      WHERE H.PHONE_NUMBER = pCTN
        AND H.BEGIN_DATE <= pDATE_BEGIN
        AND H.END_DATE >= pDATE_END;
  DUMMY C%ROWTYPE;
  CURSOR H(pDATE_BEGIN IN DATE) IS
    SELECT *
      FROM DB_LOADER_ACCOUNT_PHONE_HISTS H
      WHERE H.PHONE_NUMBER = pCTN
        AND H.BEGIN_DATE <= pDATE_BEGIN
        AND H.END_DATE > SYSDATE;
  DUMMY_H H%ROWTYPE;
  vDATE_BEGIN DATE;
  vDATE_END DATE;   
  vSTATUS_ID INTEGER;
  vCONSERVATION NUMBER(1);
  vSYSTEM_BLOCK NUMBER(1);
BEGIN
  SELECT BSC.IS_CONSERVATION, BSC.IS_SYSTEM_BLOCK, BSC.STATUS_ID
    INTO vCONSERVATION, vSYSTEM_BLOCK, vSTATUS_ID
    FROM BEELINE_STATUS_CODE BSC
    WHERE BSC.STATUS_CODE = pREASONSTATUS;
  IF pDATE_REPORT IS NOT NULL THEN
    -- Адаптация истории где-то в прошлом
    vDATE_BEGIN:=TRUNC(pSTATUSDATE)+1;
    vDATE_END:=TRUNC(pDATE_REPORT)-1/24/60/60;
    IF vDATE_END > vDATE_BEGIN THEN
      OPEN C(vDATE_BEGIN, vDATE_END);    
      FETCH C INTO DUMMY;
      IF C%FOUND THEN
        IF DUMMY.PHONE_IS_ACTIVE <> pPHONE_IS_ACTIVE THEN
          IF DUMMY.BEGIN_DATE = vDATE_BEGIN AND DUMMY.END_DATE = vDATE_END THEN
            -- Если найденный отрезок истории совпадает с обновляемым
            UPDATE DB_LOADER_ACCOUNT_PHONE_HISTS H
              SET H.PHONE_IS_ACTIVE = pPHONE_IS_ACTIVE,
                  H.CONSERVATION = CASE WHEN pPHONE_IS_ACTIVE = 1 THEN 0 ELSE vCONSERVATION END,
                  H.SYSTEM_BLOCK = CASE WHEN pPHONE_IS_ACTIVE = 1 THEN 0 ELSE vSYSTEM_BLOCK END,
                  H.STATUS_ID = vSTATUS_ID
              WHERE H.ROWID = DUMMY.ROWID;
          ELSE
            IF DUMMY.BEGIN_DATE = vDATE_BEGIN THEN 
              -- Если у найденного отрезка истории торчит кусок позже обновляемого
              UPDATE DB_LOADER_ACCOUNT_PHONE_HISTS H
                SET H.BEGIN_DATE = vDATE_END + 1/24/60/60  --  +1sec
                WHERE H.ROWID = DUMMY.ROWID;            
              INSERT INTO DB_LOADER_ACCOUNT_PHONE_HISTS(PHONE_NUMBER, BEGIN_DATE, END_DATE, PHONE_IS_ACTIVE, CELL_PLAN_CODE,
                                                        CONSERVATION, SYSTEM_BLOCK, STATUS_ID)   
                VALUES(pCTN, vDATE_BEGIN, vDATE_END, pPHONE_IS_ACTIVE, pPRICEPLAN,
                       CASE WHEN pPHONE_IS_ACTIVE = 1 THEN 0 ELSE vCONSERVATION END,
                       CASE WHEN pPHONE_IS_ACTIVE = 1 THEN 0 ELSE vSYSTEM_BLOCK END, vSTATUS_ID);
            ELSE
              IF DUMMY.END_DATE = vDATE_END THEN
                -- Если у найденного отрезка истории торчит кусок раньше обновляемого
                -- Кусок до обновляемого
                UPDATE DB_LOADER_ACCOUNT_PHONE_HISTS H
                  SET H.END_DATE = vDATE_BEGIN - 1/24/60/60  --  -1sec
                  WHERE H.ROWID = DUMMY.ROWID; 
                -- Обновляемый кусок           
                INSERT INTO DB_LOADER_ACCOUNT_PHONE_HISTS(PHONE_NUMBER, BEGIN_DATE, END_DATE, PHONE_IS_ACTIVE, CELL_PLAN_CODE,
                                                          CONSERVATION, SYSTEM_BLOCK, STATUS_ID)   
                  VALUES(pCTN, vDATE_BEGIN, vDATE_END, pPHONE_IS_ACTIVE, pPRICEPLAN,
                         CASE WHEN pPHONE_IS_ACTIVE = 1 THEN 0 ELSE vCONSERVATION END,
                         CASE WHEN pPHONE_IS_ACTIVE = 1 THEN 0 ELSE vSYSTEM_BLOCK END, vSTATUS_ID);
              ELSE            
                -- Если у найденного отрезка истории торчат кусоки раньше и позже обновляемого
                UPDATE DB_LOADER_ACCOUNT_PHONE_HISTS H
                  SET H.END_DATE = vDATE_BEGIN - 1/24/60/60  --  -1sec
                  WHERE H.ROWID = DUMMY.ROWID;            
                INSERT INTO DB_LOADER_ACCOUNT_PHONE_HISTS(PHONE_NUMBER, BEGIN_DATE, END_DATE, PHONE_IS_ACTIVE, CELL_PLAN_CODE,
                                                          CONSERVATION, SYSTEM_BLOCK, STATUS_ID)   
                  VALUES(pCTN, vDATE_BEGIN, vDATE_END, pPHONE_IS_ACTIVE, pPRICEPLAN,
                         CASE WHEN pPHONE_IS_ACTIVE = 1 THEN 0 ELSE vCONSERVATION END,
                         CASE WHEN pPHONE_IS_ACTIVE = 1 THEN 0 ELSE vSYSTEM_BLOCK END, vSTATUS_ID);
                INSERT INTO DB_LOADER_ACCOUNT_PHONE_HISTS(PHONE_NUMBER, BEGIN_DATE, END_DATE, PHONE_IS_ACTIVE, CELL_PLAN_CODE)   
                  VALUES(DUMMY.PHONE_NUMBER, vDATE_END + 1/24/60/60, DUMMY.END_DATE, DUMMY.PHONE_IS_ACTIVE, DUMMY.CELL_PLAN_CODE);
              END IF;
            END IF;
          END IF;        
          COMMIT;
        END IF;
      ELSE
        -- Удаляем все внутри обновляемого отрезка истории
        DELETE 
          FROM DB_LOADER_ACCOUNT_PHONE_HISTS H
          WHERE H.PHONE_NUMBER = pCTN
            AND H.BEGIN_DATE >= vDATE_BEGIN
            AND H.END_DATE <= vDATE_END;  
        -- Замыкаем отрезок до обновляемого
        UPDATE DB_LOADER_ACCOUNT_PHONE_HISTS H
          SET H.END_DATE = vDATE_BEGIN - 1/24/60/60   -- -1sec
          WHERE H.PHONE_NUMBER = pCTN
            AND H.BEGIN_DATE <= vDATE_BEGIN - 1/24/60/60
            AND H.END_DATE >= vDATE_BEGIN - 1/24/60/60;
        -- Замыкаем отрезок после обновляемого
        UPDATE DB_LOADER_ACCOUNT_PHONE_HISTS H
          SET H.BEGIN_DATE = vDATE_END + 1/24/60/60   -- +1sec
          WHERE H.PHONE_NUMBER = pCTN
            AND H.BEGIN_DATE <= vDATE_END + 1/24/60/60
            AND H.END_DATE >= vDATE_END + 1/24/60/60;
        -- Вставляем обновляемый отрезок
        INSERT INTO DB_LOADER_ACCOUNT_PHONE_HISTS(PHONE_NUMBER, BEGIN_DATE, END_DATE, PHONE_IS_ACTIVE, CELL_PLAN_CODE,
                                                  CONSERVATION, SYSTEM_BLOCK, STATUS_ID)   
          VALUES(pCTN, vDATE_BEGIN, vDATE_END, pPHONE_IS_ACTIVE, pPRICEPLAN,
                 CASE WHEN pPHONE_IS_ACTIVE = 1 THEN 0 ELSE vCONSERVATION END,
                 CASE WHEN pPHONE_IS_ACTIVE = 1 THEN 0 ELSE vSYSTEM_BLOCK END, vSTATUS_ID);
        COMMIT;
      END IF;
      CLOSE C;
    END IF;
  ELSE
    -- Адаптация текущей загрузки статусов
    -- Проверка, нужно ли менять    
    OPEN H(vDATE_BEGIN); 
    FETCH H INTO DUMMY_H;
    IF C%NOTFOUND THEN  -- ЕСЛИ НЕ НАШЛИ ВЕРНОГО, ЗНАЧИТ НАДО ПОПРАВИТЬ.
      -- Замыкаем отрезок до обновляемого
      UPDATE DB_LOADER_ACCOUNT_PHONE_HISTS H
        SET H.END_DATE = vDATE_BEGIN - 1/24/60/60   -- -1sec
        WHERE H.PHONE_NUMBER = pCTN
          AND H.BEGIN_DATE <= vDATE_BEGIN - 1/24/60/60
          AND H.END_DATE >= vDATE_BEGIN - 1/24/60/60;
      -- Вставляем обновляемый отрезок
      INSERT INTO DB_LOADER_ACCOUNT_PHONE_HISTS(PHONE_NUMBER, BEGIN_DATE, END_DATE, PHONE_IS_ACTIVE, CELL_PLAN_CODE,
                                                CONSERVATION, SYSTEM_BLOCK, STATUS_ID)   
        VALUES(pCTN, vDATE_BEGIN, TO_DATE('01.01.3000','DD.MM.YYYY'), pPHONE_IS_ACTIVE, pPRICEPLAN,
               CASE WHEN pPHONE_IS_ACTIVE = 1 THEN 0 ELSE vCONSERVATION END,
               CASE WHEN pPHONE_IS_ACTIVE = 1 THEN 0 ELSE vSYSTEM_BLOCK END, vSTATUS_ID);
    END IF;
    CLOSE H;
  END IF;
END;  