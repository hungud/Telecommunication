SET PARAMS= --username GSM_USER --password R_SEMES_GG --trust-server-cert --non-interactive --no-auth-cache
SET SVN="C:\Program Files\TortoiseSVN\bin\svn.exe" %PARAMS%
::for /f "tokens=2*" %%i in ('%SVN% status %1 ^| find "?"') do %SVN% add "%%i"
D:
CD D:\Tarifer\VersionControl\Database\
%SVN% cleanup
%SVN% add –force * –auto-props –parents –depth infinity -q
%SVN% commit  -m "auto commit real script from db %TIME%"
