unit RefFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Forms, Vcl.Menus, ShellApi,
  Vcl.Graphics, Vcl.Controls, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.ExtCtrls, Vcl.ActnList, Vcl.DBCtrls,
  Data.DB, DBAccess, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  sBitBtn, sPanel, sScrollBox, sLabel, sToolBar, Ora, MemDS, CRGrid,
  VirtualTable, ExportGridToExcelPDF, DMUnit,
  ChildFrm, Func_Const, TimedMsgBox, RefFrmEdit, ImageVarnCl, Vcl.Buttons;

type
  TMyRf = class of TChildForm;

Type
  TLCls = array of TMyRf;

type
  TRefForm = class(TChildForm)
    actlst1: TActionList;
    aInsert: TAction;
    aEdit: TAction;
    aDelete: TAction;
    aRefresh: TAction;
    aPost: TAction;
    aCancel: TAction;
    pm1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    aNext: TAction;
    aPrev: TAction;
    aFirst: TAction;
    aLast: TAction;
    aFind: TAction;
    aFiltr: TAction;
    qGetNewId: TOraStoredProc;
    aMoveNext: TAction;
    aMovePrev: TAction;
    aToExcel: TAction;
    sPanel1: TsPanel;
    sBsave: TsBitBtn;
    sBClose: TsBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TlBr: TsToolBar;
    btnInsert: TToolButton;
    btnEdit: TToolButton;
    btnDelete: TToolButton;
    btn4: TToolButton;
    btnPost: TToolButton;
    btnCancel: TToolButton;
    btn7: TToolButton;
    btnRefresh: TToolButton;
    btnFind: TToolButton;
    btnFiltr: TToolButton;
    btnExcel: TToolButton;
    btn1: TToolButton;
    btnFirst: TToolButton;
    btnMovePrev: TToolButton;
    btnPrev: TToolButton;
    btnNext: TToolButton;
    btnMoveNext: TToolButton;
    btnLast: TToolButton;
    CRGrid: TCRDBGrid;
    procedure fdsGlQStateChange(Sender: TObject);
    procedure aInsertExecute(Sender: TObject);
    procedure aEditExecute(Sender: TObject);
    procedure aDeleteExecute(Sender: TObject);
    procedure aPostExecute(Sender: TObject);
    procedure aCancelExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FieldValidate(Sender: TField);
    procedure SetTextDate(Sender: TField; const Text: string);
    procedure FieldKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RfFormActivate(Sender: TObject);
    procedure sBsaveClick(Sender: TObject);

    procedure redtExit(Sender: TObject);
    procedure FullFormEdit;
    procedure saveBtnClick(Sender: TObject);
    procedure loadBtnClick(Sender: TObject);
    procedure saveRTFBtnClick(Sender: TObject);
    procedure loadRTFBtnClick(Sender: TObject);
    procedure newSprBtnClick(Sender: TObject);

    procedure aFindExecute(Sender: TObject);
    procedure aNextExecute(Sender: TObject);
    procedure aPrevExecute(Sender: TObject);
    procedure aFirstExecute(Sender: TObject);
    procedure aLastExecute(Sender: TObject);
    procedure fGlQAfterScroll(DataSet: TDataSet);
    procedure fGlQAfterOpen(DataSet: TDataSet);
    procedure Loaded; override;
    procedure FullColumnGrid(Grid: TDBGrid);

    procedure FormShow(Sender: TObject);
    procedure aFiltrExecute(Sender: TObject);
    procedure aMoveNextExecute(Sender: TObject);
    procedure aMovePrevExecute(Sender: TObject);
    procedure fGlQBeforePost(DataSet: TDataSet);
    procedure fGlQBeforeOpen(DataSet: TDataSet);
    procedure FullColumn_Array(DataSet: TDataSet);
    procedure SetGlQ(aValue: TOraQuery);
    procedure SetdsGlQ(aValue: TOraDataSource);
    procedure SetListCls(aValue: TLCls);
    procedure GetTextBoolean(Sender: TField; var Text: string;
      DisplayText: Boolean);

    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure aToExcelExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CRGridDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    DBMemoSize, Glob_Cnt: Integer;
    myCapt: string;
    RefFormEdit: TRefFormEdit;
    AllLoaded: Boolean;

    { Private declarations }
  protected
    procedure Setbuttons; virtual;
    procedure SetStatusBar; virtual;
    procedure SetFormMode(aValue: TFormMode); override;
  public
    fGlQ: TOraQuery;
    //fGlQ: TDataSet;
    fdsGlQ: TOraDataSource;
    aColumn_Array: TColumn_Array;
    AddExcelColNumber: Boolean;
    fListCls: TLCls;
    fCaptList: TStringList;
    procedure RefreshToolBar;

  published
    property GlQuery: TOraQuery read fGlQ write SetGlQ;
    property dsGlQ: TOraDataSource read fdsGlQ write SetdsGlQ;
    property ListCls: TLCls read fListCls write SetListCls;
    property CaptList: TStringList read fCaptList write fCaptList;

  end;

var
  RefForm: TRefForm;

implementation

{$R *.dfm}

procedure TRefForm.SetListCls(aValue: TLCls);
begin
  fListCls := aValue;
end;

procedure TRefForm.SetGlQ(aValue: TOraQuery);
var
  i: Integer;
begin
  fGlQ := aValue;
  fGlQ.Session := Dm.OraSession;
  fGlQ.AfterScroll := fGlQAfterScroll;
  fGlQ.BeforeOpen := fGlQBeforeOpen;
  fGlQ.BeforePost := fGlQBeforePost;
  fGlQ.AfterOpen := fGlQAfterOpen;
  fGlQ.Options.TemporaryLobUpdate := True;
  fGlQ.ReadOnly := True;
  if not Dm.vt.Active then
    Dm.vt.Open;
  for i := 0 to Dm.ComponentCount - 1 do
  begin
    if (Dm.Components[i].ClassName = 'TOraDataSource') or
      (Dm.Components[i].ClassName = 'TDataSource') then
    begin
      if ((Dm.Components[i] as TDataSource).DataSet = aValue) then
        dsGlQ := (Dm.Components[i] as TOraDataSource);
    end;
  end;
  if (dsGlQ = nil) then
    TimedMessageBox('К OraQuery - ' + fGlQ.Name + ' не установлен DATASOURCE!',
      'Пожалуйста, будьте внимательны!', mtError, [mbOK], mbOK, 25, 3);
  FullColumn_Array(fGlQ);
  FullColumnGrid(TDBGrid(CRGrid));
end;

procedure TRefForm.SetdsGlQ(aValue: TOraDataSource);
begin
  fdsGlQ := aValue;
  fdsGlQ.OnStateChange := fdsGlQStateChange;
  CRGrid.DataSource := fdsGlQ;
end;

procedure TRefForm.Loaded;
begin
  inherited;
  /// процедура выполняется до события FormCreate
  /// если нижна доп. инициализвция чего - либо - писать здесь

end;

procedure TRefForm.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  fCaptList := TStringList.Create;
  Glob_Cnt := 1;
  DBMemoSize := 890;
  for i := 0 to ComponentCount - 1 do
  begin
    if (Components[i].ClassName = 'TOraQuery') then
    begin
      (Components[i] as TOraQuery).Close;
      (Components[i] as TOraQuery).Session := Dm.OraSession;
    end;
    if (Components[i].ClassName = 'TOraStoredProc') then
    begin
      (Components[i] as TOraStoredProc).Session := Dm.OraSession;
    end;
  end;
  Dm.applMainForm.OnKeyDown := FormKeyDown;
  myCapt := Caption;
  if (FormStyle = fsNormal) and (BorderStyle = bsNone) then
    Dm.applMainForm.Caption := Dm.MainCaption + ' - ' + Caption;

  CRGrid.TitleFont.Style := [fsBold];
  CRGrid.ReadOnly := True;

  RefFormEdit := TRefFormEdit.Create(self);
  RefFormEdit.OnActivate := RfFormActivate;

  // fGlQBeforeOpen(DataSet: TDataSet);

  if fGlQ.Active then
  begin
    fGlQBeforeOpen(fGlQ);
    FitGrid(TDBGrid(CRGrid), Dm.fFileName, myCapt);
    FullFormEdit;
    FormMode := fmBrowse;
  end
  else
  begin
    if (fGlQ.SQL.Text <> '') then
      fGlQ.Open;
    FitGrid(TDBGrid(CRGrid), Dm.fFileName, myCapt);
    FullFormEdit;
    FormMode := fmBrowse;
  end;
  if (FormStyle = fsNormal) and (BorderStyle <> bsNone) then
    sPanel1.Visible := True;

  AddExcelColNumber := True;
  AllLoaded := True;
end;

procedure TRefForm.FormDestroy(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  for i := 0 to CRGrid.Columns.Count - 1 do
  begin
    WriteIniAny(Dm.fFileName, myCapt, CRGrid.Columns[i].FieldName,
      IntToStr(CRGrid.Columns[i].Width));
  end;
  if (FormStyle = fsNormal) and (BorderStyle = bsNone) then
    Dm.applMainForm.Caption := Dm.MainCaption;
  Dm.applMainForm.OnKeyDown := nil;
  Dm.applMainForm.OnKeyPress := nil;
  for i := Low(aColumn_Array) to High(aColumn_Array) do
  begin
//    if (aColumn_Array[i].LookupDataset <> nil) then
//      aColumn_Array[i].LookupDataset.Close;
    aColumn_Array[i].LookupDataset := nil;
    aColumn_Array[i].LookupDataSource := nil;
    aColumn_Array[i].Cmpnt1 := nil;
    aColumn_Array[i].Cmpnt2 := nil;
    aColumn_Array[i].Cmpnt3 := nil;
  end;

  fGlQ.AfterScroll := nil;
  fGlQ.BeforeOpen := nil;
  fGlQ.BeforePost := nil;
  fGlQ.AfterOpen := nil;
  fdsGlQ.OnStateChange := nil;

  SetLength(aColumn_Array, 0);
  RefFormEdit.Free;
  RefFormEdit := nil;
  for i := Low(fListCls) to High(fListCls) do
    fListCls[i] := nil;
  SetLength(fListCls, 0);
//  if (FormStyle = fsNormal) and (BorderStyle = bsNone) then
//    fGlQ.Close;
  fCaptList.Free;

end;

procedure TRefForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if ((Key = VK_F5) and aRefresh.Enabled) then
    aRefresh.Execute;
  inherited;
end;

procedure TRefForm.FullFormEdit;
var
  AllHeight, NumberDict, PanelHeight, cntPanel, i, q: Integer;
  pnl: TPanel;
  bvl: TBevel;
  lbl: TsLabel;
  fname: string;
  dbdt: TDBEdit;
  dblkcbb: TDBLookupComboBox;
  dbchk: TDBCheckBox;
  fdtp: TFieldType;
  img: TImageVarn;
  img_o: TImage;
  dbmmo: TDBMemo;
  redt: TRichEdit;
  sBtn, sBtn2: TsBitBtn;

  procedure CreatePanel;
  begin
    pnl := TPanel.Create(RefFormEdit);
    pnl.Parent := RefFormEdit.ScrollBox;
    pnl.Name := 'spn' + IntToStr(i) + IntToStr(q); // + IntToStr(i);
    pnl.Align := alBottom;
    pnl.Align := alTop;
    pnl.Height := PanelHeight;
    // pnl.BevelOuter := bvNone;
    pnl.Caption := '';
    cntPanel := cntPanel + 1;
    bvl := TBevel.Create(pnl);
    bvl.Parent := pnl;
    bvl.Name := 'bvl' + IntToStr(i) + '1';
    bvl.Top := 0;
    bvl.Height := PanelHeight;
    bvl.Left := 308;
    bvl.Width := 2;
    bvl := TBevel.Create(pnl);
    bvl.Parent := pnl;
    bvl.Name := 'bvl' + IntToStr(i) + '2';
    bvl.Top := 0;
    bvl.Height := PanelHeight;
    bvl.Left := 618;
    bvl.Width := 2;
  end;

  procedure CreateLabel;
  begin
    lbl := TsLabel.Create(pnl);
    lbl.Parent := pnl;
    lbl.AutoSize := False;
    lbl.Alignment := taRightJustify;
    lbl.Layout := tlCenter;
    lbl.WordWrap := True;
    lbl.Font.Style := [fsBold];
    lbl.Name := 'lbl' + IntToStr(i) + IntToStr(q);
    lbl.Caption := aColumn_Array[i].DisplayLabel;
    lbl.Top := 5;
    lbl.Tag := aColumn_Array[i].Tag;
    lbl.Height := 43;
    lbl.Left := 4 + 310 * (q - 1);
    lbl.Width := 100;
    aColumn_Array[i].Cmpnt1 := lbl;
  end;

  procedure CreateLookupStringComboBox;
  begin
    dblkcbb := TDBLookupComboBox.Create(pnl);
    dblkcbb.Parent := pnl;
    dblkcbb.Name := aColumn_Array[i].FieldName + '_dblkcbb' + IntToStr(i) +
      IntToStr(q);
    dblkcbb.Top := 17;
    dblkcbb.Height := 21;
    dblkcbb.Left := 112 + 310 * (q - 1);
    dblkcbb.Width := 190;
    dblkcbb.Tag := aColumn_Array[i].Tag;
    dblkcbb.DataSource := dsGlQ;
    dblkcbb.DataField := aColumn_Array[i].KeyFields;
    dblkcbb.KeyField := aColumn_Array[i].LookupKeyFields;
    dblkcbb.ListField := aColumn_Array[i].LookupResultField;
    dblkcbb.ListSource := aColumn_Array[i].LookupDataSource;
    aColumn_Array[i].Cmpnt2 := dblkcbb;
    if aColumn_Array[i].LookupDataSource.Tag = 0 then
    begin
      aColumn_Array[i].NumberDict := NumberDict;
      dblkcbb.Width := 162;
      sBtn := TsBitBtn.Create(pnl);
      sBtn.Parent := pnl;
      sBtn.Top := 17;
      sBtn.Height := 21;
      sBtn.Left := (dblkcbb.Left + dblkcbb.Width + 3);
      sBtn.Width := 26;
      sBtn.Name := aColumn_Array[i].FieldName + 'sBtn_' + IntToStr(i);
      sBtn.Caption := '';
      sBtn.Hint := 'Открыть справочник';
      sBtn.Images := Dm.ImageList24;
      sBtn.ImageIndex := 36;
      sBtn.Tag := aColumn_Array[i].Tag;
      sBtn.OnClick := newSprBtnClick;
      NumberDict := NumberDict + 1;
    end;
  end;

  procedure CreateLookupBooleanCheckBox;
  begin
    dbchk := TDBCheckBox.Create(pnl);
    dbchk.Parent := pnl;
    dbchk.Name := aColumn_Array[i].FieldName + '_dbchk' + IntToStr(i) +
      IntToStr(q);
    dbchk.Top := 5;
    dbchk.Height := 43;
    dbchk.Left := 60 + 310 * (q - 1);
    dbchk.Width := 200;
    dbchk.Tag := aColumn_Array[i].Tag;
    dbchk.WordWrap := True;
    dbchk.Font.Style := [fsBold];
    dbchk.Alignment := taRightJustify;
    dbchk.DataSource := dsGlQ;
    dbchk.DataField := aColumn_Array[i].KeyFields;
    dbchk.Caption := aColumn_Array[i].DisplayLabel;
    fdtp := dbchk.DataSource.DataSet.FieldByName
      (aColumn_Array[i].KeyFields).DataType;
    if (fdtp = ftBoolean) then
    begin
      dbchk.ValueChecked := 'True';
      dbchk.ValueUnchecked := 'False';
    end;
     if (fdtp = ftSmallint) or (fdtp = ftInteger) or (fdtp = ftWord) or (fdtp = ftFloat) or (fdtp = ftCurrency) then
    begin
      dbchk.ValueChecked := '1';
      dbchk.ValueUnchecked := '0';
    end;
    aColumn_Array[i].Cmpnt2 := dbchk;
  end;

  procedure CreateDBEdit;
  var
    rStream: TResourceStream;
  begin
    dbdt := TDBEdit.Create(pnl);
    dbdt.Parent := pnl;
    dbdt.Name := aColumn_Array[i].FieldName + '_dbdt' + IntToStr(i) +
      IntToStr(q);
    dbdt.Top := 17;
    dbdt.Height := 21;
    dbdt.Left := 112 + 310 * (q - 1);
    dbdt.Width := 190;
    dbdt.Tag := aColumn_Array[i].Tag;
    dbdt.DataSource := dsGlQ;
    dbdt.DataField := aColumn_Array[i].FieldName;
    if aColumn_Array[i].Required then
    begin
      dbdt.DataSource.DataSet.FieldByName(dbdt.DataField).OnValidate := FieldValidate;
      dbdt.OnKeyDown := FieldKeyDown;
      fname := Dm.PersonalPath + 'claim.png';
      img := TImageVarn.Create(pnl);
      img.Parent := pnl;
      img.Top := 11;
      img.Left := (dbdt.Left + dbdt.Width - 32);
      img.Height := 32;
      img.Width := 32;
      img.Tag := aColumn_Array[i].Tag;
      img.Transparent := True;
      img.Visible := False;
      img.AutoSize := True;
      img.Name := aColumn_Array[i].FieldName;
      if FileExists(fname) then
        img.Picture.Bitmap.LoadFromFile(fname)
      else
      begin
        rStream := TResourceStream.Create(hInstance, 'PngImage_1', RT_RCDATA);
        rStream.Position := 0;
        try
          rStream.SaveToFile(fname);
        finally
          rStream.Position := 0;
          img.Picture.Bitmap.LoadFromStream(rStream);
          // PNG загружать только так
          rStream.Free;
        end;
      end;
      aColumn_Array[i].Cmpnt3 := img;
    end;
    if (aColumn_Array[i].DataType = ftDate) or
      (aColumn_Array[i].DataType = ftDateTime) then
    begin
      dbdt.DataSource.DataSet.FieldByName(dbdt.DataField).OnSetText := SetTextDate;
    end;
    aColumn_Array[i].Cmpnt2 := dbdt;
  end;

  procedure CreatePanel2;
  begin
    pnl := TPanel.Create(RefFormEdit);
    pnl.Parent := RefFormEdit.ScrollBox;
    pnl.Name := 'spn' + IntToStr(i) + IntToStr(q); // + IntToStr(i);
    pnl.Align := alBottom;
    pnl.Align := alTop;
    pnl.Height := PanelHeight * 2;
    // pnl.BevelOuter := bvNone;
    pnl.Caption := '';
    lbl := TsLabel.Create(pnl);
    lbl.Parent := pnl;
    lbl.AutoSize := False;
    lbl.Alignment := taRightJustify;
    lbl.Layout := tlCenter;
    lbl.WordWrap := True;
    lbl.Font.Style := [fsBold];
    lbl.Name := 'lbl_' + IntToStr(i);
    lbl.Caption := aColumn_Array[i].DisplayLabel;
    lbl.Top := 2;
    lbl.Height := 112;
    lbl.Left := 4;
    lbl.Width := 80;
    lbl.Tag := aColumn_Array[i].Tag;
    aColumn_Array[i].Cmpnt1 := lbl;
    AllHeight := AllHeight + pnl.Height;
  end;

  procedure CreatePanel3;
  begin
    pnl := TPanel.Create(RefFormEdit);
    pnl.Parent := RefFormEdit.ScrollBox;
    pnl.Name := 'spn' + IntToStr(i) + IntToStr(q); // + IntToStr(i);
    pnl.Align := alBottom;
    pnl.Align := alTop;
    pnl.Height := PanelHeight * 6;
    // pnl.BevelOuter := bvNone;
    pnl.Caption := '';
    lbl := TsLabel.Create(pnl);
    lbl.Parent := pnl;
    lbl.AutoSize := False;
    lbl.Alignment := taRightJustify;
    lbl.Layout := tlCenter;
    lbl.WordWrap := True;
    lbl.Font.Style := [fsBold];
    lbl.Name := 'lbl_' + IntToStr(i);
    lbl.Caption := aColumn_Array[i].DisplayLabel;
    lbl.Top := 2;
    lbl.Height := 200;
    lbl.Left := 4;
    lbl.Width := 80;
    lbl.Tag := aColumn_Array[i].Tag;
    aColumn_Array[i].Cmpnt1 := lbl;
    AllHeight := AllHeight + pnl.Height;
  end;

begin
  q := 1;
  cntPanel := 0;
  PanelHeight := 58;
  NumberDict := 1;
  for i := Low(aColumn_Array) to High(aColumn_Array) do
  begin
    if aColumn_Array[i].ReadOnly or aColumn_Array[i].IsBlob or
      (aColumn_Array[i].Size > DBMemoSize) then
      Continue;
    if (q > 3) then
      q := 1;
    if (q = 1) then // на счет 1,2,3 новая панель
      CreatePanel;
    if (aColumn_Array[i].FieldKind = fkLookup) then // составное поле
    begin
      if (aColumn_Array[i].DataType = ftString) then //
      begin
        CreateLabel;
        CreateLookupStringComboBox;
      end;
      if (aColumn_Array[i].DataType = ftBoolean) then //
        CreateLookupBooleanCheckBox;
    end
    else
    begin
      CreateLabel;
      if (aColumn_Array[i].DataType = ftString) or
        (aColumn_Array[i].DataType = ftDate) or
        (aColumn_Array[i].DataType = ftDateTime) or
        (aColumn_Array[i].DataType = ftTime) or
        (aColumn_Array[i].DataType = ftFloat) or
        (aColumn_Array[i].DataType = ftCurrency) or
        (aColumn_Array[i].DataType = ftInteger) then
        CreateDBEdit;
    end;
    q := q + 1;
  end;
  AllHeight := cntPanel * (PanelHeight + 3);

  for i := Low(aColumn_Array) to High(aColumn_Array) do
  begin
    if aColumn_Array[i].IsBlob or (aColumn_Array[i].Size > DBMemoSize) then
    begin
      if aColumn_Array[i].DataType = ftString then
      begin
        CreatePanel2;
        dbmmo := TDBMemo.Create(pnl);
        dbmmo.Parent := pnl;
        dbmmo.Top := 2;
        dbmmo.Height := 116;
        dbmmo.Left := 88;
        dbmmo.Width := 836;
        dbmmo.Tag := aColumn_Array[i].Tag;
        dbmmo.Name := aColumn_Array[i].FieldName + 'dbmmo_' + IntToStr(i);
        dbmmo.ScrollBars := ssVertical;
        dbmmo.DataSource := dsGlQ;
        dbmmo.DataField := aColumn_Array[i].FieldName;
        aColumn_Array[i].Cmpnt2 := dbmmo;
      end
      else if aColumn_Array[i].DataType = ftOraClob then
      begin
        CreatePanel2;
        pnl.Height := pnl.Height + 112;
        // redt: TRichEdit;
        redt := TRichEdit.Create(pnl);;
        redt.Parent := pnl;
        redt.Top := 2;
        redt.Height := 224;
        redt.Left := 108;
        redt.Width := 816;
        redt.Tag := aColumn_Array[i].Tag;
        redt.Name := aColumn_Array[i].FieldName + 'redt_' + IntToStr(i);
        redt.ScrollBars := ssVertical;
        redt.OnExit := redtExit;
        aColumn_Array[i].Cmpnt2 := redt;
        sBtn := TsBitBtn.Create(pnl);
        sBtn.Parent := pnl;
        sBtn.Top := 118;
        sBtn.Height := 31;
        sBtn.Left := 4;
        sBtn.Width := 99;
        sBtn.Name := 'sBtn_' + IntToStr(i);
        sBtn.Caption := 'Сохранить';
        sBtn.Hint := 'Сохранить текст из программы в указанную папку';
        sBtn.Images := Dm.ImageList24;
        sBtn.ImageIndex := 24;
        sBtn.Tag := aColumn_Array[i].Tag;
        sBtn.OnClick := saveRTFBtnClick;
        sBtn2 := TsBitBtn.Create(pnl);
        sBtn2.Parent := pnl;
        sBtn2.Top := 153;
        sBtn2.Height := 31;
        sBtn2.Left := 4;
        sBtn2.Width := 99;
        sBtn2.Name := 'sBtn2_' + IntToStr(i);
        sBtn2.Caption := 'Загрузить';
        sBtn2.Hint := 'Загрузить текст в программу из указанной папки';
        sBtn2.Images := Dm.ImageList24;
        sBtn2.ImageIndex := 47;
        sBtn2.Tag := aColumn_Array[i].Tag;
        sBtn2.OnClick := loadRTFBtnClick;

      end
      else if aColumn_Array[i].DataType = ftOraBlob then
      begin
        CreatePanel3;
        img_o := TImage.Create(pnl);
        img_o.Parent := pnl;
        img_o.Top := 2;
        img_o.Height := pnl.Height - 4;
        img_o.Left := 108;
        img_o.Width := 816;
        img_o.Name := aColumn_Array[i].FieldName + 'img_o_' + IntToStr(i);
        img_o.Transparent := True;
        img_o.Center := True;
        img_o.Proportional := True;
        // img_o.Stretch := True;
        img_o.Tag := aColumn_Array[i].Tag;
        sBtn := TsBitBtn.Create(pnl);
        sBtn.Parent := pnl;
        sBtn.Top := 185;
        sBtn.Height := 31;
        sBtn.Left := 4;
        sBtn.Width := 99;
        sBtn.Name := 'sBtn_' + IntToStr(i);
        sBtn.Caption := 'Сохранить';
        sBtn.Hint := 'Сохранить картинку из программы в указанную папку';
        sBtn.Images := Dm.ImageList24;
        sBtn.ImageIndex := 24;
        sBtn.Tag := aColumn_Array[i].Tag;
        sBtn.OnClick := saveBtnClick;
        sBtn2 := TsBitBtn.Create(pnl);
        sBtn2.Parent := pnl;
        sBtn2.Top := 220;
        sBtn2.Height := 31;
        sBtn2.Left := 4;
        sBtn2.Width := 99;
        sBtn2.Name := 'sBtn2_' + IntToStr(i);
        sBtn2.Caption := 'Загрузить';
        sBtn2.Hint := 'Загрузить картинку в программу из указанной папки';
        sBtn2.Images := Dm.ImageList24;
        sBtn2.ImageIndex := 47;
        sBtn2.Tag := aColumn_Array[i].Tag;
        sBtn2.OnClick := loadBtnClick;
        aColumn_Array[i].Cmpnt2 := img_o;
      end;
    end;
  end;
  RefFormEdit.sBsave.OnClick := sBsaveClick;
  if ((AllHeight + 35) < 563) then
  begin
    RefFormEdit.ClientHeight := (AllHeight + 35);
  end;

end;

procedure TRefForm.RfFormActivate(Sender: TObject);
var
  dl, i: Integer;
  nm, fname: string;
  BStream: TStream;
  SStream: TStringStream;
  img_o: TImage;
  redt: TRichEdit;
begin
  for i := Low(aColumn_Array) to High(aColumn_Array) do
  begin
    if aColumn_Array[i].DataType = ftOraBlob then
    begin
      img_o := TImage(aColumn_Array[i].Cmpnt2);
      dl := Length(aColumn_Array[i].FieldName);
      nm := Copy(img_o.Name, 1, dl);
      if (nm = aColumn_Array[i].FieldName) then
      begin
        if not fGlQ.FieldByName(aColumn_Array[i].FieldName).IsNull then
        begin
          BStream := fGlQ.CreateBlobStream
            (fGlQ.FieldByName(aColumn_Array[i].FieldName), bmRead);
          if BStream.Size > 0 then
          begin
            BStream.Position := 0;
            SStream := TStringStream.Create('');
            SStream.CopyFrom(BStream, BStream.Size);
            fname := Dm.PersonalPath + 's.jpg';
            SStream.Position := 0;
            SStream.SaveToFile(fname);
            try
              try
                img_o.Picture.LoadFromFile(fname);
                if FileExists(fname) then
                  DeleteFile(fname);
              except
                if FileExists(fname) then
                  DeleteFile(fname);
                fname := Dm.PersonalPath + 's.bmp';
                SStream.Position := 0;
                SStream.SaveToFile(fname);
                try
                  img_o.Picture.LoadFromFile(fname);
                  if FileExists(fname) then
                    DeleteFile(fname);
                except
                  if FileExists(fname) then
                    DeleteFile(fname);
                  fname := Dm.PersonalPath + 's.png';
                  SStream.Position := 0;
                  SStream.SaveToFile(fname);
                  try
                    img_o.Picture.LoadFromFile(fname);
                    if FileExists(fname) then
                      DeleteFile(fname);
                  except
                    if FileExists(fname) then
                      DeleteFile(fname);
                    TimedMessageBox
                      ('Картинки в блоб-поле можно отображать только типов bmp, jpg, png',
                      'Пожалуйста, будьте внимательны!', mtError, [mbCancel],
                      mbCancel, 15, 3);
                  end;
                end;
              end;
            finally
              BStream.Free;
              SStream.Free;
            end;
          end;
        end;
      end;
    end
    else if aColumn_Array[i].DataType = ftOraClob then
    begin
      redt := TRichEdit(aColumn_Array[i].Cmpnt2);
      dl := Length(aColumn_Array[i].FieldName);
      nm := Copy(redt.Name, 1, dl);
      if (nm = aColumn_Array[i].FieldName) then
      begin
        if not fGlQ.FieldByName(aColumn_Array[i].FieldName).IsNull then
        begin
          BStream := fGlQ.CreateBlobStream
            (fGlQ.FieldByName(aColumn_Array[i].FieldName), bmRead);
          if BStream.Size > 0 then
          begin
            BStream.Position := 0;
            SStream := TStringStream.Create('');
            SStream.CopyFrom(BStream, BStream.Size);
            fname := Dm.PersonalPath + 's.rtf';
            SStream.Position := 0;
            SStream.SaveToFile(fname);
            try
              redt.Lines.LoadFromFile(fname);
              if FileExists(fname) then
                DeleteFile(fname);
            except
              if FileExists(fname) then
                DeleteFile(fname);
              TimedMessageBox
                ('Текст  в клоб-поле можно отображать только типа rtf',
                'Пожалуйста, будьте внимательны!', mtError, [mbCancel],
                mbCancel, 15, 3);
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TRefForm.redtExit(Sender: TObject);
var
  i: Integer;
  redt: TRichEdit;
begin
  for i := Low(aColumn_Array) to High(aColumn_Array) do
  begin
    if (TRichEdit(Sender).Tag = aColumn_Array[i].Tag) then
    begin
      redt := TRichEdit(aColumn_Array[i].Cmpnt2);
      redt.Lines.SaveToStream
        (fGlQ.CreateBlobStream(fGlQ.FieldByName(aColumn_Array[i].FieldName),
        bmWrite));
    end;
  end;
end;

procedure TRefForm.saveRTFBtnClick(Sender: TObject);
var
  i: Integer;
  redt: TRichEdit;
  dlt: Boolean;
begin
  for i := Low(aColumn_Array) to High(aColumn_Array) do
  begin
    if (TRichEdit(Sender).Tag = aColumn_Array[i].Tag) then
    begin
      redt := TRichEdit(aColumn_Array[i].Cmpnt2);
      Dm.dlgSave.Filter := '(*.rtf)|*.rtf|(*.txt)|*.txt';
      Dm.dlgSave.InitialDir := Dm.PersonalPath;
      if Dm.dlgSave.Execute then
      begin
        if FileExists(Dm.dlgSave.FileName) then
        begin
          if (TimedMessageBox
            ('Такой файл уже есть! Заменить существующий файл на новый?',
            'Пожалуйста, будьте внимательны!', mtConfirmation, [mbYes, mbNo],
            mbNo, 15, 3) = IDYES) then
          begin
            DeleteFile(Dm.dlgSave.FileName);
            dlt := True;
          end
          else
            dlt := False;
        end
        else
        begin
          dlt := True;
        end;
        if dlt then
        begin
          redt.Lines.SaveToFile(Dm.dlgSave.FileName);
          if (TimedMessageBox('Открыть сохраненный файл для просмотра?',
            'Файл успешно сохранен', mtConfirmation, [mbYes, mbNo], mbNo, 15, 3)
            = IDYES) then
          begin
            ShellExecute(0, 'open', PChar(Dm.dlgSave.FileName), '', '',
              SW_SHOWNORMAL);
          end;
        end;
      end;
    end;
  end;
end;

procedure TRefForm.newSprBtnClick(Sender: TObject);
var
  NumberDict, i: Integer;
  fr: TMyRf;
  New_F: TChildForm;
  st: string;
  vl: Variant;
  mfld: TField;
begin
  for i := Low(aColumn_Array) to High(aColumn_Array) do
  begin
    if (TsBitBtn(Sender).Tag = aColumn_Array[i].Tag) then
    begin
      NumberDict := aColumn_Array[i].NumberDict;
      st := aColumn_Array[i].DisplayLabel;
      fr := TMyRf(fListCls[(NumberDict - 1)]);
      New_F := fr.Create(self, New_F, st, True);
      try
        New_F.Width := Width;
        New_F.Height := Height;
        New_F.Top := Top;
        New_F.Left := Left;
        New_F.Caption := CaptList[NumberDict - 1];
        if (New_F.ShowModal = mrOk) then
        begin
          mfld := TRefForm(New_F).fGlQ.FindField(aColumn_Array[i].LookupKeyFields);
          if (mfld <> nil) then
            vl := mfld.Value
          else
            vl := TRefForm(New_F).fGlQ.FieldByName(TRefForm(New_F).fGlQ.KeyFields).Value;
          fGlQ.FieldByName(aColumn_Array[i].LookupKeyFields).Value := vl;
        end;
      finally
        New_F.Free;
      end;
      break;
    end;
  end;
end;

procedure TRefForm.loadRTFBtnClick(Sender: TObject);
var
  i: Integer;
  redt: TRichEdit;
begin
  for i := Low(aColumn_Array) to High(aColumn_Array) do
  begin
    if (TRichEdit(Sender).Tag = aColumn_Array[i].Tag) then
    begin
      redt := TRichEdit(aColumn_Array[i].Cmpnt2);
      Dm.dlgOpen.Filter := '(*.rtf)|*.rtf|(*.txt)|*.txt';
      Dm.dlgOpen.InitialDir := Dm.PersonalPath;
      if Dm.dlgOpen.Execute then
      begin
        redt.Lines.LoadFromFile(Dm.dlgOpen.FileName);
        redt.Lines.SaveToStream
          (fGlQ.CreateBlobStream(fGlQ.FieldByName(aColumn_Array[i].FieldName),
          bmWrite));
      end;
    end;
  end;
end;

procedure TRefForm.saveBtnClick(Sender: TObject);
var
  i: Integer;
  dlt: Boolean;
  FData: TFileStream;
  BStream: TStream;
  fname: string;
begin
  for i := Low(aColumn_Array) to High(aColumn_Array) do
  begin
    if (TsBitBtn(Sender).Tag = aColumn_Array[i].Tag) then
    begin
      Dm.SavePictureDialog.InitialDir := Dm.PersonalPath;
      if Dm.SavePictureDialog.Execute then
      begin
        fname := Dm.SavePictureDialog.FileName;
        // + Dm.SavePictureDialog.Filter;
        if FileExists(fname) then
        begin
          if (TimedMessageBox('Такой файл уже есть! Заменить существующий файл на новый?',
            'Пожалуйста, будьте внимательны!', mtConfirmation, [mbYes, mbNo],
            mbNo, 15, 3) = IDYES) then
          begin
            DeleteFile(fname);
            dlt := True;
          end
          else
            dlt := False;
        end
        else
        begin
          dlt := True;
        end;
        if dlt then
        begin
          FData := TFileStream.Create(fname, fmCreate or fmOpenReadWrite);
          BStream := fGlQ.CreateBlobStream
            (fGlQ.FieldByName(aColumn_Array[i].FieldName), bmRead);
          BStream.Position := 0;
          try
            FData.CopyFrom(BStream, BStream.Size);
          finally
            BStream.Free;
            FData.Free;
          end;
          if (TimedMessageBox('Открыть сохраненный файл для просмотра?',
            'Файл успешно сохранен', mtConfirmation, [mbYes, mbNo], mbNo, 15, 3)
            = IDYES) then
          begin
            ShellExecute(0, 'open', PChar(fname), '', '', SW_SHOWNORMAL);
          end;
        end;
      end;
    end;
  end;
end;

procedure TRefForm.loadBtnClick(Sender: TObject);
var
  i: Integer;
  FData: TFileStream;
  BStream: TStream;
  fname: string;
  img_o: TImage;
begin
  for i := Low(aColumn_Array) to High(aColumn_Array) do
  begin
    if (TsBitBtn(Sender).Tag = aColumn_Array[i].Tag) then
    begin
      img_o := TImage(aColumn_Array[i].Cmpnt2);
      Dm.dlgOpenPic.InitialDir := Dm.PersonalPath;
      if Dm.dlgOpenPic.Execute then
      begin
        fname := Dm.dlgOpenPic.FileName;
        try
          img_o.Picture.LoadFromFile(fname);
          FData := TFileStream.Create(fname, fmOpenRead);
          FData.Position := 0;
          BStream := fGlQ.CreateBlobStream(fGlQ.FieldByName(aColumn_Array[i].FieldName), bmWrite);
          try
            BStream.CopyFrom(FData, FData.Size);
          finally
            BStream.Free;
            FData.Free;
          end;
        except
          on E: Exception do
            TimedMessageBox(E.Message, 'Пожалуйста, будьте внимательны!',
              mtWarning, [mbOK], mbOK, 15, 3);
        end;
      end;
    end;
  end;
end;

procedure TRefForm.SetTextDate(Sender: TField; const Text: string);
var
  FieldName, FieldName2, ss: string;
  dbdt: TDBEdit;
  i: Integer;
  dd: TDateTime;
  chk: Boolean;
begin
  inherited;
  FieldName2 := (Sender as TField).DisplayLabel;
  i := (Sender as TField).Tag;
  chk := False;
  if (Sender.Asstring = '') and (Text = '  .  .    ') then
    Exit;
  if ((Sender as TField).DataType = ftDateTime) then
  begin
    chk := TryStrToDateTime(Text, dd);
    ss := 'Значение в поле ' + FieldName2 + #10 + #13 + '"' + Text + '"' +
      ' - неправильная дата или время';
  end
  else if ((Sender as TField).DataType = ftDate) then
  begin
    chk := TryStrToDate(Text, dd);
    ss := 'Значение в поле ' + FieldName2 + #10 + #13 + '"' + Text + '"' +
      ' - неправильная дата';
  end
  else if ((Sender as TField).DataType = ftTime) then
  begin
    chk := TryStrToTime(Text, dd);
    ss := 'Значение в поле ' + FieldName2 + #10 + #13 + '"' + Text + '"' +
      ' - неправильное время';
  end;
  if not chk then
  begin
    FieldName := (Sender as TField).FieldName;
    TimedMessageBox(ss, 'Пожалуйста, будьте внимательны!', mtWarning, [mbOK],
      mbOK, 15, 3);
    dbdt := TDBEdit(aColumn_Array[i].Cmpnt2);
    if (dbdt <> nil) then
      dbdt.Text := '';
    raise EAbort.Create('');
  end
  else
    Sender.Asstring := Text;
end;

procedure TRefForm.FieldValidate(Sender: TField);
var
  i: Integer;
  img: TImageVarn;
  dbdt: TDBEdit;
  FieldName, FieldName2: string;
begin
  inherited;
  FieldName := (Sender as TField).FieldName;
  FieldName2 := (Sender as TField).DisplayLabel;
  i := (Sender as TField).Tag;
  img := TImageVarn(aColumn_Array[i].Cmpnt3);
  dbdt := TDBEdit(aColumn_Array[i].Cmpnt2);
  if Sender.Asstring = '' then
  begin
    if (img <> nil) and (dbdt <> nil) then
    begin
      Glob_Cnt := Glob_Cnt + 1;
      dbdt.Width := 158;
      dbdt.Hint := 'Поле ' + FieldName2 + ' обязательно к заполнению';
      img.Blink := True;
      dbdt.SetFocus;
    end;
    if (Glob_Cnt > 3) then
    begin
      TimedMessageBox('Поле ' + FieldName2 + ' обязательно к заполнению',
        'Пожалуйста, будьте внимательны!', mtWarning, [mbOK], mbOK, 5, 3);
      Glob_Cnt := 1;
    end;
    raise EAbort.Create('');

  end
  else
  begin
    if (img <> nil) and (dbdt <> nil) then
    begin
      dbdt.Width := 170;
      dbdt.Hint := '';
      img.Blink := False;
    end;
  end;
end;

procedure TRefForm.FieldKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  img: TImageVarn;
begin
  inherited;
  if (Key = VK_ESCAPE) then
  begin
    img := TImageVarn(aColumn_Array[TDBEdit(Sender).Tag].Cmpnt3);
    TDBEdit(Sender).Width := 190;
    TDBEdit(Sender).Hint := '';
    img.Blink := False;
  end;
end;

procedure TRefForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  fGlQ.Filter := '';
  fGlQ.Filtered := False;
end;

procedure TRefForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  ss: string;
begin
  if (FormMode = fmInsert) then
    ss := 'Вы вставили запись! Данные не сохранены. ';
  if (FormMode = fmEdit) then
    ss := 'Вы редактируете запись! Данные не сохранены. ';
  if ss <> '' then
    CanClose := (TimedMessageBox(ss + 'Закрыть с потерей данных?',
      'Пожалуйста, будьте внимательны!', mtConfirmation, [mbYes, mbNo], mbNo,
      15, 3) = IDYES);
end;

procedure TRefForm.fGlQAfterOpen(DataSet: TDataSet);
begin
//  FitGrid(TDBGrid(CRGrid), Dm.fFileName, myCapt);
//  FullFormEdit;
end;

procedure TRefForm.fGlQAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if AllLoaded then
  begin
    aNext.Enabled := not DataSet.Eof;
    aMoveNext.Enabled := not DataSet.Eof;
    aLast.Enabled := not DataSet.Eof;
    aPrev.Enabled := not DataSet.Bof;
    aMovePrev.Enabled := not DataSet.Bof;
    aFirst.Enabled := not DataSet.Bof;
  end;
end;

procedure TRefForm.GetTextBoolean(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if (Sender.Value = True) then
    Text := 'Да'
  else
    Text := 'Нет';
end;

procedure TRefForm.FullColumnGrid(Grid: TDBGrid);
var
  i, r: Integer;
  FieldName: string;
  Col: TColumn;
begin
  for r := 0 to Grid.Columns.Count - 1 do
  begin
    //Grid.Columns[r].ReadOnly := True;
    FieldName := Grid.Columns[r].FieldName;
    for i := Low(aColumn_Array) to High(aColumn_Array) do
      if (FieldName = aColumn_Array[i].FieldName) then
        aColumn_Array[i].IsHandCreated := True;
  end;
  for i := Low(aColumn_Array) to High(aColumn_Array) do
  begin
    if aColumn_Array[i].IsHandCreated then
      Continue;
    Col := Grid.Columns.Add;
    Col.FieldName := aColumn_Array[i].FieldName;
    Col.Title.Caption := aColumn_Array[i].DisplayLabel;
    Col.Title.Alignment := taCenter;
  end;
end;

procedure TRefForm.FullColumn_Array(DataSet: TDataSet);
var
  i, r, q: Integer;
begin
  SetLength(aColumn_Array, 0);
  for q := 0 to DataSet.FieldCount - 1 do
  begin
    if DataSet.Fields[q].Visible then
    begin
      r := Length(aColumn_Array);
      SetLength(aColumn_Array, r + 1); // Length(aColumn_Array) + 1);
      aColumn_Array[r].FieldName := DataSet.Fields[q].FieldName;
      aColumn_Array[r].FieldKind := DataSet.Fields[q].FieldKind;
      aColumn_Array[r].DisplayLabel := DataSet.Fields[q].DisplayLabel;
      aColumn_Array[r].ReadOnly := DataSet.Fields[q].ReadOnly;
      aColumn_Array[r].Required := DataSet.Fields[q].Required;
      aColumn_Array[r].Size := DataSet.Fields[q].Size;
      DataSet.Fields[q].Tag := r;
      aColumn_Array[r].IsBlob := DataSet.Fields[q].IsBlob;
      aColumn_Array[r].DisplayWidth := DataSet.Fields[q].DisplayWidth;
      aColumn_Array[r].Tag := DataSet.Fields[q].Tag;
      if (DataSet.Fields[q].FieldKind = fkLookup) then
      begin
        aColumn_Array[r].KeyFields := DataSet.Fields[q].KeyFields;
        aColumn_Array[r].LookupDataset := DataSet.Fields[q].LookupDataset;
        if not DataSet.Fields[q].LookupDataset.Active then
          DataSet.Fields[q].LookupDataset.Open;
        for i := 0 to Dm.ComponentCount - 1 do
        begin
          if (Dm.Components[i].ClassName = 'TOraDataSource') or
            (Dm.Components[i].ClassName = 'TDataSource') then
          begin
            if ((Dm.Components[i] as TDataSource).DataSet = aColumn_Array[r].LookupDataset) then
              aColumn_Array[r].LookupDataSource := (Dm.Components[i] as TDataSource);
          end;
        end;
        aColumn_Array[r].LookupKeyFields := DataSet.Fields[q].LookupKeyFields;
        aColumn_Array[r].LookupResultField := DataSet.Fields[q].LookupResultField;
      end;
      aColumn_Array[r].DataType := DataSet.Fields[q].DataType;
      if (aColumn_Array[r].DataType = ftBoolean) then
        DataSet.Fields[q].OnGetText := GetTextBoolean;
    end;
  end;
end;

procedure TRefForm.fGlQBeforeOpen(DataSet: TDataSet);
var
  i: Integer;
  ss: string;
begin
  inherited;
  if Dm.DebugMode then
  begin
    ss := '';
    for i := Low(aColumn_Array) to High(aColumn_Array) do
      if (aColumn_Array[i].FieldName = aColumn_Array[i].DisplayLabel) then
        ss := ss + aColumn_Array[i].DisplayLabel + ', ';
    if ss <> '' then
    begin
      ss := Copy(ss, 1, Length(ss) - 2);
      TimedMessageBox('  У следующих полей не заполнены значения DisplayLabel '
        + ' - ' + #10 + #13 + ss, 'Внимание! Это видно только в дебаг режиме',
        mtWarning, [mbOK], mbOK, 15, 3);
    end;
  end;
end;

procedure TRefForm.fGlQBeforePost(DataSet: TDataSet);
var
  i: Integer;
begin
  for i := 0 to fGlQ.FieldCount - 1 do
  begin
    if fGlQ.Fields[i].Required then
    begin
      if (fGlQ.Fields[i].DataType = ftSmallint) or (fGlQ.Fields[i].DataType = ftInteger) or (fGlQ.Fields[i].DataType = ftFloat) then
        if (fGlQ.Fields[i].IsNull) then
        begin
          TimedMessageBox('Ошибка' + ' - ' + 'значение' + ' ' + fGlQ.Fields[i].DisplayLabel + ' ' + 'не заполнено', 'Внимание!', mtError, [mbAbort], mbAbort, 15, 3);
          raise EAbort.Create('');
        end;
      if (fGlQ.Fields[i].DataType = ftString) then
        if (fGlQ.Fields[i].IsNull) or (Trim(fGlQ.Fields[i].Asstring) = '') then
        begin
          TimedMessageBox('Ошибка' + ' - ' + 'значение' + ' ' + fGlQ.Fields[i].DisplayLabel + ' ' + 'не заполнено', 'Внимание!', mtError, [mbAbort], mbAbort, 15, 3);
          raise EAbort.Create('');
        end;
    end;
  end;
  if ((fGlQ.KeySequence = '') and (qGetNewId.StoredProcName <> '') and (fGlQ.State in [dsInsert]) and (fGlQ.KeyFields <> '')) then
  begin
    qGetNewId.ExecSQL;
    fGlQ.FieldByName(fGlQ.KeyFields).Value :=
      qGetNewId.ParamByName('RESULT').Value;
  end;

  inherited;
end;

procedure TRefForm.SetFormMode(aValue: TFormMode);
begin
  inherited SetFormMode(aValue);
  if ((aValue = fmInsert) or (aValue = fmEdit)) then
    SendMessage(sndWind, WM_NOTIFY_CHGMODE, 0, DWORD(PChar('SetEdit')));
  if ((aValue = fmBrowse) or (aValue = fmInactive)) then
    SendMessage(sndWind, WM_NOTIFY_CHMODE, 0, DWORD(PChar('Setbrowse')));
  Setbuttons;
  SetStatusBar;
end;

procedure TRefForm.Setbuttons;

  procedure SetBrowseButtons;
  begin
    aPost.Enabled := False;
    aRefresh.Enabled := True;
    aCancel.Enabled := False;
    aInsert.Enabled := True;
    aDelete.Enabled := True;
    aEdit.Enabled := True;
    aFind.Enabled := True;
    aFiltr.Enabled := True;
    aNext.Enabled := True;
    aPrev.Enabled := True;
    aFirst.Enabled := True;
    aLast.Enabled := True;
    aMoveNext.Enabled := True;
    aMovePrev.Enabled := True;
    aToExcel.Enabled := True;
    CRGrid.Enabled := True;
  end;

  procedure SetInsertButtons;
  begin
    aPost.Enabled := True;
    aRefresh.Enabled := False;
    aCancel.Enabled := True;
    aInsert.Enabled := False;
    aDelete.Enabled := False;
    aEdit.Enabled := False;
    aFind.Enabled := False;
    aFiltr.Enabled := False;
    aNext.Enabled := False;
    aPrev.Enabled := False;
    aFirst.Enabled := False;
    aLast.Enabled := False;
    aMoveNext.Enabled := False;
    aMovePrev.Enabled := False;
    aToExcel.Enabled := False;
  end;

  procedure SetEditButtons;
  begin
    aPost.Enabled := True;
    aRefresh.Enabled := False;
    aCancel.Enabled := True;
    aInsert.Enabled := False;
    aDelete.Enabled := False;
    aEdit.Enabled := False;
    aFind.Enabled := False;
    aFiltr.Enabled := False;
    aNext.Enabled := False;
    aPrev.Enabled := False;
    aFirst.Enabled := False;
    aLast.Enabled := False;
    aMoveNext.Enabled := False;
    aMovePrev.Enabled := False;
    aToExcel.Enabled := False;
  end;

  procedure SetInactiveButtons;
  begin
    aPost.Enabled := False;
    aRefresh.Enabled := False;
    aCancel.Enabled := False;
    aInsert.Enabled := False;
    aDelete.Enabled := False;
    aEdit.Enabled := False;
    aFind.Enabled := False;
    aFiltr.Enabled := False;
    aNext.Enabled := False;
    aPrev.Enabled := False;
    aFirst.Enabled := False;
    aLast.Enabled := False;
    aMoveNext.Enabled := False;
    aMovePrev.Enabled := False;
    aToExcel.Enabled := False;
    CRGrid.Enabled := False;
  end;

begin
  case FormMode of
    fmBrowse:
      SetBrowseButtons;
    fmInsert:
      SetInsertButtons;
    fmEdit:
      SetEditButtons;
    fmInactive:
      SetInactiveButtons;
  end; { case }

end;

procedure TRefForm.SetStatusBar;
var
  capt: string;
begin
  case FormMode of
    fmBrowse:
      capt := 'просмотр';
    fmInsert:
      capt := 'вставка записи';
    fmEdit:
      capt := 'редактирование';
    fmInactive:
      capt := 'нет данных';
  end;
  Caption := myCapt + ' ' + capt;
  if (FormStyle = fsNormal) then
    Dm.applMainForm.Caption := Dm.MainCaption + ' - ' + Caption;
end;

procedure TRefForm.aPostExecute(Sender: TObject);
begin
  fGlQ.Post;
  fGlQ.ReadOnly := True;
end;

procedure TRefForm.aCancelExecute(Sender: TObject);
begin
  fGlQ.Cancel;
  fGlQ.ReadOnly := True;
end;

procedure TRefForm.aDeleteExecute(Sender: TObject);
begin
  if TimedMessageBox('Вы действительно хотите удалить эту запись ?', 'Пожалуйста, будьте внимательны!', mtConfirmation, [mbYes, mbNo], mbNo, 15, 3) = 6 then
  begin
    fGlQ.ReadOnly := False;
    fGlQ.Delete;
  end;
end;

procedure TRefForm.aEditExecute(Sender: TObject);
begin
  fGlQ.ReadOnly := False;
  fGlQ.Edit;
  RefFormEdit.Caption := myCapt + ' - режим редактирования.';
  try
    if (RefFormEdit.ShowModal <> mrOk) then
      fGlQ.Cancel;
  except
    fGlQ.Cancel;
  end;
  fGlQ.ReadOnly := True;
end;

procedure TRefForm.aInsertExecute(Sender: TObject);
begin
  fGlQ.ReadOnly := False;
  fGlQ.Insert;
  RefFormEdit.Caption := myCapt + ' - режим добавления.';
  try
    if (RefFormEdit.ShowModal <> mrOk) then
      fGlQ.Cancel;
  except
    fGlQ.Cancel;
  end;
  fGlQ.ReadOnly := True;
end;

procedure TRefForm.sBsaveClick(Sender: TObject);
begin
  if ((dsGlQ.State = dsEdit) or (dsGlQ.State = dsInsert)) then
    fGlQ.Post;
  RefFormEdit.ModalResult := mrOk;
end;

procedure TRefForm.aFiltrExecute(Sender: TObject);
begin
  inherited;
  if aFiltr.checked then
  begin
    CRGrid.OptionsEx := CRGrid.OptionsEx + [dgeFilterBar];
    if ((dsGlQ.State = dsEdit) or (dsGlQ.State = dsInsert)) then
      fGlQ.Cancel;
  end
  else
    CRGrid.OptionsEx := CRGrid.OptionsEx - [dgeFilterBar];
end;

procedure TRefForm.aFindExecute(Sender: TObject);
begin
  inherited;
  if aFind.checked then
  begin
    CRGrid.OptionsEx := CRGrid.OptionsEx + [dgeSearchBar];
    if ((dsGlQ.State = dsEdit) or (dsGlQ.State = dsInsert)) then
      fGlQ.Cancel;
  end
  else
    CRGrid.OptionsEx := CRGrid.OptionsEx - [dgeSearchBar];
end;

procedure TRefForm.aFirstExecute(Sender: TObject);
begin
  inherited;
  fGlQ.First;
end;

procedure TRefForm.aLastExecute(Sender: TObject);
begin
  inherited;
  fGlQ.Last;
end;

procedure TRefForm.aMoveNextExecute(Sender: TObject);
begin
  inherited;
  fGlQ.MoveBy(100);
end;

procedure TRefForm.aMovePrevExecute(Sender: TObject);
begin
  inherited;
  fGlQ.MoveBy(-100);
end;

procedure TRefForm.aNextExecute(Sender: TObject);
begin
  inherited;
  fGlQ.Next;
end;

procedure TRefForm.aPrevExecute(Sender: TObject);
begin
  inherited;
  fGlQ.Prior;
end;

procedure TRefForm.aRefreshExecute(Sender: TObject);
begin
  fGlQ.Refresh;
end;

procedure TRefForm.aToExcelExecute(Sender: TObject);
begin
  ExportOraQuery2(myCapt, '', myCapt, fGlQ, aColumn_Array, true, True, AddExcelColNumber);
end;

procedure TRefForm.CRGridDblClick(Sender: TObject);
begin
  inherited;
  if not sPanel1.Visible then
    aEdit.Execute
  else
  begin
   if ((dsGlQ.State = dsEdit) or (dsGlQ.State = dsInsert)) then
      fGlQ.Cancel;
   sBsave.Click;
   //RefFormEdit.ModalResult := mrOk;
   //RefFormEdit.Close;
   end;
end;

procedure TRefForm.fdsGlQStateChange(Sender: TObject);
begin
  if (fdsGlQ.State = dsBrowse) then
    FormMode := fmBrowse;
  if (fdsGlQ.State = dsInsert) then
    FormMode := fmInsert;
  if (fdsGlQ.State = dsEdit) then
    FormMode := fmEdit;
  if (fdsGlQ.State = dsInactive) then
    FormMode := fmInactive;
  if (fdsGlQ.State = dsOpening) then
    FormMode := fmInactive;
end;

procedure TRefForm.RefreshToolBar;
begin
  TlBr.Refresh;
end;

procedure TRefForm.FormShow(Sender: TObject);
begin
  inherited;
  if not Dm.NewIcon then
  begin
    aInsert.ImageIndex := 4;
    aEdit.ImageIndex := 6;
    aDelete.ImageIndex := 5;
    aPost.ImageIndex := 7;
    aCancel.ImageIndex := 8;
    aRefresh.ImageIndex := 9;
    aFind.ImageIndex := 15;
    aFiltr.ImageIndex := 13;
    aNext.ImageIndex := 2;
    aPrev.ImageIndex := 1;
    aFirst.ImageIndex := 0;
    aLast.ImageIndex := 3;
    aMoveNext.ImageIndex := 42;
    aMovePrev.ImageIndex := 43;
    aToExcel.ImageIndex := 45;
  end
  else
  begin
    aInsert.ImageIndex := 33;
    aEdit.ImageIndex := 41;
    aDelete.ImageIndex := 34;
    aPost.ImageIndex := 31;
    aCancel.ImageIndex := 32;
    aRefresh.ImageIndex := 9;
    aFind.ImageIndex := 35;
    aFiltr.ImageIndex := 13;
    aNext.ImageIndex := 39;
    aPrev.ImageIndex := 38;
    aFirst.ImageIndex := 37;
    aLast.ImageIndex := 40;
    aMoveNext.ImageIndex := 42;
    aMovePrev.ImageIndex := 43;
    aToExcel.ImageIndex := 45;
  end;
  if (fGlQ.IsEmpty or (not fGlQ.Active)) then
    Hint := 'Внимание! Нет данных в справочнике!';

end;

end.
