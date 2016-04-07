unit uRepFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.StrUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ChildFrm, uDm, Func_Const, TimedMsgBox,
  Ora, MemDS, Data.DB,
  Vcl.ComCtrls, sStatusBar, Vcl.ExtCtrls, sPanel, Vcl.ToolWin, sToolBar,
  ExportGridToExcelPDF,
  Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, sBitBtn, sBevel, sSplitter,
  sCheckBox,
  Vcl.Grids, Vcl.DBGrids, CRGrid, sSpeedButton, sListBox, sCheckListBox, sLabel,
  sComboBox, Vcl.Menus, DBAccess , RepInfoAboutPhone, sEdit, sGauge, sScrollBox;

type
  TFLst = Array of String;

type
  TRepFrm = class(TChildForm)
    sStatusBar1: TsStatusBar;
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
    sSplitter1: TsSplitter;
    aCheckedAll: TAction;
    aUncheckedAll: TAction;
    pm1: TPopupMenu;
    D1: TMenuItem;
    N1: TMenuItem;
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
    qMob_Oper: TOraQuery;
    dsqMob_Oper: TOraDataSource;
    pm2: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    aCheckedAll1: TAction;
    aUncheckedAll1: TAction;
    qLogin: TOraQuery;
    dsqLogin: TOraDataSource;
    qLoginID: TFloatField;
    qLoginLOGIN: TStringField;
    aCheckedSel: TAction;
    miCheckedSel: TMenuItem;
    aCheckedSel1: TAction;
    miCheckedSel1: TMenuItem;
    qVirt_Acc: TOraQuery;
    dsqVirt_Acc: TOraDataSource;
    pm3: TPopupMenu;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    aCheckedAll2: TAction;
    aUncheckedAll2: TAction;
    aCheckedSel2: TAction;
    CRGrid: TCRDBGrid;
    qAccount_cnt: TOraQuery;
    qAccount_cntCNT: TFloatField;
    pm4: TPopupMenu;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    qfilials: TOraQuery;
    qfilialsFILIAL_ID: TFloatField;
    qfilialsFILIAL_NAME: TStringField;
    dsqfilials: TOraDataSource;
    aCheckedAll3: TAction;
    aUncheckedAll3: TAction;
    aCheckedSel3: TAction;
    qVirt_AccVIRTUAL_ACCOUNTS_ID: TFloatField;
    qVirt_AccVIRTUAL_ACCOUNTS_NAME: TStringField;
    qMob_OperMOBILE_OPERATOR_NAME_ID: TFloatField;
    qMob_OperMOBILE_OPERATOR_NAME: TStringField;
    sScrollBox1: TsScrollBox;
    spMobOper: TsPanel;
    slMobOperCapt: TsLabel;
    sAll1: TsSpeedButton;
    s_cancel1: TsSpeedButton;
    sbCheckedSel1: TsSpeedButton;
    sbCheckSel2: TsSpeedButton;
    CLB_Mob_Oper: TsCheckListBox;
    seMobOperSearch: TsEdit;
    spFilial: TsPanel;
    slFilialCapt: TsLabel;
    sAll3: TsSpeedButton;
    s_cancel3: TsSpeedButton;
    sbCheckedSel3: TsSpeedButton;
    sbCheckSel4: TsSpeedButton;
    CLB_Filial: TsCheckListBox;
    seFilialSearch: TsEdit;
    spVirtAcc: TsPanel;
    slVirtAcc: TsLabel;
    sAll2: TsSpeedButton;
    s_cancel2: TsSpeedButton;
    sbCheckedSel2: TsSpeedButton;
    sbCheckSel3: TsSpeedButton;
    CLB_VirtAcc: TsCheckListBox;
    seVirtAccSearch: TsEdit;
    spAccount: TsPanel;
    slAccontCapt: TsLabel;
    sAll: TsSpeedButton;
    s_cancel: TsSpeedButton;
    sbCheckedSel: TsSpeedButton;
    sbCheckSel: TsSpeedButton;
    CLB_Accounts: TsCheckListBox;
    sp: TsPanel;
    pButtonMove: TsPanel;
    sGauge1: TsGauge;
    seAccountSearch: TsEdit;
    cbPeriod: TsComboBox;
    spFiltrSearch: TsPanel;
    sBevel4: TsBevel;
    sbFind: TsSpeedButton;
    sbFiltr: TsSpeedButton;
    sBevel5: TsBevel;
    spShow: TsPanel;
    sBevel1: TsBevel;
    sBevel2: TsBevel;
    sbShowSel: TsSpeedButton;
    sbToExcel: TsSpeedButton;
    sbInfoShow: TsSpeedButton;
    sbFirst: TsSpeedButton;
    sbMovePrior: TsSpeedButton;
    sbPrior: TsSpeedButton;
    sbNext: TsSpeedButton;
    sbMoveNext: TsSpeedButton;
    sBevel3: TsBevel;
    sBevel6: TsBevel;
    sBevel7: TsBevel;
    sBevel8: TsBevel;
    sBevel9: TsBevel;
    sbLast: TsSpeedButton;
    qVirt_AccINN: TStringField;
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
    procedure SetCLB_VirtAccs(aValue : Boolean);
    procedure SetCLB_filial(aValue : Boolean);
    procedure Setcb_Mob_Oper(aValue : Boolean);
    procedure FullCLBAccounts;
    procedure Loaded; override;
    procedure Setb_PhoneField(aValue : Boolean);
    procedure CLB_Mob_OperClickCheck(Sender: TObject);
    procedure qAccountBeforeOpen(DataSet: TDataSet);
    procedure aCheckedAll1Execute(Sender: TObject);
    procedure aUncheckedAll1Execute(Sender: TObject);
    procedure aCheckedSelExecute(Sender: TObject);
    procedure CLB_AccountsClick(Sender: TObject);
    procedure aCheckedSel1Execute(Sender: TObject);
    procedure CLB_Mob_OperMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CLB_Mob_OperClick(Sender: TObject);
    procedure CLB_AccountsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure qVirt_AccBeforeOpen(DataSet: TDataSet);
    procedure aCheckedAll2Execute(Sender: TObject);
    procedure CLB_VirtAccClick(Sender: TObject);
    procedure CLB_VirtAccMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CLB_VirtAccClickCheck(Sender: TObject);
    procedure aUncheckedAll2Execute(Sender: TObject);
    procedure aCheckedSel2Execute(Sender: TObject);
    procedure sbCheckSelClick(Sender: TObject);
    procedure sbCheckSel2Click(Sender: TObject);
    procedure sbCheckSel3Click(Sender: TObject);
    procedure qAccount_cntBeforeOpen(DataSet: TDataSet);
    procedure aNextExecute(Sender: TObject);
    procedure aPrevExecute(Sender: TObject);
    procedure aFirstExecute(Sender: TObject);
    procedure aLastExecute(Sender: TObject);
    procedure aMoveNextExecute(Sender: TObject);
    procedure aMovePrevExecute(Sender: TObject);
    procedure aCheckedAll3Execute(Sender: TObject);
    procedure CLB_FilialClick(Sender: TObject);
    procedure CLB_FilialClickCheck(Sender: TObject);
    procedure qfilialsBeforeOpen(DataSet: TDataSet);
    procedure sbCheckSel4Click(Sender: TObject);
    procedure s_cancel3Click(Sender: TObject);
    procedure qfilialsAfterOpen(DataSet: TDataSet);
    procedure MessageReceiverMoveNext(var Msg: TMessage); message WM_NOTIFY_GO_ON_THE;
    procedure qVirt_AccAfterOpen(DataSet: TDataSet);
    procedure aUncheckedAll3Execute(Sender: TObject);
    procedure aCheckedSel3Execute(Sender: TObject);
    procedure set_panels_visible_all  (value : boolean);
    procedure qReportBeforeOpen(DataSet: TDataSet);
  private
    FieldWithOutCapt, myCapt: string;
    FieldNameStr: TFLst;
    MayShow, AllLoaded: Boolean;
    fcb_Period   : Boolean;
    fcb_Mob_Oper : Boolean;
    fCLBAccounts : Boolean;
    fCLB_VirtAccs: Boolean;
    fCLB_filial  : Boolean;
    fb_PhoneField: Boolean;
    fpanels_visible_all: Boolean;
    ExAfterScroll, ExBeforeOpen, ExAfterOpen : MyProc;
    //FindUser : TFindUser;

  protected
    account_count, account_check_count, Mob_Check_count, VSch_count, Filial_count: Integer;
    PhoneField : TField;
    procedure Setbuttons; virtual;
    procedure SetFormMode(aValue: TFormMode); override;
    procedure ResiseAllButtons;

  public
    AddExcelColNumber: Boolean;
    Name_File_Excel, Zagolovok_Excel,
    FMOpid, FMOpcount, FAccid, FAccount, FVSchid, FVSchcount, Filialid, Filialcount: string;
    YEAR_MONTH : Integer;

  published
    property cb_Mob_Oper : Boolean read fcb_Mob_Oper write Setcb_Mob_Oper;
    property cb_Period : Boolean read fcb_Period write Setcb_Period;
    property CLBAccounts : Boolean read fCLBAccounts write SetCLBAccounts;
    property CLB_VirtAccs : Boolean read fCLB_VirtAccs write SetCLB_VirtAccs;
    property CLB_FilialT : Boolean read fCLB_filial write SetCLB_filial;
    property b_PhoneField : Boolean read fb_PhoneField write Setb_PhoneField;
    property panels_visible_all : Boolean read fpanels_visible_all write set_panels_visible_all;
  end;

var
  RepFrm: TRepFrm;

implementation

{$R *.dfm}

procedure TRepFrm.MessageReceiverMoveNext(var Msg: TMessage);
//var
//txt: PChar;
begin
  //txt := PChar(Msg.lParam);
  Msg.Result := 0;
  aMoveNext.Caption := Dm.MoveNextHint;
  aMoveNext.Hint := aMoveNext.Caption;
  sbMoveNext.Hint := aMoveNext.Caption;
  aMovePrev.Caption := Dm.MovePrevHint;
  aMovePrev.Hint := aMovePrev.Caption;
  sbMovePrior.Hint := aMovePrev.Caption;
end;

procedure TRepFrm.Setb_PhoneField(aValue : Boolean);
begin
  if aValue then
  begin
     aInfo.Visible := True;
     sBevel2.Visible := True;
  end
  else
  begin
     aInfo.Visible := false;
     sBevel2.Visible := false;
  end;
  fb_PhoneField := aValue;
end;

procedure TRepFrm.Setcb_Period(aValue : Boolean);
var
  i, month_year : Integer;
begin
  if aValue then
  begin
    if not qMonthYearforRepFrm.Active then
      qMonthYearforRepFrm.Open
    else
      qMonthYearforRepFrm.First;
    month_year := Dm.month_year_withLastData;
    i := 0;
    while not qMonthYearforRepFrm.EOF do
    begin
      cbPeriod.Items.AddObject(qMonthYearforRepFrm.FieldByName('YEAR_MONTH_NAME').AsString, TObject(qMonthYearforRepFrm.FieldByName('YEAR_MONTH').Asinteger));
      if qMonthYearforRepFrm.FieldByName('YEAR_MONTH').Asinteger = month_year then
        i := cbPeriod.Items.Count -1;
      qMonthYearforRepFrm.Next;
    end;
    if cbPeriod.Items.Count > 0 then
    begin
      cbPeriod.ItemIndex := i;
      YEAR_MONTH := integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
    end
    else
      YEAR_MONTH := -1;

    cbPeriod.Visible := True;
  end
  else
    cbPeriod.Visible := false;
  fcb_Period := aValue;
end;

procedure TRepFrm.SetCLB_filial(aValue : Boolean);
begin
  if aValue then
  begin
    if not qfilials.Active then
      qfilials.Open
    else
      qfilials.First;
    spFilial.Visible := True;
    CLB_Filial.Visible := True;
    slFilialCapt.Visible := True;
    aCheckedAll3.Visible := True;
    aUncheckedAll3.Visible := True;
    aCheckedSel3.Visible := True;
    seFilialSearch.Visible := True;
    seFilialSearch.Text := '';
    aCheckedAll3.Enabled := True;
    aUncheckedAll3.Enabled := false;
    aCheckedSel3.Enabled := false;
  end
  else
  begin
    spFilial.Visible := false;
    CLB_Filial.Visible := false;
    slFilialCapt.Visible := false;
    aCheckedAll3.Visible := false;
    aUncheckedAll3.Visible := false;
    aCheckedSel3.Visible := false;
    seFilialSearch.Visible := false;
  end;
  slFilialCapt.Caption := 'Филиалы: выбрано - 0.';
  fCLB_filial := aValue;
end;

procedure TRepFrm.SetCLB_VirtAccs(aValue : Boolean);
begin
  if aValue then
  begin
    if not qVirt_Acc.Active then
      qVirt_Acc.Open
    else
      qVirt_Acc.First;
    spVirtAcc.Visible := True;
    CLB_VirtAcc.Visible := True;
    slVirtAcc.Visible := True;
    aCheckedAll2.Visible := True;
    aUncheckedAll2.Visible := True;
    aCheckedSel2.Visible := True;
    seVirtAccSearch.Visible := True;
    seVirtAccSearch.Text := '';
    aCheckedAll2.Enabled := True;
    aUncheckedAll2.Enabled := false;
    aCheckedSel2.Enabled := false;
  end
  else
  begin
    spVirtAcc.Visible := false;
    CLB_VirtAcc.Visible := false;
    slVirtAcc.Visible := false;
    aCheckedAll2.Visible := false;
    aUncheckedAll2.Visible := false;
    aCheckedSel2.Visible := false;
    seVirtAccSearch.Visible := false;
  end;
  slVirtAcc.Caption := 'Виртуальный счет: выбрано - 0';
  fCLB_VirtAccs := aValue;
end;

procedure TRepFrm.Setcb_Mob_Oper(aValue : Boolean);
begin
  if aValue then
  begin
    if not qMob_Oper.Active then
      qMob_Oper.Open
    else
      qMob_Oper.First;
    while not qMob_Oper.EOF do
    begin
      CLB_Mob_Oper.Items.AddObject(Trim(qMob_Oper.FieldByName('MOBILE_OPERATOR_NAME').AsString),
      Pointer(qMob_Oper.FieldByName('MOBILE_OPERATOR_NAME_ID').AsInteger));
      qMob_Oper.Next;
    end;
    spMobOper.Visible := True;
    CLB_Mob_Oper.Visible := True;
    slMobOperCapt.Visible := True;
    aCheckedAll1.Visible := True;
    aUncheckedAll1.Visible := True;
    aCheckedSel1.Visible := True;
    seMobOperSearch.Visible := True;
    seMobOperSearch.Text := '';
  end
  else
  begin
    spMobOper.Visible := false;
    CLB_Mob_Oper.Visible := false;
    slMobOperCapt.Visible := false;
    aCheckedAll1.Visible := false;
    aUncheckedAll1.Visible := false;
    aCheckedSel1.Visible := false;
    seMobOperSearch.Visible := false;
  end;
  fcb_Mob_Oper := aValue;
end;

procedure TRepFrm.FullCLBAccounts;
begin
    if MayShow then
    begin
      sGauge1.Progress := 0;
      sGauge1.MaxValue := 10;
      sp.Visible := True;
      CLB_Accounts.Visible := false;
      Application.ProcessMessages;
      sGauge1.Repaint;
      sGauge1.Refresh;
      Application.ProcessMessages;
    end;
    if MayShow then
    begin
      sGauge1.Progress := 4;
      Application.ProcessMessages;
      sGauge1.Repaint;
      sGauge1.Refresh;
      Application.ProcessMessages;
    end;
    CLB_Accounts.Items.Clear;
    qAccount_cnt.Close;
    qAccount_cnt.Open;
    account_count := qAccount_cnt.FieldByName('cnt').AsInteger;
    if MayShow then
    begin
      sGauge1.Progress := 6;
      Application.ProcessMessages;
      sGauge1.Repaint;
      sGauge1.Refresh;
      Application.ProcessMessages;
      sGauge1.MaxValue := account_count;
      qAccount_cnt.Close;
      sGauge1.Progress := 0;
      sGauge1.Visible := True;
      Application.ProcessMessages;
    end;
    if not qAccount.Active then
      qAccount.Open
    else
      qAccount.First;
    while not qAccount.EOF do
    begin
//      CLB_Accounts.Items.AddObject(Trim(qAccount.FieldByName('ACCOUNT_NUMBER_LOGIN').AsString),
      CLB_Accounts.Items.AddObject(Trim(qAccount.FieldByName('ACCOUNT_NUMBER').AsString),
      Pointer(qAccount.FieldByName('ACCOUNT_ID').AsInteger));
      if MayShow then
      begin
        Application.ProcessMessages;
        sGauge1.Progress := sGauge1.Progress + 1;
        sGauge1.Repaint;
        Application.ProcessMessages;
      end;
      qAccount.Next;
    end;
    if MayShow then
      sp.Visible := false;
    CLB_Accounts.Visible := True;
end;

procedure TRepFrm.SetCLBAccounts(aValue : Boolean);
begin
  if aValue then
  begin
    spAccount.Visible := True;
    CLB_Accounts.Visible := True;
    slAccontCapt.Visible := True;
    aCheckedAll.Visible := True;
    aUncheckedAll.Visible := True;
    seAccountSearch.Visible := True;
    seAccountSearch.Text := '';
    aCheckedSel.Visible := True;
    aCheckedAll.Enabled := True;
    aUncheckedAll.Enabled := false;
    aCheckedSel.Enabled := false;
    FullCLBAccounts;
  end
  else
  begin
    spAccount.Visible := false;
    CLB_Accounts.Visible := false;
    slAccontCapt.Visible := false;
    aCheckedAll.Visible := false;
    aUncheckedAll.Visible := false;
    seAccountSearch.Visible := false;
    aCheckedSel.Visible := false;
  end;
  slAccontCapt.Caption := 'Лицевой счет: выбрано - 0 из ' + IntToStr(account_count);
  fCLBAccounts := aValue;
end;

procedure TRepFrm.ResiseAllButtons;
begin
  spMobOper.BevelOuter := bvNone;
  spVirtAcc.BevelOuter := bvNone;
  spAccount.BevelOuter := bvNone;
  spFilial.BevelOuter := bvNone;
  spShow.BevelOuter := bvNone;
  spFiltrSearch.BevelOuter := bvNone;
end;

procedure TRepFrm.Loaded;
var
  st  : string;
begin
  inherited;
  /// процедура выполняется до события FormCreate
  /// если нижна доп. инициализвция чего - либо - писать здесь
  if FormStyle = fsMDIChild then
  begin
    ReadIniAny(Dm.FileNameIni, name, 'WindowState', st);
    if st = ''  then
      WindowState := wsNormal;
    if st = '1' then
      WindowState := wsNormal;
    if st = '3' then
      WindowState := wsMaximized;
    if st = '2' then
      WindowState := wsMinimized;

    ReadIniAny(Dm.FileNameIni, name, 'Left', st);
    self.Left := StrToIntDef(st, Left);

    ReadIniAny(Dm.FileNameIni, name, 'Top', st);
    self.Top := StrToIntDef(st, Top);

    ReadIniAny(Dm.FileNameIni, name, 'Height', st);
    self.Height := StrToIntDef(st, Height);

    ReadIniAny(Dm.FileNameIni, name, 'Width', st);
    self.Width := StrToIntDef(st, Width);
  end;

end;

procedure TRepFrm.FormCreate(Sender: TObject);
var
  r,i: Integer;
  ff : TField;
  st  : string;
begin
  inherited;
  myCapt := caption;
  aMoveNext.Caption := Dm.MoveNextHint;
  aMoveNext.Hint := aMoveNext.Caption;
  aMovePrev.Caption := Dm.MovePrevHint;
  aMovePrev.Hint := aMovePrev.Caption;
  MayShow := False;
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
  try
    ff := qReport.FindField('USER_CREATED_FIO');
    if ff  <> nil then
    begin
      qReport.FieldByName('USER_CREATED_FIO').ReadOnly := True;
      qReport.FieldByName('DATE_CREATED_').ReadOnly := True;
      qReport.FieldByName('USER_CREATED_FIO').Visible := Dm.ShowInfoCreator;
      qReport.FieldByName('DATE_CREATED_').Visible := Dm.ShowInfoCreator;
    end;
    ff := qReport.FindField('USER_LAST_UPDATED_FIO');
    if ff  <> nil then
    begin
      qReport.FieldByName('USER_LAST_UPDATED_FIO').ReadOnly := True;
      qReport.FieldByName('DATE_LAST_UPDATED_').ReadOnly := True;
      qReport.FieldByName('USER_LAST_UPDATED_FIO').Visible := Dm.ShowInfoChanger;
      qReport.FieldByName('DATE_LAST_UPDATED_').Visible := Dm.ShowInfoChanger;
    end;
  except
    //
  end;

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

  seMobOperSearch.Enabled := True;
  seMobOperSearch.ReadOnly := False;
  Dm.applMainForm.OnKeyDown := OnKeyDown;
  myCapt := Caption;
  if (FormStyle = fsNormal) and (BorderStyle = bsNone) then
    Dm.applMainForm.Caption := Dm.MainCaption + ' - ' + Caption;
  AddExcelColNumber := True;
  CRGrid.TitleFont.Style := [fsBold];
  CRGrid.ReadOnly := True;
  YEAR_MONTH := -1;

  ReadIniAny(Dm.FileNameIni, myCapt, TDBGrid(CRGrid).Columns[0].FieldName, st);
  if (st <> '') then
  begin
    FitGrid(TDBGrid(CRGrid), Dm.FileNameIni, myCapt);
    AllLoaded := true;
  end;
end;


procedure TRepFrm.fGlQBeforeOpen(DataSet: TDataSet);
begin
  if qReport.SQL.ToString = '' then
    TimedMessageBox('У OraQuery - ' + qReport.Name + ' не указан запрос!', 'Пожалуйста, будьте внимательны!', mtError, [mbOK], mbOK, 25, 3);
  if Assigned(ExBeforeOpen) then
    ExBeforeOpen(DataSet);
end;

procedure TRepFrm.fGlQAfterOpen(DataSet: TDataSet);
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
  if Assigned(ExAfterScroll) then
    ExAfterScroll(DataSet);
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

procedure TRepFrm.aFiltrExecute(Sender: TObject);
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

procedure TRepFrm.aFindExecute(Sender: TObject);
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

procedure TRepFrm.aFirstExecute(Sender: TObject);
begin
  inherited;
  qReport.First;
end;

procedure TRepFrm.aInfoExecute(Sender: TObject);
var
  mfUser : TFindUser;
begin
  inherited;
  if fb_PhoneField then
  begin
     mfUser.PHONE_ID := PhoneField.AsInteger;
     mfUser.ACCOUNT_ID := 1;
     mfUser.MOBILE_OPERATOR_NAME_ID := 1;
     DoShowInfoAboutPhone(mfUser);
  end;
end;

procedure TRepFrm.aLastExecute(Sender: TObject);
begin
  inherited;
  qReport.Last;
end;

procedure TRepFrm.aMoveNextExecute(Sender: TObject);
begin
  inherited;
   qReport.MoveBy(dm.MoveNext);
end;

procedure TRepFrm.aMovePrevExecute(Sender: TObject);
begin
  inherited;
   qReport.MoveBy(-dm.MoveNext);
end;

procedure TRepFrm.aNextExecute(Sender: TObject);
begin
  inherited;
  qReport.Next;
end;

procedure TRepFrm.aPrevExecute(Sender: TObject);
begin
  inherited;
  qReport.Prior;
end;

procedure TRepFrm.qAccountBeforeOpen(DataSet: TDataSet);
var
  txt, par, sort : string;
begin
  inherited;
  txt := 'select distinct                                               '+#10+#13+
         '     v.ACCOUNT_ID,                                            '+#10+#13+
         '     v.ACCOUNT_NUMBER,                                        '+#10+#13+
         '     v.login,                                                 '+#10+#13+
         '     v.ACCOUNT_NUMBER||''; ''||v.login  ACCOUNT_NUMBER_LOGIN  '+#10+#13+
         '  from V_BILLS v                                              ';


  if FMOpid <> '' then
    par := ' where v.MOBILE_OPERATOR_NAME_ID in (' + FMOpid + ')'
  else
    par := ' where v.MOBILE_OPERATOR_NAME_ID in (-1)';

  sort := 'ORDER BY ACCOUNT_NUMBER ASC';

  //qAccount.SQL.Clear;
  //qAccount.SQL.Add(txt);
  //qAccount.SQL.Add(par);
  //qAccount.SQL.Add(sort);
end;

procedure TRepFrm.qAccount_cntBeforeOpen(DataSet: TDataSet);
//var
//txt, par, par1 : string;
begin
  inherited;
 {
  txt :=   'SELECT count(account_id) cnt ' +
           'FROM ACCOUNTS where (MOBILE_OPERATOR_NAME_ID is not null) ';

  txt := 'select '+#10+#13+
         '     count(distinct v.ACCOUNT_ID) cnt                         '+#10+#13+
         '  from V_BILLS v                                              ';
    if FVSchid <> '' then
      par := ' where v.VIRTUAL_ACCOUNTS_ID in (' + FVSchid + ')'+#10+#13;

    if Filialid <> '' then
    begin
      if FVSchid <> '' then
        par1 := ' and v.filial_id in (' + Filialid + ')'+#10+#13
      else
        par1 := ' where v.filial_id in (' + Filialid + ')'+#10+#13;
    end;
  }
//  qAccount_cnt.SQL.Clear;
//  qAccount_cnt.SQL.Add(txt);
//  qAccount_cnt.SQL.Add(par);
 // qAccount_cnt.SQL.Add(par1);

end;

procedure TRepFrm.qfilialsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  CLB_Filial.Items.Clear;
  while not qfilials.EOF do
  begin
    CLB_Filial.Items.AddObject(Trim(qfilials.FieldByName('FILIAL_NAME').AsString),
       Pointer(qfilials.FieldByName('FILIAL_ID').AsInteger));
    qfilials.Next;
  end;

end;

procedure TRepFrm.qfilialsBeforeOpen(DataSet: TDataSet);
var
txt, par, sort : string;
begin
  inherited;
  txt := 'select distinct     '+
         '     v.filial_id,   '+
         '     v.filial_name  '+
         '    from V_BILLS v  ';
  if FMOpid <> '' then
    par := ' where MOBILE_OPERATOR_NAME_ID in (' + FMOpid + ')'
  else
    par := ' where MOBILE_OPERATOR_NAME_ID in (-1)';
  sort :=  ' ORDER BY filial_name ASC';
//  qfilials.SQL.Clear;
 // qfilials.SQL.Add(txt);
 // qfilials.SQL.Add(par);
  //qfilials.SQL.Add(sort);
end;

procedure TRepFrm.qReportBeforeOpen(DataSet: TDataSet);
begin
  inherited;
//
end;

procedure TRepFrm.qVirt_AccAfterOpen(DataSet: TDataSet);
begin
  inherited;
    CLB_VirtAcc.Items.Clear;
    while not qVirt_Acc.EOF do
    begin
      CLB_VirtAcc.Items.AddObject(Trim(qVirt_Acc.FieldByName('VIRTUAL_ACCOUNTS_NAME').AsString),
        Pointer(qVirt_Acc.FieldByName('VIRTUAL_ACCOUNTS_ID').AsInteger));
      qVirt_Acc.Next;
    end;
end;

procedure TRepFrm.qVirt_AccBeforeOpen(DataSet: TDataSet);
var
txt, par, sort : string;
begin
  inherited;
  txt := ' select distinct              '+
         ' v.VIRTUAL_ACCOUNTS_ID,       '+
         ' v.VIRTUAL_ACCOUNTS_name      '+
         ' from V_BILLS v               ';

  if FMOpid <> '' then
    par := ' where v.MOBILE_OPERATOR_NAME_ID in (' + FMOpid + ')'
  else
    par := ' where v.MOBILE_OPERATOR_NAME_ID in (-1)';
  sort := 'order by VIRTUAL_ACCOUNTS_name ASC';

 // qVirt_Acc.SQL.Clear;
 // qVirt_Acc.SQL.Add(txt);
 // qVirt_Acc.SQL.Add(par);
 // qVirt_Acc.SQL.Add(sort);
//  if (Mob_Check_count = 0) then
//  begin
//    CLB_VirtAcc.Items.Clear;
//    raise EAbort.Create('');
//  end;
end;

procedure TRepFrm.aRefreshExecute(Sender: TObject);
var
  st, i, ln : Integer;
  OraStoredProc : TOraStoredProc;
  rzd, lFAccid, rFAccid : string;
begin
  inherited;
  st := 3900;

 // if (Mob_Check_count = 0) then
 // begin
 //   TimedMessageBox('Не выбрано ни одного мобильного оператора!','Пожалуйста, будьте внимательны!',mtWarning,[mbOK],mbOK,5);
 //   exit;
 // end;
 // if (CLB_Check_count = 0) then
 // begin
 //   TimedMessageBox('Не выбрано ни одного лицевого счета!','Пожалуйста, будьте внимательны!',mtWarning,[mbOK],mbOK,5);
 //   exit;
 // end;

  if (account_check_count > 1000) and (account_count > account_check_count) then
  begin
  //  TimedMessageBox('    Вы выбрали более тысячи позиций!' +
   //                  #10#13 + 'Допускается выбрать не более 1000.' +
   //                  #10#13 + 'Пожалуйста, пересмотрите свой выбор и укажите не более 1000 позицый.','Допускается к выбору только 1000 позиций!',mtWarning,[mbOK],mbOK,15);
   // exit;
     //OraStoredProc.StoredProcName := FAccid;
    OraStoredProc := TOraStoredProc.Create(self);
    OraStoredProc.Session := Dm.OraSession;
    OraStoredProc.StoredProcName := 'delete_T_ACCOUNTS';
    OraStoredProc.PrepareSQL;  // receive parameters
    OraStoredProc.Execute;
    OraStoredProc.StoredProcName := 'ins_t_accounts2';
    OraStoredProc.PrepareSQL;  // receive parameters
    ln := Length(FAccid);
    if Ln <= st then
    begin
      OraStoredProc.ParamByName('txtID').AsString := FAccid;
     OraStoredProc.Execute;
    end
    else
    begin
      rFAccid := FAccid;
      sGauge1.MaxValue := Ln div st;
      sGauge1.Progress := 0;
      sp.Visible := True;
      CLB_Accounts.Visible := false;
      while Ln > st do
      begin
        Application.ProcessMessages;
        sGauge1.Progress := sGauge1.Progress + 1;
        sGauge1.Repaint;
        Application.ProcessMessages;
        lFAccid := Copy(rFAccid,1,st);
        for i := st downto 0 do
        begin
          rzd := lFAccid[i];
          if rzd = ',' then Break;
        end;
        rzd := Copy(lFAccid,i+1,st);
        lFAccid := Copy(rFAccid,1,i-1);
        rFAccid := rzd + Copy(rFAccid,st+1, Ln - st);
        OraStoredProc.ParamByName('txtID').AsString := lFAccid;
        OraStoredProc.Execute;
        Ln := Length(rFAccid);
      end;
      sp.Visible := false;
      CLB_Accounts.Visible := True;
    end;

    OraStoredProc.Free;
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
    begin
       TimedMessageBox('Ошибка выполнения запроса: ' + qReport.sql.text, 'Пожалуйста, будьте внимательны!',mtError,[mbOK],mbOK,0);
       TimedMessageBox(E.Message, 'Текст ошибки',mtError,[mbOK],mbOK,0);
    end;
  end;
  if CRGrid.DataSource.DataSet.IsEmpty then
  begin
    CRGrid.Enabled := false;
    aFind.Enabled := false;
    aFiltr.Enabled := false;
    aInfo.Enabled := false;
    aToExcel.Enabled := false;
    aDelete.Enabled := false;
  end
  else
  begin
    CRGrid.Enabled := True;
    aFind.Enabled := True;
    aFiltr.Enabled := True;
    aInfo.Enabled := True;
    aToExcel.Enabled := True;
    aDelete.Enabled := True;
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
      if (qReport <> nil) then
      begin
        Name_File_Excel := GET_EXCEL_FILE_NAME( Name_File_Excel);
        ExportOraQuery2(Zagolovok_Excel, '', Name_File_Excel, qReport, FieldNameStr, Dm.AskExcelFileName, True, AddExcelColNumber);
      end
      else
        TimedMessageBox('Не назазначен GlQuery!', 'Пожалуйста, будьте внимательны!', mtError, [mbOK], mbOK, 25, 3);
end;

procedure TRepFrm.aCheckedAll1Execute(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to CLB_Mob_Oper.Items.Count - 1 do
    CLB_Mob_Oper.checked[i] := True;
  aUncheckedAll1.Enabled := True;
  aCheckedAll1.Enabled := false;
  CLB_Mob_OperClickCheck(Sender);
end;

procedure TRepFrm.aCheckedAll2Execute(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to CLB_VirtAcc.Items.Count - 1 do
    CLB_VirtAcc.checked[i] := True;
  aUncheckedAll2.Enabled := True;
  aCheckedAll2.Enabled := false;
  CLB_VirtAccClickCheck(Sender);
end;

procedure TRepFrm.aCheckedAll3Execute(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to CLB_Filial.Items.Count - 1 do
    CLB_Filial.checked[i] := True;
  aUncheckedAll3.Enabled := True;
  aCheckedAll3.Enabled := false;
  CLB_FilialClickCheck(Sender);
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

procedure TRepFrm.aCheckedSel1Execute(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  for i := 0 to CLB_Mob_Oper.Items.Count - 1 do
  begin
    if CLB_Mob_Oper.Selected[i] then
      CLB_Mob_Oper.checked[i] := True
    else
      CLB_Mob_Oper.checked[i] := false;
  end;
  CLB_Mob_OperClickCheck(Sender);
end;

procedure TRepFrm.aCheckedSel2Execute(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  for i := 0 to CLB_VirtAcc.Items.Count - 1 do
  begin
    if CLB_VirtAcc.Selected[i] then
      CLB_VirtAcc.checked[i] := True
    else
      CLB_VirtAcc.checked[i] := false;
  end;
  CLB_VirtAccClickCheck(Sender);
end;

procedure TRepFrm.aCheckedSel3Execute(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  for i := 0 to CLB_Filial.Items.Count - 1 do
  begin
    if CLB_Filial.Selected[i] then
      CLB_Filial.checked[i] := True
    else
      CLB_Filial.checked[i] := false;
  end;
  CLB_FilialClickCheck(Sender);
end;

procedure TRepFrm.aCheckedSelExecute(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  for i := 0 to CLB_Accounts.Items.Count - 1 do
  begin
    if CLB_Accounts.Selected[i] then
      CLB_Accounts.checked[i] := True
    else
      CLB_Accounts.checked[i] := false;
  end;
  CLB_AccountsClickCheck(Sender);
end;

procedure TRepFrm.aUncheckedAll1Execute(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to CLB_Mob_Oper.Items.Count - 1 do
    CLB_Mob_Oper.checked[i] := false;
  aCheckedAll1.Enabled := True;
  aUncheckedAll1.Enabled := false;
  CLB_Mob_OperClickCheck(Sender);
end;

procedure TRepFrm.aUncheckedAll2Execute(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to CLB_VirtAcc.Items.Count - 1 do
    CLB_VirtAcc.checked[i] := false;
  aCheckedAll2.Enabled := True;
  aUncheckedAll2.Enabled := false;
  CLB_VirtAccClickCheck(Sender);
end;

procedure TRepFrm.aUncheckedAll3Execute(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to CLB_Filial.Items.Count - 1 do
    CLB_Filial.checked[i] := false;
  aCheckedAll3.Enabled := True;
  aUncheckedAll3.Enabled := false;
  CLB_FilialClickCheck(Sender);

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

procedure TRepFrm.CLB_AccountsClick(Sender: TObject);
begin
  inherited;
  aCheckedSel.Enabled := (CLB_Accounts.SelCount > 0);
end;

procedure TRepFrm.CLB_AccountsClickCheck(Sender: TObject);
var
  i: Integer;
begin
  FAccid := '';
  FAccount := '';
  account_check_count := 0;
  for i := 0 to CLB_Accounts.Items.Count - 1 do
  begin
    if CLB_Accounts.checked[i] then
    begin
      Inc(account_check_count);
      FAccid := FAccid + IntToStr(Integer(CLB_Accounts.Items.Objects[i])) + ',';
      FAccount := FAccount + CLB_Accounts.Items[i] + ',';
    end;
  end;
  FAccid := copy(FAccid, 1, Length(FAccid) - 1);
  FAccount := copy(FAccount, 1, Length(FAccount) - 1);
  //aRefresh.Enabled := (CLB_Check_count > 0);
  aUncheckedAll.Enabled := account_check_count > 0;
  aCheckedAll.Enabled := account_check_count <> CLB_Accounts.Items.Count;
  aToExcel.Enabled := qReport.Active and (not qReport.IsEmpty);
  slAccontCapt.Caption := 'Лицевой счет: выбрано - ' + IntToStr(account_check_count)+ ' из ' + IntToStr(account_count);
end;

procedure TRepFrm.CLB_AccountsMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  aCheckedSel.Enabled := CLB_Accounts.SelCount > 0;
end;

procedure TRepFrm.CLB_FilialClick(Sender: TObject);
begin
  inherited;
 aCheckedSel3.Enabled := (CLB_Filial.SelCount > 0);
end;

procedure TRepFrm.CLB_FilialClickCheck(Sender: TObject);
var
  i: Integer;
begin
  Filialid := '';
  Filialcount := '';
  Filial_count := 0;

  for i := 0 to CLB_Filial.Items.Count - 1 do
  begin
    if CLB_Filial.checked[i] then
    begin
      Inc(Filial_count);
      Filialid := Filialid + IntToStr(Integer(CLB_Filial.Items.Objects[i])) + ',';
      Filialcount := Filialcount + CLB_Filial.Items[i] + ',';
    end;
  end;
  Filialid := copy(Filialid, 1, Length(Filialid) - 1);
  Filialcount := copy(Filialcount, 1, Length(Filialcount) - 1);
  //aRefresh.Enabled := False;//(Mob_Check_count > 0) and (VSch_count > 0) and (CLB_Check_count > 0);
  aUncheckedAll3.Enabled := (Filial_count > 0);
  aCheckedAll3.Enabled := (Filial_count <> CLB_Filial.Items.Count);
  aToExcel.Enabled := qReport.Active and (not qReport.IsEmpty);
  slFilialCapt.Caption := 'Филиалы: выбрано - ' + IntToStr(Filial_count);
  //qAccount.Close;
  //CLBAccounts := True;
end;

procedure TRepFrm.CLB_Mob_OperClick(Sender: TObject);
begin
  inherited;
   aCheckedSel1.Enabled := CLB_Mob_Oper.SelCount > 0;
end;

procedure TRepFrm.CLB_Mob_OperClickCheck(Sender: TObject);
var
  i: Integer;
begin
  FMOpid := '';
  FMOpcount := '';
  Mob_Check_count := 0;
  for i := 0 to CLB_Mob_Oper.Items.Count - 1 do
  begin
    if CLB_Mob_Oper.checked[i] then
    begin
      Inc(Mob_Check_count);
      FMOpid := FMOpid + IntToStr(Integer(CLB_Mob_Oper.Items.Objects[i])) + ',';
      FMOpcount := FMOpcount + CLB_Mob_Oper.Items[i] + ',';
    end;
  end;
  FMOpid := copy(FMOpid, 1, Length(FMOpid) - 1);
  FMOpcount := copy(FMOpcount, 1, Length(FMOpcount) - 1);

  //aRefresh.Enabled := False; //(Mob_Check_count > 0) and (VSch_count > 0) and (CLB_Check_count > 0);
  aRefresh.Enabled := (Mob_Check_count > 0);
  aUncheckedAll1.Enabled := Mob_Check_count > 0;
  aCheckedAll1.Enabled := Mob_Check_count <> CLB_Mob_Oper.Items.Count;
  aToExcel.Enabled := qReport.Active and (not qReport.IsEmpty);
  slMobOperCapt.Caption := 'Мобильный оператор: выбрано - ' + IntToStr(Mob_Check_count);

  //qfilials.Close;
  //qfilials.Open;

  //qVirt_Acc.Close;
  //qVirt_Acc.Open;

//  qAccount.Close;
//  qAccount.Open;
//  FullCLBAccounts;
end;

procedure TRepFrm.CLB_Mob_OperMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
   aCheckedSel1.Enabled := CLB_Mob_Oper.SelCount > 0;
end;

procedure TRepFrm.CLB_VirtAccClick(Sender: TObject);
begin
  inherited;
 aCheckedSel2.Enabled := (CLB_VirtAcc.SelCount > 0);
end;

procedure TRepFrm.CLB_VirtAccClickCheck(Sender: TObject);
var
  i: Integer;
begin
  FVSchid := '';
  FVSchcount := '';
  VSch_count := 0;
  for i := 0 to CLB_VirtAcc.Items.Count - 1 do
  begin
    if CLB_VirtAcc.checked[i] then
    begin
      Inc(VSch_count);
      FVSchid := FVSchid + IntToStr(Integer(CLB_VirtAcc.Items.Objects[i])) + ',';
      FVSchcount := FVSchcount + CLB_VirtAcc.Items[i] + ',';
    end;
  end;
  FVSchid := copy(FVSchid, 1, Length(FVSchid) - 1);
  FVSchcount := copy(FVSchcount, 1, Length(FVSchcount) - 1);
  //aRefresh.Enabled := False;//(Mob_Check_count > 0) and (VSch_count > 0) and (CLB_Check_count > 0);
  aUncheckedAll2.Enabled := (VSch_count > 0);
  aCheckedAll2.Enabled := (VSch_count <> CLB_VirtAcc.Items.Count);
  aToExcel.Enabled := qReport.Active and (not qReport.IsEmpty);
  slVirtAcc.Caption := 'Виртуальный счет: выбрано - ' + IntToStr(VSch_count);
  //qAccount.Close;
  //CLBAccounts := True;
end;

procedure TRepFrm.CLB_VirtAccMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
 aCheckedSel2.Enabled := (CLB_VirtAcc.SelCount > 0);
end;

procedure TRepFrm.fdsGlQStateChange(Sender: TObject);
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

procedure TRepFrm.SetFormMode(aValue: TFormMode);
begin
  inherited SetFormMode(aValue);
  if ((aValue = fmInsert) or (aValue = fmEdit)) then
    SendMessage(sndWind, WM_NOTIFY_CHGMODE, 0, DWORD(PChar('SetEdit')));
  if ((aValue = fmBrowse) or (aValue = fmInactive)) then
    SendMessage(sndWind, WM_NOTIFY_CHMODE, 0, DWORD(PChar('Setbrowse')));
  Setbuttons;
end;

procedure TRepFrm.set_panels_visible_all(value: boolean);
begin
  cb_Mob_Oper := value;
  CLB_VirtAccs := value;
  CLB_FilialT := value;
  CLBAccounts := value;
  cb_Period   := value;
  spShow.Visible := value;
  pButtonMove.Visible := value;

end;

procedure TRepFrm.s_cancel3Click(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to CLB_Filial.Items.Count - 1 do
    CLB_Filial.checked[i] := false;
  aCheckedAll3.Enabled := True;
  aUncheckedAll3.Enabled := false;
  CLB_FilialClickCheck(Sender);
end;

procedure TRepFrm.sbCheckSelClick(Sender: TObject);
var
 i : Integer;
 txt, txt2 : string;
begin
  inherited;
  if Trim(seAccountSearch.Text) = '' then
    Exit;
   LockWindowUpdate(CLB_Accounts.Handle);

  for i := 0 to CLB_Accounts.Items.Count - 1 do
  begin
    txt := UpperCase(CLB_Accounts.Items.Strings[i]);
    txt2 := UpperCase(Trim(seAccountSearch.Text));
    if AnsiContainsText(txt,txt2) then
      CLB_Accounts.Selected[i] := True
    else
      CLB_Accounts.Selected[i] := false;
  end;
  aCheckedSel.Enabled := CLB_Accounts.SelCount > 0;
  LockWindowUpdate(0);
end;

procedure TRepFrm.sbCheckSel3Click(Sender: TObject);
var
 i : Integer;
 txt, txt2 : string;
begin
  inherited;
  if Trim(seVirtAccSearch.Text) = '' then
    Exit;
  LockWindowUpdate(CLB_VirtAcc.Handle);
  for i := 0 to CLB_VirtAcc.Items.Count - 1 do
  begin
    txt := UpperCase(CLB_VirtAcc.Items.Strings[i]);
    txt2 := UpperCase(Trim(seVirtAccSearch.Text));// Copy(txt,1,length(Trim(seVirtAccSearch.Text))));

    if AnsiContainsText(txt,txt2) then //txt2 = Trim(seVirtAccSearch.Text) then
      CLB_VirtAcc.Selected[i] := True
    else
      CLB_VirtAcc.Selected[i] := false;
  end;
  aCheckedSel2.Enabled := CLB_VirtAcc.SelCount > 0;
  LockWindowUpdate(0);
end;

procedure TRepFrm.sbCheckSel4Click(Sender: TObject);
var
 i : Integer;
 txt, txt2 : string;
begin
  inherited;
  if Trim(seFilialSearch.Text) = '' then
    Exit;
  LockWindowUpdate(CLB_Filial.Handle);
  for i := 0 to CLB_Filial.Items.Count - 1 do
  begin
    txt := UpperCase(CLB_Filial.Items.Strings[i]);
    txt2 := UpperCase(Trim(seFilialSearch.Text));
    if AnsiContainsText(txt,txt2) then
//    txt := CLB_Filial.Items.Strings[i];
//    txt2 := Copy(txt,1,length(Trim(seFilialSearch.Text)));
//    if txt2 = Trim(seFilialSearch.Text) then
      CLB_Filial.Selected[i] := True
    else
      CLB_Filial.Selected[i] := false;
  end;
  aCheckedSel3.Enabled := CLB_Filial.SelCount > 0;
  LockWindowUpdate(0);
end;

procedure TRepFrm.sbCheckSel2Click(Sender: TObject);
var
 i : Integer;
 txt, txt2 : string;
begin
  inherited;
  if Trim(seMobOperSearch.Text) = '' then
    Exit;
  LockWindowUpdate(CLB_Mob_Oper.Handle);
  for i := 0 to CLB_Mob_Oper.Items.Count - 1 do
  begin
    txt := UpperCase(CLB_Mob_Oper.Items.Strings[i]);
    txt2 := UpperCase(Trim(seMobOperSearch.Text));
    if AnsiContainsText(txt,txt2) then
      CLB_Mob_Oper.Selected[i] := True
    else
      CLB_Mob_Oper.Selected[i] := false;
  end;
  aCheckedSel1.Enabled := CLB_Mob_Oper.SelCount > 0;
  LockWindowUpdate(0);
end;

procedure TRepFrm.Setbuttons;
begin
  //
end;

procedure TRepFrm.FormDestroy(Sender: TObject);
var
  i: Integer;
  st:string;
begin
  for i := 0 to CRGrid.Columns.Count - 1 do
  begin
    WriteIniAny(Dm.FileNameIni, myCapt, CRGrid.Columns[i].FieldName, IntToStr(CRGrid.Columns[i].Width));
  end;
  if WindowState = wsNormal then
    st := '1';
  if  WindowState = wsMaximized then
    st := '3';
  if WindowState = wsMinimized then
    st := '2';

  WriteIniAny(Dm.FileNameIni, name, 'WindowState' ,st);

  WriteIniAny(Dm.FileNameIni, name, 'Left' ,IntToStr(left));
  WriteIniAny(Dm.FileNameIni, name, 'Top' ,IntToStr(Top));
  WriteIniAny(Dm.FileNameIni, name, 'Height' ,IntToStr(Height));
  WriteIniAny(Dm.FileNameIni, name, 'Width' ,IntToStr(Width));

  if (FormStyle = fsNormal) and (BorderStyle = bsNone) then
    Dm.applMainForm.Caption := Dm.MainCaption;
  Dm.applMainForm.OnKeyDown := nil;
  Dm.applMainForm.OnKeyPress := nil;
  if (FormStyle = fsNormal) and (BorderStyle = bsNone) then
    qReport.Close;
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
    ResiseAllButtons;

  MayShow := True;
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
