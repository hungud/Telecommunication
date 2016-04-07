unit CRStrUtils;

interface

function GetTokenCount(const StrValue : string; FieldDelimiter : char {$IFDEF PRISM} := {$ELSE} = {$ENDIF} #9) : integer;

function GetToken(const Str : string; TokenIndex : integer; FieldDelimiter : char = #9) : string;

function StrToFloat2(const s : String) : Double;

implementation

uses SysUtils;

const CR : Char = #13;

function GetTokenCount(const StrValue : string; FieldDelimiter : char {$IFDEF PRISM} := {$ELSE} = {$ENDIF} #9) : integer;
const
  BoolInt : array[False..True] of integer = {$IFDEF PRISM} [ {$ELSE} ( {$ENDIF}0, 1{$IFDEF PRISM} ] {$ELSE} ) {$ENDIF};
var
  L : integer;
  i : integer;
  c : Char;
begin
  L := Length(StrValue);
  if L = 0 then
    Result := 0
  else
  begin
    Result := 1;
    for i := 1 to L do
    begin
      c := StrValue[i];
      Inc(Result, BoolInt[c = FieldDelimiter]);
      if c = CR then
        Break;
    end;
  end;
end;

function GetNextToken(const s : string; var SymbolIndex : integer; FieldDelimiter : char {$IFDEF PRISM} := {$ELSE} = {$ENDIF} #9) : string;
var
  PrevIndex : integer;
  L : integer;
  c : char;
begin
  PrevIndex := SymbolIndex;
  L := Length(s);
  while (SymbolIndex <= L) do
  begin
    c := s[SymbolIndex];
    if (c = FieldDelimiter) or (c = #13) then
      Break;
    Inc(SymbolIndex);
  end;
  Result := Copy(s, PrevIndex, SymbolIndex-PrevIndex);
  if SymbolIndex <= L then
    Inc(SymbolIndex);
end;

procedure SkipNextToken(const s : string; var SymbolIndex : integer; SkipCount : integer; FieldDelimiter : char);
var
  i : integer;
  L : integer;
  c : char;
begin
  i := SymbolIndex;
  L := Length(s);
  while SkipCount > 0 do
  begin
    while (i <= L)  do
    begin
      c := s[i];
      if (c = FieldDelimiter) or (c = #13) then
        Break;
      Inc(i);
    end;
    if i <= L then
      Inc(i)
    else
      Break;
    Dec(SkipCount);
  end;
  SymbolIndex := i;
end;

// Получить элемент, начиная с 1
function GetToken(const Str : string; TokenIndex : integer; FieldDelimiter : char = #9) : string;
var
  p : integer;
begin
  if Str = '' then
    Result := ''
  else
  begin
    p := 1;
    SkipNextToken(Str, p, TokenIndex-1, FieldDelimiter);
    Result := GetNextToken(Str, p, FieldDelimiter);
  end;
end;


function StrToFloat2(const s : String) : Double;
var
  s2 : String;
  i : Integer;
begin
  s2 := s;
  UniqueString(s2);
  for i := 1 to Length(s2) do
    if s2[i] in [',', '.'] then
      s2[i] := DecimalSeparator;
  Result := StrToFloat(s2);
end;

end.

