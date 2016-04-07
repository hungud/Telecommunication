CREATE OR REPLACE PROCEDURE LOAD_UNBLOCK IS
    CURSOR c IS SELECT queue_load_block_id, phone_number, type_action 
                FROM queue_load_block_unblock
              WHERE TRUNC(dateb) <= TRUNC(SYSDATE) AND success <> 1
                and type_action = 1;

  vSTR VARCHAR2(1000 CHAR);
  vAnswer INTEGER;
  v INTEGER;
BEGIN
  FOR v IN c LOOP
  BEGIN
      vSTR := beeline_api_pckg.UNLOCK_PHONE(v.phone_number);
      IF SUBSTR(vSTR, 1, 19) = 'Заявка на разблок №' THEN
        vAnswer := 1;
      ELSE
        vAnswer := 0;
      END IF;
    UPDATE queue_load_block_unblock SET result_str = vSTR, success = vAnswer WHERE queue_load_block_id = v.queue_load_block_id;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      vSTR := SUBSTR(SQLERRM, 1, 1000);
      UPDATE queue_load_block_unblock SET result_str = vSTR, success = 0 WHERE queue_load_block_id = v.queue_load_block_id;
      COMMIT;
  END;
  END LOOP;
END;
/
