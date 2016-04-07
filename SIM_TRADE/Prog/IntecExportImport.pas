unit IntecExportImport;

interface

type
(*
  ITableContentHandler = interface
    procedure StartHeader; safecall;
    procedure AppendField(const FieldName : WideString); safecall;
    procedure EndHeader; safecall;

    procedure StartRow; safecall;
    procedure EndRow; safecall;
    procedure SetFieldValue(FieldNumber : integer); safecall;
  end;

  TTableParser = class
  private
    FContentHandler : ITableContentHandler;
  public
    procedure ProcessData(const Data : string; const ContentHandler : ITableContentHandler);

  protected
    procedure DoProcessData; dynamic; abstract;
    function GetSymbol(var Symbol : char) : Boolean; virtual; abstract;

    procedure DoStartHeader;
    procedure DoAppendField(const FieldName : string);
    procedure DoEndHeader;

    procedure DoStartRow;
    procedure DoEndRow;
    procedure DoSetFieldValue(FieldNumber : integer; const FieldName : string);
  end;

  TDelimiterTableParser = class(TTableParser)
  private
    FFieldSeparator: char;
    FRowSeparator: string;
  protected
    procedure DoProcessData; override;
  public
    constructor Create(FieldSeparator : char; const RowSeparator : string);
  end;
*)








// Экспорт
  TTableExporter = class
  protected
    procedure Initialize; dynamic;
  public
    constructor Create;

    procedure Clear; virtual; abstract;
    procedure StartHeader; virtual; abstract;
    procedure AppendField(const FieldName : string); virtual; abstract;
    procedure EndHeader; dynamic; abstract;
    procedure StartRow; virtual; abstract;
    procedure AddFieldValue(const Value : string); virtual; abstract;
    procedure EndRow; virtual; abstract;
    function GetResult : string; dynamic; abstract;
  end;

  TTextTableExporter = class(TTableExporter)
  private
    FData : Array of string;
    FCurrentRow : integer;
  protected
    procedure Initialize; override;

    procedure AddString(const Value : string);
  public
    procedure Clear; override;

    function GetResult : string; override;
  end;


  TDelimitedTableExporter = class(TTextTableExporter)
  protected
    FFieldSeparator: char;
    FRowSeparator: string;

    FCurrentField : integer;

    function QuotedString(const Value : string) : string;
  public
    constructor Create(FieldSeparator : char; const RowSeparator : string);
    procedure StartHeader; override;
    procedure AppendField(const FieldName : string); override;
    procedure EndHeader; override;
    procedure StartRow; override;
    procedure AddFieldValue(const Value : string); override;
    procedure EndRow; override;
  end;

  TTabDelimitedTableExporter = class(TDelimitedTableExporter)
    constructor Create;
  end;

implementation

uses SysUtils;

{ TTableExporter }

constructor TTableExporter.Create;
begin
  inherited Create;
  Initialize;
end;

procedure TTableExporter.Initialize;
begin
  // Nothing
end;

{ TTextTableExporter }

procedure TTextTableExporter.AddString(const Value: string);
const
  RowIncrement = 10;
  MAX_STRING_LENGTH = 256;
var
  l : integer;
  sl : integer;
begin
  if Value <> '' then
  begin
    sl := Length(FData[FCurrentRow]);
    if sl > MAX_STRING_LENGTH then
    begin
      Inc(FCurrentRow);
      sl := 0;
    end;
    l := Length(FData);
    if FCurrentRow >= l  then
      SetLength(FData, l+RowIncrement);
    if sl = 0 then
      FData[FCurrentRow] := Value
    else
      System.Insert(Value, FData[FCurrentRow], sl+1)
  end;
end;

procedure TTextTableExporter.Clear;
begin
  SetLength(FData, 1);
  FData[0] := '';
  FCurrentRow := 0;
end;

function TTextTableExporter.GetResult : string;
var
  i : integer;
  L : integer;
  p : PChar;
begin
  L := 0;
  for i := 0 to FCurrentRow do
    Inc(L, Length(FData[i]));
  SetLength(Result, L);
  p := PChar(Result);
  for i := 0 to FCurrentRow do
  begin
    L := Length(FData[i]);
    Move(PChar(FData[i])^, p^, L);
    Inc(p, L);
  end;
end;

procedure TTextTableExporter.Initialize;
begin
  inherited;
  Clear;
end;

{ TDelimitedTableExporter }

procedure TDelimitedTableExporter.AppendField(const FieldName: string);
begin
  AddFieldValue(FieldName);
end;

procedure TDelimitedTableExporter.AddFieldValue(const Value : string);
begin
  if FCurrentField = 0 then
    AddString(QuotedString(Value))
  else
    AddString(FFieldSeparator+QuotedString(Value));
  Inc(FCurrentField);
end;

constructor TDelimitedTableExporter.Create(FieldSeparator: char;
  const RowSeparator: string);
begin
  inherited Create;
  FFieldSeparator := FieldSeparator;
  FRowSeparator := RowSeparator;
end;

procedure TDelimitedTableExporter.EndHeader;
begin
  EndRow;
end;

function TDelimitedTableExporter.QuotedString(const Value: string): string;
begin
  if Assigned(AnsiStrScan(PChar(Value), '"')) then
    Result := AnsiQuotedStr(Value, '"')
  else
    Result := Value;
end;

procedure TDelimitedTableExporter.EndRow;
begin
  AddString(FRowSeparator);
  //
end;

procedure TDelimitedTableExporter.StartHeader;
begin
  StartRow;
// Nothing
end;

procedure TDelimitedTableExporter.StartRow;
begin
  FCurrentField := 0;
end;

{ TTabDelimitedTableExporter }

constructor TTabDelimitedTableExporter.Create;
begin
  inherited Create(#9, #13#10);
end;
(*
{ TTableParser }

procedure TTableParser.DoStartHeader;
begin
  FContentHandler.StartHeader;
end;

procedure TTableParser.DoAppendField(const FieldName: string);
begin
  FContentHandler.AppendField(FieldName);
end;

procedure TTableParser.DoEndHeader;
begin
  FContentHandler.EndHeader;
end;

procedure TTableParser.DoEndRow;
begin
  FContentHandler.EndRow;
end;

procedure TTableParser.DoStartRow;
begin
  FContentHandler.StartRow;
end;

procedure TTableParser.DoSetFieldValue(FieldNumber: integer;
  const FieldName: string);
begin
  FContentHandler.SetFieldValue(FieldNumber);
end;

procedure TTableParser.ProcessData(const Data: string;
  const ContentHandler: ITableContentHandler);
begin
  FContentHandler := ContentHandler;
  try
  finally
    FContentHandler := nil;
  end;
end;

{ TDelimiterTableParser }

constructor TDelimiterTableParser.Create(FieldSeparator: char;
  const RowSeparator: string);
begin
  inherited Create;
  FFieldSeparator := FieldSeparator;
  FRowSeparator := RowSeparator;
end;

procedure TDelimiterTableParser.DoProcessData;
begin
  { Используется шаблон "машина состояний"

  Доступные состояния:
  BeforeStart
  BeforeEnd
  }
  while GetSymbol(Symbol) do
  begin
  end;
  ;

end;
*)
end.
