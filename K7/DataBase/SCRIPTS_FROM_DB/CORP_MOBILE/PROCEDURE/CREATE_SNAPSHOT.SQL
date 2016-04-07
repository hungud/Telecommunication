
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."CREATE_SNAPSHOT" (
  pPHONE_NUMBER IN VARCHAR2
  ) IS
-- Version = 1
  PRAGMA AUTONOMOUS_TRANSACTION;  
  LSnapDt DATE:=SYSDATE;
  LSnapID NUMBER;
BEGIN
  SELECT s_new_snapshot_id.NEXTVAL 
    INTO LSnapID 
    FROM DUAL;
  CALC_BALANCE_ROWS(pPHONE_NUMBER);
  INSERT INTO snapshots(snap_id, snap_dt, phone_number)
    VALUES(LSnapID, LSnapDt, pPHONE_NUMBER);
  INSERT INTO snapshot_log(snap_log_id, snap_id, row_date, row_cost, row_desc)
    SELECT s_new_snapshot_log_id.NEXTVAL, LSnapID, ABR.ROW_DATE, ABR.ROW_COST, ABR.ROW_COMMENT         
      FROM ABONENT_BALANCE_ROWS abr;
  COMMIT;
END CREATE_SNAPSHOT;