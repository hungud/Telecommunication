--#if IsClient("CORP_MOBILE") then
@USSD_deliver_K7.sql
--#end if

--#if IsClient("GSM_CORP") then
@USSD_deliver_GSM.sql
--#end if