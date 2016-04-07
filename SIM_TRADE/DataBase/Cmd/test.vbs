option explicit

Dim asd
asd = "Подстановка!"
MsgBox SubstAmpersand("123 ")
MsgBox SubstAmpersand("123 &asd &'")
asd=""
MsgBox SubstAmpersand("123 &asd")


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
        Result = Left(Result, Pos-2) & VarValue & Mid(Result, Pos+L)
'        MsgBox "VarName="&VarName
      end if
    end if
  wend



  SubstAmpersand = Result
end if
end function

