--#if IsClient("CORP_MOBILE") then
@USSD_notify_K7.sql
--#end if

--#if IsClient("GSM_CORP") then
@USSD_notify_GSM.sql
--#end if