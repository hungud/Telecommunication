option explicit

'	const ConnectionString = "Provider=OraOLEDB.Oracle;Data Source=ora10xe;User ID=MF;Password=MF"
'	const ConnectionString = "Provider=OraOLEDB.Oracle;Data Source=tarifer.ru;User ID=MF;Password=INTEC"
	const ConnectionString = "Provider=OraOLEDB.Oracle;Data Source=beta.tarifer.ru/XE;User ID=LONTANA_WWW;Password=LONTANA_WWW_173"
'	const ConnectionString = "Provider=MSDAORA;Data Source=94.45.162.176/XE;User ID=LONTANA_WWW;Password=LONTANA_WWW_173"
	
	const adCmdStoredProc = 4
	const adExecuteNoRecords = 128
	const adBSTR = 8
	const adCHAR = 129
	const adParamInput = 1
	Dim Connection
	Dim ContentType
	Dim Command

	Set Connection=CreateObject("ADODB.Connection")
	Call Connection.Open(ConnectionString)

	Set Command = CreateObject("ADODB.Command")
	Set Command.ActiveConnection = Connection
'    Command.CommandType = adCmdStoredProc
    Command.CommandText = "insert into blob_data (blob_id, content_type) values (?, ?)"
    Command.Parameters.Append Command.CreateParameter("", adBSTR)
    Command.Parameters.Append Command.CreateParameter("", adBSTR)
'    Set ReturnParameter = Command.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
'    Command.Parameters.Append ReturnParameter

Dim fs, f, fc
Dim f1, FileName
Dim ImageID, ImageData
Dim fstream

Set fs = CreateObject("Scripting.FileSystemObject")
Set f = fs.GetFolder(".")
Set fc = f.Files
For Each f1 in fc
	FileName = f1.Name
	if UCase(Right(FileName, 4))=".GIF" then
		ContentType = "IMAGE/GIF"
	elseif UCase(Right(FileName, 4))=".JPG" then
		ContentType = "IMAGE/JPEG"
	elseif UCase(Right(FileName, 4))=".ICO" then
		ContentType = "IMAGE/VND.MICROSOFT.ICON"
	elseif UCase(Right(FileName, 4))=".PNG" then
		ContentType = "IMAGE/PNG"
	else
		ContentType = ""
	end if
	if ContentType <> "" then
		set fstream = f1.OpenAsTextStream(1, 0)
		if not fstream.AtEndOfStream then
			ImageID = UCASE(Left(FileName, Len(FileName)-4))
'			MsgBox ImageID
			ImageData = fstream.ReadAll
'			MsgBox Len(ImageData) & " " & ImageData
			Command.Parameters(0).Value = ImageID
			Command.Parameters(1).Value = ContentType
			on error resume next
			Command.Execute
			on error goto 0
			Call LoadBlob("blob_data", "blob_content", "blob_id", ImageID, FileName)
		end if
	end if
  Next

MsgBox "Изображения загружены"


function GetFileAsBlob(FileName)
  Dim Stream
  const adTypeBinary = 1
  const adReadAll = -1
  Set Stream = CreateObject("ADODB.STREAM")
  Stream.Open 
  Stream.Type = adTypeBinary
  Stream.LoadFromFile FileName
  Stream.Position = 0
  GetFileAsBlob = Stream.Read(adReadAll)
end function

function ConvertByteArrayToString(Arr)
  const adTypeBinary = 1
  const adTypeText = 2
  const adReadAll = -1

  Dim Stream
  
  Set Stream = CreateObject("ADODB.STREAM")
  Stream.Open 
  Stream.Type = adTypeBinary
  Stream.Write Arr
  Stream.Position = 0
  Stream.Type = adTypeText
  ConvertByteArrayToString = Stream.ReadText
end function

function ArrayEqual(ByRef Ar1, ByRef Ar2)
  ArrayEqual = False
  if IsArray(Ar1) and IsArray(Ar2) then
    if UBound(Ar1)=UBound(Ar2) and LBound(Ar1)=LBound(Ar2) then
      if ConvertByteArrayToString(Ar1) = ConvertByteArrayToString(Ar2) then
        ArrayEqual = True
      end if
    end if
  end if
end function

function CreateRecordset(SQLText, Params)
  Dim Rs
  Dim Result
  Dim Command

  Set Command = CreateObject("ADODB.Command")
  Command.CommandText = SQLText
  Set Command.ActiveConnection = Connection
  Command.Prepared = True
  Set CreateRecordset = Command.Execute(, Params)
end function

function LoadBlob(TableName, BlobColumnName, KeyColumnName, KeyValue, FileName)
  Dim SQLText
  Dim Value, SourceValue
  Dim Rs
  Dim Cmd
  
  LoadBlob = False
  SQLText = "SELECT "&BlobColumnName&" FROM "&TableName&" WHERE "&KeyColumnName&"=?"
'  MsgBox SQLText
'  MsgBox KeyValue
  Set Rs = CreateRecordset(SQLText, KeyValue)
  if not Rs.EOF then
    SourceValue = GetFileAsBlob(FileName)
    Value = Rs(BlobColumnName).Value
    if not ArrayEqual(Value, SourceValue) then
        SQLText = "UPDATE "&TableName&" SET "&BlobColumnName&"=? WHERE "&KeyColumnName&"=?"
        Set Cmd = CreateObject("ADODB.Command")
        Set Cmd.ActiveConnection = Connection
        Cmd.CommandText = SQLText
        Cmd.Execute , Array(SourceValue, KeyValue)
      LoadBlob = True
    end if
  end if
end function
