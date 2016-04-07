unit uRepLoaderBill;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ChildFrm, uDm, Func_Const, TimedMsgBox,
  Ora, MemDS, Data.DB,
  Vcl.ComCtrls, sStatusBar, Vcl.ExtCtrls, sPanel, Vcl.ToolWin, sToolBar,
  ExportGridToExcelPDF,
  Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, sBitBtn, sBevel, sSplitter,
  sCheckBox,
  Vcl.Grids, Vcl.DBGrids, CRGrid, sSpeedButton, sListBox, sCheckListBox, sLabel,
  sComboBox, Vcl.Menus, DBAccess;

type
  TFLst = Array of String;

type
  TRepLoaderBillFrm = class(TChildForm)
    sStatusBar1: TsStatusBar;
    sPanel1: TsPanel;
    sPanel2: TsPanel;
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
    qMonthYearforRepFrm: TOraQuery;
    qAccount: TOraQuery;
    qAccountACCOUNT_ID: TFloatField;
    qAccountLOGIN: TStringField;
    dsqAccount: TOraDataSource;
    qMonthYearforRepFrmYEARS: TFloatField;
    qMonthYearforRepFrmMONTHS: TFloatField;
    qMonthYearforRepFrmYEAR_MONTH: TFloatField;
    qMonthYearforRepFrmYEAR_MONTH_NAME: TStringField;
    qAccountACCOUNT_NUMBER: TFloatField;
    qAccountACCOUNT_NUMBER_LOGIN: TStringField;
    qReport: TOraQuery;
    dsqReport: TOraDataSource;
    qReportBILL_ID: TFloatField;
    qReportACCOUNT_ID: TFloatField;
    qReportYEAR_MONTH: TFloatField;
    qReportPHONE_ID: TFloatField;
    qReportDATE_BEGIN: TDateTimeField;
    qReportDATE_END: TDateTimeField;
    qReportTARIFF_CODE: TStringField;
    qReportBILL_SUM: TFloatField;
    qReportSUBSCRIBER_PAYMENT_MAIN: TFloatField;
    qReportSUBSCRIBER_PAYMENT_ADD: TFloatField;
    qReportSINGLE_PAYMENTS: TFloatField;
    qReportCALLS_LOCAL_COST: TFloatField;
    qReportCALLS_OTHER_CITY_COST: TFloatField;
    qReportCALLS_OTHER_COUNTRY_COST: TFloatField;
    qReportMESSAGES_COST: TFloatField;
    qReportINTERNET_COST: TFloatField;
    qReportOTHER_COUNTRY_ROAMING_COST: TFloatField;
    qReportNATIONAL_ROAMING_COST: TFloatField;
    qReportPENI_COST: TFloatField;
    qReportDISCOUNT_VALUE: TFloatField;
    qReportOTHER_COUNTRY_ROAMING_CALLS: TFloatField;
    qReportOTHER_COUNTRY_ROAMING_MESSAGES: TFloatField;
    qReportOTHER_COUNTRY_ROAMING_INTERNET: TFloatField;
    qReportNATIONAL_ROAMING_CALLS: TFloatField;
    qReportNATIONAL_ROAMING_MESSAGES: TFloatField;
    qReportNATIONAL_ROAMING_INTERNET: TFloatField;
    sSpeedButton1: TsSpeedButton;
    qReportACCOUNT_NAME: TStringField;
    sSpeedButton2: TsSpeedButton;
    sSpeedButton3: TsSpeedButton;
    qReportPHONE: TIntegerField;
    qReportPeriod: TStringField;
    procedure FormCreate(Sender: TObject);
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
    procedure qReportBeforeOpen(DataSet: TDataSet);
  private
    FieldWithOutCapt, myCapt: string;
    FieldNameStr: TFLst;
    AllLoaded: Boolean;
    CLB_Check_count: Integer;
    fcb_Period : Boolean;
    fCLBAccounts : Boolean;
    ExAfterScroll, ExBeforeOpen, ExAfterOpen : MyProc;

  protected
    procedure Setbuttons; virtual;
    procedure SetFormMode(aValue: TFormMode); override;
  public
    AddExcelColNumber: Boolean;
    Name_File_Excel, Zagolovok_Excel, SQL_Text, SQL_Param, SQL_Sort, FAccid, FAccount: string;
    YEAR_MONTH : Integer;

  published
    property cb_Period : Boolean read fcb_Period write Setcb_Period;
    property CLBAccounts : Boolean read fCLBAccounts write SetCLBAccounts;
  end;

var
  RepLoaderBillFrm: TRepLoaderBillFrm;

implementation

{$R *.dfm}

procedure TRepLoaderBillFrm.Setcb_Period(aValue : Boolean);
begin
  if aValue then
  begin
    if not qMonthYearforRepFrm.Active then
      qMonthYearforRepFrm.Open
    else
      qMonthYearforRepFrm.First;
    while not qMonthYearforRepFrm.EOF do
    begin
      cbPeriod.Items.AddObject(qMonthYearforRepFrm.FieldByName('YEAR_MONTH_NAME').AsString, TObject(qMonthYearforRepFrm.FieldByName('YEAR_MONTH').Asinteger));
      qMonthYearforRepFrm.Next;
    end;
    if cbPeriod.Items.Count > 0 then
      cbPeriod.ItemIndex := 0;
    cbPeriod.Visible := True;
  end
  else
    cbPeriod.Visible := false;
end;

procedure TRepLoaderBillFrm.SetCLBAccounts(aValue : Boolean);
begin
  if aValue then
  begin
    if not qAccount.Active then
      qAccount.Open
    else
      qAccount.First;
    while not qAccount.EOF do
    begin
      CLB_Accounts.Items.AddObject(Trim(qAccount.FieldByName('ACCOUNT_NUMBER_LOGIN').AsString),
      Pointer(qAccount.FieldByName('ACCOUNT_ID').AsInteger));
      qAccount.Next;
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

procedure TRepLoaderBillFrm.FormCreate(Sender: TObject);
var
  r,i: Integer;
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

  SetLength(FieldNameStr,0);
  FieldWithOutCapt := '';
  qReport.Session := Dm.OraSession;
  qReport.Options.TemporaryLobUpdate := True;

  ExAfterScroll := nil;
  ExBeforeOpen  := nil; //
  ExAfterOpen   := nil; //

  if Assigned(qReport.AfterScroll) then
    ExAfterScroll := qReport.AfterScroll;
  qReport.AfterScroll := fGlQAfterScroll;


  if Assigned(qReport.BeforeOpen) then
    ExBeforeOpen := qReport.BeforeOpen;
  qReport.BeforeOpen := fGlQBeforeOpen;

  if Assigned(qReport.AfterOpen) then
    ExAfterOpen := qReport.AfterOpen;
  qReport.AfterOpen := fGlQAfterOpen;

  qReport.Options.TemporaryLobUpdate := True;
  qReport.ReadOnly := True;

  r := 0;
  if (qReport <> nil) then
    for i := 0 to qReport.Fields.Count - 1 do
      if qReport.Fields[i].Visible then
      begin
        SetLength(FieldNameStr, Length(FieldNameStr) + 1);
        FieldNameStr[r] := qReport.Fields[i].FieldName;
        r := r + 1;
        if (qReport.Fields[i].FieldName = qReport.Fields[i].DisplayLabel) then
          FieldWithOutCapt := FieldWithOutCapt + qReport.Fields[i].DisplayLabel + ', ';
      end;
  dsqReport.OnStateChange := fdsGlQStateChange;
  CRGrid.DataSource := dsqReport;
  FullColumnGrid(TDBGrid(CRGrid));



  Dm.applMainForm.OnKeyDown := OnKeyDown;
  myCapt := Caption;
  if (FormStyle = fsNormal) and (BorderStyle = bsNone) then
    Dm.applMainForm.Caption := Dm.MainCaption + ' - ' + Caption;
  AddExcelColNumber := True;
  CRGrid.TitleFont.Style := [fsBold];
  CRGrid.ReadOnly := True;
  YEAR_MONTH := -1;

  Name_File_Excel := myCapt;
  Zagolovok_Excel := 'Журнал выставленных оператором счетов';

  cb_Period   := True;
  CLBAccounts := True;
  SQL_Text  := 'SELECT dlb.BILL_ID, dlb.ACCOUNT_ID, dlb.YEAR_MONTH, dlb.PHONE_ID, dlb.DATE_BEGIN, dlb.DATE_END, '+
               'dlb.TARIFF_CODE, dlb.BILL_SUM, dlb.SUBSCRIBER_PAYMENT_MAIN, dlb.SUBSCRIBER_PAYMENT_ADD, dlb.SINGLE_PAYMENTS, '+
               'dlb.CALLS_LOCAL_COST, dlb.CALLS_OTHER_CITY_COST, dlb.CALLS_OTHER_COUNTRY_COST, dlb.MESSAGES_COST, '+
               'dlb.INTERNET_COST, dlb.OTHER_COUNTRY_ROAMING_COST, dlb.NATIONAL_ROAMING_COST,dlb.PENI_COST, dlb.DISCOUNT_VALUE, '+
               'dlb.OTHER_COUNTRY_ROAMING_CALLS, dlb.OTHER_COUNTRY_ROAMING_MESSAGES, dlb.OTHER_COUNTRY_ROAMING_INTERNET, '+
               'dlb.NATIONAL_ROAMING_CALLS, dlb.NATIONAL_ROAMING_MESSAGES, dlb.NATIONAL_ROAMING_INTERNET from DB_LOADER_BILLS dlb '+
               'where dlb.YEAR_MONTH = :YEAR_MONTH ';
  SQL_Param := ' and dlb.ACCOUNT_ID = :ACCOUNT_ID';
  SQL_Sort  := ' order by dlb.PHONE_ID';
end;


procedure TRepLoaderBillFrm.fGlQBeforeOpen(DataSet: TDataSet);
begin
  if SQL_Text = '' then
    TimedMessageBox('У OraQuery - ' + qReport.Name + ' не указан запрос!', 'Пожалуйста, будьте внимательны!', mtError, [mbOK], mbOK, 25, 3)
  else
  begin
    if (CLB_Check_count = 1) then
      SQL_Param := ' and dlb.ACCOUNT_ID = :ACCOUNT_ID'
    else
      SQL_Param := ' and dlb.ACCOUNT_ID in (' + FAccid + ')';
    qReport.SQL.Clear;
    qReport.SQL.Add(SQL_Text);
    qReport.SQL.Add(SQL_Param);
    qReport.SQL.Add(SQL_Sort);
    if (CLB_Check_count = 1) then
      qReport.ParamByName('ACCOUNT_ID').AsString :=  FAccid;
    qReport.ParamByName('YEAR_MONTH').AsInteger :=  YEAR_MONTH;
  end;
  if Assigned(ExBeforeOpen) then
    ExBeforeOpen(DataSet);
end;

procedure TRepLoaderBillFrm.fGlQAfterOpen(DataSet: TDataSet);
begin
  aToExcel.Enabled := qReport.Active and (not qReport.IsEmpty);
  aInfo.Enabled :=    qReport.Active and (not qReport.IsEmpty);
  aFind.Enabled :=    qReport.Active and (not qReport.IsEmpty);
  aFiltr.Enabled :=   qReport.Active and (not qReport.IsEmpty);

  if not AllLoaded then
    FitGrid(TDBGrid(CRGrid), Dm.FileNameIni, myCapt);
  FormMode := fmBrowse;
  AllLoaded := true;
  if Assigned(ExAfterOpen) then
    ExAfterOpen(DataSet);
end;

procedure TRepLoaderBillFrm.fGlQAfterScroll(DataSet: TDataSet);
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
  if Assigned(ExAfterScroll) then
    ExAfterScroll(DataSet);
end;

procedure TRepLoaderBillFrm.FullColumnGrid(Grid: TDBGrid);
var
  i, r: Integer;
  FieldName: string;
  myField : TField;
  Col: TColumn;
begin
  for r := 0 to Grid.Columns.Count - 1 do
  begin
    FieldName := Grid.Columns[r].FieldName;
    myField := qReport.FindField(FieldName);
    if myField <> nil then
      myField.Tag := 1;
  end;
  for i := Low(FieldNameStr) to High(FieldNameStr) do
  begin
    myField := qReport.FindField(FieldNameStr[i]);
    if myField.Tag = 0 then
    begin
      Col := Grid.Columns.Add;
      Col.FieldName := myField.FieldName;
      Col.Title.Caption := myField.DisplayLabel;
      Col.Title.Alignment := taCenter;
    end;
  end;

end;

procedure TRepLoaderBillFrm.aFiltrExecute(Sender: TObject);
begin
  inherited;
  if aFiltr.checked then
  begin
    CRGrid.OptionsEx := CRGrid.OptionsEx + [dgeFilterBar];
    if ((dsqReport.State = dsEdit) or (dsqReport.State = dsInsert)) then
      qReport.Cancel;
  end
  else
    CRGrid.OptionsEx := CRGrid.OptionsEx - [dgeFilterBar];

end;

procedure TRepLoaderBillFrm.aFindExecute(Sender: TObject);
begin
  inherited;
  if aFind.checked then
  begin
    CRGrid.OptionsEx := CRGrid.OptionsEx + [dgeSearchBar];
    if ((dsqReport.State = dsEdit) or (dsqReport.State = dsInsert)) then
      qReport.Cancel;
  end
  else
    CRGrid.OptionsEx := CRGrid.OptionsEx - [dgeSearchBar];

end;

procedure TRepLoaderBillFrm.aInfoExecute(Sender: TObject);
begin
  inherited;
  //
end;

procedure TRepLoaderBillFrm.qReportBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  if (CLB_Check_count = 1) then
    SQL_Param := ' and dlb.ACCOUNT_ID = :ACCOUNT_ID'
  else
    SQL_Param := ' and dlb.ACCOUNT_ID in (' + FAccid + ')';

   qReport.SQL.Clear;
   qReport.SQL.Add(SQL_Text);
   qReport.SQL.Add(SQL_Param);
   qReport.SQL.Add(SQL_Sort);
  if (CLB_Check_count = 1) then
    qReport.ParamByName('ACCOUNT_ID').AsString :=  FAccid;
  qReport.ParamByName('YEAR_MONTH').AsInteger :=  YEAR_MONTH;
end;


procedure TRepLoaderBillFrm.aRefreshExecute(Sender: TObject);
begin
  inherited;
  if (CLB_Check_count = 0) then
  begin
    TimedMessageBox('Не выбрано ни одного лицевого счета!','Пожалуйста, будьте внимательны!',mtWarning,[mbOK],mbOK,5);
    exit;
  end;

   if cbPeriod.ItemIndex >= 0 then
      YEAR_MONTH := integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
    else
      YEAR_MONTH := -1;

  try
      qReport.Close;
      //qReport.Prepare;
      qReport.Open;

  except
    on e: exception do
      TimedMessageBox('Ошибка выполнения запроса: ' + qReport.sql.text, 'Пожалуйста, будьте внимательны!',mtError,[mbOK],mbOK,0);
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

procedure TRepLoaderBillFrm.aToExcelExecute(Sender: TObject);
begin
  inherited;
  if (Name_File_Excel = '') then
    TimedMessageBox('Не назазначен Name_File_Excel!', 'Пожалуйста, будьте внимательны!', mtError, [mbOK], mbOK, 25, 3)
  else
    if (Zagolovok_Excel = '') then
      TimedMessageBox('Не назазначен Zagolovok_Excel!', 'Пожалуйста, будьте внимательны!', mtError, [mbOK], mbOK, 25, 3)
    else
      if (qReport <> nil) then
        ExportOraQuery(Name_File_Excel, '', Zagolovok_Excel, qReport, FieldNameStr, True, True)
    //    ExportOraQuery2(myCapt, '', myCapt, fGlQ, aColumn_Array, Dm.AskExcelFileName, True, AddExcelColNumber);

      else
        TimedMessageBox('Не назазначен GlQuery!', 'Пожалуйста, будьте внимательны!', mtError, [mbOK], mbOK, 25, 3);
end;

procedure TRepLoaderBillFrm.aCheckedAllExecute(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to CLB_Accounts.Items.Count - 1 do
    CLB_Accounts.checked[i] := True;
  aUncheckedAll.Enabled := True;
  aCheckedAll.Enabled := false;
  CLB_AccountsClickCheck(Sender);
end;

procedure TRepLoaderBillFrm.aUncheckedAllExecute(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to CLB_Accounts.Items.Count - 1 do
    CLB_Accounts.checked[i] := false;
  aCheckedAll.Enabled := True;
  aUncheckedAll.Enabled := false;
  CLB_AccountsClickCheck(Sender);
end;

procedure TRepLoaderBillFrm.CLB_AccountsClickCheck(Sender: TObject);
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
  aToExcel.Enabled := qReport.Active and (not qReport.IsEmpty);
end;

procedure TRepLoaderBillFrm.fdsGlQStateChange(Sender: TObject);
begin
  if (dsqReport.State = dsBrowse) then
    FormMode := fmBrowse;
  if (dsqReport.State = dsInsert) then
    FormMode := fmInsert;
  if (dsqReport.State = dsEdit) then
    FormMode := fmEdit;
  if (dsqReport.State = dsInactive) then
    FormMode := fmInactive;
  if (dsqReport.State = dsOpening) then
    FormMode := fmInactive;
end;

procedure TRepLoaderBillFrm.SetFormMode(aValue: TFormMode);
begin
  inherited SetFormMode(aValue);
  if ((aValue = fmInsert) or (aValue = fmEdit)) then
    SendMessage(sndWind, WM_NOTIFY_CHGMODE, 0, DWORD(PChar('SetEdit')));
  if ((aValue = fmBrowse) or (aValue = fmInactive)) then
    SendMessage(sndWind, WM_NOTIFY_CHMODE, 0, DWORD(PChar('Setbrowse')));
  Setbuttons;
end;

procedure TRepLoaderBillFrm.Setbuttons;
begin
  //
end;

procedure TRepLoaderBillFrm.FormDestroy(Sender: TObject);
begin
  if (FormStyle = fsNormal) and (BorderStyle = bsNone) then
    Dm.applMainForm.Caption := Dm.MainCaption;
  Dm.applMainForm.OnKeyDown := nil;
  Dm.applMainForm.OnKeyPress := nil;
  if (FormStyle = fsNormal) and (BorderStyle = bsNone) then
    qReport.Close;
  SetLength(FieldNameStr, 0);

  inherited;
end;

procedure TRepLoaderBillFrm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if ((Key = VK_F5) and aRefresh.Enabled) then
    aRefresh.Execute;
end;

procedure TRepLoaderBillFrm.FormShow(Sender: TObject);
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
