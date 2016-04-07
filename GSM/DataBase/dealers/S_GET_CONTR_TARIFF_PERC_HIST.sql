CREATE OR REPLACE FUNCTION WWW_DEALER.S_GET_CONTR_TARIFF_PERC_HIST(pTARIFF_ID INTEGER, pUSER_ID INTEGER) RETURN VARCHAR2 IS
--#Version=1
-- история изменения процента днного контрагента (проценты загруженные из 1С)
    CURSOR CUR_1C IS
       SELECT TO_CHAR(P.PERIOD, 'YYYY, Month', 'NLS_DATE_LANGUAGE = Russian') PERIOD_TEXT
             , P.PERCENT
         FROM D_CONTR_TARIFF_PERCENTS P
        WHERE (pTARIFF_ID = P.TARIFF_ID)
          and (pUSER_ID = P.USER_ID)
         ORDER BY P.PERIOD DESC NULLS LAST -- последний установленный процент
         ;
         
    CURSOR CUR_HAND IS
       SELECT TO_CHAR(P.PERIOD, 'YYYY, Month', 'NLS_DATE_LANGUAGE = Russian') PERIOD_TEXT
             , P.PERCENT
         FROM D_CONTR_TARIFF_PERC_HANDS P
        WHERE (pTARIFF_ID = P.TARIFF_ID)
           AND(pUSER_ID = P.USER_ID)
         ORDER BY P.PERIOD DESC NULLS LAST -- последний установленный процент
         ;
         
    vRES VARCHAR2(4000 CHAR) := '';
    vRES2 VARCHAR2(4000 CHAR) := '';
  BEGIN
    FOR REC IN CUR_1C LOOP
      IF TRIM(vRES) IS NOT NULL THEN
        vRES := vRES || CHR(13) || CHR(10);
      ELSE
        vRES := 'Процент для тарифа, загруженный из 1С: ' || CHR(13) || CHR(10);
      END IF;
      vRES := vRES || REC.PERIOD_TEXT || ' - ' || TO_CHAR(REC.PERCENT) || '%';
    END LOOP;
    
    FOR REC IN CUR_HAND LOOP
      IF TRIM(vRES2) IS NULL THEN
        vRES2 := CHR(13) || CHR(10) || 'Процент для тарифа, измененный вручную: ';
      END IF;
      vRES2 := vRES2 || CHR(13) || CHR(10) || REC.PERIOD_TEXT || ' - ' || TO_CHAR(REC.PERCENT) || '%';
    END LOOP;
    
    IF vRES2 IS NOT NULL THEN
      RETURN vRES || CHR(13) || CHR(10) || vRES2;
    ELSE
      RETURN vRES;
    END IF;
  END;
/
