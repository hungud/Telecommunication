CREATE OR REPLACE PROCEDURE SAVE_V_DRAVE_INFO IS
-- Version = 2
--
-- 2. 2015.09.28. Крайнов.Убрал временной разрыв из-за транкейта.
--
BEGIN
  IF TRUNC(SYSDATE, 'MM') <> TRUNC(SYSDATE + 3, 'MM') THEN
    delete
      from SAVED_V_DRAVE_INFO;
    INSERT INTO SAVED_V_DRAVE_INFO
      SELECT V.PHONE_NUMBER_FEDERAL,
             V.MONTHLY_PAYMENT
        FROM V_DRAVE_INFO V;
    COMMIT;
  END IF;
END;