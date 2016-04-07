
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."SET_PHONE_HISTORY" (
   p_STREAM_ID    IN INTEGER default 0,
   pCountSTREAM   IN INTEGER default 1
   )
 IS
--
--#Version=2
--
--v.2 15.09.2015  Афросин Добавил разбиение по потокам. Убрал мусор 
--

BEGIN
  FOR rec IN (SELECT Q.*, Q.ROWID
                FROM
                  QUEUE_UPDATE_PHONE_HISTORY Q
                where
                  MOD (TO_NUMBER (PHONE_NUMBER), pCountSTREAM) = p_STREAM_ID  
                ORDER BY PHONE_NUMBER ASC, DATE_REPORT ASC)
  LOOP 
    BEGIN      
      SET_PHONE_HISTORY2(rec.PHONE_NUMBER, rec.PHONE_IS_ACTIVE, rec.CELL_PLAN_CODE, 
                         rec.CONSERVATION, rec.SYSTEM_BLOCK, rec.STATUS_ID, rec.DATE_REPORT);
      DELETE FROM QUEUE_UPDATE_PHONE_HISTORY Q
        WHERE Q.ROWID = REC.ROWID;
      COMMIT;
    EXCEPTION
      WHEN OTHERS THEN 
        NULL;
        insert into temp7(str2)
        values(rec.PHONE_NUMBER);
        commit;
    END;
  END LOOP;
end;