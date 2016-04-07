unit OperationUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, sToolBar, DBCtrls, StdCtrls, sLabel, ExtCtrls,
  sPanel, DBGridEhGrouping, GridsEh, DBGridEh, DB, MemDS, VirtualTable,
  sPageControl, sEdit, Mask, sMaskEdit, sCustomComboEdit, sTooledit, DBAccess,
  Ora, DateUtils, MainUnit, ComObj, Menus, OraObjects, OperationFrameUnit,
  Buttons, sBitBtn, IntecExportGrid, acProgressBar, ActnList, DBCtrlsEh,
  DBLookupEh;

type
  TOperationMode = (omUndefined, omInit, omMove, omMoveAgain, omMoveBack,
    omBlock, omPaidSMS, omService, omBalanceAndServices);

type
  TOperationForm = class(TForm)
    sPanel1: TsPanel;
    sToolBar1: TsToolBar;
    tbPrihod: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    tbLoadXLS: TToolButton;
    ToolButton6: TToolButton;
    tbHistory: TToolButton;
    ToolButton1: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton7: TToolButton;
    vtLoad: TVirtualTable;
    vtLoadaccount: TStringField;
    vtLoadcellnum: TStringField;
    vtLoadtarif: TStringField;
    dsLoad: TDataSource;
    grMain: TDBGridEh;
    vtLoadsimnumber: TStringField;
    sPanel2: TsPanel;
    sEdit1: TsEdit;
    sLabel1: TsLabel;
    sPageControl1: TsPageControl;
    sTabSheet1: TsTabSheet;
    sTabSheet2: TsTabSheet;
    sTabSheet3: TsTabSheet;
    sTabSheet4: TsTabSheet;
    sTabSheet5: TsTabSheet;
    sLabel2: TsLabel;
    sLabel3: TsLabel;
    sDateEdit1: TsDateEdit;
    dsAgent: TDataSource;
    qAgent: TOraQuery;
    spLoad: TOraStoredProc;
    qSubagent: TOraQuery;
    dsSubagent: TDataSource;
    sLabel4: TsLabel;
    sLabel5: TsLabel;
    sDateEdit2: TsDateEdit;
    spSetSimStatus: TOraStoredProc;
    sDateEdit3: TsDateEdit;
    sLabel6: TsLabel;
    sLabel7: TsLabel;
    DBLookupComboBox3: TDBLookupComboBox;
    qOperator: TOraQuery;
    dsOperator: TDataSource;
    qOperatorOPERATOR_ID: TFloatField;
    qOperatorOPERATOR_NAME: TStringField;
    qUpdateMoveSim: TOraQuery;
    PopupMenu1: TPopupMenu;
    qTariff: TOraQuery;
    qTariffTARIFF_NAME: TStringField;
    vtLoaddatelastactiv: TDateField;
    vtLoaddatesell: TDateField;
    sTabSheet6: TsTabSheet;
    qOptions: TOraQuery;
    spSetOptionOn: TOraStoredProc;
    spSetOptionOff: TOraStoredProc;
    sTabSheet7: TsTabSheet;
    sTabSheet8: TsTabSheet;
    cbBalance: TCheckBox;
    cbServices: TCheckBox;
    spSendPaidSMS: TOraStoredProc;
    spGetPhoneStatus: TOraStoredProc;
    qAgentAGENT_ID: TFloatField;
    qAgentNAME: TStringField;
    qSubagentSUB_AGENT_ID: TFloatField;
    qSubagentNAME: TStringField;
    pFilter: TsPanel;
    sBitBtn1: TsBitBtn;
    sBitBtn2: TsBitBtn;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    qSimNoActiv: TOraQuery;
    qSimNoActivNoMoney: TOraQuery;
    qSimNoActivCELL_NUMBER: TStringField;
    qSimNoActivNoMoneyТелефон: TStringField;
    qSimNoActivNoMoneyНедостаток: TFloatField;
    vtLoadagent: TStringField;
    qTariffTARIFF_ID: TFloatField;
    dsTariff: TDataSource;
    Label1: TLabel;
    spSimMove: TOraStoredProc;
    sPanel3: TsPanel;
    sProgressBar1: TsProgressBar;
    sLabel8: TsLabel;
    sBitBtn3: TsBitBtn;
    qCheckPhones: TOraQuery;
    ActionList1: TActionList;
    aShowSimInfo: TAction;
    dsOptions: TDataSource;
    DBGridEh1: TDBGridEh;
    qOptionsOPTION_NAME: TStringField;
    qOptionsCHK_ON: TFloatField;
    qOptionsCHK_OFF: TFloatField;
    DBLookupComboboxEh1: TDBLookupComboboxEh;
    DBLookupComboboxEh2: TDBLookupComboboxEh;
    DBLookupComboboxEh4: TDBLookupComboboxEh;
    procedure tbLoadXLSClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton7Click(Sender: TObject);
    procedure tbHistoryClick(Sender: TObject);
    procedure tbPrihodClick(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure vtLoadAfterInsert(DataSet: TDataSet);
    procedure N11Click(Sender: TObject);
    procedure rgSetTypeClick(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
    procedure sBitBtn1Click(Sender: TObject);
    procedure sBitBtn2Click(Sender: TObject);
    procedure sBitBtn3Click(Sender: TObject);
    procedure sPanel3Click(Sender: TObject);
    procedure grMainDblClick(Sender: TObject);
    procedure aShowSimInfoExecute(Sender: TObject);
  private
    { Private declarations }
    fMode: TOperationMode;
    CountMax: Integer;
    CountProgress: Integer;
    OperRetMessage: String;
    procedure InitMode;
    procedure InitModeLoad;
    procedure MoveMode;
    procedure NotInitLoad(vStatusID: Integer; vDate: TDate);
    procedure MoveBack;
    procedure BlockMode;
    procedure PaidSMSMode;
    procedure PaidSMSModeLoad;
    procedure ServiceMode;
    procedure ServiceModeLoad;
    procedure BalanceAndServicesMode;
    procedure BalanceAndServicesModeLoad;
    procedure ShowProgress(Count: Integer);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; AMode: TOperationMode); reintroduce;
  end;

implementation

{$R *.dfm}

uses ShowSimInfo;

{ TOperationForm }

constructor TOperationForm.Create(AOwner: TComponent; AMode: TOperationMode);
var
  i: Integer;
  Filter: TOperationFilterFrame;
begin
  inherited Create(AOwner);
  sProgressBar1.Width := sPanel3.Width - 120;
  sLabel8.Width := 112;
  sLabel8.Left := 5;
  sLabel8.Top := 4;
  fMode := AMode;

  for i := 0 to sPageControl1.PageCount - 1 do
  begin
    sPageControl1.Pages[i].TabVisible := false;
  end;

  grMain.Columns[0].Visible := fMode = omInit;
  grMain.Columns[1].Visible := fMode = omInit;
  grMain.Columns[3].Visible := fMode = omInit;
  grMain.Columns[4].Visible := fMode = omInit;

  case fMode of
    omInit:
      InitMode;
    omMove, omMoveAgain:
      MoveMode;
    omMoveBack:
      MoveBack;
    omBlock:
      BlockMode;
    omPaidSMS:
      PaidSMSMode;
    omService:
      ServiceMode;
    omBalanceAndServices:
      BalanceAndServicesMode;
  end;

  Filter := TOperationFilterFrame.Create(self);
  Filter.Parent := pFilter;
  Filter.Align := alClient;
  if fMode = omInit then
    pFilter.Hide
  else
    pFilter.Show;
  Filter.Init(vtLoad);

  vtLoad.Open;
  if fMode = omInit then
    Exit;

  MainForm.qSim.DisableControls;
  vtLoad.DisableControls;
  MainForm.qSim.Last;
  while not MainForm.qSim.Bof do
  begin
    if MainForm.qSimCHK.AsInteger = 1 then
    begin
      vtLoad.Insert;
      vtLoadaccount.AsString := MainForm.qSimACCOUNT.AsString;
      vtLoadcellnum.AsString := MainForm.qSimCELL_NUMBER.AsString;
      vtLoadsimnumber.AsString := MainForm.qSimSIM_NUMBER.AsString;
      vtLoadtarif.AsString := MainForm.qSimTARIFF_NAME.AsString;
      vtLoaddatelastactiv.AsDateTime :=
        MainForm.qSimDATE_LAST_ACTIVITY.AsDateTime;
      vtLoad.Post;
    end;
    MainForm.qSim.Prior;
  end;
  MainForm.qSim.EnableControls;
  vtLoad.EnableControls;

  if vtLoad.RecordCount > 0 then
    Exit;
  if not MainForm.qSim.Filtered then
    Exit;

  MainForm.qSim.DisableControls;
  vtLoad.DisableControls;
  MainForm.qSim.Last;
  while not MainForm.qSim.Bof do
  begin
    vtLoad.Insert;
    vtLoadaccount.AsString := MainForm.qSimACCOUNT.AsString;
    vtLoadcellnum.AsString := MainForm.qSimCELL_NUMBER.AsString;
    vtLoadsimnumber.AsString := MainForm.qSimSIM_NUMBER.AsString;
    vtLoadtarif.AsString := MainForm.qSimTARIFF_NAME.AsString;
    vtLoaddatelastactiv.AsDateTime :=
      MainForm.qSimDATE_LAST_ACTIVITY.AsDateTime;
    vtLoad.Post;
    MainForm.qSim.Prior;
  end;
  MainForm.qSim.EnableControls;
  vtLoad.EnableControls;
end;

procedure TOperationForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  vtLoad.Close;
  Action := caFree;
end;

procedure TOperationForm.grMainDblClick(Sender: TObject);
begin
  aShowSimInfo.Execute;
end;

procedure TOperationForm.ShowProgress(Count: Integer);
begin
  if CountMax <> 0 then
  begin
    sLabel8.Caption := FloatToStr(Round(10000 * Count / CountMax) / 100) + '% ('
      + IntToStr(Count) + '/' + IntToStr(CountMax) + ')';
    sProgressBar1.Position := Round(100 * Count / CountMax);
  end
  else
    sLabel8.Caption := '(' + IntToStr(Count) + '/' + IntToStr(CountMax) + ')';
  Application.ProcessMessages;
end;

procedure TOperationForm.sPanel3Click(Sender: TObject);
begin
  CountMax := vtLoad.RecordCount;
  CountProgress := 0;
  ShowProgress(CountProgress);
end;

procedure TOperationForm.BlockMode;
begin
  Caption := 'Списание';
  sPageControl1.ActivePageIndex := 3;
  sDateEdit3.Date := Today;
end;

procedure TOperationForm.InitMode;
var
  m: TMenuItem;
begin
  Caption := 'Приходование новых карт';
  sPageControl1.ActivePageIndex := 0;
  sDateEdit1.Date := Today;
  qTariff.Open;
  if not qTariff.IsEmpty then
    DBLookupComboBoxEh1.KeyValue := qTariffTARIFF_ID.AsVariant;
  qOperator.Open;
  if not qOperator.IsEmpty then
    DBLookupComboBox3.KeyValue := qOperatorOPERATOR_ID.AsInteger;
  qAgent.Open;
  qAgent.First;
  while not qAgent.Eof do
  begin
    m := TMenuItem.Create(self);
    m.Caption := qAgentNAME.AsString;
    m.OnClick := N11Click;
    PopupMenu1.Items.Add(m);
    qAgent.Next;
  end;
  qAgent.Close;
end;

procedure TOperationForm.InitModeLoad;
var
  cnt: Integer;
begin
  Screen.Cursor := crSQLWait;
  MainForm.StatusBar1.SimpleText := 'Выполняется загрузка данных в базу...';

  spLoad.ParamByName('voperatorid').Value := DBLookupComboBox3.KeyValue;
  spLoad.ParamByName('VTARIFFID').Value := DBLookupComboBoxEh1.KeyValue;
  spLoad.ParamByName('vsubagent').Value := null;
  spLoad.ParamByName('vsimnumber').Value := null;
  spLoad.ParamByName('vdateactiv').Value := null;
  spLoad.ParamByName('vdatemove').Value := null;
  spLoad.ParamByName('vdatetechactiv').Value := null;
  spLoad.ParamByName('vdateinit').Value := sDateEdit1.Date;
  vtLoad.DisableControls;
  vtLoad.Last;
  cnt := vtLoad.RecordCount;
  CountMax := vtLoad.RecordCount;
  CountProgress := 0;
  ShowProgress(CountProgress);
  while not vtLoad.Bof do
  begin
    try
      spLoad.ParamByName('vaccount').Value := vtLoadaccount.AsVariant;
      spLoad.ParamByName('vcellnumber').Value := vtLoadcellnum.AsVariant;
      spLoad.ParamByName('vagent').Value := vtLoadagent.AsVariant;
      if vtLoaddatelastactiv.AsString <> '' then
        spLoad.ParamByName('vdatetechactiv').Value :=
          vtLoaddatelastactiv.AsDateTime
      else
        spLoad.ParamByName('vdatetechactiv').Value := null;
      if vtLoaddatesell.AsString <> '' then
        spLoad.ParamByName('vdateinit').Value := vtLoaddatesell.AsDateTime
      else
        spLoad.ParamByName('vdateinit').Value := null;
      spLoad.ExecSQL;
      Inc(CountProgress);
      ShowProgress(CountProgress);
      vtLoad.Delete;
    except
      vtLoad.Prior;
    end;
    Application.ProcessMessages;
  end;
  vtLoad.EnableControls;
  if vtLoad.RecordCount > 0 then
    Application.MessageBox(PChar('Загрузка завершена!' + #13#10 + 'Загружено ' +
      IntToStr(cnt - vtLoad.RecordCount) + ' карт.' + #13#10 +
      'Данные в списке не были загружены. Исправьте данные и запустите загрузку снова.'),
      'Предупреждение', MB_OK + MB_ICONWARNING)
  else
    Application.MessageBox(PChar('Загрузка завершена!' + #13#10 + 'Загружено ' +
      IntToStr(cnt - vtLoad.RecordCount) + ' карт.'), 'Уведомление',
      MB_OK + MB_ICONINFORMATION);
  OperRetMessage := 'Успешно ' + IntToStr(cnt - vtLoad.RecordCount) + '/' +
    IntToStr(cnt);
  Screen.Cursor := crDefault;
  MainForm.StatusBar1.SimpleText := '';
end;

procedure TOperationForm.MoveBack;
begin
  Caption := 'Возврат на склад';
  sPageControl1.ActivePageIndex := 3;
  sDateEdit3.Date := Today;
end;

procedure TOperationForm.MoveMode;
begin
  Caption := 'Отгрузка субагенту';
  sPageControl1.ActivePageIndex := 1;
  sDateEdit2.Date := Today;
  qAgent.Open;
  if not qAgent.IsEmpty then
    DBLookupComboBoxEh4.KeyValue := qAgentAGENT_ID.AsVariant;
  qSubagent.Open;
  if not qSubagent.IsEmpty then
    DBLookupComboBoxEh2.KeyValue := qSubagentSUB_AGENT_ID.AsVariant;
end;

procedure TOperationForm.ServiceMode;
begin
  Caption := 'Подключение и отключение услуг';
  sPageControl1.ActivePageIndex := 5;
  // cbOption.Clear;
  qOptions.Open;
  { while not qOptions.Eof do
    begin
    cbOption.Items.AddObject(qOptions.FieldByName('OPTION_NAME').AsString,
    TObject(qOptions.FieldByName('OPTION_NAME').AsString));
    qOptions.Next;
    end;
    qOptions.Close;
    if cbOption.Items.Count > 0 then
    cbOption.ItemIndex := 0; }
  // ToolButton4.Caption := 'Подключить опцию';
end;

procedure TOperationForm.PaidSMSMode;
begin
  Caption := 'Отправка платных СМС';
  sPageControl1.ActivePageIndex := 6;
  ToolButton4.Caption := 'Послать СМС';
end;

procedure TOperationForm.PaidSMSModeLoad;
var
  cnt, Count: Integer;
  str: String;
begin
  Screen.Cursor := crSQLWait;
  MainForm.StatusBar1.SimpleText := 'Выполняется загрузка данных в базу...';
  str := ';';
  Count := 0;
  vtLoad.DisableControls;
  vtLoad.Last;
  cnt := vtLoad.RecordCount;
  CountMax := vtLoad.RecordCount;
  CountProgress := 0;
  ShowProgress(CountProgress);
  while not vtLoad.Bof do
  begin
    try
      str := str + vtLoadcellnum.AsString + ';';
      spSendPaidSMS.ParamByName('PPHONE_NUMBER').AsString :=
        vtLoadcellnum.AsString;
      spSendPaidSMS.ExecSQL;
      if spSendPaidSMS.ParamByName('RESULT').AsString = '' then
        Count := Count + 1;
      Inc(CountProgress);
      ShowProgress(CountProgress);
      vtLoad.Delete;
    except
      vtLoad.Prior;
    end;
    Application.ProcessMessages;
  end;
  vtLoad.EnableControls;
  if vtLoad.RecordCount > 0 then
    Application.MessageBox(PChar('Отправка завершена!' + #13#10 + 'Оправлено ' +
      IntToStr(cnt - vtLoad.RecordCount) + ' карт.' + #13#10 +
      'Данные в списке не были загружены. Исправьте данные и запустите загрузку снова.'),
      'Предупреждение', MB_OK + MB_ICONWARNING)
  else
    Application.MessageBox(PChar('Отправка завершена!' + #13#10 + 'Оправлено ' +
      IntToStr(cnt - vtLoad.RecordCount) + ' карт.' + 'Успешно ' +
      IntToStr(cnt - vtLoad.RecordCount) + ' карт.'), 'Уведомление',
      MB_OK + MB_ICONINFORMATION);
  Application.MessageBox(PChar('Успешно отправлено ' + IntToStr(Count) +
    ' СМС.'), 'Уведомление', MB_OK + MB_ICONINFORMATION);
  OperRetMessage := 'Успешно ' + IntToStr(cnt - vtLoad.RecordCount) + '/' +
    IntToStr(cnt);
  Screen.Cursor := crDefault;
  MainForm.StatusBar1.SimpleText := '';
end;

procedure TOperationForm.aShowSimInfoExecute(Sender: TObject);
begin
  DoShowSimInfo(vtLoadcellnum.AsString);
end;

procedure TOperationForm.BalanceAndServicesMode;
begin
  Caption := 'Получение баланса и списка подключенных услуг';
  sPageControl1.ActivePageIndex := 7;
  ToolButton4.Caption := 'Получить данные';
end;

procedure TOperationForm.BalanceAndServicesModeLoad;
var
  cnt: Integer;
  str: String;
begin
  Screen.Cursor := crSQLWait;
  MainForm.StatusBar1.SimpleText := 'Выполняется загрузка данных в базу...';
  if cbServices.Checked then
    spGetPhoneStatus.ParamByName('PFULL_CHECK').AsInteger := 1
  else
    spGetPhoneStatus.ParamByName('PFULL_CHECK').AsInteger := 0;
  str := ';';
  vtLoad.DisableControls;
  vtLoad.Last;
  cnt := vtLoad.RecordCount;
  CountMax := vtLoad.RecordCount;
  CountProgress := 0;
  ShowProgress(CountProgress);
  while not vtLoad.Bof do
  begin
    try
      str := str + vtLoadcellnum.AsString + ';';
      spGetPhoneStatus.ParamByName('PPHONE_NUMBER').AsString :=
        vtLoadcellnum.AsString;
      spGetPhoneStatus.ExecSQL;
      Inc(CountProgress);
      ShowProgress(CountProgress);
      vtLoad.Delete;
    except
      vtLoad.Prior;
    end;
    Application.ProcessMessages;
  end;
  vtLoad.EnableControls;
  if vtLoad.RecordCount > 0 then
    Application.MessageBox(PChar('Загрузка завершена!' + #13#10 + 'Загружено ' +
      IntToStr(cnt - vtLoad.RecordCount) + ' карт.' + #13#10 +
      'Данные в списке не были загружены. Исправьте данные и запустите загрузку снова.'),
      'Предупреждение', MB_OK + MB_ICONWARNING)
  else
    Application.MessageBox(PChar('Загрузка завершена!' + #13#10 + 'Загружено ' +
      IntToStr(cnt - vtLoad.RecordCount) + ' карт.'), 'Уведомление',
      MB_OK + MB_ICONINFORMATION);
  OperRetMessage := 'Успешно ' + IntToStr(cnt - vtLoad.RecordCount) + '/' +
    IntToStr(cnt);
  Screen.Cursor := crDefault;
  MainForm.StatusBar1.SimpleText := '';
end;

procedure TOperationForm.N11Click(Sender: TObject);
begin
  vtLoad.Edit;
  vtLoadagent.AsString := TMenuItem(Sender).Caption;
end;

procedure TOperationForm.NotInitLoad(vStatusID: Integer; vDate: TDate);
var
  cnt: Integer;
  str: String;
begin
  Screen.Cursor := crSQLWait;
  MainForm.StatusBar1.SimpleText := 'Выполняется загрузка данных в базу...';
  spSetSimStatus.ParamByName('VSTATUSID').Value := vStatusID;
  spSetSimStatus.ParamByName('VDATE').Value := vDate;
  spSetSimStatus.ParamByName('VDESCR').Value := sEdit1.Text;
  spSimMove.ParamByName('PAGENT_ID').AsInteger := qAgentAGENT_ID.AsInteger;
  spSimMove.ParamByName('PSUB_AGENT_ID').AsInteger :=
    qSubagentSUB_AGENT_ID.AsInteger;
  if fMode = omMoveBack then
  begin
    spSimMove.ParamByName('PAGENT_ID').AsInteger := 1;
    spSimMove.ParamByName('PSUB_AGENT_ID').AsInteger := 1;
  end;

  str := ';';
  vtLoad.DisableControls;
  vtLoad.Last;
  cnt := vtLoad.RecordCount;
  CountMax := vtLoad.RecordCount;
  CountProgress := 0;
  ShowProgress(CountProgress);
  while not vtLoad.Bof do
  begin
    try
      str := str + vtLoadcellnum.AsString + ';';
      spSetSimStatus.ParamByName('VCELLNUMBER').Value :=
        vtLoadcellnum.AsVariant;
      spSetSimStatus.ExecSQL;
      if fMode in [omMove, omMoveAgain, omMoveBack] then
      begin
        spSimMove.ParamByName('PCELL_NUMBER').Value := vtLoadcellnum.AsVariant;
        spSimMove.ExecSQL;
      end;
      Inc(CountProgress);
      ShowProgress(CountProgress);
      vtLoad.Delete;
    except
      vtLoad.Prior;
    end;
    Application.ProcessMessages;
  end;
  vtLoad.EnableControls;
  if vtLoad.RecordCount > 0 then
    Application.MessageBox(PChar('Загрузка завершена!' + #13#10 + 'Загружено ' +
      IntToStr(cnt - vtLoad.RecordCount) + ' карт.' + #13#10 +
      'Данные в списке не были загружены. Исправьте данные и запустите загрузку снова.'),
      'Предупреждение', MB_OK + MB_ICONWARNING)
  else
    Application.MessageBox(PChar('Загрузка завершена!' + #13#10 + 'Загружено ' +
      IntToStr(cnt - vtLoad.RecordCount) + ' карт.'), 'Уведомление',
      MB_OK + MB_ICONINFORMATION);
  OperRetMessage := 'Успешно ' + IntToStr(cnt - vtLoad.RecordCount) + '/' +
    IntToStr(cnt);
  Screen.Cursor := crDefault;
  MainForm.StatusBar1.SimpleText := '';
end;

procedure TOperationForm.ServiceModeLoad;
var
  cnt: Integer;
begin
  Screen.Cursor := crSQLWait;
  MainForm.StatusBar1.SimpleText := 'Выполняется загрузка данных в базу...';
  qOptions.DisableControls;
  vtLoad.DisableControls;
  vtLoad.Last;
  cnt := vtLoad.RecordCount;
  CountMax := vtLoad.RecordCount;
  CountProgress := 0;
  ShowProgress(CountProgress);
  while not vtLoad.Bof do
  begin
    try
      qOptions.First;
      while not qOptions.Eof do
      begin
        spSetOptionOn.ParamByName('POPTION_NAME').AsString :=
          qOptionsOPTION_NAME.AsString;
        spSetOptionOff.ParamByName('POPTION_NAME').AsString :=
          qOptionsOPTION_NAME.AsString;
        if qOptionsCHK_ON.AsInteger = 1 then
        begin
          spSetOptionOn.ParamByName('PPHONE_NUMBER').AsString :=
            vtLoadcellnum.AsString;
          spSetOptionOn.ExecSQL;
        end;
        if qOptionsCHK_OFF.AsInteger = 1 then
        begin
          spSetOptionOff.ParamByName('PPHONE_NUMBER').Value :=
            vtLoadcellnum.AsVariant;
          spSetOptionOff.ExecSQL;
        end;
        qOptions.Next;
      end;
      Inc(CountProgress);
      ShowProgress(CountProgress);
      vtLoad.Delete;
    except
      vtLoad.Prior;
    end;
    Application.ProcessMessages;
  end;
  vtLoad.EnableControls;
  if vtLoad.RecordCount > 0 then
    Application.MessageBox(PChar('Загрузка завершена!' + #13#10 + 'Загружено ' +
      IntToStr(cnt - vtLoad.RecordCount) + ' карт.' + #13#10 +
      'Данные в списке не были загружены. Исправьте данные и запустите загрузку снова.'),
      'Предупреждение', MB_OK + MB_ICONWARNING)
  else
    Application.MessageBox(PChar('Загрузка завершена!' + #13#10 + 'Загружено ' +
      IntToStr(cnt - vtLoad.RecordCount) + ' карт.'), 'Уведомление',
      MB_OK + MB_ICONINFORMATION);
  OperRetMessage := 'Успешно ' + IntToStr(cnt - vtLoad.RecordCount) + '/' +
    IntToStr(cnt);
  qOptions.EnableControls;
  Screen.Cursor := crDefault;
  MainForm.StatusBar1.SimpleText := '';
end;

procedure TOperationForm.rgSetTypeClick(Sender: TObject);
begin
  { if rgSetType.ItemIndex = 0 then
    ToolButton4.Caption := 'Отключить опцию';
    if rgSetType.ItemIndex = 1 then
    ToolButton4.Caption := 'Подключить опцию'; }
end;

procedure TOperationForm.sBitBtn1Click(Sender: TObject);
begin
  vtLoad.DisableControls;
  vtLoad.Clear;
  qSimNoActiv.Open;
  qSimNoActiv.First;
  while not qSimNoActiv.Eof do
  begin
    vtLoad.Insert;
    vtLoadcellnum.AsString := qSimNoActivCELL_NUMBER.AsString;
    vtLoad.Post;
    qSimNoActiv.Next;
  end;
  qSimNoActiv.Close;
  vtLoad.EnableControls;
end;

procedure TOperationForm.sBitBtn2Click(Sender: TObject);
begin
  qSimNoActivNoMoney.Open;
  ExportDBGridEhToExcel('Список номеров на пополнение баланса для платных СМС',
    grMain, false);
  qSimNoActivNoMoney.Close;
end;

procedure TOperationForm.sBitBtn3Click(Sender: TObject);
var
  Check: Integer;
  Phones: TStringList;
begin
  vtLoad.DisableControls;
  CountMax := vtLoad.RecordCount;
  CountProgress := 0;
  ShowProgress(CountProgress);
  { if rgSetType.ItemIndex = 0 then
    qCheckPhones.ParamByName('PTYPE_SET').AsString := 'Отключение';
    if rgSetType.ItemIndex = 1 then
    qCheckPhones.ParamByName('PTYPE_SET').AsString := 'Подключение'; }
  // qCheckPhones.ParamByName('POPTION_NAME').AsString :=
  // cbOption.Items[cbOption.ItemIndex];
  Phones := TStringList.Create;
  Phones.Clear;
  Phones.Sorted := true;
  qCheckPhones.Open;
  qCheckPhones.First;
  vtLoad.Last;
  while not qCheckPhones.Eof do
  begin
    Phones.Append(qCheckPhones.FieldByName('PHONE_NUMBER').AsString);
    qCheckPhones.Next;
  end;
  qCheckPhones.Close;
  while not vtLoad.Bof do
  begin
    if Phones.Find(vtLoadcellnum.AsString, Check) then
      vtLoad.Delete
    else
      vtLoad.Prior;
    Inc(CountProgress);
    ShowProgress(CountProgress);
  end;
  vtLoad.EnableControls;
  CountMax := vtLoad.RecordCount;
  CountProgress := 0;
  ShowProgress(CountProgress);
end;

procedure TOperationForm.tbHistoryClick(Sender: TObject);
begin
  vtLoad.Clear;
end;

procedure TOperationForm.tbLoadXLSClick(Sender: TObject);
const
  ExcelApp = 'Excel.Application';
var
  Excel: OleVariant;
  i: Integer;
  datecheck: string;
begin
  if MainForm.sOpenDialog1.Execute then
  begin
    Excel := CreateOleObject(ExcelApp);
    Excel.Application.EnableEvents := false;
    Excel.Visible := false;
    Excel.Workbooks.Open(MainForm.sOpenDialog1.FileName);
    i := 1;
    while VarToStr(Excel.Cells[i, 1]) <> '' do
    begin
      vtLoad.Append;
      if fMode = omInit then
      begin
        vtLoadagent.AsString := Excel.Cells[i, 1];
        vtLoadaccount.AsString := Excel.Cells[i, 2];
        vtLoadcellnum.AsString := Excel.Cells[i, 3];
        if VarToStr(Excel.Cells[i, 4]) <> '' then
          vtLoaddatelastactiv.AsDateTime :=
            StrToDate(StringReplace(Excel.Cells[i, 4], ',', '.',
            [rfReplaceAll]))
        else
          vtLoaddatelastactiv.AsVariant := null;
        if VarToStr(Excel.Cells[i, 5]) <> '' then
          vtLoaddatesell.AsDateTime :=
            StrToDate(StringReplace(Excel.Cells[i, 5], ',', '.',
            [rfReplaceAll]))
        else
          vtLoaddatesell.AsVariant := null;
      end
      else
        vtLoadcellnum.AsString := Excel.Cells[i, 1];
      vtLoad.Post;

      Inc(i);
    end;
    Excel.Quit;
    Excel := Unassigned;
  end;
end;

procedure TOperationForm.tbPrihodClick(Sender: TObject);
begin
  vtLoad.Insert;
end;

procedure TOperationForm.ToolButton2Click(Sender: TObject);
begin
  if not vtLoad.IsEmpty then
    vtLoad.Delete;
end;

procedure TOperationForm.ToolButton4Click(Sender: TObject);
var
  oq: TOraQuery;
  dtStart: TDateTime;
begin
  oq := TOraQuery.Create(self);
  try
    oq.SQL.Text := 'select sysdate q from dual';
    oq.Open;
    dtStart := oq.FieldByName('q').AsDateTime;
    oq.Close;
    case fMode of
      omInit:
        InitModeLoad;
      omMove, omMoveAgain:
        NotInitLoad(7, sDateEdit2.Date);
      omMoveBack:
        NotInitLoad(8, sDateEdit3.Date);
      omBlock:
        NotInitLoad(6, sDateEdit3.Date);
      omPaidSMS:
        PaidSMSModeLoad;
      omService:
        ServiceModeLoad;
      omBalanceAndServices:
        BalanceAndServicesModeLoad;
    end;
    oq.SQL.Text :=
      'begin insert into sim_operation_history(operation_type, note, date_begin) '
      + 'values(:v_operation_type, :v_note, :v_date_begin); commit; end;';
    case fMode of
      omInit:
        oq.ParamByName('v_operation_type').Value := 'Загрузка новых карт';
      omMove:
        oq.ParamByName('v_operation_type').Value := 'Отгрузка';
      omMoveBack:
        oq.ParamByName('v_operation_type').Value := 'Возврат';
      omPaidSMS:
        oq.ParamByName('v_operation_type').Value := 'Платная СМС';
      omService:
        oq.ParamByName('v_operation_type').Value :=
          'Подключение/отключение опций';
      omBalanceAndServices:
        oq.ParamByName('v_operation_type').Value :=
          'Получение баланса и списка подключенных услуг';
    end;

    oq.ParamByName('v_note').Value := OperRetMessage;
    oq.ParamByName('v_date_begin').Value := dtStart;
    oq.ExecSQL;
  finally
    oq.Free;
  end;
end;

procedure TOperationForm.ToolButton7Click(Sender: TObject);
begin
  Close;
end;

procedure TOperationForm.ToolButton9Click(Sender: TObject);
begin
  Enabled := false;
  Screen.Cursor := crHourGlass;
  vtLoad.DisableControls;
  try
    ExportDBGridEhToExcel(Caption, grMain, false);
    Enabled := true;
    Application.MessageBox('Выгрузка в Excel завершена!', 'Уведомление',
      MB_OK + MB_ICONEXCLAMATION);
  finally
    Enabled := true;
    vtLoad.EnableControls;
    Screen.Cursor := crDefault;
  end;
end;

procedure TOperationForm.vtLoadAfterInsert(DataSet: TDataSet);
begin
  MainForm.StatusBar1.SimpleText := IntToStr(vtLoad.RecordCount) +
    ' записей для обработки..';
end;

end.
