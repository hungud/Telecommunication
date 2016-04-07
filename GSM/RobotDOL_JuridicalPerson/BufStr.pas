unit BufStr;

interface

{$IFDEF CLR}
uses system.Text;

type
  TBufferedString = StringBuilder;

{$ELSE}

{$IFDEF UNICODE__}
uses SysUtils;

type
  TBufferedString = TStringBuilder;

{$ELSE}
uses Classes, SysUtils;

type
  TBufferedString = class
  private
    FString : string;
    FStringPC : PChar;
    //FString : array of char; // string;
    FLen : integer;
    BufferLen : integer;
//    function GetBuffer: PChar;
    procedure Grow;
    procedure SetLength(Value : integer);
  public
    procedure Append(c : char); overload;
    procedure Append(const s : string); overload;
    procedure AddBuffer(Data: PChar; Size: integer);
//    procedure AddString(const s : string);
//    procedure AddStrings(const s : array of string);
    function GetString : string;
//    procedure Clear;
    property Length : integer read FLen write SetLength;
//    property Buffer : PChar read GetBuffer;
    property ToString : string read GetString;
  end;
{$ENDIF} // UNICODE

{$ENDIF} // CLR

//procedure ClearBufferedString(b : TBufferedString);

implementation

{$IFNDEF CLR}
  {$IFDEF UNICODE__}

procedure ClearBufferedString(b : TBufferedString);
begin
  b.Clear;
end;

  {$ELSE} // UNICODE
procedure ClearBufferedString(b : TBufferedString);
begin
  b.SetLength(0);
end;

procedure TBufferedString.Grow;
begin
  BufferLen := (FLen + (FLen div 2) + 100);
  System.SetLength(FString, BufferLen);
  FStringPC := PChar(FString);
end;

procedure TBufferedString.SetLength(Value : integer);
begin
  if (Value > BufferLen) then
  begin
    BufferLen := Value;
    System.SetLength(FString, Value);
    FStringPC := PChar(FString);
  end;
  if FLen > Value then
    FLen := Value;
{  if Value <> 0 then
    Raise Exception.Create('Value <> 0 not supported')
  else
    FLen := 0;}
end;

procedure TBufferedString.Append(c : char);
begin
  if BufferLen <= FLen then
    Grow;
  FStringPC[FLen] := c;
  Inc(FLen);
end;

procedure TBufferedString.AddBuffer(Data : PChar; Size : integer);
var
  OldLen : integer;
begin
  if Size > 0 then
  begin
    OldLen := FLen;
    Inc(FLen, Size);
    if BufferLen < FLen then
      Grow;
    if Size = 1 then
      FStringPC[OldLen] := Data^
    else
      Move(Data^, FStringPC[OldLen], Size*SizeOf(Data^));
  end;
end;

procedure TBufferedString.Append(const s: string);
var
  L : integer;
begin
  L := System.Length(s);
  if L > 0 then
    AddBuffer(PChar(s), L);
end;

function TBufferedString.GetString : string;
begin
  if FLen = 0 then
    Result := ''
  else
  begin
    if (FLen > 1000000) then
    begin // Обрежем буфер и вернём его как строку (экономия памяти на больших объёмах)
      BufferLen := FLen;
      System.SetLength(FString, FLen);
      FStringPC := PChar(FString);
      Result := FString;
    end
    else
    begin
      // Оставляем буфер нетронутым
      SetString(Result, FStringPC, FLen);
    end;
  end
end;

{procedure TBufferedString.Clear;
begin
  SetLength(0);
end;}


{function TBufferedString.GetBuffer: PChar;
begin
  Result := PChar(FString);
end;}

  {$ENDIF} // UNICODE
{$ELSE}

procedure ClearBufferedString(b : TBufferedString);
begin
  b.Length := 0;
end;


{$ENDIF}
end.

