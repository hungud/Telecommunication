
  CREATE OR REPLACE PACKAGE "CORP_MOBILE"."PKG_SFTP" AS

procedure  put( p_Host  varchar2,
                p_Login  varchar2,
                p_Password  varchar2,
                p_RemoteFileWithPath  varchar2,
                p_LocalFileName  varchar2,
                p_LocalDir  varchar2,
                p_Result  out  varchar2 );

procedure  get( p_Host  varchar2,
                p_Login  varchar2,
                p_Password  varchar2,
                p_RemoteFileWithPath  varchar2,
                p_LocalFileName  varchar2,
                p_LocalDir  varchar2,
                p_Result  out  varchar2 );

end  pkg_sftp;
CREATE OR REPLACE PACKAGE BODY "CORP_MOBILE"."PKG_SFTP" IS

/* ------------------------------------------------------------------------------------------------- */

function  sftp_cmd( p_User  varchar2,
                    p_Pass  varchar2,
                    p_Host  varchar2,
                    p_LocalFile  varchar2,
                    p_RemoteFile  varchar2,
                    p_Cmd  varchar2 )  return  varchar2  as

    language java name  'Sftp.sftpcmd( java.lang.String,
                                       java.lang.String,
                                       java.lang.String,
                                       java.lang.String,
                                       java.lang.String,
                                       java.lang.String )  return  java.lang.String';


/* ------------------------------------------------------------------------------------------------- */

procedure  put( p_Host  varchar2,
                p_Login  varchar2,
                p_Password  varchar2,
                p_RemoteFileWithPath  varchar2,
                p_LocalFileName  varchar2,
                p_LocalDir  varchar2,
                p_Result  out  varchar2 )  as

begin
    p_Result := sftp_cmd( p_User => p_Login,
                          p_Pass => p_Password,
                          p_Host =>  p_Host,
                          p_RemoteFile => p_RemoteFileWithPath,
                          p_LocalFile => p_LocalDir || '\' || p_LocalFileName,   -- '
                          p_Cmd => 'put' );

    if   p_Result <> 'Ok'  then
        raise_application_error( -20001, 'SFTP put error : ' || p_Result );
    end if;
end  put;

/* ------------------------------------------------------------------------------------------------- */

procedure  get( p_Host  varchar2,
                p_Login  varchar2,
                p_Password  varchar2,
                p_RemoteFileWithPath  varchar2,
                p_LocalFileName  varchar2,
                p_LocalDir  varchar2,
                p_Result  out  varchar2 )  as

begin
    p_Result := sftp_cmd( p_User => p_Login,
                          p_Pass => p_Password,
                          p_Host =>  p_Host,
                          p_RemoteFile => p_RemoteFileWithPath,
                          p_LocalFile => p_LocalDir || '\' || p_LocalFileName,     -- '
                          p_Cmd => 'get' );

   
 if   p_Result <> 'Ok'  then
        raise_application_error( -20001, 'SFTP get error : ' || p_Result );
    end if;

end  get;


end  pkg_sftp;