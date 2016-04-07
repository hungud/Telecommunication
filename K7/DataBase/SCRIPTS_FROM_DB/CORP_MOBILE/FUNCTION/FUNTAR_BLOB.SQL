
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."FUNTAR_BLOB" ( pFileIn in out VARCHAR2, 
                                        pdestfolder in out varchar2, 
                                        prezfile in out varchar2 ) RETURN VARCHAR2 is
  vResFile varchar2(1000);
  vResFile1 varchar2(1000);
  vResTmp varchar2(1000);
  vBlobOut BLOB;
  l_uncompressed_blob BLOB;
  vCmnDir varchar2(100) := 'ZIPDIRF1'; --'FZIPDIR';
  --
  function blob_to_file ( v_file_desc BLOB ) return varchar2
  is
  v_fhandle       UTL_FILE.file_type;
  vInFileTMP      varchar2(1000);
  v_xlen          PLS_INTEGER;
  my_vr           RAW(10000);
  i2              NUMBER                     := 1;
  i3              NUMBER                     := 10000;
  begin
    select to_char(systimestamp,'ddmmyyyyhh24missFF4')||'.dat' as ts
    into vInFileTMP from dual;
    IF DBMS_LOB.getlength(v_file_desc) > 0
    THEN
        v_fhandle :=
            UTL_FILE.fopen( vCmnDir, vInFileTMP, 'wb' ); -- 'WWW_DEALER_ZIP_TEMP_DIR'
        v_xlen := DBMS_LOB.getlength(v_file_desc);
        --
        IF v_xlen < 10000
        THEN
            DBMS_LOB.READ(v_file_desc, v_xlen, 1, my_vr);
            UTL_FILE.put_raw(v_fhandle, my_vr);
        ELSE
            --
            WHILE(i2 < v_xlen)
            LOOP
                DBMS_LOB.READ(v_file_desc, i3, i2, my_vr);
                UTL_FILE.put_raw(v_fhandle, my_vr);
                UTL_FILE.fflush(v_fhandle);
                i2 := i2 + 10000;
            END LOOP;
        END IF;
        -- 
        UTL_FILE.fflush(v_fhandle);
        UTL_FILE.fclose(v_fhandle);
    END IF;
    return vInFileTMP;
  end;
  --
  procedure FILE_TO_BLOB ( pOutFile in varchar2, pl_blob out BLOB )
  is
  l_bfile  BFILE;
  begin
    DBMS_LOB.CREATETEMPORARY(pl_blob,true);
    l_bfile := BFILENAME( vCmnDir , pOutFile ); 
    DBMS_LOB.fileopen(l_bfile, DBMS_LOB.file_readonly);
    DBMS_LOB.loadfromfile(pl_blob, l_bfile, DBMS_LOB.getlength(l_bfile));
    DBMS_LOB.fileclose(l_bfile);
  end;
  --
  procedure del_file ( pfilename varchar2 )
  as
  f pls_integer;
  begin
    SELECT DBMS_LOB.FILEEXISTS(BFILENAME (vCmnDir, pfilename )) INTO f FROM DUAL;
    IF f > 0 THEN
       SYS.UTL_FILE.FREMOVE(vCmnDir, pfilename );
    END IF;
  end;
  --
begin
--  DBMS_LOB.CREATETEMPORARY(vBlobOut,true);
--  DBMS_LOB.CREATETEMPORARY(l_uncompressed_blob,true);

 /* FILE_TO_BLOB( pFileIn , vBlobOut );  
  UTL_COMPRESS.lz_uncompress (src => vBlobOut,
                              dst => l_uncompressed_blob);
  vResFile := blob_to_file(l_uncompressed_blob);*/
  -- vdestfolder := 'c:\tmp\_27_12_2014\arc\';
--  pFileIn := 'c:\tmp\_27_12_2014\'+pFileIn+'';
  vResFile1 := BLOB_UNZIP( pFileIn, pdestfolder );
--  vResFile1 := BLOB_UNZIP( 'c:\tmp\_27_12_2014\'+vResFile, 'c:\tmp\_27_12_2014' );

 -- FILE_TO_BLOB( vResFile , vBlobOut );
  --
  if prezfile<>'' then
    vResFile := prezfile;
  else
    vResFile := '1.dat';
  end if;
--  vResTmp := vResFile1;
  
  vResFile := blob_untar(tarfile => pdestfolder||vResFile1,
                        resfile => vResFile,
                        destfolder => pdestfolder); 
  del_file(vResFile1);
--  prezfile:=vResTmp;
 -- UTL_COMPRESS.lz_uncompress (src => vBlobOut,
 --                             dst => l_uncompressed_blob);
 -- vResFile := blob_to_file(l_uncompressed_blob);
  RETURN vResFile;

end;