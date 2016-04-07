
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."LOAD_CDR_CALL" 
IS
--
--Version=2
--
--
--v.2 Афросин 18.06.2015 Добавил перечень столбцов во вставку в таблицу hot_billing_temp_call
--
   req             UTL_HTTP.req;                                      --запрос
   resp            UTL_HTTP.resp;                                      --ответ
   s_url           VARCHAR2 (256);
   response_env    VARCHAR2 (4000);
   TempField       VARCHAR2 (4000) := '';
   saTail          VARCHAR2 (4000) := '';
   RecCount        INTEGER;
   max_id_call     NUMBER := 0;

   pid_call        NUMBER := 0;
   pcall_start     VARCHAR2 (16);                                      --date;
   pcall_end       VARCHAR2 (16);
   pnum_from       VARCHAR2 (21);
   pnum_to         VARCHAR2 (21);
   pduration       NUMBER;
   pdur            VARCHAR2 (8);
   pcost           NUMBER;
   ptarif_prefix   VARCHAR2 (21);
   pat_ft_code     VARCHAR2 (6);
BEGIN
   max_id_call := TO_NUMBER (MS_params.GET_PARAM_VALUE ('CALL_BACK_MAXIC'));

   SELECT MAX (id_call) INTO max_id_call FROM cdr_call;

   BEGIN
      s_url :=
         'http://5.9.175.165:83/ftasksres?phone_number=5:' || max_id_call;

      req := UTL_HTTP.begin_request (s_url);
      UTL_HTTP.set_body_charset (req, 'UTF-8');
      resp := UTL_HTTP.get_response (req);
      UTL_HTTP.read_text (resp, response_env);
      response_env :=
         SUBSTR (
            response_env,
            INSTR (response_env, '":"') + 3,
            INSTR (response_env, '"}') - INSTR (response_env, '":"') - 3);

      DBMS_OUTPUT.put_line (response_env);

      IF resp.status_code = '200'
      THEN
         FOR rec
            IN (SELECT SUBSTR ( (response_env || '#'),
                               2,
                               LENGTH ( (response_env || '#')))
                          AS cdrtext
                  FROM DUAL)
         LOOP
            TempField := rec.cdrtext;
            RecCount :=
               (LENGTH (rec.cdrtext) - LENGTH (REPLACE (rec.cdrtext, '#')));

            --   dbms_output.put_line('RecCount=' || RecCount);

            FOR n IN 1 .. RecCount
            LOOP
               BEGIN
                  saTail :=
                     SUBSTR (TempField,
                             1,
                               INSTR (TempField,
                                      '#',
                                      1,
                                      1)
                             - 1);
                  saTail :=
                     REPLACE (saTail, 'to_date(''', 'to_char(to_date(''');
                  saTail :=
                     REPLACE (saTail, ''')', '''),''yyyymmddhh24miss'')');

                  EXECUTE IMMEDIATE 'select ' || saTail || '  from dual'
                     --                              ' into :1, :2, :3, :4, :5, :6, :7, :8  from dual'
                     INTO pid_call,
                          pcall_start,
                          pcall_end,
                          pnum_from,
                          pnum_to,
                          pduration,
                          pcost,
                          ptarif_prefix;

                  --commit;
                  pdur :=
                     REPLACE (
                           '00'
                        || TO_CHAR (TRUNC (pduration / 60 / 60), '09')
                        || TO_CHAR (TRUNC (MOD (pduration, 3600) / 60), '09')
                        || TO_CHAR (MOD (MOD (pduration, 3600), 60), '09'),
                        ' ');

                  IF SUBSTR (pnum_from, -10) = SUBSTR (pnum_to, -10)
                  THEN
                     pat_ft_code := 'CBIN';
                  ELSE
                     pat_ft_code := 'CBOUT';
                  END IF;

                  INSERT INTO hot_billing_temp_call
                      (
                        SUBSCR_NO,
                        CH_SEIZ_DT,
                        AT_FT_CODE,
                        AT_CHG_AMT,
                        CALLING_NO,
                        DURATION,
                        DATA_VOL,
                        IMEI,
                        CELL_ID,
                        DIALED_DIG,
                        AT_FT_DESC,
                        DBF_ID   
                      
                      )
                       VALUES (SUBSTR (pnum_from, -10),
                               pcall_start,
                               pat_ft_code,
                               TRIM (TO_CHAR (pcost, '99999999990D99')),
                               SUBSTR (pnum_from, -10),
                               pdur,
                               '0,00',
                               NULL,
                               NULL,
                               pnum_to,
                               'Call Back',
                               76056);

                  pid_call :=
                     MS_params.SET_PARAM_VALUE ('CALL_BACK_MAXIC',
                                                TO_CHAR (pid_call));
                  -- dbms_output.put_line(n||' : saTail='||saTail);
                  COMMIT;
                  TempField :=
                     SUBSTR (TempField,
                               INSTR (TempField,
                                      '#',
                                      1,
                                      1)
                             + 1);
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     DBMS_OUTPUT.put_line (n || ' : sqlerrm=' || SQLERRM);
                     NULL;
               END;
            END LOOP;
         END LOOP;
      END IF;

      IF resp.status_code > 0
      THEN
         UTL_HTTP.END_RESPONSE (resp);
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         IF resp.status_code > 0
         THEN
            UTL_HTTP.END_RESPONSE (resp);
         END IF;

         NULL;
   END;
END;

--select * from cdr_temp