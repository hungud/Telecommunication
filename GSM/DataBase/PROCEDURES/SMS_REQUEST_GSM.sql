/* Formatted on 25/11/2014 10:56:10 (QP5 v5.252.13127.32867) */
CREATE OR REPLACE PROCEDURE SMS_REQUEST
IS
   prov_id        INTEGER;

   CURSOR C
   IS
      SELECT ssp.LOGIN, ssp.PASSWORD, ssp.SENDER_NAME
        FROM SMS_SEND_PARAMETRS ssp
       WHERE ssp.provider_id = prov_id;

   --
   vREC           C%ROWTYPE;

   CURSOR CUR
   IS
        SELECT ROWID,
               sc.provider_id,
               sc.phone,
               sc.MESSAGE,
               sc.sms_id,
               sc.status_code,
               sc.ERROR_CODE,
               sc.req_count,
               sc.insert_date,
               sc.update_date,
               sc.result_str,
               sc.description_str,
               sc.date_start,
               SC.SMS_SENDER_NAME
          FROM SMS_CURRENT SC
         WHERE     sc.date_start <= SYSDATE
               AND (   (    sc.status_code = 99
                        AND (   sc.ERROR_CODE = 0
                             OR sc.ERROR_CODE IS NULL
                             OR (    sc.ERROR_CODE IN (6,
                                                       7,
                                                       43,
                                                       40)
                                 AND sc.update_date < SYSDATE - 1 / 1440 / 2)))
                    OR (    sc.status_code IN (0, 1)
                        AND sc.update_date < SYSDATE - 1 / 1440 / 2))
      ORDER BY 6 DESC;

   pREC           CUR%ROWTYPE;
   pANSWER        VARCHAR2 (2000 CHAR);
   pSTATUS_CODE   INTEGER;

   CURSOR st (pSTATUS IN VARCHAR2)
   IS
      SELECT STATUS_CODE
        FROM sms_status
       WHERE MESSAGE = pSTATUS;

   st_dummy       st%ROWTYPE;
   vSMS_ID        INTEGER;
   vSMS_TRAFFIC   VARCHAR2 (2000 CHAR);
BEGIN
   OPEN cur;

   LOOP
      FETCH cur INTO pREC;

      EXIT WHEN cur%NOTFOUND;
      DBMS_LOCK.SLEEP (2);

      IF pREC.req_count <
            TO_NUMBER (MS_params.GET_PARAM_VALUE ('SMS_REQ_COUNT'))
      THEN
         --prov_id := pREC.provider_id;
         OPEN c;

         FETCH c INTO vREC;

         CLOSE c;

         pANSWER := NULL;

         IF prec.status_code = 99     /*or prec.error_code in (6, 7, 43, 40)*/
         THEN
            DBMS_LOCK.SLEEP (1);
            pANSWER := BEELINE_SMPP.SEND_SMS (pREC.phone, pREC.MESSAGE);

            IF INSTR (pANSWER, '0000062c') > 0
            THEN
               vSMS_TRAFFIC :=
                  SMS_PROVIDER_SMSTRAFFIC2 (pREC.phone, pREC.MESSAGE);

               DELETE SMS_CURRENT sc
                WHERE sc.ROWID = pREC.ROWID;

               INSERT INTO sms_log (PHONE,
                                    MESSAGE,
                                    SMS_ID,
                                    SLERROR_CODE,
                                    SLERROR,
                                    INSERT_DATE,
                                    REQ_COUNT,
                                    DATE_START,
                                    SMS_SENDER_NAME
                                    )
                    VALUES (pREC.phone,
                            pREC.MESSAGE,
                            prec.sms_id,
                            44,
                            pANSWER || '. ok. ' || vSMS_TRAFFIC,
                            SYSDATE,
                            pREC.req_count,
                            prec.date_start,
                            pREC.SMS_SENDER_NAME
                            );

               COMMIT;
            END IF;
         ELSE
            pANSWER := BEELINE_SMPP.GET_SMS_STATUS (pREC.sms_id);

            OPEN st (pANSWER);

            FETCH st INTO st_dummy;

            IF st%FOUND
            THEN
               pSTATUS_CODE := st_dummy.STATUS_CODE;
            ELSE
               pSTATUS_CODE := -1;
            END IF;

            CLOSE st;
         END IF;

         IF (pANSWER IS NOT NULL) AND (INSTR (pANSWER, '0000') = 0)
         THEN
            IF prec.status_code = 99  /*or prec.error_code in (6, 7, 43, 40)*/
            THEN
               BEGIN
                  IF INSTR (pANSWER, ';') = 0
                  THEN
                     vSMS_ID := TO_NUMBER (pANSWER);
                  ELSE
                     -- Первый кусок СМС, обычно статус UNDELIVERABLE
                     /*vSMS_ID:=to_number(substr(pANSWER,
                                               instr(pANSWER, ';', 1, 1)+2,
                                               instr(pANSWER, ';', 1,2)-instr(pANSWER, ';', 1, 1)-3));*/
                     -- Последний кусок СМС, проверяем его статус
                     vSMS_ID :=
                        TO_NUMBER (SUBSTR (pANSWER,
                                             INSTR (pANSWER,
                                                    ';',
                                                    -1,
                                                    1)
                                           + 2,
                                             LENGTH (pANSWER)
                                           - INSTR (pANSWER,
                                                    ';',
                                                    -1,
                                                    1)
                                           - 1));
                  END IF;

                  UPDATE SMS_CURRENT sc
                     SET sc.status_code = 0,
                         sc.sms_id = vSMS_ID,
                         sc.req_count = sc.req_count + 1
                   WHERE SC.ROWID = pREC.ROWID;

                  COMMIT;
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     UPDATE SMS_CURRENT sc
                        SET sc.req_count = sc.req_count + 1
                      WHERE SC.ROWID = pREC.ROWID;

                     IF pREC.req_count = 2
                     THEN
                        DELETE SMS_CURRENT sc
                         WHERE sc.ROWID = pREC.ROWID;

                        INSERT INTO sms_log (PHONE,
                                             MESSAGE,
                                             SMS_ID,
                                             SLERROR_CODE,
                                             SLERROR,
                                             INSERT_DATE,
                                             REQ_COUNT,
                                             DATE_START,
                                             SMS_SENDER_NAME
                                             )
                             VALUES (pREC.phone,
                                     pREC.MESSAGE,
                                     prec.sms_id,
                                     40,
                                     pANSWER,
                                     SYSDATE,
                                     pREC.req_count,
                                     prec.date_start,
                                     pREC.SMS_SENDER_NAME
                                     );

                        COMMIT;
                     END IF;
               END;
            ELSE
               IF pSTATUS_CODE IN ('0', '1')
               THEN
                  UPDATE SMS_CURRENT sc
                     SET sc.status_code = pSTATUS_CODE,
                         sc.DESCRIPTION_STR = pANSWER,
                         sc.ERROR_CODE = 0
                   WHERE sc.ROWID = pREC.ROWID;

                  COMMIT;
               --          end if;
               ELSE
                  IF pSTATUS_CODE <> -1
                  THEN
                     DELETE SMS_CURRENT sc
                      WHERE sc.ROWID = pREC.ROWID;

                     INSERT INTO sms_log (PHONE,
                                          MESSAGE,
                                          SMS_ID,
                                          STATUS,
                                          STATUS_CODE,
                                          INSERT_DATE,
                                          REQ_COUNT,
                                          DATE_START,
                                          SMS_SENDER_NAME
                                          )
                          VALUES (pREC.phone,
                                  pREC.MESSAGE,
                                  prec.sms_id,
                                  pANSWER,
                                  pSTATUS_CODE,
                                  SYSDATE,
                                  pREC.req_count,
                                  prec.date_start,
                                  pREC.SMS_SENDER_NAME
                                  );

                     COMMIT;
                  END IF;
               END IF;
            END IF;
         ELSE
            IF pREC.req_count <
                  TO_NUMBER (MS_params.GET_PARAM_VALUE ('SMS_REQ_COUNT'))
            THEN
               UPDATE SMS_CURRENT sc
                  SET sc.req_count = sc.req_count + 1
                WHERE sc.ROWID = pREC.ROWID;

               COMMIT;
            ELSE
               DELETE SMS_CURRENT sc
                WHERE sc.ROWID = pREC.ROWID;

               INSERT INTO sms_log (PHONE,
                                    MESSAGE,
                                    SMS_ID,
                                    SUBMITION_DATE,
                                    SEND_DATE,
                                    LAST_STATUS_CHANGE_DATE,
                                    STATUS,
                                    INSERT_DATE,
                                    REQ_COUNT,
                                    DATE_START,
                                    SMS_SENDER_NAME
                                    )
                    VALUES (pREC.phone,
                            pREC.MESSAGE,
                            prec.sms_id,
                            pREC.insert_date,
                            pREC.insert_date,
                            pREC.update_date,
                            pANSWER,
                            SYSDATE,
                            pREC.req_count + 1,
                            prec.date_start,
                            pREC.SMS_SENDER_NAME
                            );

               COMMIT;
            END IF;
         END IF;
      ELSE
         DELETE SMS_CURRENT sc
          WHERE sc.ROWID = pREC.ROWID;

         INSERT INTO sms_log (
          PHONE,
          MESSAGE,
          SMS_ID,
          SUBMITION_DATE,
          SEND_DATE,
          LAST_STATUS_CHANGE_DATE,
          STATUS,
          STATUS_CODE,
          SLERROR_CODE,
          SLERROR,
          INSERT_DATE,
          REQ_COUNT,
          DATE_START,
          SMS_SENDER_NAME
                 
         )
              VALUES (pREC.phone,
                      pREC.MESSAGE,
                      prec.sms_id,
                      pREC.insert_date,
                      pREC.insert_date,
                      pREC.update_date,
                      'Max request count:' || pREC.result_str,
                      pREC.status_code,
                      pREC.ERROR_CODE,
                      pREC.description_str,
                      SYSDATE,
                      pREC.req_count,
                      prec.date_start,
                      pREC.SMS_SENDER_NAME
                      );

         COMMIT;
      END IF;
   END LOOP;

   CLOSE cur;
END;
/
