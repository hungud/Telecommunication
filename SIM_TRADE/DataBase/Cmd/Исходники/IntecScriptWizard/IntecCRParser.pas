
//////////////////////////////////////////////////
//  Copyright © 1998,1999 Core Lab. All right reserved.
//  CRParser
//  Created:            27.03.98
//  Last modified:      04.02.99
//////////////////////////////////////////////////

unit IntecCRParser;

interface
const
  lcEnd     =  0;
  lcLexem   = -100;
  lcSymbol  = -102;
  lcIdent   = -103;  // identificator
  lcNumber  = -105;
  lcString  = -106;
  lcBlank   = -107;
  lcComment = -108;

type
  PArrLexem = ^TArrLexem;
  TArrLexem = array [1..1000] of PChar;

  TParserClass = class of TIntecParser;

  TIntecParser = class
  private
    Text: PChar;
    Pos: PChar;
    OldPos: PChar;
    OldOldPos: PChar;
    FOmitBlank: boolean;
    FOmitComment: boolean;
    FUppered: boolean;
    FCurrLine: integer;
    FPrevLine: integer;
    FCurrBegLine: PChar;
    FPrevBegLine: PChar;
    FQuotedString: boolean;

  protected
    SymbolCount: word;
    KeywordCount: word;
    ArrLexem: PArrLexem;

    function IsBlank(Ch: char): boolean; virtual;
    function IsSymbol(Ch: char): boolean; virtual;
    function IsAlpha(Ch: char): boolean; virtual;
    function IsNumber(Ch: char): boolean; virtual;
    function IsStringQuote(Ch: char): boolean; virtual;
    function IsIdentQuote(Ch: char): boolean; virtual;
    function FindLexem(const Lexem: string; StartInd, EndInd: integer): integer;

  public
    CommentBegin: string;
    CommentEnd: string;
    InlineComment: string;

    constructor Create(Text: PChar); virtual;

    procedure SetText(Text: PChar);

    procedure ToBegin;
    procedure Back;
    function GetNext(var StrLexem: string): integer;
    function GetNextEx(var StrLexem: string; var Code: integer): integer;
    function GetNextCode: integer;

    function ToLexem(Code: integer): integer;

    function CurrPos: integer;
    function PrevPos: integer;
    function PrevPrevPos: integer;
    function CurrLine: integer;
    function PrevLine: integer;
    function CurrCol: integer;
    function PrevCol: integer;

    property OmitBlank: boolean read FOmitBlank write FOmitBlank;
    property OmitComment: boolean read FOmitComment write FOmitComment;
    property Uppered: boolean read FUppered write FUppered;
    property QuotedString: boolean read FQuotedString write FQuotedString;
  end;

implementation
uses
  SysUtils;

const
  CommonSymbolCount = 28;
  CommonKeywordCount = 3;
  CommonLexems: array [1..CommonSymbolCount + CommonKeywordCount] of PChar = (
    '!','"','#','$','%','&','''','(',')','*','+',',','-','.','/',
    ':',';','<','=','>','?','@','[','\',']','^','_','`','AND','NOT','OR');

{ TIntecParser }

constructor TIntecParser.Create(Text: PChar);
begin
  Self.Text := Text;
  SymbolCount := CommonSymbolCount;
  KeywordCount := CommonKeywordCount;
  ArrLexem := @CommonLexems;
  CommentBegin := '/*';
  CommentEnd := '*/';
  InlineComment := '//';

  FOmitBlank := True;
  FUppered := True;
  FQuotedString := False;
  ToBegin;
end;

procedure TIntecParser.SetText(Text: PChar);
begin
  Self.Text := Text;
  ToBegin;
end;

function TIntecParser.IsBlank(Ch: char): boolean;
begin
  Result := Ch in [#9,#10,#13,#32];
end;

function TIntecParser.IsSymbol(Ch: char): boolean;
begin
  Result := Ch in ['!'..'/',':'..'@','['..'^','`','{'..'~'];
end;

function TIntecParser.IsAlpha(Ch: char): boolean;
begin
  Result := Ch in ['A'..'Z', 'a'..'z', #128 ..#255];
end;

function TIntecParser.IsNumber(Ch: char): boolean;
begin
  Result := Ch in ['0'..'9'];
end;

function TIntecParser.IsStringQuote(Ch: char): boolean;
begin
  Result := Ch in ['''', '"'];
end;

function TIntecParser.IsIdentQuote(Ch: char): boolean;
begin
  Result := False;
end;

function TIntecParser.FindLexem(const Lexem: string; StartInd, EndInd: integer): integer;
var
  L, H, I, C: integer;
  UpLexem: string;
begin
  Result := -1;
  L := StartInd;
  H := EndInd;
  UpLexem := AnsiUpperCase(Lexem);
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := CompareStr(ArrLexem^[I], UpLexem);// ANSI works 100 times slower on NT4
    if C < 0 then                          // with no "Sorting Order" key
      L := I + 1
    else begin
      H := I - 1;
      if C = 0 then
        Result := I;
    end;
  end;
end;

procedure TIntecParser.ToBegin;
begin
  Pos := Text;
  OldPos := Pos;
  OldOldPos := OldPos;
  FCurrLine := 0;
  FPrevLine := 0;
  FCurrBegLine := Pos;
  FPrevBegLine := Pos;
end;

procedure TIntecParser.Back;
begin
  Pos := OldPos;
end;

function TIntecParser.GetNext(var StrLexem: string): integer;
var
  i: integer;
  St: string;
  SymbolPos: PChar;
  IsComment: boolean;
  Buf: PChar;
begin
  OldOldPos := OldPos;
  OldPos := Pos;
  FPrevLine := FCurrLine;
  FPrevBegLine := FCurrBegLine;

  StrLexem := '';
  repeat
  // Blanks
    while IsBlank(Pos^) do begin
      StrLexem := StrLexem + Pos^;
      if Pos^ in [#13,#10] then
        if (Pos^ = #13) and ((Pos + 1)^ = #10) then begin
          Inc(FCurrLine, 2);
          FCurrBegLine := Pos + 2;
        end
        else begin
          Inc(FCurrLine);
          FCurrBegLine := Pos + 1;
        end;
      Inc(Pos);
    end;

    if not OmitBlank and (StrLexem <> '') then begin
      Result := lcBlank;
      Exit;
    end;

  // End
    if Pos^ = #0 then begin
      Result := lcEnd;
      Exit;
    end;

  // Comment
    IsComment := False;
    if StrLComp(PChar(InlineComment), Pos, Length(InlineComment)) = 0 then begin
      IsComment := True;
      Buf := Pos;
      while not(Pos^ in [#13, #10, #0]) do
        Inc(Pos);
      StrLexem := StrLexem + Copy(Buf, 1, Pos - Buf);
    end;

    if StrLComp(PChar(CommentBegin), Pos, Length(CommentBegin)) = 0 then begin
      IsComment := True;
      if Pos^ <> #0 then begin
        Buf := AnsiStrPos(Pos, PChar(CommentEnd));
        if Buf <> nil then begin
          StrLexem := StrLexem + Copy(Pos, 1, Buf - Pos) + CommentEnd;
          Pos := Buf + Length(CommentEnd);
        end
        else
          Pos := Pos + StrLen(Pos);
      end;
    end;

    if not OmitComment and IsComment then begin
      Result := lcComment;
      Exit;
    end;
  until not IsComment;

  StrLexem := '';
  if IsSymbol(Pos^) then
    if IsStringQuote(Pos^) then begin
      Result := lcString;
      if FQuotedString then
        StrLexem := StrLexem + Pos^;
      Inc(Pos);
      Buf := Pos;
      while not IsStringQuote(Pos^) and (Pos^ <> #0) do
        Inc(Pos);
      StrLexem := StrLexem + Copy(Buf, 1, Pos - Buf);
      if Pos^ <> #0 then begin
        if FQuotedString then
          StrLexem := StrLexem + Pos^;
        Inc(Pos);
      end;
    end
    else
      if IsIdentQuote(Pos^) then begin
        Result := lcIdent;
        StrLexem := StrLexem + Pos^;
        repeat
          Inc(Pos);
          StrLexem := StrLexem + Pos^;
        until IsIdentQuote(Pos^) or (Pos^ = #0);
        if Pos^ <> #0 then
          Inc(Pos);
      end
      else begin
        Result := lcSymbol;
        SymbolPos := Pos + 1;   // WAR
        St := Pos^;
        repeat
          StrLexem := StrLexem + Pos^;
          Inc(Pos);
        // Find
          i := 1;
          while (i <= SymbolCount) and (StrComp(PChar(StrLexem), ArrLexem^[i]) <> 0) do
            Inc(i);
          if i <= SymbolCount then begin
            St := StrLexem;
            SymbolPos := Pos;
            Result := i;
          end;
        until not IsSymbol(Pos^);

        StrLexem := St;
        Pos := SymbolPos;
      end
  else
    if IsAlpha(Pos^) or (Pos^ = '_') then begin
      Result := lcIdent;
      repeat
        StrLexem := StrLexem + Pos^;
        Inc(Pos);
      until not IsAlpha(Pos^) and not IsNumber(Pos^) and (Pos^ <> '_');
    end
    else
      if IsNumber(Pos^) then begin
        Result := lcNumber;
        repeat
          StrLexem := StrLexem + Pos^;
          Inc(Pos);
        until not IsNumber(Pos^);
        if (Pos^ = DecimalSeparator) and IsNumber((Pos + 1)^) then begin
          StrLexem := StrLexem + Pos^;
          Inc(Pos);
          while IsNumber(Pos^) do begin
            StrLexem := StrLexem + Pos^;
            Inc(Pos);
          end;
        end;
      end
      else
        raise Exception.Create('Parser: The unknown symbol ''' + Pos^ + '''  $' + IntToHex(Byte(Pos^), 2));

  if Result = lcIdent then begin
    i := FindLexem(StrLexem, SymbolCount + 1, SymbolCount + KeywordCount);
    if i <> -1 then begin
      Result := i;
      if Uppered then
        AnsiStrUpper(PChar(StrLexem));  //WAR problem with macros as key words
    end;
  end;
end;

function TIntecParser.GetNextEx(var StrLexem: string; var Code: integer): integer;
begin
  Code := GetNext(StrLexem);
  Result := Code;
end;

function TIntecParser.GetNextCode: integer;
var
  St: string;
begin
  Result := GetNext(St);
end;

function TIntecParser.ToLexem(Code: integer): integer;
var
  St: string;
begin
  repeat
    Result := GetNext(St);
  until (Result = Code) or (Result = lcEnd);
end;

function TIntecParser.CurrPos: integer;
begin
  Result := Pos - Text;
end;

function TIntecParser.PrevPos: integer;
begin
  Result := OldPos - Text;
end;

function TIntecParser.PrevPrevPos: integer;
begin
  Result := OldOldPos - Text;
end;

function TIntecParser.CurrLine: integer;
begin
  Result := FCurrLine;
end;

function TIntecParser.PrevLine: integer;
begin
  Result := FPrevLine;
end;

function TIntecParser.CurrCol: integer;
begin
  Result := Pos - FCurrBegLine;
end;

function TIntecParser.PrevCol: integer;
begin
  Result := OldPos - FPrevBegLine;
end;

end.

