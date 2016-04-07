<%

Dim PhoneNumber
Dim Password
Password = Request.QueryString("password")
if Password <> "TariferSimTr13" then
	Response.End
end if

PhoneNumber = Request.QueryString("phone_number")
if PhoneNumber = "" then
	Response.End
end if

Response.ContentType="text/plain"

const adParamInput = 1
    const adParamOutput = 2
    const adParamReturnValue = 4
    const adDouble = 5
    const adBSTR = 8
    const adInteger = 3
    const adDBTimeStamp = 135
    const adCmdStoredProc = 4
    const adExecuteNoRecords = 128

on error resume next

const ConnectionString="Provider=MSDAORA;Data Source=localhost;User ID=SIM_TRADE_USER1;Password=SIM_TRADE_USER1"
Dim c
set c = Server.CreateObject("ADODB.Connection")
c.Open ConnectionString
if Err then
	Response.write "ERROR" & vbCrLf & Err.Description
	Response.End
end if

Dim Cmd
Set Cmd = CreateObject("ADODB.Command")
Set Cmd.ActiveConnection = c

Cmd.CommandType = adCmdStoredProc
Cmd.CommandText = "SIM_TRADE.GET_ABONENT_BALANCE"

Cmd.Parameters.Append Cmd.CreateParameter("RETURN_VALUE", adDouble, adParamReturnValue)
Cmd.Parameters.Append Cmd.CreateParameter("pPHONE_NUMBER", adBSTR, adParamInput, Len(PhoneNumber), PhoneNumber)
Call Cmd.Execute
if Err then
	Response.write "ERROR" & vbCrLf & Err.Description
	Response.End
end if

Dim BalanceValue
BalanceValue = Cmd.Parameters("RETURN_VALUE").Value

' Закроем соединение
Call Connection.Close

Response.write "OK" & vbCrLf & Replace(BalanceValue, ",", ".")

%>