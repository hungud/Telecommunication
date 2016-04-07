--#if IsClient("CORP_MOBILE") then
@Send_sms_notice_K7.sql
--#end if

--#if IsClient("GSM_CORP") then
@Send_sms_notice_GSM.sql
--#end if

--#if IsClient("SIM_TRADE") then
@Send_sms_notice_SIM_trade.sql
--#end if