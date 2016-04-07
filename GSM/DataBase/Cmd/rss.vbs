'**************************************************************************
'                                                                         *
' Утилита предназначена для исполнения SQL-скриптов с расширенным         *
' синтаксисом. Синтаксис расширения см. в файле readme_rss.txt            *
'                                                                         *
' (C) ООО "ИНТЕК", 2004-2007                                              *
' 
'**************************************************************************

option explicit

const adBSTR = 8

const adParamInput = 1
const adParamOutput = 2

Dim fso
Dim OutputFile, OutputFileName
Dim LogFileName, TempLogFileName
Dim SeparateSQLPlusExecute
Dim VerboseOutput
Dim CommandCache
Dim Connection
Dim ConnectionString
Dim StartLine
Dim EndLine
Dim wshShell
Dim WrotedLineCount
Dim ScriptText
Dim ServerName, UserName
Dim DoExecFlag
Dim oPlusExec
Dim ExecResult
Dim VersionArray
Dim ComSpecProgram
Dim ShowScriptObj
Dim ProcessedFileList
Dim OutFileName, OutFileNamePos, ListFileNamePos, FullOutFile
Dim RootDirectory

const ForReading = 1

const EndSignature = "ZDHJEBY48JTVADETJ3G"

call Run


sub Run

  Dim InputFileName
  Dim wshNetwork

  DetectExeType

  Set fso = CreateObject("Scripting.FileSystemObject")

  InputFileName = GetParamByPos(1)
  if InputFileName = "" then Usage

  Set ProcessedFileList = CreateObject("Scripting.Dictionary")

  OutFileNamePos = ParamKeyPos("Out")+1
  if OutFileNamePos > 0 then
    if WScript.Arguments.Count <= OutFileNamePos then
      WScript.Echo "Неверные параметры. За параметром -Out должно следовать имя файла!"
      WScript.Quit 1
    end if
    OutFileName = WScript.Arguments(OutFileNamePos)

    WScript.Echo "Режим записи полного скрипта в файл " & OutFileName
    Set FullOutFile = fso.CreateTextFile(OutFileName, True)
  end if

  ListFileNamePos = ParamKeyPos("List")+1
  if ListFileNamePos > 0 then
    
    if OutFileNamePos > 0 then
      WScript.Echo "Неверные параметры. Нельзя использовать -Out и -List одновременно!"
      WScript.Quit 1
    end if
    if WScript.Arguments.Count <= ListFileNamePos then
      WScript.Echo "Неверные параметры. За параметром -List должно следовать имя файла!"
      WScript.Quit 1
    end if
    OutFileName = WScript.Arguments(ListFileNamePos)

    WScript.Echo "Режим записи списка используемых файлов в файл " & OutFileName
    Set FullOutFile = fso.CreateTextFile(OutFileName, True)
  end if

  if OutFileName = "" then

    SeparateSQLPlusExecute = ParamKeyPresent("S") or ParamKeyPresent("Separate")
    if not SeparateSQLPlusExecute then
      VersionArray = Split(WScript.Version, ".")
      if (CInt(VersionArray(0)) < 5) or (CInt(VersionArray(0)) = 5 and CInt(VersionArray(1)) < 6) then
        WScript.Echo "Однократный запуск SQL Plus поддерживается только на Windows Script Host"
        WScript.Echo "версии 5.6 или выше (http://msdn.microsoft.com/scripting/)."
        WScript.Echo "Будет использоваться многократный запуск SQL Plus."
        WScript.Echo ""
        SeparateSQLPlusExecute = True
      end if
    end if

    VerboseOutput = ParamKeyPresent("V") or ParamKeyPresent("Verbose")

    Set wshShell = CreateObject("WScript.Shell")

    ComSpecProgram = wshShell.ExpandEnvironmentStrings("%ComSpec%")

    Set wshNetwork = CreateObject("WScript.Network")
    OutputFileName = wshNetwork.ComputerName+".sql.tmp"

    ExecResult = ""

    Set CommandCache = CreateObject("Scripting.Dictionary")

    Set Connection = Nothing
    ConnectionString = GetParamByPos(2)
    if ConnectionString <> "" then 
      DoConnect
    end if

    while Connection Is Nothing
      ConnectionString = InputBox("Укажите строку соединения (имя_схемы/пароль@сервер)", "Выполнение SQL-скриптов",ConnectionString)
      if ConnectionString = "" then
        WScript.Quit 1
      end if
      DoConnect
    wend

    Set OutputFile = fso.CreateTextFile(OutputFileName, True)


    TempLogFileName = wshNetwork.ComputerName&".tmp"
    LogFileName = wshNetwork.ComputerName&".log"

    wshShell.Run ComSpecProgram&" /C echo *** Script Prepared "&Now&"> "&LogFileName, 7, True
    AppendToLog "----------------------------"

    if ParamKeyPresent("NoExecute") or ParamKeyPresent("NoExec") then
      DoExecFlag = False
    elseif ParamKeyPresent("Execute") or ParamKeyPresent("Exec") then
      DoExecFlag = True
    else
      DoExecFlag = (vbYes = MsgBox("Запускать SQL Plus?", vbYesNo, "Выполнение SQL скриптов"))
    end if
    
    if (not SeparateSQLPlusExecute) and DoExecFlag then
      Set oPlusExec    = WshShell.Exec(ComSpecProgram&" /C sqlplus.exe -silent /NOLOG")
    end if

    if not DoExecFlag then
      on error resume next
      Set ShowScriptObj = CreateObject("IntecScriptWizard.ShowScript")
      on error goto 0
      if not IsEmpty(ShowScriptObj) then
        Set ShowScriptObj.Connection = Connection
      end if
    end if

    StartLine = _
      "set sqlprompt """""& vbCRLF& _
      "set echo off"& vbCrLF& _
      "set feedback off"& vbCRLF& _
      "set termout on"& vbCRLF& _
      "set sqlnumber off"& vbCRLF& _
      "define connection_string="&ConnectionString& vbCRLF& _
      "define server_name="&ServerName& vbCRLF& _
      "define user_name="&UserName& vbCRLF& _
      "Connect &Connection_String"& vbCRLF
    if SeparateSQLPlusExecute then
      EndLine = "commit;"&vbCR&vbLF&"exit"
    else
      EndLine = vbCRLF
    end if

    WriteLine StartLine
    WrotedLineCount = 0
    ScriptText = ""

    end if
    Call ProcessFile(InputFileName, True)

    if OutFileName = "" then
      ExecScript InputFileName

      if SeparateSQLPlusExecute then
        if fso.FileExists(TempLogFileName) then
          fso.DeleteFile TempLogFileName, True
        end if
      else
        WriteLine "Exit"
        WScript.Sleep 300
  '      AppendToLog ExecResult
      end if

      if DoExecFlag then
        wshShell.Run "notepad.exe """&LogFileName&""""
      else
        WriteLine EndLine
       wshShell.Run "notepad.exe """&OutputFileName&""""
      if not IsEmpty(ShowScriptObj) then
        ShowScriptObj.Run
      end if
    end if
  end if
'end if

'MsgBox "Файл создан"
end sub

Sub  WaitPlusExec
  Dim OutputLine

  if not IsEmpty(oPlusExec) then
    Do While True

      If Not oPlusExec.StdOut.AtEndOfStream Then
        OutputLine = oPlusExec.StdOut.ReadLine
        If InStr(UCase(OutputLine), UCase(EndSignature)) <> 0 Then Exit Do
        WScript.Echo OutputLine
        AppendToLog OutputLine
      End If
    Loop
  end if
end sub

sub AppendToLog(Message)
  Dim File
  const ForAppending = 8
  Set File = fso.OpenTextFile(LogFileName, ForAppending, True)
  File.WriteLine Message
  File.Close
end sub

sub ExecScript(InputFileName)
  Dim ExecLine
  Dim ScriptCaption

  if WrotedLineCount > 0 then
    if DoExecFlag then
      WriteLine EndLine

      if SeparateSQLPlusExecute then
        OutputFile.Close
        Set OutputFile = Nothing

        ' Исполняем скрипт
        ExecLine = ComSpecProgram&" /C sqlplus.exe -SILENT /NOLOG @"&OutputFileName
        wshShell.Run ExecLine, 7, True

        ' Добавляем запись в LOG-файл
        ExecLine = ComSpecProgram&" /C copy /B "&LogFileName&"+"&TempLogFileName&" "&LogFileName
        wshShell.Run ExecLine, 7, True

        Set OutputFile = fso.CreateTextFile(OutputFileName, True)
        WriteLine StartLine
      else
        oPlusExec.StdIn.Write "DEFINE "&EndSignature&vbCrLf
        WaitPlusExec
      end if
    else
      if not IsEmpty(ShowScriptObj) then
        ScriptCaption = Trim(Replace(Replace(Left(ScriptText, 200), vbCr, " "), vbLf, " "))
        ShowScriptObj.Add ScriptCaption, ScriptText, "", InputFileName, 0
      end if
    end if
    WrotedLineCount = 0
  end if
  ScriptText = ""
end sub

function GetFileNameArray(IncludeFileName)
  Dim folder
  Dim File
  Dim Mask
  Dim regEx, Matches
  Dim c
  Dim Res

  c = 0
  Mask = fso.GetFileName(IncludeFileName)

  Set regEx = New RegExp
  regEx.Pattern = Replace(Mask, "*", "[a-z]")
  regEx.IgnoreCase = True
  regEx.Global = True

  Res = Array()

  Set Folder = fso.GetFolder(fso.GetParentFolderName(IncludeFileName))
  for each File in Folder.Files
'    Set Matches = regEx.Execute(File.Name)
'    MsgBox Matches.Count
'    if Matches.Count > 0 then
    if regEx.Test(File.Name) then
'      MsgBox File.Path
      redim Preserve Res(c)
      Res(c) = File.Path
      c = c + 1
    end if
  next

  GetFileNameArray = Res

end function

sub ProcessFile(InputFileName, IsRootFile)
  Dim InputFile
  Dim LineText, SourceLineText
  Dim Expression
  Dim LineNumber
  Dim LockCount
  Dim CurrentDirectory
  Dim IncludeFileName
  Dim DoWrite
  Dim FileNameArray
  Dim CodeLevel
  Dim VersionArray
  Dim PreparedFileName
  Dim RegExp

  LineNumber = 0
  LockCount = 0
  CodeLevel = 0

  PreparedFileName = InputFileName
  ' Заменяем конструкцию "Папка\..\" на пустую строку 
  ' (Папка не содержит первую точку и начинается после начала строки или после \)
  Set RegExp = New RegExp
  RegExp.Pattern = "(^|\\)[^\.][^\\]*\\\.\.\\"
  while RegExp.Test(PreparedFileName)
    PreparedFileName = RegExp.Replace(PreparedFileName, "$1")
'    MsgBox "Старый файл "&InputFileName&" новый - "&PreparedFileName
  wend
  ' Если файл уже обрабатывался, и работаем не в режиме SQL Plus, то прерываем
  if (OutFileName <> "") or (not DoExecFlag) then
    if ProcessedFileList.Exists(UCase(PreparedFileName)) then
      exit sub
    end if
    ProcessedFileList.Add UCase(PreparedFileName), 1
  end if
  Set InputFile = fso.OpenTextFile(PreparedFileName, ForReading)

  if IsRootFile then
    RootDirectory = fso.GetParentFolderName(fso.GetAbsolutePathName(PreparedFileName)) & "\"
  end if

  VersionArray = Split(WScript.Version, ".")

  if OutFileName <> "" then
    if OutFileNamePos > 0 then
      FullOutFile.WriteLine "--@" & PreparedFileName & vbCrLf
    elseif ListFileNamePos > 0 then
      if Left(PreparedFileName, Len(RootDirectory)) = RootDirectory then
        FullOutFile.WriteLine Mid(PreparedFileName, Len(RootDirectory)+1)
      else
        FullOutFile.WriteLine PreparedFileName
      end if
    end if
  end if

  while not InputFile.AtEndOfStream

    if (LineNumber mod 500) = 0 then
      if (CInt(VersionArray(0)) < 5) or (CInt(VersionArray(0)) = 5 and CInt(VersionArray(1)) < 1) then
        WScript.Echo "."
      else
        ' WScript.StdOut поддерживается начиная с WSH 5.1
        WScript.StdOut.write "."
      end if
    end if

    SourceLineText = InputFile.ReadLine
    LineText = Trim(SourceLineText)
    LineNumber = LineNumber + 1

    if OutFileName <> "" then
      if OutFileNamePos > 0 then
        if Left(LineText, 1) <> "@" then
          FullOutFile.WriteLine SourceLineText
        end if
      end if
    else

      if UCase(LineText) = "#ELSE" then
        PrintError PreparedFileName, LineNumber, "Команда #ELSE не поддерживается"
      end if
      if UCase(LineText) = "--#ELSE" then
        PrintError PreparedFileName, LineNumber, "Команда --#ELSE не поддерживается"
      end if
    end if

    if LockCount = 0 then
      if OutFileName = "" then

        DoWrite = True
        if (UCase(Left(LineText, 10)) = "--#EXECUTE") _
             or (UCase(Left(LineText, 7)) = "--#EXEC") then
          if (UCase(Left(LineText, 10)) = "--#EXECUTE") then
            Expression = Trim(Mid(LineText, 12))
          else
            Expression = Trim(Mid(LineText, 9))
          end if
          if Expression = "" then
            PrintError PreparedFileName, LineNumber, "Использован #Execute без условия"
          end if
          on error resume next
          Execute Expression
          if Err then
            PrintError PreparedFileName, LineNumber, Err.Description
          end if
          on error goto 0
          DoWrite = False
        end if
        if (UCase(Left(LineText, 9)) = "--#MSGBOX") then
          Expression = Trim(Mid(LineText, 11))
          if Expression = "" then
            PrintError PreparedFileName, LineNumber, "Использован #MsgBox без условия"
          end if
          on error resume next
          Expression = Eval(Expression)
          if Err then
            PrintError PreparedFileName, LineNumber, Err.Description
          end if
          on error goto 0
          WScript.Echo Expression
          AppendToLog PreparedFileName&", строка "&LineNumber&": "&Expression
          DoWrite = False
        end if
        if (UCase(Left(LineText, 9)) = "--#END IF") or (UCase(Left(LineText, 8)) = "--#ENDIF") then
          DoWrite = False
          CodeLevel = CodeLevel - 1
          if CodeLevel <  0 then
            PrintError PreparedFileName, LineNumber, "#END IF не имеет соответствующего #IF"
           end if
        end if
        if (UCase(Left(LineText, 5)) = "--#IF") then

' Выполняем подготовленный файл
ExecScript PreparedFileName

          DoWrite = False
          CodeLevel = CodeLevel + 1
          Expression = Trim(Mid(LineText, 7))
          if UCase(Right(Expression, 5)) = " THEN" then
            Expression = Left(Expression, Len(Expression)-5)
          end if
          if Expression = "" then
            PrintError PreparedFileName, LineNumber, "Использован #IF без условия"
          end if
          on error resume next
          if not Eval(Expression) then
            LockCount = 1
          end if
          if Err then
            PrintError PreparedFileName, LineNumber, Err.Description
          end if
          on error goto 0
        end if
      end if
      if Left(LineText, 1) = "@" then
        IncludeFileName = Mid(LineText, 2)
        if Left(IncludeFileName, 1) = "@" then
          IncludeFileName = Mid(IncludeFileName, 2)
        end if
        if Left(IncludeFileName, 1) = """" then
          IncludeFileName = Mid(IncludeFileName, 2)
        end if
        if Right(IncludeFileName, 1) = """" then
          IncludeFileName = Left(IncludeFileName, Len(IncludeFileName)-1)
        end if
        if fso.GetExtensionName(IncludeFileName) = "" then
          IncludeFileName = IncludeFileName&".sql"
        end if
        CurrentDirectory = fso.GetParentFolderName(fso.GetAbsolutePathName(PreparedFileName))
        while left(PreparedFileName, 3) = "..\"
          CurrentDirectory = fso.GetParentFolderName(CurrentDirectory)
          IncludeFileName = Mid(IncludeFileName, 4)
        wend
        IncludeFileName = CurrentDirectory & "\" & IncludeFileName
        IncludeFileName = Replace(IncludeFileName, "\\", "\")
        if Instr(IncludeFileName, "*") > 0 or Instr(IncludeFileName, "?") > 0 then
          FileNameArray = GetFileNameArray(IncludeFileName)
          for each IncludeFileName in FileNameArray
            Call ProcessFile(IncludeFileName, False)
          next
        else
          if not fso.FileExists(IncludeFileName) then
            PrintError PreparedFileName, LineNumber, "Файл """&IncludeFileName&""" не найден"
          end if
          Call ProcessFile(IncludeFileName, False)
        end if
        DoWrite = False
      end if
      if DoWrite then
        if Trim(SourceLineText) <> "" and Left(LTrim(SourceLineText), 2) <> "--" then
          if WrotedLineCount = 0 then
            AppendToLog SourceLineText&vbCrLf
            if VerboseOutput then
              WScript.Echo "/* файл " & PreparedFileName & " */"
              WScript.Echo SourceLineText
              WScript.Echo "..."
            end if
          end if
          WrotedLineCount = WrotedLineCount + 1
          ' Выполняем подстановку для конструкций вида "&Имя_переменной"
          SourceLineText = SubstAmpersand(SourceLineText)
        end if
        ScriptText = ScriptText & SourceLineText & vbCrLf
        WriteLine SourceLineText
      end if
    else
      if OutFileName = "" then
        if (UCase(Left(LineText, 3)) = "#IF") or (UCase(Left(LineText, 5)) = "--#IF") then
          LockCount = LockCount + 1
          CodeLevel = CodeLevel + 1
        elseif (UCase(Left(LineText, 7)) = "#END IF") or (UCase(Left(LineText, 6)) = "#ENDIF") _
          or (UCase(Left(LineText, 9)) = "--#END IF") or (UCase(Left(LineText, 8)) = "--#ENDIF") then
          LockCount = LockCount - 1
          CodeLevel = CodeLevel - 1
        end if
      end if
    end if

  wend

  if CodeLevel <> 0 then
    PrintError PreparedFileName, LineNumber, "Парный #END IF не найден"
  end if
  
  ' Выполняем подготовленный файл
  ExecScript PreparedFileName
end sub

function SubstAmpersand(SourceLineText)
if Instr(SourceLineText, "&") = 0 then
  SubstAmpersand = SourceLineText
else
  Dim Result
  Dim VarName, VarValue
  Dim Pos
  Dim L, StrLen

  Result = SourceLineText

  Pos = 1
  while Pos > 0
    Pos = Instr(Pos, Result, "&")
    if Pos > 0 then
      Pos = Pos + 1
      StrLen = Len(Result)
      ' Определяем длину переменной (состоит из букв, цифр или подчеркивания)
      L = 0
      while L < StrLen and Instr("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_", Mid(Result, Pos+L, 1)) > 0
        L = L + 1
      wend
      if L > 0 then
        VarName = Mid(Result, Pos, L)
        VarValue = Eval(VarName)
'        MsgBox "Left = """ & Left(Result, Pos-2) & """"
'        MsgBox "VarName="&VarName
'        MsgBox "VarValue="&VarValue
        Result = Left(Result, Pos-2) & VarValue & Mid(Result, Pos+L)
      end if
    end if
  wend



  SubstAmpersand = Result
end if
end function















sub WriteLine(LineText)
  OutputFile.WriteLine LineText
  if not IsEmpty(oPlusExec) then
    oPlusExec.StdIn.WriteLine LineText
  end if
end sub


function GetParamFromConnectionString(ParamName)
  Dim p
  Dim Result

  p = Instr(1, ConnectionString, ParamName&"=", vbTextCompare)
  if p = 0 then
    Result = ""
  else
    Result = Mid(ConnectionString, p + Len(ParamName))
    p = instr(1, Result, ";")
    if p > 0 then Result = Left(Result, p-1)
  end if
  GetParamFromConnectionString = Trim(Result)
end function

sub DoConnect
  Dim AdoConnectionString
  Dim Password
  Dim cs

  Dim p
  if Instr(1, ConnectionString, "Provider=", vbTextCompare) > 0 then
    AdoConnectionString = ConnectionString
    ServerName = GetParamFromConnectionString("Data Source")
    UserName = GetParamFromConnectionString("User ID")
    Password = GetParamFromConnectionString("Password")
  else
    cs = ConnectionString
    p = Instr(cs, "@")
    if p > 0 then
      ServerName = Mid(cs, p+1)
      cs = left(cs, p-1)
    end if
    p = Instr(cs, "/")
    if p > 0 then
      UserName = Left(cs, p-1)
      Password = Mid(cs, p+1)
    end if
    AdoConnectionString = "Provider=MSDAORA;Data Source="&ServerName&";User ID="""&UserName&""";Password="""&Password&""""
    'AdoConnectionString = "Provider=OraOLEDB.Oracle;Data Source="&ServerName&";User ID="""&UserName&""";Password="""&Password&""""

  end if
  Set Connection = CreateObject("ADODB.Connection")
  on error resume next
    Connection.Open AdoConnectionString
    if Err then
      Set Connection = Nothing
      MsgBox "Ошибка соединения. "+Err.Description
    end if
  on error goto 0
end sub



sub Usage
  print "Использование: cscript.exe rss.vbs входной_файл [имя/пароль@алиасБД] [/separate] [/verbose] /out <выходной файл>"
  WScript.Quit 1

end sub


sub print(s)
  WScript.echo s
'  WScript.echo s
end sub

function GetParamByPos(Pos)
  Dim i
  Dim Arg, ArgFirstChar
  Dim Result
  Dim c
  Dim Args

  Set Args = WScript.Arguments
  Result = ""
  c = 0
  for i = 0 to args.Count-1
    Arg = args(i)
    ArgFirstChar = Left(Arg, 1)
    if ArgFirstChar <> "-" and ArgFirstChar <> "/" then
      c = c + 1
      if c = Pos then
        Result = Arg
        exit for
      end if
    end if
  next
  GetParamByPos = Result
end function

function ParamKeyPresent(KeyName)
  Dim i
  Dim Arg
  Dim Args
  Set Args = WScript.Arguments
  ParamKeyPresent = False
  for i = 0 to args.Count-1
    Arg = UCase(args(i))
    if Arg = "-"&UCase(KeyName) or Arg = "/"&UCase(KeyName) then
      ParamKeyPresent = True
      exit for
    end if
  next
end function

function ParamKeyPos(KeyName)
  Dim i
  Dim Arg
  Dim Args
  Set Args = WScript.Arguments
  ParamKeyPos = -1
  for i = 0 to args.Count-1
    Arg = UCase(args(i))
    if Arg = "-"&UCase(KeyName) or Arg = "/"&UCase(KeyName) then
      ParamKeyPos = i
      exit for
    end if
  next
end function

sub PrintError(InputFileName, LineNumber, Description)
  print "Ошибка в "&InputFileName&" ("&LineNumber&"). "&Description
  WScript.Quit 1
end sub


 '      This can detect the type of exe the script is running under and warns the
'       user of the popups.
Sub DetectExeType()
        Dim ScriptHost
        On Error Resume Next

        ScriptHost = WScript.FullName
        ScriptHost = Right(ScriptHost, Len(ScriptHost) - InStrRev(ScriptHost, "\"))
        If (UCase(ScriptHost) = "WSCRIPT.EXE") Then
                Dim msg

                msg =                           "Скрипт запущен при помощи WScript, но он должен быть запущен с помощью CScript."
                msg = msg & vbCrLf & "Пожалуйста, запустите скрипт так:"
                msg = msg & vbCrLf & vbCrLf & "cscript.exe    rss.vbs    Параметры"

                WScript.Echo msg

                WScript.Quit 2
        End If
End Sub


' *****************
function RecordExists(SQLText)
  Dim Rs
  Dim Result
  if DoExecFlag then
    Set Rs = Connection.Execute(SQLText)
    Result = (not Rs.EOF)
  else
    on error resume next
    Set Rs = Connection.Execute(SQLText)
    if Err then
      if Instr(Err.Description, "ORA-00942") > 0 then
        Result = False
        Err.Clear
      else
        on error goto 0
        err.Raise 
      end if
    else
      Result = (not Rs.EOF)
    end if
    on error goto 0
  end if
  RecordExists = CBool(Result)
end function

function RecordExists2(SQLText)
  Dim Rs
  Dim Result

  Result = False
  on error resume next
    Set Rs = Connection.Execute(SQLText)
  if not Err then Result = not Rs.EOF
  on error goto 0
  RecordExists2 = CBool(Result)
end function

function CreateRecordset(SQLText, Params)
  Dim Command

  if CommandCache.Exists(SQLText) then
    Set Command = CommandCache.Item(SQLText)
  else
    if CommandCache.Count > 100 then
      CommandCache.RemoveAll ' Чистим кэш
    end if
    Set Command = CreateObject("ADODB.Command")
    Command.CommandText = SQLText
    Set Command.ActiveConnection = Connection
    Command.Prepared = True
    Set CommandCache.Item(SQLText) = Command
  end if
  Set CreateRecordset = Command.Execute(, Params)
end function

function RecordExistsP(SQLText, Params)
  Dim Rs

  Set Rs = CreateRecordset(SQLText, Params)
  RecordExistsP = CBool(not Rs.EOF)
end function

function ObjectExists(ObjectName)
  Dim SQL
  SQL = "select object_name from user_objects where object_name=? "
  ObjectExists = RecordExistsP(SQL, Array(ObjectName))
  if not ObjectExists then
    ObjectExists = ConstraintExists(ObjectName)
  end if
end function

function IndexExists(ObjectName)
  Dim SQL
  SQL = "select index_name from user_indexes where index_name=? "
  IndexExists = RecordExistsP(SQL, Array(ObjectName))
end function

function GrantExists(ObjectName, RoleName, PRIVILEGE)
  Dim SQL
  if RoleName="ROLE" OR RoleName="ROLE_RO" then 
   RoleName=IsClient("") & "_" & RoleName
  end if
  SQL = "select * from user_TAB_PRIVS where table_name=? AND GRANTEE=? AND PRIVILEGE=?"
  GrantExists = RecordExistsP(SQL, Array(ObjectName, RoleName, PRIVILEGE))
end function

function IsClient(ClientName)
  Dim SQL
  Dim Rs
  Dim Rs1
  Dim SchemaName
  SQL = "SELECT USERNAME FROM USER_USERS WHERE '1'=?"
  Set Rs1 = CreateRecordset(SQL, Array("1"))
  if not Rs1.EOF then
    SchemaName = Rs1("USERNAME")
  end if

  if ClientName="" then 
    IsClient=SchemaName
  else 
    SQL = "select VALUE FROM "& SchemaName &".CONSTANTS WHERE NAME ='SERVER_NAME' AND VALUE=?"

    Set Rs = CreateRecordset(SQL, Array(ClientName))
    IsClient = CBool(not Rs.EOF)
  end if
end function

function ConstraintExists(ConstraintName)
  Dim SQL
  SQL = "select name from sys.con$ where name=? and owner# = userenv('SCHEMAID')"
'  SQL = "select constraint_name from user_constraints where constraint_name=?"
  ConstraintExists = RecordExistsP(SQL, Array(ConstraintName))
end function

function TableExists(TableName)
  TableExists = RecordExistsP("select table_name from user_tables where table_name=?", Array(TableName))
end function

function ColumnExists(TableColumnName)
  Dim p
  Dim TableName, ColumnName
  p = instr(TableColumnName, ".")
  TableName = UCASE(Left(TableColumnName, p-1))
  ColumnName = UCASE(Mid(TableColumnName, p+1))

  ColumnExists = RecordExistsP("select 1 from user_tab_columns where table_name=? and column_name=?", Array(TableName, ColumnName))
end function

function ColumnNullable(TableColumnName)
  Dim p
  Dim TableName, ColumnName
  p = instr(TableColumnName, ".")
  TableName = UCASE(Left(TableColumnName, p-1))
  ColumnName = UCASE(Mid(TableColumnName, p+1))

  ColumnNullable = RecordExistsP("select 1 from user_tab_columns where table_name=? and column_name=? AND NULLABLE = 'Y'", Array(TableName, ColumnName))
end function

function GetVersion(ProcName)
  Dim p
  Dim Rs
  Dim SQLText
  const VersionLabel="--#VERSION="
  Dim Txt
  Dim ObjectType

  GetVersion = 0
  Txt = ""

  SQLText = "SELECT OBJECT_TYPE FROM USER_OBJECTS WHERE OBJECT_NAME=? ORDER BY OBJECT_TYPE"
  Set Rs = CreateRecordset(SQLText, Array(ProcName))
  if not Rs.EOF then
    ObjectType = Rs("OBJECT_TYPE")
    if ObjectType = "TRIGGER" then
      SQLText = "SELECT description, trigger_body FROM USER_TRIGGERS WHERE TRIGGER_NAME=?"
      Set Rs = CreateRecordset(SQLText, Array(ProcName))
      if not Rs.EOF then
        txt = Rs("description")
        if Instr(UCase(txt), UCase(VersionLabel)) = 0 then
          txt = Rs("trigger_body")        
        end if
      end if
    elseif ObjectType = "VIEW" then
      SQLText = "SELECT TEXT FROM USER_VIEWS WHERE VIEW_NAME=?"
      Set Rs = CreateRecordset(SQLText, Array(ProcName))
      If Not Rs.EOF Then
        Txt = Rs("TEXT")
      End If      
    else
'      SQLText = "SELECT TRIM(TEXT) TEXT FROM USER_SOURCE WHERE NAME=? AND upper(TRIM(TEXT)) LIKE '"&VersionLabel&"%' ORDER BY TYPE, LINE"
' Исправил - взял из системного представления запрос, но из него исключил исходники JAVA
' Запрос стал открываться быстрее примерно в 15-20 раз
      SQLText = "SELECT TRIM(TEXT) TEXT FROM (select o.name, decode(o.type#, 7, 'PROCEDURE', 8, 'FUNCTION', 9, 'PACKAGE', 11, 'PACKAGE BODY', 12, 'TRIGGER', 13, 'TYPE', 14, 'TYPE BODY',  'UNDEFINED') TYPE, s.line, s.source text from sys.obj$ o, sys.source$ s where o.obj# = s.obj# and o.type# in (7, 8, 9, 11, 12, 13, 14) and o.owner# = userenv('SCHEMAID')) WHERE NAME=? AND upper(TRIM(TEXT)) LIKE '"&VersionLabel&"%' ORDER BY TYPE, LINE"
      Set Rs = CreateRecordset(SQLText, Array(ProcName))
      if not Rs.EOF then
        Txt = Rs("TEXT")
      end if
    end if
    if Txt <> "" then
      p = Instr(UCase(txt), UCase(VersionLabel))
      if p <> 0 then
        txt = mid(txt, p+Len(VersionLabel))
        p = Instr(txt, vbCR)
        if p > 0 then
          txt = Left(txt, p-1)
        end if
        p = Instr(txt, vbLF)
        if p > 0 then
          txt = Left(txt, p-1)
        end if
        GetVersion = 0
        on error resume next 
        GetVersion = CInt(txt)
        on error goto 0
      end if
    end if
  end if

'  SQLText = "SELECT TRIM(TEXT) TEXT FROM USER_SOURCE WHERE NAME=? AND upper(TRIM(TEXT)) LIKE '"&VersionLabel&"%' ORDER BY TYPE, LINE"
'  Set Rs = CreateRecordset(SQLText, Array(ProcName))
'  if Rs.EOF then
'    SQLText = "SELECT description, trigger_body FROM USER_TRIGGERS WHERE TRIGGER_NAME=?"
'    Set Rs = CreateRecordset(SQLText, Array(ProcName))
'    if not Rs.EOF then
'      txt = Rs("description")
'      if Instr(UCase(txt), UCase(VersionLabel)) = 0 then
'        txt = Rs("trigger_body")        
'      end if
'    else
'      SQLText = "SELECT TEXT FROM USER_VIEWS WHERE VIEW_NAME=?"
'      Set Rs = CreateRecordset(SQLText, Array(ProcName))
'      If Not Rs.EOF Then
'        Txt = Rs("TEXT")
'      End If      
'    end if
'    Txt = Rs("TEXT")
'    if Txt <> "" then
'      on error resume next 
'      GetVersion = CInt(Mid(Txt, Len(VersionLabel)+1))
'      on error goto 0
'    end if
'
'    if not Rs.EOF then
'      p = Instr(UCase(txt), UCase(VersionLabel))
'      if p <> 0 then
'        txt = mid(txt, p+Len(VersionLabel))
'        p = Instr(txt, vbCR)
'        if p > 0 then
'          txt = Left(txt, p-1)
'        end if
'        p = Instr(txt, vbLF)
'        if p > 0 then
'          txt = Left(txt, p-1)
'        end if
'        GetVersion = 0
'        on error resume next 
'        GetVersion = CInt(txt)
'        on error goto 0
'      end if
'    end if
'  else
'    Txt = Rs("TEXT")
'    if Txt <> "" then
'      on error resume next 
'      GetVersion = CInt(Mid(Txt, Len(VersionLabel)+1))
'      on error goto 0
'    end if
'  end if
end function

function GetColumnSize(TableColumnName)
  Dim p
  Dim TableName, ColumnName
  Dim Rs
  Dim Result
  Dim CharSize

  p = instr(TableColumnName, ".")
  TableName = UCASE(Left(TableColumnName, p-1))
  ColumnName = UCASE(Mid(TableColumnName, p+1))

  Set Rs = CreateRecordset("select * from user_tab_columns where table_name=? and column_name=?", Array(TableName, ColumnName))
  if Rs.EOF then
    Result = 0
  else
    Result = Rs("DATA_LENGTH")
    on error resume next ' Если вдруг сервер не поддерживает
    CharSize = Rs("CHAR_LENGTH")
    if CharSize > 0 then
      Result = CharSize
    end if
    on error goto 0
  end if
  if IsNull(Result) then
    Result = 0
  else
    Result = CInt(Result)
  end if
  GetColumnSize = Result
end function

function GetColumnPrecision(TableColumnName)
  Dim p
  Dim TableName, ColumnName
  Dim Rs
  Dim Result

  p = instr(TableColumnName, ".")
  TableName = UCASE(Left(TableColumnName, p-1))
  ColumnName = UCASE(Mid(TableColumnName, p+1))

  Set Rs = CreateRecordset("select data_precision from user_tab_columns where table_name=? and column_name=?", Array(TableName, ColumnName))
  if Rs.EOF then
    Result = 0
  else
    Result = Rs("DATA_PRECISION")
  end if
  if IsNull(Result) then
    Result = 0
  else
    Result = CInt(Result)
  end if
  GetColumnPrecision = Result
end function

function GetColumnType(TableColumnName)
  Dim p
  Dim TableName, ColumnName
  Dim Rs
  Dim Result

  p = instr(TableColumnName, ".")
  TableName = ucase(Left(TableColumnName, p-1))
  ColumnName = ucase(Mid(TableColumnName, p+1))

  Set Rs = CreateRecordset("select DATA_TYPE from user_tab_columns where table_name=? and column_name=?", Array(TableName, ColumnName))
  if Rs.EOF then
    Result = ""
  else
    Result = CStr(Rs("DATA_TYPE"))
  end if
  GetColumnType = Result
end function

function GetColumnDefault(TableColumnName)
  Dim p
  Dim TableName, ColumnName
  Dim Rs
  Dim Result

  p = instr(TableColumnName, ".")
  TableName = ucase(Left(TableColumnName, p-1))
  ColumnName = ucase(Mid(TableColumnName, p+1))

  Set Rs = CreateRecordset("select DATA_DEFAULT from user_tab_columns where table_name=? and column_name=?", Array(TableName, ColumnName))
  if Rs.EOF then
    Result = ""
  else
    Result = Rs("DATA_DEFAULT")
    if IsNull(Result) then
      Result = ""
    end if
  end if
  GetColumnDefault = Result
end function

function CheckDeleteNoNameConstraint(TableColumnName, ConstraintType)
' Удаляем первый НЕименованный констраинт на колонку (True - если нашли такой)
' ConstraintType
'   C - Check
'   P - Primary Key
'   R - Referential Integrity
'   U - Unique Key
'   V - Check Option on a view
  Dim p
  Dim TableName, ColumnName
  Dim Rs
  Dim Result
  Dim Rs1

  p = instr(TableColumnName, ".")
  TableName = ucase(Left(TableColumnName, p-1))
  ColumnName = ucase(Mid(TableColumnName, p+1))

  Set Rs = CreateRecordset("SELECT a1.constraint_name NAME FROM USER_CONS_COLUMNS C1, USER_CONSTRAINTS A1 WHERE (C1.Table_name = A1.table_name) AND (C1.Constraint_Name = A1.constraint_name) AND (C1.owner = A1.owner) AND (A1.GENERATED = 'GENERATED NAME') AND (A1.CONSTRAINT_TYPE = ?) AND (A1.table_name = ?) AND (C1.COLUMN_NAME = ?)", Array(ConstraintType, TableName, ColumnName))
  Result = (not Rs.EOF)
  if not Rs.EOF then
    Connection.Execute("ALTER TABLE "&TableName&" DROP CONSTRAINT "&CStr(Rs("NAME"))&" ")
  end if
  CheckDeleteNoNameConstraint = Result
end function

function GetOracleVersion
  Dim OraVersion
  Dim Command

  OraVersion = CStr(Left(Connection.Properties("DBMS Version"), 2))
  if OraVersion = "" then
    Set Command = CreateObject("ADODB.Command")
    Command.CommandText = "{ call dbms_utility.db_version(?, ?) }"
    Command.Parameters.Append Command.CreateParameter("", adBSTR, adParamOutput, 200)
    Command.Parameters.Append Command.CreateParameter("", adBSTR, adParamOutput, 200)
    Command.ActiveConnection = Connection
    Command.Execute
    OraVersion = Command.Parameters(0).Value
    if Instr(OraVersion, ".") > 0 then
      OraVersion = Left(OraVersion, Instr(OraVersion, ".")-1)
    end if
  else
  end if
  GetOracleVersion = CDbl(OraVersion)
end function

function GetConstraintCondition(ConstraintName)
  Dim Rs
  Dim Result

  Set Rs = CreateRecordset("select SEARCH_CONDITION from user_constraints where constraint_name=?", Array(ConstraintName))
  if Rs.EOF then
    Result = ""
  else
    Result = Rs("SEARCH_CONDITION")
    if IsNull(Result) then
      Result = ""
    end if
  end if
  GetConstraintCondition = CStr(Result)
end function

function GetConstraintColumnPosition(ConstraintName, ColumnName)
  Dim Rs
  Dim Result

  Set Rs = CreateRecordset("SELECT position FROM user_cons_columns WHERE (constraint_name=?) AND (COLUMN_NAME = ?)", Array(ConstraintName, ColumnName))
  if Rs.EOF then
    Result = ""
  else
    Result = Rs("POSITION")
    if IsNull(Result) then
      Result = ""
    end if
  end if
  GetConstraintColumnPosition = CStr(Result)
end function

function GetConstraintDeleteRule(ConstraintName)
  Dim Rs
  Dim Result

  Set Rs = CreateRecordset("select DELETE_RULE from user_constraints where constraint_name=?", Array(ConstraintName))
  if Rs.EOF then
    Result = ""
  else
    Result = Rs("DELETE_RULE")
    if IsNull(Result) then
      Result = ""
    end if
  end if
  GetConstraintDeleteRule = CStr(Result)
end function

function GetColumnComment(TableColumnName)
  Dim p
  Dim TableName, ColumnName
  Dim Rs
  Dim Result

  p = instr(TableColumnName, ".")
  TableName = ucase(Left(TableColumnName, p-1))
  ColumnName = ucase(Mid(TableColumnName, p+1))

  Set Rs = CreateRecordset("SELECT COMMENTS FROM USER_COL_COMMENTS where table_name=? and column_name=?", Array(TableName, ColumnName))
  if Rs.EOF then
    Result = ""
  else
    Result = Rs("COMMENTS")
    if IsNull(Result) then
      Result = ""
    end if
  end if
  GetColumnComment = CStr(Result)
end function

function GetTableComment(TableName)
  Dim Rs
  Dim Result

  Set Rs = CreateRecordset("SELECT COMMENTS FROM USER_TAB_COMMENTS where table_name=?", Array(TableName))
  if Rs.EOF then
    Result = ""
  else
    Result = Rs("COMMENTS").Value
    if IsNull(Result) then
      Result = ""
    end if
  end if
  GetTableComment = CStr(Result)
end function

function GetSeqLastNumber(SeqenceName)
  Dim Rs
  Dim Result

  Set Rs = CreateRecordset("SELECT LAST_NUMBER FROM DBA_SEQUENCES WHERE SEQUENCE_NAME = ?", Array(SeqenceName))
  if Rs.EOF then
    Result = ""
  else
    Result = Rs("LAST_NUMBER")
    if IsNull(Result) then
      Result = ""
    end if
  end if
  GetSeqLastNumber = CStr(Result)
end function

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

function LoadBlob(TableName, BlobColumnName, KeyColumnName, KeyValue, FileName)
  Dim SQLText
  Dim Value, SourceValue
  Dim Rs
  Dim Cmd
  
  LoadBlob = False
  if not DoExecFlag then
    if not TableExists(TableName) then
      exit function
    end if
  end if
  SQLText = "SELECT "&BlobColumnName&" FROM "&TableName&" WHERE "&KeyColumnName&"=?"
  Set Rs = CreateRecordset(SQLText, KeyValue)
  if not Rs.EOF then
    SourceValue = GetFileAsBlob(FileName)
    Value = Rs(BlobColumnName).Value
    if not ArrayEqual(Value, SourceValue) then
      if DoExecFlag then
        SQLText = "UPDATE "&TableName&" SET "&BlobColumnName&"=? WHERE "&KeyColumnName&"=?"
        Set Cmd = CreateObject("ADODB.Command")
        Set Cmd.ActiveConnection = Connection
        Cmd.CommandText = SQLText
        Cmd.Execute , Array(SourceValue, KeyValue)
      end if
      LoadBlob = True
      AppendToLog "Загружен BLOB в "&TableName&"."&BlobColumnName&", "&KeyColumnName&"="&KeyValue
    end if
  end if
end function
