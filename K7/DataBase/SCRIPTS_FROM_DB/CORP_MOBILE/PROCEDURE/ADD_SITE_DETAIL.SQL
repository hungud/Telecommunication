
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."ADD_SITE_DETAIL" (pPHONE_NUMBER    IN VARCHAR2,
                                             pLOADING_YEAR    IN VARCHAR2,
                                             pLOADING_MONTH   IN VARCHAR2)
IS
--
--Version=2
--
--
--v.2 Афросин 18.06.2015 Добавил перечень столбцов во вставку в таблицу hot_billing_temp_call
--
BEGIN
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
    SELECT
      subscr_no,
      ch_seiz_dt,
      at_ft_code,
      at_chg_amt,
      calling_no,
      duration,
      data_vol,
      imei,
      cell_id,
      dialed_dig,
      at_ft_desc,
      dbf_id  
        FROM TABLE (
                clob_to_pipeHB (TO_NUMBER (pLOADING_YEAR),
                                TO_NUMBER (pLOADING_MONTH),
                                pPHONE_NUMBER));

   COMMIT;
END;