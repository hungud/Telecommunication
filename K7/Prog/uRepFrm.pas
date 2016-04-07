unit uRepFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ChildFrm, DMUnit, Func_Const, TimedMsgBox,
  Ora, MemDS, Data.DB,
  Vcl.ComCtrls, sStatusBar, Vcl.ExtCtrls, sPanel, Vcl.ToolWin, sToolBar,
  ExportGridToExcelPDF,
  Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, sBitBtn, sBevel, sSplitter,
  sCheckBox,
  Vcl.Grids, Vcl.DBGrids, CRGrid, sSpeedButton, sListBox, sCheckListBox, sLabel,
  sComboBox, Vcl.Menus;

type
  TFLst = Array of String;

type
  TRepFrm = class(TChildForm)
    sStatusBar1: TsStatusBar;
    sPanel1: TsPanel;
    sPanel2: TsPanel;
    sBitBtn1: TsBitBtn;
    sBitBtn2: TsBitBtn;
    sBitBtn3: TsBitBtn;
    actlst1: TActionList;
    aInsert: TAction;
    aEdit: TAction;
    aDelete: TAction;
    aPost: TAction;
    aCancel: TAction;
    aRefresh: TAction;
    aFind: TAction;
    aFiltr: TAction;
    aNext: TAction;
    aPrev: TAction;
    aFirst: TAction;
    aLast: TAction;
    aMoveNext: TAction;
    aMovePrev: TAction;
    aToExcel: TAction;
    aInfo: TAction;
    sBevel1: TsBevel;
    sBevel2: TsBevel;
    CRGrid: TCRDBGrid;
    sSplitter1: TsSplitter;
    sPanel3: TsPanel;
    sBitBtn4: TsBitBtn;
    sBitBtn5: TsBitBtn;
    sBevel4: TsBevel;
    cbPeriod: TsComboBox;
    sLabel1: TsLabel;
    sAll: TsSpeedButton;
    aCheckedAll: TAction;
    aUncheckedAll: TAction;
    s_cancel: TsSpeedButton;
    pm1: TPopupMenu;
    D1: TMenuItem;
    N1: TMenuItem;
    CLB_Accounts: TsCheckListBox;
    procedure FormCreate(Sender: TObject);
    procedure SetGlQ(aValue: TOraQuery);
    procedure SetdsGlQ(aValue: TOraDataSource);
    procedure fdsGlQStateChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aToExcelExecute(Sender: TObject);
    procedure aInfoExecute(Sender: TObject);
    procedure aFiltrExecute(Sender: TObject);
    procedure aFindExecute(Sender: TObject);
    procedure aCheckedAllExecute(Sender: TObject);
    procedure aUncheckedAllExecute(Sender: TObject);
    procedure CLB_AccountsClickCheck(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FullColumnGrid(Grid: TDBGrid);
    procedure fGlQAfterScroll(DataSet: TDataSet);
    procedure fGlQAfterOpen(DataSet: TDataSet);
    procedure fGlQBeforeOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure Setcb_Period(aValue : Boolean);
    procedure SetCLBAccounts(aValue : Boolean);
  private
    FieldWithOutCapt, myCapt: string;
    fGlQ: TOraQuery;
    fdsGlQ: TOraDataSource;
    FieldNameStr: TFLst;
    AllLoaded: Boolean;
    CLB_Check_count: Integer;
    fcb_Period : Boolean;
    fCLBAccounts : Boolean;
  protected
    procedure Setbuttons; virtual;
    procedure SetFormMode(aValue: TFormMode); override;
  public
    AddExcelColNumber: Boolean;
    Name_File_Excel, Zagolovok_Excel, SQL_Text, SQL_Param, SQL_Sort, FAccid, FAccount: string;


  published
    property GlQuery: TOraQuery read fGlQ write SetGlQ;
    property dsGlQ: TOraDataSource read fdsGlQ write SetdsGlQ;
    property cb_Period : Boolean read fcb_Period write Setcb_Period;
    property CLBAccounts : Boolean read fCLBAccounts write SetCLBAccounts;
  end;

var
  RepFrm: TRepFrm;

implementation

{$R *.dfm}



procedure TRepFrm.Setcb_Period(aValue : Boolean);
begin
  if aValue then
  begin
    if not DM.qMonthYearforRepFrm.Active then
      DM.qMonthYearforRepFrm.Open
    else
      DM.qMonthYearforRepFrm.First;
    while not DM.qMonthYearforRepFrm.EOF do
    begin
      cbPeriod.Items.AddObject(DM.qMonthYearforRepFrm.FieldByName('YEAR_MONTH_NAME').AsString, TObject(DM.qMonthYearforRepFrm.FieldByName('YEAR_MONTH').Asinteger));
      DM.qMonthYearforRepFrm.Next;
    end;
    if cbPeriod.Items.Count > 0 then
      cbPeriod.ItemIndex := 0;
    cbPeriod.Visible := True;
  end
  else
    cbPeriod.Visible := false;
end;

procedure TRepFrm.SetCLBAccounts(aValue : Boolean);
begin
  if aValue then
  begin
    if not DM.qAccount.Active then
      DM.qAccount.Open
    else
      DM.qAccount.First;
    while not DM.qAccount.EOF do
    begin
      CLB_Accounts.Items.AddObject(Trim(DM.qAccount.FieldByName('LOGIN').AsString),
      Pointer(DM.qAccount.FieldByName('ACCOUNT_ID').AsInteger));
      DM.qAccount.Next;
    end;
    CLB_Accounts.Visible := True;
    sLabel1.Visible := True;
    sAll.Visible := True;
    s_cancel.Visible := True;
  end
  else
  begin
    CLB_Accounts.Visible := false;
    sLabel1.Visible := false;
    sAll.Visible := false;
    s_cancel.Visible := false;

  end;
end;

procedure TRepFrm.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  inherited;
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
  Dm.applMainForm.OnKeyDown := OnKeyDown;
  myCapt := Caption;
  if (FormStyle = fsNormal) and (BorderStyle = bsNone) then
    Dm.applMainForm.Caption := Dm.MainCaption + ' - ' + Caption;
  AddExcelColNumber := True;
  CRGrid.TitleFont.Style := [fsBold];
  CRGrid.ReadOnly := True;

   if fGlQ.Active then
  begin
    FitGrid(TDBGrid(CRGrid), Dm.fFileName, myCapt);
    FormMode := fmBrowse;
  end
  else
  begin
    if (fGlQ.SQL.Text <> '') then
      fGlQ.Open;
    FitGrid(TDBGrid(CRGrid), Dm.fFileName, myCapt);
    FormMode := fmBrowse;
  end;

  AllLoaded := true;
end;


procedure TRepFrm.SetGlQ(aValue: TOraQuery);
var
  r,i: Integer;
begin
  SetLength(FieldNameStr,0);
   FieldWithOutCapt := '';
  fGlQ := aValue;
  fGlQ.Session := Dm.OraSession;
  fGlQ.Options.TemporaryLobUpdate := True;
  fGlQ.AfterScroll := fGlQAfterScroll;
  fGlQ.AfterOpen := fGlQAfterOpen;
  fGlQ.BeforeOpen := fGlQBeforeOpen;
  //aToExcel.Enabled := GlQuery.Active and (not GlQuery.IsEmpty);
  fGlQ.Options.TemporaryLobUpdate := True;
  fGlQ.ReadOnly := True;

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
    TimedMessageBox('К OraQuery - ' + fGlQ.Name + ' не установлен DATASOURCE!', 'Пожалуйста, будьте внимательны!', mtError, [mbOK], mbOK, 25, 3);

  r := 0;
  if (GlQuery <> nil) then
    for i := 0 to GlQuery.Fields.Count - 1 do
      if GlQuery.Fields[i].Visible then
      begin
        SetLength(FieldNameStr, Length(FieldNameStr) + 1);
        FieldNameStr[r] := GlQuery.Fields[i].FieldName;
        r := r + 1;
        if (GlQuery.Fields[i].FieldName = GlQuery.Fields[i].DisplayLabel) then
          FieldWithOutCapt := FieldWithOutCapt + GlQuery.Fields[i].DisplayLabel + ', ';
      end;
  FullColumnGrid(TDBGrid(CRGrid));
end;

procedure TRepFrm.SetdsGlQ(aValue: TOraDataSource);
begin
  fdsGlQ := aValue;
  fdsGlQ.OnStateChange := fdsGlQStateChange;
  CRGrid.DataSource := fdsGlQ;
end;

procedure TRepFrm.fGlQBeforeOpen(DataSet: TDataSet);
begin
  if SQL_Text = '' then
    TimedMessageBox('У OraQuery - ' + fGlQ.Name + ' не указан запрос!', 'Пожалуйста, будьте внимательны!', mtError, [mbOK], mbOK, 25, 3)
  else
     GlQuery.SQL.Text := SQL_Text + ' ' + SQL_Param + ' ' + SQL_Sort;

end;

procedure TRepFrm.fGlQAfterOpen(DataSet: TDataSet);
begin
  aToExcel.Enabled := GlQuery.Active and (not GlQuery.IsEmpty);
  aInfo.Enabled := GlQuery.Active and (not GlQuery.IsEmpty);
  aFind.Enabled := GlQuery.Active and (not GlQuery.IsEmpty);
  aFiltr.Enabled := GlQuery.Active and (not GlQuery.IsEmpty);
end;

procedure TRepFrm.fGlQAfterScroll(DataSet: TDataSet);
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

procedure TRepFrm.FullColumnGrid(Grid: TDBGrid);
var
  i, r: Integer;
  FieldName: string;
  myField : TField;
  Col: TColumn;
begin
  for r := 0 to Grid.Columns.Count - 1 do
  begin
    FieldName := Grid.Columns[r].FieldName;
    myField := GlQuery.FindField(FieldName);
    if myField <> nil then
      myField.Tag := 1;
  end;
  for i := Low(FieldNameStr) to High(FieldNameStr) do
  begin
    myField := GlQuery.FindField(FieldNameStr[i]);
    if myField.Tag = 0 then
    begin
      Col := Grid.Columns.Add;
      Col.FieldName := myField.FieldName;
      Col.Title.Caption := myField.DisplayLabel;
      Col.Title.Alignment := taCenter;
    end;
  end;

end;

procedure TRepFrm.aFiltrExecute(Sender: TObject);
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

procedure TRepFrm.aFindExecute(Sender: TObject);
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

procedure TRepFrm.aInfoExecute(Sender: TObject);
begin
  inherited;
  //
end;

procedure TRepFrm.aRefreshExecute(Sender: TObject);
begin
  inherited;
  try
    if (GlQuery.SQLRefresh.Text = '') then
    begin
      GlQuery.Close;
      GlQuery.Prepare;
      GlQuery.Open;
    end
    else
    begin
      GlQuery.Refresh;
    end;

  except
    on e: exception do
      TimedMessageBox('Ошибка выполнения запроса: ' + fGlQ.sql.text, 'Пожалуйста, будьте внимательны!',mtError,[mbOK],mbOK,0);
  end;
  if CRGrid.DataSource.DataSet.IsEmpty then
  begin
    CRGrid.Enabled := false;
    aFind.Enabled := false;
    aFiltr.Enabled := false;
    aInfo.Enabled := false;
    aToExcel.Enabled := false;
  end
  else
  begin
    CRGrid.Enabled := True;
    aFind.Enabled := True;
    aFiltr.Enabled := True;
    aInfo.Enabled := True;
    aToExcel.Enabled := True;
  end;

end;

procedure TRepFrm.aToExcelExecute(Sender: TObject);
begin
  inherited;
  if (Name_File_Excel = '') then
    TimedMessageBox('Не назазначен Name_File_Excel!', 'Пожалуйста, будьте внимательны!', mtError, [mbOK], mbOK, 25, 3)
  else
    if (Zagolovok_Excel = '') then
      TimedMessageBox('Не назазначен Zagolovok_Excel!', 'Пожалуйста, будьте внимательны!', mtError, [mbOK], mbOK, 25, 3)
    else
      if (fGlQ <> nil) then
        ExportOraQuery(Name_File_Excel, '', Zagolovok_Excel, fGlQ, FieldNameStr, True, True)
      else
        TimedMessageBox('Не назазначен GlQuery!', 'Пожалуйста, будьте внимательны!', mtError, [mbOK], mbOK, 25, 3);
end;

procedure TRepFrm.aCheckedAllExecute(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to CLB_Accounts.Items.Count - 1 do
    CLB_Accounts.checked[i] := True;
  aUncheckedAll.Enabled := True;
  aCheckedAll.Enabled := false;
  CLB_AccountsClickCheck(Sender);
end;

procedure TRepFrm.aUncheckedAllExecute(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to CLB_Accounts.Items.Count - 1 do
    CLB_Accounts.checked[i] := false;
  aCheckedAll.Enabled := True;
  aUncheckedAll.Enabled := false;
  CLB_AccountsClickCheck(Sender);
end;

procedure TRepFrm.CLB_AccountsClickCheck(Sender: TObject);
var
  i: Integer;
begin
  FAccid := '';
  FAccount := '';
  CLB_Check_count := 0;
  for i := 0 to CLB_Accounts.Items.Count - 1 do
  begin
    if CLB_Accounts.checked[i] then
    begin
      Inc(CLB_Check_count);
      FAccid := FAccid + IntToStr(Integer(CLB_Accounts.Items.Objects[i])) + ',';
      FAccount := FAccount + CLB_Accounts.Items[i] + ',';
    end;
  end;
  FAccid := copy(FAccid, 1, Length(FAccid) - 1);
  FAccount := copy(FAccount, 1, Length(FAccount) - 1);
  aRefresh.Enabled := CLB_Check_count > 0;
  aUncheckedAll.Enabled := CLB_Check_count > 0;
  aCheckedAll.Enabled := CLB_Check_count <> CLB_Accounts.Items.Count;
  aToExcel.Enabled := GlQuery.Active and (not GlQuery.IsEmpty);
end;

procedure TRepFrm.fdsGlQStateChange(Sender: TObject);
begin
  if (dsGlQ.State = dsBrowse) then
    FormMode := fmBrowse;
  if (dsGlQ.State = dsInsert) then
    FormMode := fmInsert;
  if (dsGlQ.State = dsEdit) then
    FormMode := fmEdit;
  if (dsGlQ.State = dsInactive) then
    FormMode := fmInactive;
  if (dsGlQ.State = dsOpening) then
    FormMode := fmInactive;
end;

procedure TRepFrm.SetFormMode(aValue: TFormMode);
begin
  inherited SetFormMode(aValue);
  if ((aValue = fmInsert) or (aValue = fmEdit)) then
    SendMessage(sndWind, WM_NOTIFY_CHGMODE, 0, DWORD(PChar('SetEdit')));
  if ((aValue = fmBrowse) or (aValue = fmInactive)) then
    SendMessage(sndWind, WM_NOTIFY_CHMODE, 0, DWORD(PChar('Setbrowse')));
  Setbuttons;
end;

procedure TRepFrm.Setbuttons;
begin
  //
end;

procedure TRepFrm.FormDestroy(Sender: TObject);
begin
  if (FormStyle = fsNormal) and (BorderStyle = bsNone) then
    Dm.applMainForm.Caption := Dm.MainCaption;
  Dm.applMainForm.OnKeyDown := nil;
  Dm.applMainForm.OnKeyPress := nil;
  ///if (FormStyle = fsNormal) and (BorderStyle = bsNone) then
    fGlQ.Close;
  SetLength(FieldNameStr, 0);

  inherited;
end;

procedure TRepFrm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if ((Key = VK_F5) and aRefresh.Enabled) then
    aRefresh.Execute;
end;

procedure TRepFrm.FormShow(Sender: TObject);
begin
  inherited;
  if Dm.DebugMode then
  begin
    if FieldWithOutCapt <> '' then
    begin
      FieldWithOutCapt := Copy(FieldWithOutCapt, 1, Length(FieldWithOutCapt) - 2);
      TimedMessageBox('  У следующих полей не заполнены значения DisplayLabel '  + ' - ' + #10 + #13 + FieldWithOutCapt, 'Внимание! Это видно только в дебаг режиме', mtWarning, [mbOK], mbOK, 15, 3);
    end;
  end;
end;

end.
