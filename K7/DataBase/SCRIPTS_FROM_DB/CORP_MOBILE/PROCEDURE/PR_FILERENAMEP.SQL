
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."PR_FILERENAMEP" (p_oldFileName IN VARCHAR2,
                          p_newfilename IN VARCHAR2) IS
tt varchar2(10000);
tt1 varchar2(10000);
tt2 varchar2(10000);
tt3 varchar2(10000);
  BEGIN
    BEGIN
      tt:= 'DST_FL_UTL' ||pkg_fileutil.fn_extractfilenamevfe(P_NewFileName);
      tt1:= pkg_fileutil.fn_extractfilename(P_OldFileName);
      tt3:= pkg_fileutil.fn_extractfilename(P_NEWFileName);
      tt2:= ' CREATE OR REPLACE DIRECTORY '||tt || ' AS ' || '''' ||
                        pkg_fileutil.fn_extractfiledir(P_NewFileName) || '''';
      EXECUTE IMMEDIATE tt2;
      UTL_FILE.frename(tt,tt1,
                       tt,
                       tt3,
                       TRUE);
      EXECUTE IMMEDIATE ' DROP DIRECTORY ' ||tt;
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR('pr_FileRename ' || SQLERRM, 0);
    END;
  END pr_FileRenamep;
