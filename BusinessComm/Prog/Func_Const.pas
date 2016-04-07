unit Func_Const;

interface

uses
  Winapi.Windows, SysUtils, System.IOUtils, Classes, System.Variants, Vcl.Controls,
  Vcl.ExtCtrls, Data.DB, CRGrid, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,  Ora, System.DateUtils,
  idhashsha, IdHashMessageDigest, Dialogs, TimedMsgBox,
  Winapi.Messages, Registry, IniFiles, StrUtils;

const
  TYPE_DOC_PAYMENT = 0;
  TYPE_DOC_CONTRACT = 1;
  TYPE_DOC_CHANGE_SIM = 2;
  TYPE_DOC_CHANGE_PHONE_NUM = 3;
  TYPE_DOC_CHANGE_TARIFF = 4;
  TYPE_DOC_CONTRACT_CANCEL = 5;

  TYPE_DOC_PAYMENT_TXT = 'Оплата';
  TYPE_DOC_CONTRACT_TXT = 'Договора аренды номера';
  TYPE_DOC_CHANGE_SIM_TXT = 'Заявление об утере Сим-карты';
  TYPE_DOC_CHANGE_PHONE_NUM_TXT = 'Заявление о смене номера телефона';
  TYPE_DOC_CHANGE_TARIFF_TXT = 'Заявление на смену тарифного плана';
  TYPE_DOC_CONTRACT_CANCEL_TXT = 'Заявления на расторжение договора';
  WM_NOTIFY_CLSMDI = WM_USER + 4242;
  WM_NOTIFY_CHGMODE = WM_USER + 4343;
  WM_NOTIFY_CHMODE = WM_USER + 4444;
  WM_NOTIFY_GO_ON_THE = WM_USER + 4445;
  WM_NOTIFY_GLOSE_GLOBAL = WM_USER + 4446;

Type
  TFormMode = (fmInactive, fmBrowse, fmInsert, fmEdit);

type
  MyProc = procedure(Sender : TDataSet) of object;

type
  TFLst = Array of String;

type
  TColomnFiltr = record
    FieldName: String;
    FieldFiltrValue : String;
 end;

type
  TColomn_ = record
    FieldName: String;
    FieldKind: TFieldKind;
    DisplayLabel: String;
    ReadOnly: Boolean;
    Required: Boolean;
    DisplayWidth: Integer;
    Tag: Integer;
    DataType: TFieldType;
    KeyFields: string;
    LookupDataset: TDataSet;
    LookupDataSource: TDataSource;
    LookupKeyFields: string;
    LookupResultField: string;
    Size: Integer;
    IsBlob: Boolean;
    Cmpnt1: TComponent;
    Cmpnt2: TComponent;
    Cmpnt3: TComponent;
    IsHandCreated: Boolean;
    NumberDict: Integer;
    Value : Variant;
  end;

type
  TColumn_Array = array of TColomn_;

type
  TColomnFiltr_Array = array of TColomnFiltr;

  TMenu = record
    MENU_NAME: String;
    ACTIONLIST_NAME: String;
    IS_VISIBLE: Integer;
    USER_NAME: string;
  end;

  TFindUser = record
    PHONE_ID: Integer;
    ACCOUNT_ID: Integer;
    MOBILE_OPERATOR_NAME_ID: Integer;
  end;


  Type
  TSystemPath = (Desktop, StartMenu, Programs, Startup, Personal, winroot, winsys, AppData, Cache, TMP);

  function sha1(s: string): string;
  function md5_30(s: string): string;
  function GetVersionValue(const Name: string): double;
  function FormatPhoneNumber(const Text: string): string;
  procedure VisibleColumnByFieldName(pGrid: TCRDBGrid; pName: string;
    pVis: Boolean);
  function MainCheckDates(begin_date, end_date: TDate): Boolean;
  function NVL(AValue: variant; ADefValue: variant): variant;
  Function GetSystemPath(SystemPath: TSystemPath): string;
  procedure ReadIniParams(const pFileName: String;
    var pUserName, pServer, pSchemaName, pPassword: String);
  procedure WriteIniParams(const pFileName, pUserName, pServer, pSchemaName,
    pPassword: String);
  procedure ReadIniAny(const pFileName, Section, Param: String;
    var pValue: String);
  procedure WriteIniAny(const pFileName, Section, Param, pValue: String);
  procedure ReadIniDebug(const pFileName: String; var pOraSQLMon_Active: Boolean);
  function GetVersionTextOfModule(const FileName: string): string;
  procedure FitGrid(Grid: TDBGrid; FileName, Capt: String);
  function GetFileSize(FileName: String): Integer;
  function Sklonenie_Raz(cnt: Integer): String;
  function Sklonenie_pisem(cnt: Integer): String;
  procedure SaveBlobFile(pPath, pFileName: string; qS: TOraQuery; pField: TField);

  function GET_EXCEL_FILE_NAME (pFileName : string) :String;

  // возвращает прошлый месяц указанной даты в формате year_month yyyymm
  function last_month_in_year_month(InDate : TDateTime) : Integer;


implementation



//процедура загрузки файла из поля blob базы на диск
procedure SaveBlobFile(pPath, pFileName: string; qS: TOraQuery; pField: TField);
var
  StrmSrc: TStream;
  StrmDst: TStream;
begin
  StrmSrc := qS.CreateBlobStream(pField, bmRead);
  try
    StrmSrc.Position := 0;
    StrmDst:= TFileStream.Create(pPath + pFileName, fmCreate);
    try
      StrmDst.CopyFrom(StrmSrc, StrmSrc.Size - StrmSrc.Position);
    finally
      StrmDst.Free;
    end;
  finally
    StrmSrc.Free;
  end;
end;

function last_month_in_year_month(InDate : TDateTime) : Integer;
 var
   LYear, LMonth, LDay: Word;
   last_month : Integer;
begin
  last_month := MonthOf(InDate) -1;  //прошедший месяц
  DecodeDate(InDate, LYear, LMonth, LDay);
  if last_month = 12 then
    LYear := LYear -1;
  Result := StrToInt(IntToStr(LYear)+IntToStr(last_month));
end;

function Sklonenie_Raz(cnt: Integer): String;
begin
  case cnt of
    1 : Result := 'раз';
    2..4 : Result := 'раза';
    5..9 : Result := 'раз';
  end;
end;

function Sklonenie_pisem(cnt: Integer): String;
var
 st : string;
 ost : Integer;
begin
  st := IntToStr(cnt);
  st := Copy(st, Length(st),1);
  ost := StrToInt(st);
  case ost of
    1 : Result := ' письмо ';
    2..4 : Result := ' письма ';
    5..9, 0 : Result := ' писем ';
  end;
end;

function GetFileSize(FileName: String): Integer;
var
  FS: TFileStream;
begin
  try
    try
      FS := TFileStream.Create(Filename, fmOpenRead);
      Result := FS.Size;
    except
      Result := -1;
    end;
  finally
    FreeAndNil(FS);
  end;

end;

procedure FitGrid(Grid: TDBGrid; FileName, Capt: String);
const
  C_Add = 3;
var
  ds: TDataSet;
  bm: TBookmark;
  i, w, r: Integer;
  a: array of Integer;
  st: string;
begin
  ds := Grid.DataSource.DataSet;
  if not Assigned(ds) then
    exit;
  if Grid.Columns.Count = 0 then
    exit;
  ds.DisableControls;
  bm := ds.GetBookmark;
  SetLength(a, Grid.Columns.Count);
  try
    for i := 0 to Grid.Columns.Count - 1 do
    begin
      ReadIniAny(FileName, Capt, Grid.Columns[i].FieldName, st);
      if (st <> '') then
      begin
        r := StrToIntDef(st, 0);
        if (r <> 0) then
        begin
          Grid.Columns[i].Width := r;
          a[i] := r;
        end;
      end;
    end;
    if (a[0] = 0) then
    begin
      for i := 0 to Grid.Columns.Count - 1 do
        if Assigned(Grid.Columns[i].Field) then
          a[i] := Grid.Canvas.TextWidth(Grid.Columns[i].Field.DisplayLabel);
      ds.First;
      for r := 0 to 900 do
      begin
        for i := 0 to Grid.Columns.Count - 1 do
        begin
          if not Assigned(Grid.Columns[i].Field) then
            continue;
          w := Grid.Canvas.TextWidth
            (ds.FieldByName(Grid.Columns[i].Field.FieldName).DisplayText);
          if a[i] < w then
            a[i] := w;
        end;
        ds.Next;
        if ds.Eof then
          Break;
      end;
      w := 0;
      for i := 0 to Grid.Columns.Count - 1 do
      begin
        Grid.Columns[i].Width := a[i] + C_Add;
        Grid.Columns[i].Title.Alignment := taCenter;
        inc(w, a[i] + C_Add);
      end;
      w := (Grid.ClientWidth - w - 20) div (Grid.Columns.Count);

      if w > 0 then
        for i := 0 to Grid.Columns.Count - 1 do
          Grid.Columns[i].Width := Grid.Columns[i].Width + w;
      ds.GotoBookmark(bm);
    end;
  finally
    ds.FreeBookmark(bm);
    ds.EnableControls;
    SetLength(a, 0);
  end;
end;

procedure ReadIniDebug(const pFileName: String; var pOraSQLMon_Active: Boolean);
var
  Ini: TIniFile;
begin
  try
    Ini := TIniFile.Create(ChangeFileExt(pFileName, '.INI'));
    try
      pOraSQLMon_Active := ('1' = Ini.ReadString('CONNECT', 'DEBUG', '0'));
    finally
      Ini.Free;
    end;
  except // глотаем ошибку
    //
  end;
end;

procedure ReadIniParams(const pFileName: String;
  var pUserName, pServer, pSchemaName, pPassword: String);
var
  Ini: TIniFile;
begin
  try
    Ini := TIniFile.Create(ChangeFileExt(pFileName, '.INI'));
    try
      pUserName := Ini.ReadString('CONNECT', 'USER_NAME', '');
      pServer := Ini.ReadString('CONNECT', 'SERVER', '');
      pSchemaName := Ini.ReadString('CONNECT', 'SCHEMA', '');
      pPassword := Ini.ReadString('CONNECT', 'PASSWORD', '');
    finally
      Ini.Free;
    end;
  except // глотаем ошибку
    pUserName := '';
    pServer := '';
    pSchemaName := '';
    pPassword := '';
  end;
end;

procedure WriteIniParams(const pFileName, pUserName, pServer, pSchemaName,
  pPassword: String);
var
  Ini: TIniFile;
begin
  try
    Ini := TIniFile.Create(ChangeFileExt(pFileName, '.INI'));
    try
      Ini.WriteString('CONNECT', 'USER_NAME', pUserName);
      Ini.WriteString('CONNECT', 'SERVER', pServer);
      Ini.WriteString('CONNECT', 'SCHEMA', pSchemaName);
      // Ini.WriteString('CONNECT', 'PASSWORD', pPassword);
    finally
      Ini.Free;
    end;
  except // глотаем ошибку
    ;
  end;
end;

procedure ReadIniAny(const pFileName, Section, Param: String;
  var pValue: String);
var
  Ini: TIniFile;
begin
  try
    Ini := TIniFile.Create(ChangeFileExt(pFileName, '.INI'));
    try
      pValue := Ini.ReadString(Section, Param, '');
    finally
      Ini.Free;
    end;
  except // глотаем ошибку
    pValue := '';
  end;
end;

procedure WriteIniAny(const pFileName, Section, Param, pValue: String);
var
  Ini: TIniFile;
begin
  try
    Ini := TIniFile.Create(ChangeFileExt(pFileName, '.INI'));
    try
      Ini.WriteString(Section, Param, pValue);
    finally
      Ini.Free;
    end;
  except // глотаем ошибку
    ;
  end;
end;

Function GetSystemPath(SystemPath: TSystemPath): string;
var
  p: pchar;
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    Reg.OpenKey
      ('\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders',
      True);
    case SystemPath of
      Desktop:
        Result := Reg.ReadString('Desktop');
      StartMenu:
        Result := Reg.ReadString('Start Menu');
      Programs:
        Result := Reg.ReadString('Programs');
      Startup:
        Result := Reg.ReadString('Startup');
      Personal:
        Result := Reg.ReadString('Personal');
      AppData:
        Result := Reg.ReadString('AppData');
      Cache:
        Result := Reg.ReadString('Cache');
      winroot:
        begin
          GetMem(p, 255);
          GetWindowsDirectory(p, 254);
          Result := StrPas(p);
          Freemem(p);
          // result := TPath.GetPathRoot;
        end;
      winsys:
        begin
          GetMem(p, 255);
          GetSystemDirectory(p, 254);
          Result := StrPas(p);
          Freemem(p);
        end;
      TMP:
        begin
          GetMem(p, 255);
          GetTempPath(254, p);

          Result := StrPas(p);
          Freemem(p);
          Result := TPath.GetTempPath;
        end;
    end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
  if (Result <> '') and (Result[length(Result)] <> '\') then
    Result := Result + '\';
end;

function NVL(AValue: variant; ADefValue: variant): variant;
begin
  Result := AValue;
  if Trim(VarToStr(AValue)) = '' then
    Result := ADefValue;
end;

function GetVersionTextOfModule(const FileName: string): string;
var
  V1, V2, V3, V4: Word;
  VerInfoSize: Cardinal;
  VerInfo: Pointer;
  VerValueSize: Cardinal;
  VerValue: PVSFixedFileInfo;
  Dummy: Cardinal;
begin
  Result := '';
  VerInfoSize := GetFileVersionInfoSize(pchar(FileName), Dummy);
  if VerInfoSize > 0 then
  begin
    GetMem(VerInfo, VerInfoSize);
    try
      try
        GetFileVersionInfo(pchar(FileName), 0, VerInfoSize, VerInfo);
        VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
        with VerValue^ do
        begin
          V1 := dwFileVersionMS shr 16;
          V2 := dwFileVersionMS and $FFFF;
          V3 := dwFileVersionLS shr 16;
          V4 := dwFileVersionLS and $FFFF;
        end;
        Result := IntToStr(V1) + '.' + IntToStr(V2) + '.' + IntToStr(V3) + '.' +
          IntToStr(V4);
      except
      end;
    finally
      Freemem(VerInfo, VerInfoSize);
    end;
  end;
end;

function FormatPhoneNumber(const Text: string): string;
var
  L: Integer;
  i: Integer;
begin
  if Text <> '' then
  begin
    Result := Text;
    L := length(Text);
    for i := 1 to L do
      if not CharInSet(Text[i], ['0' .. '9', '+', '-', ' ']) then
        exit;
    if L >= 6 then
    begin
      Insert(' ', Result, L - 3);
    end;
    if L >= 10 then
    begin
      Insert('  ', Result, L - 6);
      if L > 10 then
        Insert('  ', Result, L - 9);
    end;
  end
  else
    Result := Text;
end;

function md5_30(s: string): string;
begin
  Result := '';
  with TIdHashMessageDigest5.Create do
    try
      Result := Copy(LowerCase(HashStringAsHex(s)), 1, 30);
    finally
      Free;
    end;
end;

function sha1(s: string): string;
begin
  Result := '';
  with TIdHashsha1.Create do
    try
      Result := LowerCase(HashStringAsHex(s));
    finally
      Free;
    end;
end;

function GetVersionValue(const Name: string): double;
var
  Itog: double;
  res: string;
begin
  try
    Itog := 0;
    res := Name;
    Itog := Itog + StrToInt(Copy(res, 1, Pos('.', res) - 1)) * 1000;
    res := Copy(res, Pos('.', res) + 1);
    Itog := Itog + StrToInt(Copy(res, 1, Pos('.', res) - 1)) * 1;
    res := Copy(res, Pos('.', res) + 1);
    Itog := Itog + StrToInt(Copy(res, 1, Pos('.', res) - 1)) * 0.001;
    res := Copy(res, Pos('.', res) + 1);
    Itog := Itog + StrToInt(res) * 0.000001;
  except
    Itog := 1008.018;
  end;
  Result := Itog;
end;

// показывает/скрывает столбец таблицы по его наименованию (pVis = false - скрыть, pVis = true - показать)
procedure VisibleColumnByFieldName(pGrid: TCRDBGrid; pName: string;
  pVis: Boolean);
var
  i: Integer;
begin
  for i := 0 to pGrid.Columns.Count - 1 do
    if pGrid.Columns[i].FieldName = pName then
    begin
      pGrid.Columns[i].Visible := pVis;
      Break;
    end;
end;

// проверка дат
function MainCheckDates(begin_date, end_date: TDate): Boolean;
begin
  Result := false;
  if begin_date > end_date then
  begin
    MessageDlg('Начальная дата не может быть больше конечной даты!',
      mtConfirmation, [mbOK], 0);
    exit;
  end;
  if begin_date > Now then
  begin
    MessageDlg('Начальная дата не может быть больше текущей даты!',
      mtConfirmation, [mbOK], 0);
    exit;
  end;
  Result := True;
end;

//возвращает название файла + время создания
function GET_EXCEL_FILE_NAME (pFileName : string) :String;
const
  charInvalid: array[1..9] of char = ('\', '/', ':', '*', '?', '"', '<', '>', '|') ;
var
  vFileName :string;
  c : Char;
begin
  vFileName := pFileName;
  //заменяем неразрешенные в имени файла символы на "_"
  for c in charInvalid do
    vFileName := AnsiReplaceStr(vFileName, c, '_');

  Result := vFileName +  ' создан ' + FormatDateTime('dd_mm_yyyy hh nn ss', now);
end;

end.
