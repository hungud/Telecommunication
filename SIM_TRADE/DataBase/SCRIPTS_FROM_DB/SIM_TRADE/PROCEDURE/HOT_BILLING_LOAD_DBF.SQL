
  CREATE OR REPLACE PROCEDURE "SIM_TRADE"."HOT_BILLING_LOAD_DBF" 
IS
--
--Version=2
--
--v.2 Афросин сделал проверку по load_date 
--
   CURSOR curf
   IS
        SELECT ROWID, hbf.file_name, hbf.hbf_id
          FROM HOT_BILLING_FILES hbf
         WHERE hbf.load_edate IS NULL --     and hbf.hbf_id=3287
                                      --     and mod(hbf.hbf_id,4)=2
               AND SUBSTR (hbf.file_name, -3) = 'dbf'
      ORDER BY hbf.hbf_id;

   rowi      ROWID;
   filen     VARCHAR2 (50);
   hbf_idp   FLOAT;
BEGIN
   OPEN curf;

   LOOP
      FETCH curf INTO rowi, filen, hbf_idp;

      EXIT WHEN curf%NOTFOUND;

      UPDATE HOT_BILLING_FILES hbf
         SET hbf.load_sdate = SYSDATE
       WHERE ROWID = rowi;

      COMMIT;
      dbase_pkg.load_table (
         p_dir        => 'DBF_FILES',
         p_file       => filen,
         p_tname      => 'HOT_BILLING_TEMP_CALL',
         p_dbf_id     => hbf_idp,
         p_cnames     => 'SUBSCR_NO,CH_SEIZ_DT,AT_FT_CODE,AT_CHG_AMT,CALLING_NO,DURATION,DATA_VOL,IMEI,CELL_ID,DIALED_DIG,AT_FT_DESC',
         p_colnames   => 'SUBSCR_NO,CH_SEIZ_DT,AT_FT_CODE,AT_CHG_AMT,CALLING_NO,DURATION,DATA_VOL,IMEI,CELL_ID,DIALED_DIG,AT_FT_DESC',
         p_show       => FALSE);

      UPDATE HOT_BILLING_FILES hbf
         SET hbf.load_edate = SYSDATE
       WHERE ROWID = rowi;

      COMMIT;
   END LOOP;

   CLOSE curf;
END;