SET PARAMS= --username K7_USER --password UE_R7_K7SS --trust-server-cert --non-interactive --no-auth-cache
SET SVN="C:\Program Files\TortoiseSVN\bin\svn.exe" %PARAMS%
::for /f "tokens=2*" %%i in ('%SVN% status %1 ^| find "?"') do %SVN% add "%%i"
D:
CD D:\Tarifer\DB_SCRIPTS\
%SVN% cleanup
%SVN% add –force * –auto-props –parents –depth infinity -q
%SVN% commit  -m "auto commit real script from db %TIME%"
