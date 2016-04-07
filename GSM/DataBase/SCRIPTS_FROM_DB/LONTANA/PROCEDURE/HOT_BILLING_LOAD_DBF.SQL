
  CREATE OR REPLACE PROCEDURE "LONTANA"."HOT_BILLING_LOAD_DBF" 
IS
   --
   --Version=4
   --
   --v.4 Афросин 28.04.2015 Добавил пропуск загрузки файлов в базу, если уже были попытки его загрузить
   --                      Добавил оповещение по Email, если произошли ошибки во првемя загрузки
   --v.3 Афросин 10.12.2014 сделал проверку на корректность загруженных строк (некорректные строки удаляем)
   --v.2 Афросин сделал проверку по load_date
   --
   CURSOR curf
   IS
        SELECT ROWID, hbf.file_name, hbf.hbf_id
          FROM HOT_BILLING_FILES hbf
         WHERE hbf.load_edate IS NULL               --     and hbf.hbf_id=3287
                                      --     and mod(hbf.hbf_id,4)=2
               AND SUBSTR (hbf.file_name, -3) = 'dbf'
               AND nvl(HBF.LOAD_COUNT, 0) = 0
      ORDER BY hbf.hbf_id;

   rowi             ROWID;
   filen            VARCHAR2 (50);
   hbf_idp          FLOAT;
   vDEL_ROW_COUNT   INTEGER;
BEGIN
   OPEN curf;

   LOOP
      FETCH curf INTO rowi, filen, hbf_idp;

      EXIT WHEN curf%NOTFOUND;

      BEGIN
        UPDATE HOT_BILLING_FILES hbf
           SET hbf.load_sdate = SYSDATE
         WHERE ROWID = rowi;

        COMMIT;
        dbase_pkg.load_table (
           p_dir        => 'DBF_FILES_COPY_DBF',
           p_file       => filen,
           p_tname      => 'HOT_BILLING_TEMP_CALL',
           p_dbf_id     => hbf_idp,
           p_cnames     => 'SUBSCR_NO,CH_SEIZ_DT,AT_FT_CODE,AT_CHG_AMT,CALLING_NO,DURATION,DATA_VOL,IMEI,CELL_ID,DIALED_DIG,AT_FT_DESC',
           p_colnames   => 'SUBSCR_NO,CH_SEIZ_DT,AT_FT_CODE,AT_CHG_AMT,CALLING_NO,DURATION,DATA_VOL,IMEI,CELL_ID,DIALED_DIG,AT_FT_DESC',
           p_show       => FALSE);

        vDEL_ROW_COUNT := null;

        --    УДАЛЯЕМ ЗАПИСИ КОТОРЫЕ НЕ КОРРЕКНЫ
        DELETE FROM hot_billing_temp_call htc
              WHERE    HTC.DBF_ID = hbf_idp AND (htc.ch_seiz_dt IS NULL
                    OR htc.ch_seiz_dt NOT LIKE ('20%')
                    OR (NOT REGEXP_LIKE (duration, '[0-9]')))
             RETURN COUNT (*)
               INTO vDEL_ROW_COUNT;

        COMMIT;

        

        UPDATE HOT_BILLING_FILES hbf
           SET hbf.load_edate = SYSDATE, 
           HBF.DEL_ROW_COUNT = nvl(vDEL_ROW_COUNT, 0),
           HBF.LOAD_COUNT = nvl(HBF.LOAD_COUNT, 0) + 1
         WHERE ROWID = rowi;
         
        COMMIT;
      EXCEPTION
        WHEN OTHERS THEN
          UPDATE HOT_BILLING_FILES hbf
             SET HBF.LOAD_COUNT = nvl(HBF.LOAD_COUNT, 0) + 1
           WHERE ROWID = rowi;
          COMMIT;
                   
          send_sys_mail(sys_context('userenv','CURRENT_SCHEMA')||' Ошибка при загрузке файла', ' Ошибка при загрузке файла: '|| filen|| '<br> Текст ошибки:<br>'||SQLERRM, 'TARIFER_SUPPORT_MAIL');
      END;
   END LOOP;

   CLOSE curf;
END;