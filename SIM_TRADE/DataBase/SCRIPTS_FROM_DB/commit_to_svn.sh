#!/bin/bash
PARAMS=" --username SIMTRADE_USER --password SRSESI_IES  --trust-server-cert --non-interactive --no-auth-cache"
SVN="svn $PARAMS"
#::for /f "tokens=2*" %%i in ('%SVN% status %1 ^| find "?"') do %SVN% add "%%i"
#D:
#CD D:\Tarifer\VersionControl\Database\
START_DIR=`pwd`
WORK_DIR=/u03/backup/DATA_BASE_SCRIPTS
cd $WORK_DIR
$SVN cleanup
$SVN add –force * –auto-props –parents –depth infinity -q
$SVN commit  -m "auto commit real script from db"
cd $START_DIR
