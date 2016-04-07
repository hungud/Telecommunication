
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."HOT_BILLING_SAVE_CALL_MM2" (mons in date) IS
  cur_g      SYS_REFCURSOR;
  NEW_SUBSCR VARCHAR2(11);
  subscr     varchar2(11);
  cf         utl_file.file_type;
  DIRECTORYP varchar2(50);
    DIRDb  varchar2(200):='\\10.176.1.10\share_ditrade\Tarifer\DB\';
  vPREV_FILE VARCHAR2(100);
  vFILE_NAME VARCHAR2(100);
  vDATA VARCHAR2(1000);
  vTEMP_DATA VARCHAR2(32000);
  --
  PROCEDURE FLUSH_DATA IS
  BEGIN
    IF vTEMP_DATA IS NOT NULL THEN
      -- Удалим хвостовой перевод строки
      vTEMP_DATA := SUBSTR(vTEMP_DATA, 1, LENGTH(vTEMP_DATA)-2);
      utl_file.put_line(cf, CONVERT(vTEMP_DATA, 'CL8MSWIN1251'));
      vTEMP_DATA := NULL;
    END IF;
  END;
  --
  PROCEDURE CLOSE_FILE IS
    DIRDbP  varchar2(200);
    NEW_FILE_NAME VARCHAR2(200);
    OLD_FILE_NAME VARCHAR2(200);
  BEGIN
    utl_file.fclose(cf);
    DIRDbP:=DIRDb||to_char(mons,'yyyy_mm')||'\'||GET_login_BY_PHONE_M(subscr,mons)||'\';
    NEW_FILE_NAME := DIRDbP||subscr||'.txt';
    OLD_FILE_NAME := '\\10.176.1.10\share_ditrade\Tarifer\DB\'||'T'||subscr||'.txt';
    pkg_fileutil.pr_FileMove(OLD_FILE_NAME, NEW_FILE_NAME);
  END;
  --
BEGIN
  vPREV_FILE := '0';
  DIRECTORYP := 'CALLSMM';
  OPEN cur_g FOR 'select tcs.subscr_no,
    tcs.subscr_no||chr(9)||tcs.call_date||chr(9)||tcs.call_time||chr(9)||
    tcs.SERVICETYPE||chr(9)||tcs.servicedirection||chr(9)||decode(tcs.subscr_no,tcs.calling_no,tcs.dialed_dig,tcs.calling_no)||chr(9)||
    decode(tcs.servicetype,''G'',tcs.data_vol,tcs.dur)||chr(9)||tcs.call_cost||chr(9)||tcs.isroaming||chr(9)||tcs.roamingzone||chr(9)||
    tcs.AT_FT_DE||chr(9)||TRIM( BOTH chr(13) FROM tcs.cell_id)||chr(9)||tcs.costnovat||chr(9)||(select max(bb.zone_name) from beeline_bs_zones bb
    where bb.beeline_bs_zone_id=TRIM( BOTH chr(13) FROM tcs.cell_id)) || CHR(10) AS DATA
    from CALL_'||to_char(mons,'mm_yyyy')||' tcs
    order by tcs.subscr_no, tcs.start_time 
    ';
  LOOP
    FETCH cur_g INTO NEW_SUBSCR, vDATA;
    EXIT WHEN cur_g%NOTFOUND;
    vFILE_NAME := 'T'||NEW_SUBSCR || '.txt';
    IF vFILE_NAME <> vPREV_FILE THEN
      IF vPREV_FILE <> '0' THEN
        -- Сохраним накопленные данные
        FLUSH_DATA;
        -- Закроем и переименуем файл
        CLOSE_FILE;
      END IF;
      -- Открываем новый файл на запись
      SUBSCR := NEW_SUBSCR;
      cf := utl_file.fopen(DIRECTORYP, vFILE_NAME, 'W');
      vPREV_FILE := vFILE_NAME;
    END IF;
    -- Добавим строку в буфер
    vTEMP_DATA := vTEMP_DATA || vDATA;
    -- Запишем из буфера в файл, если нужно
    IF LENGTH(vTEMP_DATA) > 6000 THEN
      FLUSH_DATA;
    END IF;
  END LOOP;
  -- сохраним остатки (если есть)
  FLUSH_DATA;
  -- Закроем и переименуем файл
  CLOSE_FILE;
end; 