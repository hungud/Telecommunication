CREATE OR REPLACE VIEW V_BILL_TARIFER_FOR_DILER AS
-- Version = 1
-- 1./ 2015.11.06. Крайнов. Создание.
  SELECT Z.*,
         CASE 
           WHEN Z.SUM_PREV_BILL < 500 AND Z.ABON_TP - 500 + Z.SUM_PREV_BILL < 0 THEN 0
           WHEN Z.SUM_PREV_BILL < 500 THEN Z.ABON_TP - 500 + Z.SUM_PREV_BILL
           ELSE Z.ABON_TP
         END BILL_SUMM_WITHOUT_START_BAL
    FROM (SELECT X.*,
                 NVL((SELECT SUM(B.ABON_TP)
                        FROM TARIFER_BILL_FOR_CLIENTS B
                        WHERE B.PHONE_NUMBER = X.PHONE_NUMBER
                          AND B.YEAR_MONTH >= X.BEGIN_YEAR_MONTH
                          AND B.YEAR_MONTH < X.YEAR_MONTH), 0) SUM_PREV_BILL
            FROM (SELECT BT.*, 
                         (SELECT TO_CHAR(C.CONTRACT_DATE, 'YYYYMM') 
                            FROM CONTRACTS C 
                            WHERE C.CONTRACT_ID = CONVERT_PCKG.GET_CONTRACT_ID_BY_YEAR_MONTH(BT.YEAR_MONTH, BT.PHONE_NUMBER)) BEGIN_YEAR_MONTH,
                         (SELECT COUNT(*) 
                            FROM DB_LOADER_ABONENT_PERIODS D
                            WHERE D.YEAR_MONTH = BT.YEAR_MONTH
                              AND D.PHONE_NUMBER = BT.PHONE_NUMBER
                              AND D.TARIFF_CODE LIKE 'FIVIP%') COUNT_FIVIP
                    FROM TARIFER_BILL_FOR_CLIENTS BT
                  /*  where bt.PHONE_NUMBER = '9660996205'*/ ) X
            WHERE X.YEAR_MONTH <= TO_CHAR(ADD_MONTHS(TO_DATE(X.BEGIN_YEAR_MONTH, 'YYYYMM'), CASE WHEN X.COUNT_FIVIP = 0 THEN 4 ELSE 6 END - 1), 'YYYYMM')) Z;
            
GRANT SELECT ON V_BILL_TARIFER_FOR_DILER TO CORP_MOBILE_ROLE;         
            
GRANT SELECT ON V_BILL_TARIFER_FOR_DILER TO CORP_MOBILE_ROLE_RO;            