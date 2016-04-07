CREATE OR REPLACE PROCEDURE UPDATE_SMS_STATE (
                                                p_rowid varchar2,
                                                pANSWER varchar2
                                              ) as

--
--#Version=1
--
--
--v.1 Афросин 30.10.2015 Процедура для обновления статусов смс и перемещения ее в SMS log
--
  CURSOR CUR_NEW_SORT (pcRowID ROWID) is
    SELECT ROWID ,
               sc.provider_id,
               sc.phone phone,
               sc.MESSAGE,
               sc.sms_id,
               sc.status_code,
               sc.ERROR_CODE,
               nvl(sc.req_count, 0) req_count,
               sc.insert_date,
               sc.update_date,
               sc.result_str,
               sc.description_str,
               sc.date_start,
               SC.SMS_SENDER_NAME
          FROM SMS_CURRENT SC
         WHERE    rowid = pcRowID;
   
   
   CURSOR st (pSTATUS IN VARCHAR2)
   IS
      SELECT STATUS_CODE
        FROM sms_status
       WHERE MESSAGE = pSTATUS;

  st_dummy                     st%ROWTYPE;
  vSMS_ID                      INTEGER;
  vSMS_TRAFFIC                 VARCHAR2 (2000 CHAR);

  v_SMS_SENDER_NAME varchar2(500 char);
  v_rowid ROWID;
  v_req_count  SMS_CURRENT.REQ_COUNT%TYPE;
  v_phone varchar2(20 char);
  v_message varchar2(500 char);
  v_sms_id SMS_CURRENT.sms_id%TYPE;
  v_date_start SMS_CURRENT.date_start%type;
  v_insert_date SMS_CURRENT.insert_date%type;
  v_update_date SMS_CURRENT.update_date%type;
  
  v_ERROR_CODE SMS_CURRENT.ERROR_CODE%type;
  v_result_str SMS_CURRENT.result_str%type;
  v_status_code SMS_CURRENT.status_code%type;
  pSTATUS_CODE                 INTEGER;
  
   --
   --процедура для вставки смс в SMS_LOG и удаления из SMS_CURRENT
   PROCEDURE CHANGE_SMS_LOCATION (
      pPHONE                      SMS_LOG.PHONE%TYPE,
      pMESSAGE                    SMS_LOG.MESSAGE%TYPE,
      pSMS_ID                     SMS_LOG.SMS_ID%TYPE,
      pSLERROR_CODE               SMS_LOG.SLERROR_CODE%TYPE,
      pSLERROR                    SMS_LOG.SLERROR%TYPE,
      pINSERT_DATE                SMS_LOG.INSERT_DATE%TYPE,
      pREQ_COUNT                  SMS_LOG.REQ_COUNT%TYPE,
      pDATE_START                 SMS_LOG.DATE_START%TYPE,
      pSMS_SENDER_NAME            SMS_LOG.SMS_SENDER_NAME%TYPE,
      pSTATUS                     SMS_LOG.STATUS%TYPE,
      pStatusCode                 SMS_LOG.STATUS_CODE%TYPE,
      pSUBMITION_DATE             SMS_LOG.SUBMITION_DATE%TYPE,
      pSEND_DATE                  SMS_LOG.SEND_DATE%TYPE,
      pLAST_STATUS_CHANGE_DATE    SMS_LOG.LAST_STATUS_CHANGE_DATE%TYPE,
      pNeedDelete                 INTEGER,
      pRowId                      ROWID)
   AS
      ITOG   VARCHAR2 (500);
   BEGIN
      IF NVL (pNeedDelete, 0) = 1
      THEN
         DELETE SMS_CURRENT sc
          WHERE sc.ROWID = pRowId;
      END IF;


      INSERT INTO sms_log (PHONE,
                           MESSAGE,
                           SMS_ID,
                           SLERROR_CODE,
                           SLERROR,
                           INSERT_DATE,
                           REQ_COUNT,
                           DATE_START,
                           SMS_SENDER_NAME,
                           STATUS,
                           STATUS_CODE,
                           SUBMITION_DATE,
                           SEND_DATE,
                           LAST_STATUS_CHANGE_DATE)
           VALUES (pPHONE,
                   pMESSAGE,
                   pSMS_ID,
                   pSLERROR_CODE,
                   pSLERROR,
                   pINSERT_DATE,
                   pREQ_COUNT,
                   pDATE_START,
                   pSMS_SENDER_NAME,
                   pSTATUS,
                   pStatusCode,
                   pSUBMITION_DATE,
                   pSEND_DATE,
                   pLAST_STATUS_CHANGE_DATE);

      -- если смс не имеет статуса "Доставлено", то пробуем отправить смс через смс провайдера
      /*IF NVL (pStatusCode, -1) <> 2
      THEN
         ITOG :=
            LOADER3_PCKG.SEND_SMS (pPHONE,
                                   '',
                                   pMESSAGE,
                                   0,
                                   pSMS_SENDER_NAME,
                                   1);
      END IF;*/

      COMMIT;
   END;
  
--  pSTATUS_CODE                 INTEGER;
   

BEGIN
   
    v_rowid := CHARTOROWID(p_rowid);
    for c in CUR_NEW_SORT(v_rowid)  loop
      --pANSWER := l_out(i);
      v_rowid := c.ROWID;
      v_req_count := c.req_count + 1;
      v_phone := c.phone;
      v_message := c.message;
      v_sms_id := c.sms_id;
      v_date_start := c.date_start;
      v_SMS_SENDER_NAME := c.SMS_SENDER_NAME;
      v_insert_date := c.insert_date;
      v_update_date := c.update_date;
      v_ERROR_CODE := c.ERROR_CODE;
      v_result_str := c.result_str;
      v_status_code := c.status_code;
      
    
      /*
      insert into sms_afr (phone, message , sms_is, status_code) values
        (v_phone, v_message, pANSWER, v_status_code);
      */
      IF v_req_count < TO_NUMBER (MS_params.GET_PARAM_VALUE ('SMS_REQ_COUNT')) THEN
        IF (pANSWER IS NOT NULL) AND (INSTR (pANSWER, '0000') = 0)THEN
          IF v_status_code = 99 THEN
            BEGIN
              
              IF INSTR (pANSWER, ';') = 0 THEN
                vSMS_ID := TO_NUMBER (pANSWER);
              ELSE
                -- Первый кусок СМС, обычно статус UNDELIVERABLE
                /*vSMS_ID:=to_number(substr(pANSWER,
                                           instr(pANSWER, ';', 1, 1)+2,
                                           instr(pANSWER, ';', 1,2)-instr(pANSWER, ';', 1, 1)-3));*/
                -- Последний кусок СМС, проверяем его статус
                vSMS_ID := TO_NUMBER (SUBSTR (
                                              pANSWER,
                                              INSTR (pANSWER, ';', -1, 1) + 2,
                                              LENGTH (pANSWER) - INSTR (pANSWER, ';', -1, 1)- 1
                                             )
                                     );
              END IF;

              UPDATE SMS_CURRENT sc
                 SET sc.status_code = 0,
                     sc.sms_id = vSMS_ID,
                     sc.req_count = sc.req_count + 1
               WHERE SC.ROWID = v_rowid;

              COMMIT;
            EXCEPTION
              WHEN OTHERS THEN
                UPDATE SMS_CURRENT sc
                  SET sc.req_count = sc.req_count + 1
                  WHERE SC.ROWID = v_rowid;

                 IF v_req_count = 2 THEN
                    CHANGE_SMS_LOCATION (v_phone,
                                         v_message,
                                         v_sms_id,
                                         40,
                                         pANSWER,
                                         SYSDATE,
                                         v_req_count,
                                         v_date_start,
                                         v_SMS_SENDER_NAME,
                                         NULL,
                                         NULL,
                                         NULL,
                                         NULL,
                                         NULL,
                                         1,
                                         v_rowid);
                 --                       COMMIT;
                 END IF;
            END;
          ELSE
            OPEN st (pANSWER);

            FETCH st INTO st_dummy;

            IF st%FOUND
            THEN
               pSTATUS_CODE := st_dummy.STATUS_CODE;
            ELSE
               pSTATUS_CODE := -1;
            END IF;

            CLOSE st;

             
             IF pSTATUS_CODE IN ('0', '1') THEN
                UPDATE SMS_CURRENT sc
                   SET sc.status_code = pSTATUS_CODE,
                       sc.DESCRIPTION_STR = pANSWER,
                       sc.ERROR_CODE = 0
                 WHERE sc.ROWID = v_rowid;

                COMMIT;
             --          end if;
             ELSE
                IF pSTATUS_CODE <> -1 THEN
                   --смс отправленные без ошибок
                   CHANGE_SMS_LOCATION (v_phone,
                                        v_message,
                                        v_sms_id,
                                        NULL,
                                        NULL,
                                        SYSDATE,
                                        v_req_count,
                                        v_date_start,
                                        v_SMS_SENDER_NAME,
                                        pANSWER,
                                        pSTATUS_CODE,
                                        NULL,
                                        NULL,
                                        NULL,
                                        1,
                                        v_rowid);
                --                     COMMIT;
                END IF;
             END IF;
          END IF;
        ELSE
          IF v_req_count <
                TO_NUMBER (MS_params.GET_PARAM_VALUE ('SMS_REQ_COUNT'))
          THEN
             UPDATE SMS_CURRENT sc
                SET sc.req_count = sc.req_count + 1
              WHERE sc.ROWID = v_rowid;

             COMMIT;
          ELSE
             CHANGE_SMS_LOCATION (v_phone,
                                  v_message,
                                  v_sms_id,
                                  NULL,
                                  NULL,
                                  SYSDATE,
                                  v_req_count + 1,
                                  v_date_start,
                                  v_SMS_SENDER_NAME,
                                  'Max request count:' || pANSWER,
                                  NULL,
                                  v_insert_date,
                                  v_insert_date,
                                  v_update_date,
                                  1,
                                  v_rowid);
          --               COMMIT;
          END IF;
        END IF;
      ELSE
         CHANGE_SMS_LOCATION (v_phone,
                              v_message,
                              v_sms_id,
                              v_ERROR_CODE,
                              pANSWER,
                              SYSDATE,
                              v_req_count,
                              v_date_start,
                              v_SMS_SENDER_NAME,
                              'Max request count:' || v_result_str,
                              v_status_code,
                              v_insert_date,
                              v_insert_date,
                              v_update_date,
                              1,
                              v_rowid);
      --         COMMIT;
      END IF;
    end loop;
   
   COMMIT;
END;