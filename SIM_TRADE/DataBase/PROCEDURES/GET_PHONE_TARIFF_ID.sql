--#if IsClient("CORP_MOBILE") then
@GET_PHONE_TARIFF_ID_K7.sql
--#end if

--#if IsClient("GSM_CORP") then
@GET_PHONE_TARIFF_ID_GSM.sql
--#end if

--#if IsClient("SIM_TRADE") then
@GET_PHONE_TARIFF_ID_SIM.sql
--#end if

