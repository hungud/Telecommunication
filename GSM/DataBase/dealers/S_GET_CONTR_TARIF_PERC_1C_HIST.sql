CREATE OR REPLACE FUNCTION WWW_DEALER.S_GET_CONTR_TARIF_PERC_1C_HIST(pTARIFF_ID INTEGER, pUSER_ID INTEGER) RETURN VARCHAR2 IS
--#Version=1
-- история изменения процента днного контрагента (проценты загруженные из 1С)
    CURSOR CUR IS
       SELECT TO_CHAR(P.PERIOD, 'YYYY, Month', 'NLS_DATE_LANGUAGE = Russian') PERIOD_TEXT
             , P.PERCENT
         FROM D_CONTR_TARIFF_PERCENTS P
        WHERE (pTARIFF_ID = P.TARIFF_ID)
           AND(pUSER_ID = P.USER_ID)
         ORDER BY P.PERIOD DESC NULLS LAST -- последний установленный процент
         ;
    vRES VARCHAR2(4000 CHAR) := '';
  BEGIN
    FOR REC IN CUR LOOP
      IF TRIM(vRES) IS NOT NULL THEN
        vRES := vRES || CHR(13) || CHR(10);
      ELSE
        vRES := 'Процент, загруженный из 1С: ' || CHR(13) || CHR(10);
      END IF;
      vRES := vRES || REC.PERIOD_TEXT || ' - ' || TO_CHAR(REC.PERCENT) || '%';
    END LOOP;
    RETURN vRES;
  END;
/
