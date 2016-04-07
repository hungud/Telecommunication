
  CREATE OR REPLACE PROCEDURE "LONTANA"."SMS_REQUEST_AFR" (pStreamID INTEGER DEFAULT -1, pNewSMS INTEGER DEFAULT 0)
IS
   --
   --Version=10
   --
   --v.10 Афросин А. 28.10.2015 - переделал отправку смс на отправку пачками
   --v.9 Алексеев А. 21.10.2015 - Убрал отправку через провайдера. 
   --                             Если смс через шлюз не ушла, то данная смс отправляться не будет, по ним шлются ошибки на почту клиента.
   --v.8 Афрсоин А. 20.08.2015 - Добавил сортровку по статусу и дате вставки записи
   --v.7 Матюнин И. 14.07.2015 - Добавил параметр pNewSMS для разделеия режимов отправки смс и получения статусов отосланных смс
   --v.6 Афросин 30.05.2015 - Не верно записывался sms_id при Max request count, не писался код ошибк
   --v.5 Афросин 26.03.2015 - Разбио на 5 потоков
   --v.4 Афросин 25.03.2015 - Разбио на 10 потоков
   --v.3 Афросин 24.03.2015 - Добавил проверку: если смс не имеет статуса "Доставлено", то пытаемся ее отправить через смс - провайдера
   --v.2 Афросин 19.03.2015 Разбил на потоки
   --
   PRAGMA AUTONOMOUS_TRANSACTION;
   --cMAX_STREAM_COUNT   CONSTANT INTEGER := 5;
   cMAX_SMS_COUNT CONSTANT INTEGER := 7;
   prov_id  INTEGER;
/*
   CURSOR C
   IS
      SELECT
        ssp.LOGIN,
        ssp.PASSWORD,
        ssp.SENDER_NAME
      FROM
        SMS_SEND_PARAMETRS ssp
      WHERE
        ssp.provider_id = prov_id;
*/
   --
   

   CURSOR CUR_NEW_SORT (pcNewSMS integer)
   IS
        select * from
        (
          SELECT ROWID as "ROWID",
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
         WHERE     sc.date_start <= SYSDATE
               --AND (   (MOD (TO_NUMBER (PHONE), cMAX_STREAM_COUNT) = pStreamID)
              --      OR (pStreamID = -1))
               
               AND (   (    sc.status_code = 99
                        AND (   sc.ERROR_CODE = 0
                             OR sc.ERROR_CODE IS NULL
                             OR (    sc.ERROR_CODE IN (6,
                                                       7,
                                                       43,
                                                       40)
                                 AND sc.update_date < SYSDATE - 1 / 1440 / 2))
                        AND pcNewSMS IN (0, 1) --0 чтоб работало как и раньше, 1 - только новые смс
                                             )
                    OR (    sc.status_code IN (0, 1)
                        AND sc.update_date < SYSDATE - 1 / 1440 / 2
                        AND pcNewSMS IN (0, 2) --0 чтоб работало как и раньше, 2 - только опрашивать статус смс
                        and SC.date_start >  sysdate-8/24 --статусы проверяем тольоко у смс с датой отправки не более 8 часов назад
                        
                        ))
      ORDER BY status_code desc, insert_date desc
      )
      where rownum <= cMAX_SMS_COUNT
      
      ;
      
   CURSOR CUR_STASTUS (pcNewSMS integer)
   IS
        select * from
        (
          SELECT ROWID as "ROWID",
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
         WHERE     sc.date_start <= SYSDATE
               --AND (   (MOD (TO_NUMBER (PHONE), cMAX_STREAM_COUNT) = pStreamID)
              --      OR (pStreamID = -1))
               
               AND (   (    sc.status_code = 99
                        AND (   sc.ERROR_CODE = 0
                             OR sc.ERROR_CODE IS NULL
                             OR (    sc.ERROR_CODE IN (6,
                                                       7,
                                                       43,
                                                       40)
                                 AND sc.update_date < SYSDATE - 1 / 1440 / 2))
                        AND pcNewSMS IN (0, 1) --0 чтоб работало как и раньше, 1 - только новые смс
                                             )
                    OR (    sc.status_code IN (0, 1)
                        AND sc.update_date < SYSDATE - 1 / 1440 / 2
                        AND pcNewSMS IN (0, 2) --0 чтоб работало как и раньше, 2 - только опрашивать статус смс
                        and SC.date_start >  sysdate-8/24 --статусы проверяем тольоко у смс с датой отправки не более 8 часов назад
                        
                        ))
      ORDER BY status_code asc, insert_date desc
      )
      where rownum <= cMAX_SMS_COUNT
      
      ;

  pANSWER                      VARCHAR2 (2000 CHAR);
  pSTATUS_CODE                 INTEGER;
  v_SMS_SENDER_NAME varchar2(500 char); 
   
  l_phone strArray;
  l_out strArray;
  l_message strArray;
  l_message_id strArray;
  l_status_code strArray;
  
  
  i Integer;
  
  TYPE T_ROWID IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
  TYPE T_statusCode  IS TABLE OF SMS_CURRENT.STATUS_CODE%TYPE  INDEX BY BINARY_INTEGER;
  TYPE T_req_count  IS TABLE OF  SMS_CURRENT.REQ_COUNT%TYPE INDEX BY BINARY_INTEGER;
  TYPE T_sms_id  IS TABLE OF  SMS_CURRENT.sms_id%TYPE INDEX BY BINARY_INTEGER;
  TYPE T_date_start  IS TABLE OF  SMS_CURRENT.date_start%TYPE INDEX BY BINARY_INTEGER;
  TYPE T_SMS_SENDER_NAME  IS TABLE OF SMS_CURRENT.SMS_SENDER_NAME%TYPE INDEX BY BINARY_INTEGER;
  
  TYPE T_insert_date  IS TABLE OF SMS_CURRENT.insert_date%TYPE INDEX BY BINARY_INTEGER;
  TYPE T_update_date  IS TABLE OF SMS_CURRENT.update_date%TYPE INDEX BY BINARY_INTEGER;
  
  TYPE T_ERROR_CODE  IS TABLE OF SMS_CURRENT.ERROR_CODE%TYPE INDEX BY BINARY_INTEGER;
  TYPE T_result_str  IS TABLE OF SMS_CURRENT.result_str%TYPE INDEX BY BINARY_INTEGER;
  
  l_statusCode T_statusCode;
  l_req_count T_req_count;
  l_sms_id T_sms_id;
  l_date_start T_date_start;
  l_SMS_SENDER_NAME T_SMS_SENDER_NAME;
  l_insert_date T_insert_date;
  l_update_date T_update_date;
  l_ERROR_CODE T_ERROR_CODE;
  l_result_str T_result_str;
  
  
  l_rowid T_ROWID;
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
   

   CURSOR st (pSTATUS IN VARCHAR2)
   IS
      SELECT STATUS_CODE
        FROM sms_status
       WHERE MESSAGE = pSTATUS;

   st_dummy                     st%ROWTYPE;
   vSMS_ID                      INTEGER;
   vSMS_TRAFFIC                 VARCHAR2 (2000 CHAR);

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
BEGIN
   
   
  l_phone := strArray();
  l_message := strArray();
  l_message_id := strArray();
  l_status_code := strArray();
  l_rowid.DELETE;
  l_out := strArray();
  l_statusCode.Delete;
  l_req_count.Delete; 
  l_sms_id.Delete;
  l_date_start.Delete;
  l_SMS_SENDER_NAME.Delete;
  l_insert_date.DElete;
  l_update_date.Delete;
  
  l_ERROR_CODE.Delete;
  l_result_str.Delete;
  
  
  
  i := 1;
  if pNewSMS in (0, 1) then
    for c in CUR_NEW_SORT(pNewSMS) loop
      l_phone.extend;
      l_message.extend;
      l_message_id.extend;
      l_status_code.extend;
                  
      l_phone(i) := c.phone ;
      l_message (i) := c.MESSAGE;
      l_message_id(i) := c.sms_id;
      l_status_code(i) := c.status_code;
                  
      l_rowid(i) := c.ROWID;
      l_statusCode(i) := c.status_code;
      l_req_count(i) := c.req_count;
      l_sms_id(i) := c.sms_id;
                  
                  
      l_date_start(i) := c.date_start;
      l_SMS_SENDER_NAME(i) := c.SMS_SENDER_NAME;
      l_insert_date(i) := c.insert_date;
      l_update_date(i) := c.update_date;
                  
      l_ERROR_CODE(i) := c.ERROR_CODE;
      l_result_str(i) := c.result_str;
                  
      i := i +1;
    end loop;
  else
    for c in CUR_STASTUS(pNewSMS) loop
      l_phone.extend;
      l_message.extend;
      l_message_id.extend;
      l_status_code.extend;
                    
      l_phone(i) := c.phone ;
      l_message (i) := c.MESSAGE;
      l_message_id(i) := c.sms_id;
      l_status_code(i) := c.status_code;
                    
      l_rowid(i) := c.ROWID;
      l_statusCode(i) := c.status_code;
      l_req_count(i) := c.req_count;
      l_sms_id(i) := c.sms_id;
                    
                    
      l_date_start(i) := c.date_start;
      l_SMS_SENDER_NAME(i) := c.SMS_SENDER_NAME;
      l_insert_date(i) := c.insert_date;
      l_update_date(i) := c.update_date;
                    
      l_ERROR_CODE(i) := c.ERROR_CODE;
      l_result_str(i) := c.result_str;
                    
      i := i +1;
    end loop;
  end if;
   
   
   
  if i > 1 then
    SEND_CHECK_STATUS_SMS_ARRAY(l_phone, l_message, l_message_id, l_status_code, '217.118.84.12', 3340, '717100', 'O6q^>W)\', '&'||'GSMCorp', 'CMT', l_out);
    
    for i in l_rowid.first .. l_rowid.last loop
      pANSWER := l_out(i);
      v_rowid := l_rowid(i);
      v_req_count := l_req_count(i) + 1;
      v_phone := l_phone(i);
      v_message := l_message (i);
      v_sms_id := l_sms_id(i);
      v_date_start := l_date_start(i);
      v_SMS_SENDER_NAME := l_SMS_SENDER_NAME(i);
      v_insert_date := l_insert_date(i);
      v_update_date := l_update_date(i);
      v_ERROR_CODE := l_ERROR_CODE(i);
      v_result_str := l_result_str(i);
      v_status_code := l_statusCode(i);
      
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
  end if;
   
   COMMIT;
END;