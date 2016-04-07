--#if IsClient("CORP_MOBILE") then
@SEND_NOTICE_ON_NEW_CONTRACT_K7.sql
--#end if

--#if IsClient("GSM_CORP") then
@SEND_NOTICE_ON_NEW_CONTRACT_GSM.sql
--#end if