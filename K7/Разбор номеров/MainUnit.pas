unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, DB, MemDS, VirtualTable,
  Grids, DBGrids, ComObj, ToolWin, ShellAPI;

type
  TPricedTemplate = record
    TN: string;
    Price: double;
    CN: string;
  end;

  TCellTemplates = record
    CN: String;
    templates: array of TPricedTemplate;
  end;

  TfmMain = class(TForm)
    OpenDialog1: TOpenDialog;
    vtTemplates: TVirtualTable;
    vtTemplatesTemplate: TStringField;
    vtTemplatesPrice: TFloatField;
    dsTemplates: TDataSource;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lbResFile1: TLabel;
    lbResFile2: TLabel;
    edFileName: TEdit;
    bStart: TButton;
    pb: TProgressBar;
    lbProgress: TLabel;
    sbOpenFile: TSpeedButton;
    TabSheet2: TTabSheet;
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    SpeedButton3: TSpeedButton;
    DBGrid1: TDBGrid;
    Label4: TLabel;
    edSettingsFile: TEdit;
    sbOpenSettings: TSpeedButton;
    vtTemplatesNameWithSeparators: TStringField;
    procedure sbOpenFileClick(Sender: TObject);
    procedure bStartClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure lbResFile1Click(Sender: TObject);
    procedure lbResFile2MouseEnter(Sender: TObject);
    procedure lbResFile2MouseLeave(Sender: TObject);
    procedure vtTemplatesAfterPost(DataSet: TDataSet);
    procedure sbOpenSettingsClick(Sender: TObject);
    procedure vtTemplatesCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    // Флаг процесса обработки
    InProgress: boolean;
    // Таблица результатов
    ResTable: array of TCellTemplates;
    // Для сохранения результатов
    Res2Count: integer;
    // признак необходимости сохранения шаблонов
    TemplatesChanged: boolean;

    // Загрузка настроенных шаблонов и генерация рабочих
    procedure TemplatesLoad;
    // Сохранение шаблонов
    procedure TemplatesSave;

    // Загрузка и обработка номеров
    procedure CNLoad(FN: string);

    // Сохранение результатов
    procedure ResultSave;

    // Готовим форму
    procedure SetControlsEnabled(Value: boolean);

    // Определяем принадлежность номера шаблону
    function CompareCT(CN, TN, STN: string; var ResCN: string): boolean;

    // Запуск обработки
    procedure DoAnaliz(FN: String);

    // Формирование имен результирующих файлов
    procedure GetResFilesName;
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

procedure TfmMain.bStartClick(Sender: TObject);
begin
  GetResFilesName;
  DoAnaliz(edFileName.Text);
end;

procedure TfmMain.CNLoad(FN: string);
var
  MsExcel: Variant;

  CN, ResCN: string;
  i, j: integer;
  added: boolean;
begin
  MsExcel := CreateOleObject('Excel.Application');
  MsExcel.DisplayAlerts := False;
  MsExcel.Visible := False;
  try
    MsExcel.Workbooks.Open[FN, 0, true];
    SetLength(ResTable, 0);
    i := 1;
    pb.Position := 0;
    pb.Max := MsExcel.ActiveWorkbook.ActiveSheet.UsedRange.Rows.Count;
    Res2Count := 0;
    while MsExcel.Cells[i, 1].Value <> Unassigned do
    begin
      // Получили номер
      CN := MsExcel.Cells[i, 1].Value;
      
      inc(Res2Count);
      // Добавили в таблицу результатов
      SetLength(ResTable, i);
      ResTable[i - 1].CN := CN;
      // Ищем подходящие шаблоны
      /// ////////////////////////
      vtTemplates.First;
      while not vtTemplates.Eof do
      begin
        if vtTemplatesNameWithSeparators.AsString = '' then
        begin
          vtTemplates.Next;
          Continue;
        end;     
        // проверим, нужно ли проверять шаблон
        added := False;
        for j := 0 to High(ResTable[i - 1].templates) do
        begin
          added := added or
            (ResTable[i - 1].templates[j].TN = vtTemplatesNameWithSeparators.AsString);
        end;
        // Если шаблон ещё не добавлен
        // Определим принадлежность номера шаблону
        // Сгенерируем вид номера согласно шаблона
        if (not added) and CompareCT(CN, vtTemplatesTemplate.AsString,
                             vtTemplatesNameWithSeparators.AsString, ResCN) then
        begin
          if Length(ResTable[i - 1].templates) > 0 then
            inc(Res2Count);
          SetLength(ResTable[i - 1].templates,
            Length(ResTable[i - 1].templates) + 1);
          ResTable[i - 1].templates[ High(ResTable[i - 1].templates)].TN :=
            vtTemplatesNameWithSeparators.AsString;
          ResTable[i - 1].templates[ High(ResTable[i - 1].templates)].Price :=
            vtTemplatesPrice.AsFloat;
          ResTable[i - 1].templates[ High(ResTable[i - 1].templates)].CN := ResCN;
        end;
        vtTemplates.Next;
      end;

      pb.Position := i;
      // Увеличили сдвиг
      inc(i);
      inc(Res2Count);
      Application.ProcessMessages;
    end;

  finally
    MsExcel.ActiveWorkbook.Close;
    MsExcel.Application.Quit;
  end;
end;

function TfmMain.CompareCT(CN, TN, STN: string; var ResCN: string): boolean;

  function GenCNByTemplate(idx: integer;
    SUp: boolean { true-возрастающая, false-убывающая } ): string;
  var
    j: integer;
    s, s1: string;
  begin
    Result := '';
    // Собираем из номера на основе шаблона результирующую строку без разделителей
    s := ''; // строка для сопоставления ABCD...
    s1 := ''; // результирующая строка должна быть идентична подстроке номера
    for j := 1 to Length(TN) do
    begin
      // Цифры добавляем как есть
      if TN[j] in ['0' .. '9'] then
        s1 := s1 + TN[j];
      // Вместо * - текущий символ в номере
      if TN[j] = '*' then
        s1 := s1 + CN[idx + j];
      // Вместо буквы - соответствующая цифра из номера
      if (TN[j] in ['A' .. 'Z'])and(TN[j] <> 'S') then
      begin // если буквы ещё нет, или сочетание совпадает
        if ((pos(TN[j], s) = 0) and (pos(CN[idx + j], s) = 0)) or
          (pos(TN[j], s) = (pos(CN[idx + j], s) - 1)) then
        begin
          if pos(TN[j], s) = 0 then
            s := s + TN[j] + CN[idx + j];
          s1 := s1 + s[pos(TN[j], s) + 1];
        end
        else
        begin
          // это для случая, когда буква уже есть, но занята другой цифрой
          // то есть уже не совпадает
          s1 := s1 + TN[j];
          Break;
        end;
      end;
      // Последовательность
      if TN[j] = 'S' then
      begin
        if j = 1 then
          s1 := s1 + CN[idx + j]
        else
        begin
          if TN[j - 1] = 'S' then
          begin
            if SUp then
              s1 := s1 + Chr(Ord(s1[j - 1]) + 1)
            else
              s1 := s1 + Chr(Ord(s1[j - 1]) - 1);
          end
          else
            s1 := s1 + CN[idx + j];
        end;
      end;
    end;
    Result := s1;
  end;

  function GetTemplatedCN(idx: integer): string;
  var
    j: integer;
  begin
    Result := CN;
    for j := 1 to Length(STN) do
      if STN[j] = '-' then
        insert('-', Result, idx + j);
    while pos('--', Result) > 0 do
      Result := StringReplace(Result, '--', '-', []);
    while Result[Length(Result)] = '-' do
      Delete(Result, Length(Result), 1);
    while Result[1] = '-' do
      Delete(Result, 1, 1);
  end;

var
  i: integer;
begin
  Result := False;
  for i := 0 to Length(CN) - Length(TN) do
  begin
    if (pos(GenCNByTemplate(i, true), CN) > 0) then
    begin
      ResCN := GetTemplatedCN(i);
      Result := true;
      Exit;
    end;
    if (pos(GenCNByTemplate(i, False), CN) > 0) then
    begin
      ResCN := GetTemplatedCN(i);
      Result := true;
      Exit;
    end;
  end;
end;

procedure TfmMain.DoAnaliz(FN: String);
{var
  b: boolean;
  s1, s2: string;
  p1, p2: double;}
begin
  if not FileExists(FN) then
  begin
    Application.MessageBox('Выберите существующий исходный файл!', 'Ошибка',
      MB_OK + MB_ICONERROR);
  end
  else
  begin
    SetControlsEnabled(False);
    try
      if not vtTemplates.Active then
      begin
        // Загрузили шаблоны, если они почему-то не загружены
        lbProgress.Caption := 'Загрузка шаблонов...';
        TemplatesLoad;
        if not vtTemplates.Active then
        begin
          Application.MessageBox('Укажите файл шаблонов!', 'Ошибка', MB_OK+MB_ICONERROR);
          lbProgress.Caption := '';
          Exit;
        end;

      end;

      // Загрузили и обработали исходные данные
      lbProgress.Caption := 'Обработка исходного файла...';
      CNLoad(FN);
      // Сохранили результаты
      lbProgress.Caption := 'Сохранение результатов...';
      ResultSave;
      //vtTemplates.Close;
      Application.MessageBox('Подбор номеров завершен', 'Уведомление',
        MB_OK + MB_ICONINFORMATION);
      lbProgress.Caption := '';
      pb.Position := 0;
    finally
      SetControlsEnabled(true);
    end;
  end;
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if InProgress then
    Action := caNone
  else
  begin
    if TemplatesChanged and
       (Application.MessageBox('Шаблоны были изменены. Сохранить?',
       'Подтверждение', MB_YESNO+MB_ICONQUESTION)=idYes) then
      TemplatesSave;


    if vtTemplates.Active then
      vtTemplates.Close;

    Action := caFree;
  end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  InProgress := False;
  PageControl1.ActivePageIndex := 0;
  Res2Count := -1;
  //TemplatesLoad;
end;

procedure TfmMain.GetResFilesName;
var
  s, s1, s2: String;
  i, j: integer;
begin
  lbResFile1.Caption := '';
  lbResFile2.Caption := '';
  if (edFileName.Text = '')or(edSettingsFile.Text = '') then Exit;
  
  s1 := ExtractFileName(edFileName.Text);
  s2 := ExtractFileName(edSettingsFile.Text);
  for j := 1 to 2 do
  begin
    i := 1;
    repeat
      s := ExtractFilePath(edFileName.Text) +
           StringReplace(s1, ' ', '_', []) + '_' +
           StringReplace(s2, ' ', '_', []) +
           '_res' + IntToStr(j) + '_'+IntToStr(i) +
           ExtractFileExt(edFileName.Text);
      inc(i);
    until not FileExists(s);
    if j = 1 then
      lbResFile1.Caption := s
    else
      lbResFile2.Caption := s;
  end;
end;

procedure TfmMain.lbResFile1Click(Sender: TObject);
begin
  if FileExists((Sender as TLabel).Caption) then
    ShellExecute (fmMain.Handle, nil, PChar((Sender as TLabel).Caption), nil, nil, SW_RESTORE);
end;

procedure TfmMain.lbResFile2MouseEnter(Sender: TObject);
begin
  if FileExists((Sender as TLabel).Caption) then
  begin
    (Sender as TLabel).Font.Color := clHotLight;
    (Sender as TLabel).Font.Style := [fsUnderline];
    (Sender as TLabel).Cursor := crHandPoint;
  end;
end;

procedure TfmMain.lbResFile2MouseLeave(Sender: TObject);
begin
  if FileExists((Sender as TLabel).Caption) then
  begin
    (Sender as TLabel).Font.Color := clDefault;
    (Sender as TLabel).Font.Style := (Sender as TLabel).Font.Style - [fsUnderline];
    (Sender as TLabel).Cursor := crDefault;
  end;
end;

procedure TfmMain.ResultSave;
var
  i, j, k: integer;
  pmax: double;
  b: boolean;
  tmp: TPricedTemplate;
  TN, CN: string;

  MsExcel1, MsExcel2: Variant;

  Vals1, Vals2: Variant;
begin
  Vals1 := VarArrayCreate([1, Length(ResTable), 1, 3], varOleStr);
  Vals2 := VarArrayCreate([1, Res2Count, 1, 3], varOleStr);

  // Перебор номеров с шаблонами
  pb.Position := 0;
  pb.Max := Length(ResTable);
  k := 1;
  for i := 0 to High(ResTable) do
  begin
    Application.ProcessMessages;

    if Length(ResTable[i].templates) = 0 then
    begin
      Vals1[i + 1, 1] := ResTable[i].CN;
      Vals2[k, 1] := ResTable[i].CN;
      Vals1[i + 1, 2] := 'Шаблоны не найдены';
      Vals2[k, 2] := 'Шаблоны не найдены';
      inc(k);
    end
    else
    begin
      // Сортируем результаты
      repeat
        b := false;
        for j := 1 to High(ResTable[i].templates) do
        begin
          if ResTable[i].templates[j].Price > ResTable[i].templates[j-1].Price then
          begin
            tmp.CN    := ResTable[i].templates[j].CN;
            tmp.Price := ResTable[i].templates[j].Price;
            tmp.TN    := ResTable[i].templates[j].TN;
            ResTable[i].templates[j].CN    := ResTable[i].templates[j-1].CN;
            ResTable[i].templates[j].Price := ResTable[i].templates[j-1].Price;
            ResTable[i].templates[j].TN    := ResTable[i].templates[j-1].TN;
            ResTable[i].templates[j-1].CN    := tmp.CN;
            ResTable[i].templates[j-1].Price := tmp.Price;
            ResTable[i].templates[j-1].TN    := tmp.TN;
            b := true;
          end;
        end;
      until not b;

      pmax := -1;
      for j := 0 to High(ResTable[i].templates) do
      begin
        if pmax < ResTable[i].templates[j].Price then
        begin
          pmax := ResTable[i].templates[j].Price;
          TN := ResTable[i].templates[j].TN;
          CN := ResTable[i].templates[j].CN;
        end;
        // В Res2 вывели 3 подошедших шаблона
        Vals2[k, 1] := ResTable[i].templates[j].CN;
        Vals2[k, 2] := ResTable[i].templates[j].TN;
        Vals2[k, 3] := FloatToStr(ResTable[i].templates[j].Price);
        inc(k);
        if j = 2 then Break;
      end;
      // В Res1 вывели самый дорогой
      Vals1[i + 1, 1] := CN;
      Vals1[i + 1, 2] := TN;
      Vals1[i + 1, 3] := FloatToStr(pmax);
    end;

    inc(k);
    pb.Position := i + 1;
  end;

  // Запустим 2 приложение для сохранения результатов
  MsExcel1 := CreateOleObject('Excel.Application');
  MsExcel1.DisplayAlerts := False;
  MsExcel1.Visible := False;
  MsExcel2 := CreateOleObject('Excel.Application');
  MsExcel2.DisplayAlerts := False;
  MsExcel2.Visible := False;
  // pb.Position := 0;
  // pb.Max := Length(ResTable);
  try
    // Добавим новые книги
    MsExcel1.Workbooks.Add;
    MsExcel2.Workbooks.Add;
    { // Перебор номеров с шаблонами
      k := 1;
      for i := 0 to High(ResTable) do
      begin
      Application.ProcessMessages;
      MsExcel1.Cells[i + 1, 1].NumberFormat := '@';
      MsExcel1.Cells[i + 1, 1].Value := ResTable[i].CN;
      MsExcel2.Cells[k, 1].NumberFormat := '@';
      MsExcel2.Cells[k, 1].Value := ResTable[i].CN;

      if Length(ResTable[i].templates) = 0 then
      begin
      MsExcel1.Cells[i + 1, 2].Value := 'Шаблоны не найдены';
      MsExcel2.Cells[k, 2].Value := 'Шаблоны не найдены';
      end
      else
      begin
      pmax := -1;
      for j := 0 to High(ResTable[i].templates) do
      begin
      if pmax < ResTable[i].templates[j].Price then
      begin
      pmax := ResTable[i].templates[j].Price;
      TN := ResTable[i].templates[j].TN;
      end;
      // В Res2 вывели все подошедшие шаблоны
      MsExcel2.Cells[k, 2].Value := ResTable[i].templates[j].TN;
      MsExcel2.Cells[k, 3].Value := ResTable[i].templates[j].Price;
      inc(k);
      end;
      // В Res1 вывели самый дорогой
      MsExcel1.Cells[i + 1, 2].Value := TN;
      MsExcel1.Cells[i + 1, 3].Value := pmax;
      end;

      inc(k);
      pb.Position := i + 1;
      end; }
    MsExcel1.ActiveWorkbook.ActiveSheet.Range[MsExcel1.Cells[1, 1],
      MsExcel1.Cells[Length(ResTable), 3]].Value := Vals1;
    MsExcel2.ActiveWorkbook.ActiveSheet.Range[MsExcel2.Cells[1, 1],
      MsExcel2.Cells[Res2Count, 3]].Value := Vals2;

    MsExcel1.ActiveWorkbook.SaveAs(lbResFile1.Caption);
    MsExcel2.ActiveWorkbook.SaveAs(lbResFile2.Caption);
  finally
    // Почистили массив
    SetLength(ResTable, 0);
    // Закрыли все открытое
    MsExcel1.ActiveWorkbook.Close;
    MsExcel1.Application.Quit;
    MsExcel2.ActiveWorkbook.Close;
    MsExcel2.Application.Quit;
  end;
end;

procedure TfmMain.sbOpenFileClick(Sender: TObject);
var
  s: string;
begin
  OpenDialog1.Filter := 'Файлы Excel (*.xls;*.xlsx)|*.xls;*.xlsx|Все файлы|*.*';
  OpenDialog1.FileName := edFileName.Text;
  if OpenDialog1.Execute then
  begin
    edFileName.Text := OpenDialog1.FileName;
    s := StringReplace(edFileName.Text,
      ExtractFileExt(edFileName.Text), '', []);
    GetResFilesName;
    {lbResFile1.Caption := s + '_res1' + ExtractFileExt(edFileName.Text);
    lbResFile2.Caption := s + '_res2' + ExtractFileExt(edFileName.Text);}
  end;
end;

procedure TfmMain.SetControlsEnabled(Value: boolean);
begin
  bStart.Enabled := Value;
  sbOpenFile.Enabled := Value;
  InProgress := not Value;
  if Value then
    vtTemplates.EnableControls
  else
    vtTemplates.DisableControls;
  SpeedButton1.Enabled := Value;
  SpeedButton3.Enabled := Value;
end;

procedure TfmMain.SpeedButton1Click(Sender: TObject);
begin
  TemplatesLoad;
end;

procedure TfmMain.sbOpenSettingsClick(Sender: TObject);
begin
  if TemplatesChanged and
     (Application.MessageBox('Шаблоны были изменены. Сохранить?',
     'Подтверждение', MB_YESNO+MB_ICONQUESTION)=idYes) then
    TemplatesSave;
  OpenDialog1.Filter := 'Файлы шаблонов (*.txt)|*.txt|Все файлы|*.*';
  OpenDialog1.FileName := edSettingsFile.Text;
  if OpenDialog1.Execute then
  begin
    edSettingsFile.Text := OpenDialog1.FileName;
    TemplatesLoad;
    GetResFilesName;
  end;
end;

procedure TfmMain.SpeedButton3Click(Sender: TObject);
{var
   XMLDoc: DOMDocument;
    Root: IXMLDOMElement;
    ch: IXMLDOMElement;
    i: integer; }
begin

  TemplatesSave;

  { XMLDoc := CoDOMDocument.Create;
    try
    XMLDoc.Load(ExtractFilePath(Application.ExeName) + 'settings.xml');
    Root := XMLDoc.DocumentElement;

    for i := Root.childNodes.Length - 1 downto 0 do
    Root.removeChild(Root.childNodes.item[i]);
    vtTemplates.First;
    while not vtTemplates.Eof do
    begin
    ch := XMLDoc.createElement('Template');
    ch.Text := vtTemplatesTemplate.AsString;
    ch.setattribute('price', vtTemplatesPrice.AsString);
    Root.appendChild(ch);

    vtTemplates.Next;
    end;
    XMLDoc.save(ExtractFilePath(Application.ExeName) + 'settings.xml');
    finally
    ch := nil;
    Root := nil;
    XMLDoc := nil;
    end; }
end;

procedure TfmMain.TemplatesLoad;
var
  { XMLDoc: DOMDocument;
    Root: IXMLDOMElement;

    i: integer; }

  f: textfile;
  s, s1, s2: string;
begin
  if FileExists(edSettingsFile.Text) or
    (Application.MessageBox(PChar('Файл шаблонов не найден!'+#13#10+'Создать?'),
     'Ошибка', MB_YESNO+MB_ICONQUESTION)=idYes) then
  begin
    if not FileExists(edSettingsFile.Text) then
    begin
      AssignFile(f, edSettingsFile.Text);
      Rewrite(f);
      CloseFile(f);
    end;
    
    if not vtTemplates.Active then
      vtTemplates.Open;
    if not vtTemplates.IsEmpty then
      vtTemplates.Clear;
    AssignFile(f, edSettingsFile.Text);
    Reset(f);
    while not Eof(f) do
    begin
      readln(f, s);
      if s = '' then
        s1 := ''
      else
        s1 := AnsiUpperCase(trim(copy(s, 1, pos('=', s) - 1)));
      if s = '' then
        s2 := '0'
      else
        s2 := AnsiUpperCase(trim(copy(s, pos('=', s) + 1,
                                                     Length(s) - pos('=', s))));
      vtTemplates.Append;
      vtTemplatesNameWithSeparators.AsString := s1;
      vtTemplatesPrice.AsFloat := StrTofloat(s2);
      vtTemplates.Post;
    end;
    CloseFile(f);
    TemplatesChanged := false;
  end;

  { XMLDoc := CoDOMDocument.Create;
    try
    XMLDoc.Load(ExtractFilePath(Application.ExeName) + 'settings.xml');
    Root := XMLDoc.DocumentElement;
    pb.Position := 0;
    pb.Max := Root.childNodes.Length - 1;
    for i := 0 to Root.childNodes.Length - 1 do
    begin
    vtTemplates.Append;
    vtTemplatesTemplate.AsString :=
    AnsiUpperCase(Root.childNodes.item[i].Text);
    vtTemplatesPrice.AsFloat :=
    StrTofloat(Root.childNodes.item[i].attributes.item[0].Text);
    vtTemplates.Post;
    pb.Position := i;
    end;
    finally
    Root := nil;
    XMLDoc := nil;
    end; }
end;

procedure TfmMain.TemplatesSave;
var
  f: textfile;
  s: string;
begin
  AssignFile(f, edSettingsFile.Text);
  Rewrite(f);
  vtTemplates.First;
  while not vtTemplates.Eof do
  begin
    if vtTemplatesNameWithSeparators.AsString = '' then
      s := ''
    else
      s := vtTemplatesNameWithSeparators.AsString + '=' + vtTemplatesPrice.AsString;
    Writeln(f, s);
    vtTemplates.Next;
  end;
  CloseFile(f);
  TemplatesChanged := false;
end;

procedure TfmMain.vtTemplatesAfterPost(DataSet: TDataSet);
begin
  TemplatesChanged := true and not InProgress;
end;

procedure TfmMain.vtTemplatesCalcFields(DataSet: TDataSet);
begin
  vtTemplatesTemplate.AsString := StringReplace(vtTemplatesNameWithSeparators.AsString
                                       , '-', '', [rfReplaceAll, rfIgnoreCase]);
end;

end.
