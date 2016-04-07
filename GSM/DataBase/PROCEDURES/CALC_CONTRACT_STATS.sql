CREATE OR REPLACE PROCEDURE CALC_CONTRACT_STATS IS
-- Version = 1
BEGIN
  FOR rec IN (SELECT C.*,
                     CC.CONTRACT_CANCEL_DATE
                FROM CONTRACTS C,
                     CONTRACT_CANCELS CC
                WHERE C.CONTRACT_ID NOT IN (SELECT CS.CONTRACT_ID
                                              FROM CONTRACT_STATISTICS CS)
                  AND C.CONTRACT_ID = CC.CONTRACT_ID(+)) 
  LOOP
    INSERT INTO CONTRACT_STATISTICS(CONTRACT_ID, PHONE_NUMBER, DATE_BEGIN, DATE_CANCEL, STAT_COMPLETE)
      VALUES(rec.CONTRACT_ID, rec.PHONE_NUMBER_FEDERAL, rec.CONTRACT_DATE, rec.CONTRACT_CANCEL_DATE, 0);
  END LOOP;
  FOR rec IN (SELECT *
                FROM CONTRACT_STATISTICS
                WHERE STAT_COMPLETE = 0)
  LOOP
    UPDATE CONTRACT_STATISTICS CS
      SET CS.DATE_CANCEL = (SELECT CC.CONTRACT_CANCEL_DATE
                              FROM CONTRACT_CANCELS CC
                              WHERE CC.CONTRACT_ID = rec.CONTRACT_ID),
          CS.PAYMENTS_SUMM_ALL = NVL((SELECT SUM(V.PAYMENT_SUM)
                                        FROM V_FULL_BALANCE_PAYMENTS V
                                        WHERE V.CONTRACT_ID = rec.CONTRACT_ID
                                          OR (V.PHONE_NUMBER = rec.PHONE_NUMBER
                                                AND V.PAYMENT_DATE >= rec.DATE_BEGIN
                                                AND V.PAYMENT_DATE <= NVL(rec.DATE_CANCEL, SYSDATE + 1))),
                                     0),
          CS.PAYMENTS_SUMM_BEELINE = NVL((SELECT SUM(B.PAYMENT_SUM)
                                            FROM DB_LOADER_PAYMENTS B
                                            WHERE B.CONTRACT_ID = rec.CONTRACT_ID
                                              OR (B.PHONE_NUMBER = rec.PHONE_NUMBER
                                                    AND B.PAYMENT_DATE >= rec.DATE_BEGIN
                                                    AND B.PAYMENT_DATE <= NVL(rec.DATE_CANCEL, SYSDATE + 1))),
                                         0),
          CS.BILLS_SUMM_ALL = NVL((SELECT SUM(-V.BILL_SUM)   --ÂÑÅ Ñ×ÅÒÀ ÄËß ÊËÈÅÍÒÀ
                                     FROM V_FULL_BALANCE_BILLS V
                                     WHERE V.PHONE_NUMBER = rec.PHONE_NUMBER
                                       AND V.BILL_DATE >= rec.DATE_BEGIN
                                       AND V.BILL_DATE <= NVL(rec.DATE_CANCEL, SYSDATE + 1)),
                                  0),
          CS.BILLS_SUMM_BEELINE = NVL((SELECT SUM(-FB.BILL_SUM)  -- Ñ×ÅÒÀ ÁÈËÀÉÍÀ ÍÎÂÎÃÎ ÔÎÐÌÀÒÀ
                                         FROM DB_LOADER_FULL_FINANCE_BILL FB
                                         WHERE FB.PHONE_NUMBER = rec.PHONE_NUMBER
                                           AND FB.COMPLETE_BILL = 1
                                           AND LAST_DAY(TO_DATE(FB.YEAR_MONTH||'01', 'YYYYMMDD')) >= rec.DATE_BEGIN
                                           AND LAST_DAY(TO_DATE(FB.YEAR_MONTH||'01', 'YYYYMMDD')) <= NVL(rec.DATE_CANCEL, SYSDATE + 1)) 
                                      + (SELECT SUM(-B.BILL_SUM)  -- Ñ×ÅÒÀ ÁÈËÀÉÍÀ ÑÒÀÐÎÃÎ ÔÎÐÌÀÒÀ 
                                           FROM DB_LOADER_BILLS B
                                           WHERE B.PHONE_NUMBER = rec.PHONE_NUMBER
                                             AND NOT EXISTS(SELECT 1
                                                              FROM DB_LOADER_FULL_FINANCE_BILL FB
                                                              WHERE FB.ACCOUNT_ID = B.ACCOUNT_ID
                                                                AND FB.YEAR_MONTH = B.YEAR_MONTH
                                                                AND FB.PHONE_NUMBER = B.PHONE_NUMBER
                                                                AND FB.COMPLETE_BILL = 1)
                                             AND B.DATE_END >= rec.DATE_BEGIN
                                             AND B.DATE_BEGIN <= NVL(rec.DATE_CANCEL, SYSDATE + 1)),
                                      0)                                             
      WHERE CS.CONTRACT_ID = rec.CONTRACT_ID;
  END LOOP;   
  FOR rec IN (SELECT *
                FROM CONTRACT_STATISTICS
                WHERE STAT_COMPLETE = 0)
  LOOP 
    UPDATE CONTRACT_STATISTICS CS
      SET CS.DEBITORKA = cs.PAYMENTS_SUMM_ALL + cs.BILLS_SUMM_ALL,
          cs.STAT_COMPLETE = CASE
                               WHEN CS.DATE_CANCEL IS NOT NULL THEN 1
                               ELSE 0
                             END                                  
      WHERE CS.CONTRACT_ID = rec.CONTRACT_ID;     
  END LOOP;   
  COMMIT;                        
END;

GRANT EXECUTE ON CALC_CONTRACT_STATS TO CORP_MOBILE_ROLE; 