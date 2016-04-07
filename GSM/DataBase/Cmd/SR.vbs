Option explicit

if Wscript.Arguments.Count < 3 or Wscript.Arguments.Count > 4 then
	MsgBox "Использование: SR.vbs входной_файл выражене_поиска выражение_замены [выходной_файл]"
else


Dim FileName, OutFileName
FileName = WScript.Arguments(0)
if Wscript.Arguments.Count = 4 then
  OutFileName = WScript.Arguments(3)
end if
if OutFileName = "" then
  OutFileName = FileName
end if

Dim SearchPattern, ReplaceExpression
SearchPattern = WScript.Arguments(1)
ReplaceExpression = WScript.Arguments(2)

const adTypeBinary=1
const adTypeText=2
const adWriteLine=1

Const ForReading = 1

Dim objStream
Dim Text, NewText

Dim fso, f
Set fso = CreateObject("Scripting.FileSystemObject")
  
Set f = fso.OpenTextFile(FileName, ForReading, False)
Text = f.ReadAll
f.Close

'Set objStream = CreateObject("ADODB.Stream")
'objStream.Open
'objStream.Type = adTypeBinary
'objStream.LoadFromFile FileName
'objStream.Position = 0
'objStream.Type = adTypeText
''objStream.CharSet = "cp866" ' ДОС-кодировк
'objStream.CharSet = "windows-1251"
'Text = ObjStream.ReadText
'MsgBox Text


Dim RegExp
Set RegExp = CreateObject("VBScript.RegExp")
RegExp.IgnoreCase = true
RegExp.Global = true

' Подробнее о шаблонах регулярных выражений см. http://www.pcre.org/
' или http://www.google.com/search?hl=ru&q=%D1%81%D0%B8%D0%BD%D1%82%D0%B0%D0%BA%D1%81%D0%B8%D1%81+%D1%88%D0%B0%D0%B1%D0%BB%D0%BE%D0%BD%D0%BE%D0%B2+%D1%80%D0%B5%D0%B3%D1%83%D0%BB%D1%8F%D1%80%D0%BD%D1%8B%D1%85+%D0%B2%D1%8B%D1%80%D0%B0%D0%B6%D0%B5%D0%BD%D0%B8%D0%B9&lr=
RegExp.Pattern = SearchPattern

'if RegExp.Test(Text) then
'  MsgBox "Match!"
'end if
NewText = RegExp.Replace(Text, ReplaceExpression)
'  MsgBox NewText
if (FileName <> OutFileName) or (NewText <> Text) then

'MsgBox "Saving!"
	Call SaveToFile(OutFileName, NewText)
end if

end if



sub SaveToFile(FileName, Text)
  Dim objStream

  Const ForWriting = 2
  Dim fso, f
  Set fso = CreateObject("Scripting.FileSystemObject")
  

'  if fso.FileExists(FileName) then
'    Call fso.DeleteFile(FileName, True)
'  end if
'  MsgBox FileName
'  MsgBox Text
  Set f = fso.OpenTextFile(FileName, ForWriting, True)
  f.Write Text
  f.Close
'Set objStream = CreateObject("ADODB.Stream")
'objStream.Open
'objStream.CharSet = "windows-1251"
'objStream.Type = adTypeText
'objStream.WriteText Text
'objStream.SaveToFile FileName

end sub
