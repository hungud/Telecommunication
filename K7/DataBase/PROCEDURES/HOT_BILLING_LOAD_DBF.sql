CREATE OR REPLACE PROCEDURE HOT_BILLING_LOAD_DBF IS
--Version=7
--
--7. 2015.11.26. Крайнов. Добавил загрузку столбцов AT_SOC, PC_PLAN_CD, C_ACT_CD, MESSAGE_TP, SRV_FT_CD, UOM, DISCT_SOCS
--v.6 Афросин 18.06.2015 Добавил загрузку столбца PROV_ID
--v.5 Афросин 28.04.2015 Добавил пропуск загрузки файлов в базу, если уже были попытки его загрузить
--                      Добавил оповещение по Email, если произошли ошибки во првемя загрузки
--v.4 Афросин 25.03.2015 вставил HOT_BILLING_ALARM_PHONE
--v.3 Афросин 10.12.2014 сделал проверку на корректность загруженных строк (некорректные строки удаляем)
--v.2 Афросин сделал проверку по load_date
--
  CURSOR curf IS
    SELECT ROWID, hbf.file_name, hbf.hbf_id
      FROM HOT_BILLING_FILES hbf
      WHERE hbf.load_edate IS NULL         
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
         p_dir        => 'DBF_FILES',
         p_file       => filen,
         p_tname      => 'HOT_BILLING_TEMP_CALL',
         p_dbf_id     => hbf_idp,
         p_cnames     => 'SUBSCR_NO,CH_SEIZ_DT,AT_SOC,AT_FT_CODE,PC_PLAN_CD,C_ACT_CD,AT_CHG_AMT,CALLING_NO,MESSAGE_TP,SRV_FT_CD,DURATION,DATA_VOL,IMEI,CELL_ID,PROV_ID,DIALED_DIG,UOM,DISCT_SOCS,AT_FT_DESC',
         p_colnames   => 'SUBSCR_NO,CH_SEIZ_DT,AT_SOC,AT_FT_CODE,PC_PLAN_CD,C_ACT_CD,AT_CHG_AMT,CALLING_NO,MESSAGE_TP,SRV_FT_CD,DURATION,DATA_VOL,IMEI,CELL_ID,PROV_ID,DIALED_DIG,UOM,DISCT_SOCS,AT_FT_DESC',
         p_show       => FALSE);
      vDEL_ROW_COUNT := null;
      --Удаляем записи которые не коррекны
      DELETE FROM hot_billing_temp_call htc
        WHERE HTC.DBF_ID = hbf_idp 
          AND (htc.ch_seiz_dt IS NULL
              OR htc.ch_seiz_dt NOT LIKE ('20%')
              OR (NOT REGEXP_LIKE (duration, '[0-9]')))
        RETURN COUNT (*) INTO vDEL_ROW_COUNT;
      COMMIT; 
      UPDATE HOT_BILLING_FILES hbf
        SET hbf.load_edate = SYSDATE, 
            HBF.DEL_ROW_COUNT = nvl(vDEL_ROW_COUNT, 0),
            HBF.LOAD_COUNT = nvl(HBF.LOAD_COUNT, 0) + 1
        WHERE ROWID = rowi;
      -- Оправляем номера на подсчет статистики     
      for rec in (select distinct subscr_no  
                    from hot_billing_temp_call 
                    where dbf_id = hbf_idp)
      loop
        HOT_BILLING_ALARM_PHONE(rec.subscr_no, hbf_idp);     
      end loop;
      COMMIT;
    EXCEPTION
      WHEN OTHERS THEN
        UPDATE HOT_BILLING_FILES hbf
          SET HBF.LOAD_COUNT = nvl(HBF.LOAD_COUNT, 0) + 1
          WHERE ROWID = rowi;
        COMMIT;                     
        send_sys_mail(sys_context('userenv', 'CURRENT_SCHEMA')||' Ошибка при загрузке файла', 
          'Ошибка при загрузке файла: '|| filen|| '<br> Текст ошибки:<br>'||SQLERRM, 'TARIFER_SUPPORT_MAIL');
    END;
  END LOOP;
  CLOSE curf;
END;
/