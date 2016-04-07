--#if IsClient("CORP_MOBILE") then
@SMS_SYSTEM_ERROR_NOTICE_K7.sql
--#end if

--#if IsClient("GSM_CORP") then
@SMS_SYSTEM_ERROR_NOTICE_GSM.sql
--#end if

--#if IsClient("SIM_TRADE") then
@SMS_SYSTEM_ERROR_NOTICE_SIM.sql
--#end if