unit Func_Const;

interface

uses
  SysUtils, System.IOUtils, Classes, System.Variants, Vcl.Controls,
  Vcl.ExtCtrls, Data.DB, CRGrid, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  idhashsha, IdHashMessageDigest, Dialogs, Vcl.Imaging.jpeg, Vcl.Graphics,
  Winapi.Windows, Winapi.Messages, Registry, IniFiles;

const
  WM_NOTIFY_CLSMDI = WM_USER + 4242;
  WM_NOTIFY_CHGMODE = WM_USER + 4343;
  WM_NOTIFY_CHMODE = WM_USER + 4444;

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
  end;

type
  TColumn_Array = array of TColomn_;

  TMenu = record
    MENU_NAME: String;
    ACTIONLIST_NAME: String;
    IS_VISIBLE: Integer;
    USER_NAME: string;
  end;

 type
  TStr = record
    Name:String;
    Value:String;
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

implementation

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

end.
