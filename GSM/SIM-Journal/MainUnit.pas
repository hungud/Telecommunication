unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, acAlphaImageList, XPMan, DB, DBAccess, Ora, ComCtrls,
  ToolWin, sToolBar, ActnList, sDialogs, sSkinManager, sSkinProvider,
  acAlphaHints, DBGridEhGrouping, GridsEh, DBGridEh, sSplitter, ExtCtrls,
  StdCtrls, sCheckBox, Mask, sMaskEdit, sCustomComboEdit, sTooledit, Buttons,
  sBitBtn, sComboBox, sLabel, sPanel, ComObj, sPageControl, MemDS, sMemo,
  EhLibCDS, DAScript, OraScript, DateUtils, OdacVcl, IntecExportGrid,
  IdHashMessageDigest;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    XPManifest1: TXPManifest;
    ilToolbar: TsAlphaImageList;
    ilButtons: TsAlphaImageList;
    sAlphaHints1: TsAlphaHints;
    sSkinProvider1: TsSkinProvider;
    sSkinManager1: TsSkinManager;
    sOpenDialog1: TsOpenDialog;
    sToolBar1: TsToolBar;
    tbPrihod: TToolButton;
    tbMove: TToolButton;
    tbMoveBack: TToolButton;
    tbMoveAgain: TToolButton;
    tbBlock: TToolButton;
    tbSeperator2: TToolButton;
    tbRefresh: TToolButton;
    tbSeperator3: TToolButton;
    tbSaveToXL: TToolButton;
    pFilter: TsPanel;
    Splitter1: TSplitter;
    Panel2: TsPanel;
    Splitter2: TsSplitter;
    Panel4: TsPanel;
    sLabelFX3: TsLabelFX;
    grMain: TDBGridEh;
    pHistory: TsPanel;
    sLabelFX2: TsLabelFX;
    ActionList1: TActionList;
    aConnect: TAction;
    acInit: TAction;
    acMove: TAction;
    acMoveAgain: TAction;
    acMoveBack: TAction;
    acBlock: TAction;
    acRefresh: TAction;
    acSaveToXL: TAction;
    acService: TAction;
    acBalanceAndServices: TAction;
    acPaidSMS: TAction;
    aJournalOptionSet: TAction;
    aJournalPaidSMS: TAction;
    aJournalBalances: TAction;
    aJournalUndefPhone: TAction;
    aJournalOperations: TAction;
    sPageControl1: TsPageControl;
    sTabSheet1: TsTabSheet;
    sTabSheet2: TsTabSheet;
    sTabSheet3: TsTabSheet;
    sTabSheet4: TsTabSheet;
    sTabSheet5: TsTabSheet;
    DBGridEh1: TDBGridEh;
    qSim: TOraQuery;
    qSimSIM_ID: TFloatField;
    qSimAGENT_NAME: TStringField;
    qSimSUBAGENT_NAME: TStringField;
    qSimOPERATOR_NAME: TStringField;
    qSimDATE_INIT: TDateTimeField;
    qSimSTATUS_NAME: TStringField;
    qSimDATE_MOVE: TDateTimeField;
    qSimACCOUNT: TStringField;
    qSimCELL_NUMBER: TStringField;
    qSimTARIFF_NAME: TStringField;
    qSimSIM_NUMBER: TStringField;
    qSimABON_PAY: TFloatField;
    qSimDATE_ACTIVATE: TDateTimeField;
    qSimDATE_ERASE: TDateTimeField;
    qSimABONENT_NAME: TStringField;
    qSimBALANCE: TFloatField;
    qSimDATE_BALANCE: TDateTimeField;
    qSimDATE_LAST_ACTIVITY: TDateTimeField;
    qSimGID_STATUS: TStringField;
    dsSim: TDataSource;
    StatusBar1: TStatusBar;
    qSimstatus: TOraQuery;
    dsSimstatus: TDataSource;
    qSimstatusSIMSTATUS_ID: TFloatField;
    qSimstatusSIM_ID: TFloatField;
    qSimstatusSTATUSNAME: TStringField;
    qSimstatusDESCR: TStringField;
    Button1: TButton;
    PopupMenu1: TPopupMenu;
    qSimCHK: TFloatField;
    qDel: TOraQuery;
    tbService: TToolButton;
    tbActiv: TToolButton;
    tbSeperator1: TToolButton;
    ConnectDialog: TConnectDialog;
    OraSession: TOraSession;
    qSimstatusSTATUSDATE: TDateTimeField;
    tbBalanceAndServices: TToolButton;
    qSimOptions: TOraQuery;
    dsSimOptions: TDataSource;
    DBGridEh2: TDBGridEh;
    qSimOptionsDATE_OPTION_CHECK: TDateTimeField;
    qSimOptionsOPTION_NAME: TStringField;
    aShowSimInfo: TAction;
    qSimPHONE_IS_ACTIVE: TStringField;
    qSimOPTS: TStringField;
    qSettings: TOraQuery;
    qSettingsMASTER_PASSWORD: TStringField;
    aSettingsPanel: TAction;
    aCorpPortal: TAction;
    N25: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    aCorpPortalJournal: TAction;
    N30: TMenuItem;
    aJournalBills: TAction;
    N31: TMenuItem;
    aJournalUnAccessPhones: TAction;
    N32: TMenuItem;
    N33: TMenuItem;
    qEncryptPwd: TOraQuery;
    tCaptcha: TTimer;
    qCaptcha: TOraQuery;
    sCheckBox1: TsCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure grMainTitleClick(Column: TColumnEh);
    procedure qSimAfterOpen(DataSet: TDataSet);
    procedure qSimBeforeClose(DataSet: TDataSet);
    procedure acSaveToXLExecute(Sender: TObject);
    procedure acInitExecute(Sender: TObject);
    procedure acRefreshExecute(Sender: TObject);
    procedure acMoveExecute(Sender: TObject);
    procedure acMoveAgainExecute(Sender: TObject);
    procedure acMoveBackExecute(Sender: TObject);
    procedure acBlockExecute(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure acServiceExecute(Sender: TObject);
    procedure acPaidSMSExecute(Sender: TObject);
    procedure aConnectExecute(Sender: TObject);
    procedure aJournalOptionSetExecute(Sender: TObject);
    procedure aJournalPaidSMSExecute(Sender: TObject);
    procedure acBalanceAndServicesExecute(Sender: TObject);
    procedure aJournalBalancesExecute(Sender: TObject);
    procedure aJournalUndefPhoneExecute(Sender: TObject);
    procedure OraSessionAfterConnect(Sender: TObject);
    procedure aJournalOperationsExecute(Sender: TObject);
    procedure aShowSimInfoExecute(Sender: TObject);
    procedure grMainDblClick(Sender: TObject);
    procedure aCorpPortalExecute(Sender: TObject);
    procedure aSettingsPanelExecute(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure aCorpPortalJournalExecute(Sender: TObject);
    procedure aJournalBillsExecute(Sender: TObject);
    procedure aJournalUnAccessPhonesExecute(Sender: TObject);
    procedure tCaptchaTimer(Sender: TObject);
    procedure sCheckBox1Click(Sender: TObject);
  private
    { Private declarations }
    procedure CallOperation(AMode: byte);
    procedure CallJournal(AMode: byte);
  public
    FConnected : Boolean;
    FCaptcha: boolean;
    function CheckMasterPassword:Integer;
    //хеш-функция MD5
    function md5_30(s: string): string;
  end;

var
  MainForm: TMainForm;

implementation

uses InitUnit, DictionaryUnit, OperationUnit, FilterFrameUnit, JournalUnit,
  ShowSimInfo, CorpPortal, SettingsPanel, CorpPortalJournal, ChangePassword,
  CaptchaCheck;

{$R *.dfm}

function TMainForm.md5_30(s: string): string;
begin
Result := '';
  with TIdHashMessageDigest5.Create do
  try
    Result :=Copy(LowerCase(HashStringAsHex(s)),1,30);
  finally
    Free;
  end;
end;

procedure TMainForm.acInitExecute(Sender: TObject);
begin
  CallOperation(1);
end;

procedure TMainForm.acMoveExecute(Sender: TObject);
begin
  CallOperation(2);
end;

function TMainForm.CheckMasterPassword:Integer;
var Otvet:string;
//0-неверно, 1-верно, 2-отказались, не ввели.
begin
  Otvet:=InputBox('Проверка пароля','Введите мастер-пароль','');
  if Length(Otvet)>0 then
  begin
    qSettings.Open;
    if Otvet=qSettingsMASTER_PASSWORD.AsString then
      Result:=1
    else
      Result:=0;
    qSettings.Close;
  end else
    Result:=2;
end;

procedure TMainForm.acMoveAgainExecute(Sender: TObject);
begin
  CallOperation(3);
end;

procedure TMainForm.acMoveBackExecute(Sender: TObject);
begin
  CallOperation(4);
end;

procedure TMainForm.acBlockExecute(Sender: TObject);
begin
  CallOperation(5);
end;

procedure TMainForm.acServiceExecute(Sender: TObject);
begin
  CallOperation(6);
end;

procedure TMainForm.acPaidSMSExecute(Sender: TObject);
begin
  CallOperation(7);
end;

procedure TMainForm.acBalanceAndServicesExecute(Sender: TObject);
begin
  CallOperation(8);
end;

procedure TMainForm.aConnectExecute(Sender: TObject);
begin
  OraSession.Connected := False;
  OraSession.Connected := True;
end;

procedure TMainForm.aCorpPortalExecute(Sender: TObject);
var CorpPortalForm:TCorpPortalForm;
    CheckPassResult:Integer;
begin
  CheckPassResult:=CheckMasterPassword;
  if CheckPassResult=1 then
  begin
    CorpPortalForm := TCorpPortalForm.Create(self);
    try
      CorpPortalForm.ShowModal;
    finally
      CorpPortalForm.Free;
    end;
  end else
    if CheckPassResult=0 then
      Application.MessageBox(PChar('Пароль неверен.'), 'Предупреждение',
        MB_OK + MB_ICONWARNING)
end;

procedure TMainForm.aCorpPortalJournalExecute(Sender: TObject);
var CorpPortalJournalForm:TCorpPortalJournalForm;
    CheckPassResult:Integer;
begin
  CheckPassResult:=CheckMasterPassword;
  if CheckPassResult=1 then
  begin
    CorpPortalJournalForm := TCorpPortalJournalForm.Create(self);
    try
      CorpPortalJournalForm.ShowModal;
    finally
      CorpPortalJournalForm.Free;
    end;
  end else
    if CheckPassResult=0 then
      Application.MessageBox(PChar('Пароль неверен.'), 'Предупреждение',
        MB_OK + MB_ICONWARNING)
end;

procedure TMainForm.acRefreshExecute(Sender: TObject);
var
  i: integer;
begin
  Screen.Cursor := crSQLWait;
  qSim.DisableControls;
  try
    qSim.Cancel;
    qSim.Close;
    qSim.IndexFieldNames := '';
    qSim.Open;

    for i:= 0 to ComponentCount-1 do
      if Components[i].ClassName = TFilterFrame.ClassName then (Components[i] as TFilterFrame).RefreshFilter;

  finally
    qSim.EnableControls;
    Screen.Cursor := crDefault;
  end;
end;

procedure TMainForm.acSaveToXLExecute(Sender: TObject);
begin
  Enabled := false;
  Screen.Cursor := crHourGlass;
  qSim.DisableControls;
  try
    ExportDBGridEhToExcel('СИМ-Карты',grMain, false);
  finally
    qSim.EnableControls;
    Screen.Cursor := crDefault;
  end;
  Enabled := true;
end;

procedure TMainForm.aJournalOptionSetExecute(Sender: TObject);
begin
  CallJournal(0);
end;

procedure TMainForm.aJournalPaidSMSExecute(Sender: TObject);
begin
  CallJournal(1);
end;

procedure TMainForm.aJournalBalancesExecute(Sender: TObject);
begin
  CallJournal(2);
end;

procedure TMainForm.aJournalUndefPhoneExecute(Sender: TObject);
begin
  CallJournal(3);
end;

procedure TMainForm.aJournalOperationsExecute(Sender: TObject);
begin
  CallJournal(4);
end;

procedure TMainForm.aJournalBillsExecute(Sender: TObject);
begin
  CallJournal(5);
end;

procedure TMainForm.aJournalUnAccessPhonesExecute(Sender: TObject);
begin
  CallJournal(6);
end;

procedure TMainForm.aSettingsPanelExecute(Sender: TObject);
var SettingsPanelForm:TSettingsPanelForm;
    CheckPassResult:Integer;
begin
  CheckPassResult:=CheckMasterPassword;
  if CheckPassResult=1 then
  begin
    SettingsPanelForm:=TSettingsPanelForm.Create(self);
    try
      SettingsPanelForm.ShowModal;
    finally
      SettingsPanelForm.Free;
    end;
  end else
    if CheckPassResult=0 then
      Application.MessageBox(PChar('Пароль неверен.'), 'Предупреждение',
        MB_OK + MB_ICONWARNING)
end;

procedure TMainForm.aShowSimInfoExecute(Sender: TObject);
begin
  DoShowSimInfo(qSimCELL_NUMBER.AsString);
end;

procedure TMainForm.CallJournal(AMode: Byte);
var
  fMode: TJournalMode;
  JournalForm: TJournalForm;
begin
  fMode := jmUndefined;
  case AMode of
    0: fMode:=jmOptionSet;
    1: fMode:=jmPaidSMS;
    2: fMode:=jmBalances;
    3: fMode:=jmUndefPhone;
    4: fMode:=jmOperations;
    5: fMode:=jmBills;
    6: fMode:=jmUnAccess;
  end;
  JournalForm := TJournalForm.Create(self, fMode);
  try
    JournalForm.ShowModal;
  finally
    JournalForm.Free;
  end;
  acRefresh.Execute;
end;

procedure TMainForm.CallOperation(AMode: byte);
var
  fMode: TOperationMode;
  OperationForm: TOperationForm;
begin
  fMode := omUndefined;
  case AMode of
    1: fMode:=omInit;
    2: fMode:=omMove;
    3: fMode:=omMoveAgain;
    4: fMode:=omMoveBack;
    5: fMode:=omBlock;
    6: fMode:=omService;
    7: fMode:=omPaidSMS;
    8: fMode:=omBalanceAndServices;
  end;
  OperationForm := TOperationForm.Create(self, fMode);
  try
    OperationForm.ShowModal;
  finally
    OperationForm.Free;
  end;
  acRefresh.Execute;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  f: TFilterFrame;
begin
  qSim.Open;
  sPageControl1.ActivePageIndex := 0;
  f := TFilterFrame.Create(self);
  f.Parent := pFilter;
  f.Align := alClient;
  f.Init(qSim);
end;

procedure TMainForm.FormShow(Sender: TObject);
var
  changepassword:TChangePasswordForm;
begin
  try
    if not OraSession.Connected then
      aConnect.Execute();
  except
    on eAbort : exception do
      ;
    on E : EDatabaseError do
      ;
  end;
  if OraSession.Connected then
  begin
    FConnected := True;
    LoadKeyboardLayout('00000419', KLF_ACTIVATE);//рус
    //Если выставлена константа шифрования пароля, предлогаем пользователю сменить пароль на шифрованный
    //у владельца схемы пароль нешифрованный
    qEncryptPwd.ParamByName('USER_NAME').AsString := OraSession.Username;
    qEncryptPwd.Open;
    if (qEncryptPwd.FieldByName('const_server_name').AsString='GSM_CORP') and
       (qEncryptPwd.FieldByName('const_encrypt_password').AsInteger = 1) and
       (not SameText(OraSession.Username, OraSession.Schema)) then
      try
        changepassword:=nil;
        if qEncryptPwd.FieldByName('user_encrypt_pwd').AsInteger <> 1 then begin
          changepassword:=TChangePasswordForm.Create(application);
          if (changepassword.showmodal = mrCancel) then Close;
        end;
      finally
        qEncryptPwd.close;
        ChangePassword.Free
      end;
  end
  else
    Close;
end;

procedure TMainForm.grMainDblClick(Sender: TObject);
begin
  aShowSimInfo.Execute;
end;

procedure TMainForm.grMainTitleClick(Column: TColumnEh);
var
  i: integer;
begin
  if Column.FieldName = 'CHK' then Exit;

  for i:= 0 to grMain.Columns.Count-1 do
    if (i <> Column.Index) then grMain.Columns[i].Title.SortMarker := smNoneEh;

  case Column.Title.SortMarker of
  smUpEh: begin Column.Title.SortMarker := smDownEh; qSim.IndexFieldNames := Column.FieldName+' desc'; end;
  smNoneEh: begin Column.Title.SortMarker := smUpEh; qSim.IndexFieldNames := Column.FieldName; end;
  smDownEh: begin Column.Title.SortMarker := smNoneEh; qSim.IndexFieldNames := ''; end;
  end;
end;

procedure TMainForm.N10Click(Sender: TObject);
var
  InitForm: TInitForm;
begin
  InitForm := TInitForm.Create(self);
  try
    InitForm.ShowModal;
    acRefresh.Execute;
  finally
    Initform.Free;
  end;

end;

procedure TMainForm.N14Click(Sender: TObject);
var
  str: String;
begin
  qSim.DisableControls;
  try
    Screen.Cursor := crSQLWait;
    str := ';';
    qSim.First;
    while not qSim.Eof do
    begin
      if qSimCHK.AsInteger=1 then Str := Str + qSimSIM_ID.AsString + ';';
      qSim.Next;
    end;
    qDel.Params.ParamByName('idlist').Value := str;
    qDel.Execute;
    acRefresh.Execute;
    Screen.Cursor := crDefault;
  finally
    qSim.EnableControls;
  end;
end;

procedure TMainForm.N15Click(Sender: TObject);
var
  id: integer;
begin
  qSim.DisableControls;
  try
    id := qSimSIM_ID.AsInteger;
    qSim.First;
    while not qSim.Eof do
    begin
      qSim.Edit;
      qSimCHK.AsInteger := 1;
      qSim.Next;
    end;
    qSim.Locate('sim_id', id, []);
  finally
    qSim.EnableControls;
  end;
end;

procedure TMainForm.N16Click(Sender: TObject);
var
  id: integer;
begin
  qSim.DisableControls;
  try
    id := qSimSIM_ID.AsInteger;
    qSim.First;
    while not qSim.Eof do
    begin
      qSim.Edit;
      qSimCHK.AsInteger := 0;
      qSim.Next;
    end;
    qSim.Locate('sim_id', id, []);
  finally
    qSim.EnableControls;
  end;
end;

procedure TMainForm.N2Click(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.N4Click(Sender: TObject);
var
  DictionaryForm: TDictionaryForm;
  amode: TDictionaryMode;
  cap: String;
begin
  cap := TMenuItem(Sender).Caption;
  amode := dmUndefined;
  if cap = 'Агенты' then amode := dmAgent;
  if cap = 'Субагенты' then amode := dmSubagent;
  if cap = 'Операторы' then amode := dmOperator;
  if cap = 'Тарифы' then amode := dmTarif;
  if cap = 'Услуги Мегафона' then amode := dmService;
  DictionaryForm := TDictionaryForm.Create(self, amode);
  try
    DictionaryForm.ShowModal;
  finally
    DictionaryForm.Free;
  end;
end;

procedure TMainForm.qSimAfterOpen(DataSet: TDataSet);
begin
  qSimstatus.Open;
  qSimOptions.Open;
end;

procedure TMainForm.qSimBeforeClose(DataSet: TDataSet);
begin
  qSimstatus.Close;
  qSimOptions.Close;
end;

procedure TMainForm.sCheckBox1Click(Sender: TObject);
begin
  tCaptcha.Enabled:=sCheckBox1.Checked;
  FCaptcha:=true;
end;

procedure TMainForm.tCaptchaTimer(Sender: TObject);
begin
  if FCaptcha then
  begin
    qCaptcha.Close;
    qCaptcha.Open;
    if qCaptcha.Active and (qCaptcha.RecordCount > 0) and FCaptcha then
      DoCaptchaCheck;
  end;
end;

function GetVersionTextOfModule(const FileName : string) : string;
{$IFNDEF CLR}
var
  V1, V2, V3, V4 : Word;
  VerInfoSize : Cardinal;
  VerInfo : Pointer;
  VerValueSize : Cardinal;
  VerValue : PVSFixedFileInfo;
  Dummy : Cardinal;
{$ELSE}
var
  FileVersionAttribute : AssemblyFileVersionAttribute;
{$ENDIF}
begin
{$IFNDEF CLR}
  Result := '';
  VerInfoSize := GetFileVersionInfoSize(PChar(FileName), Dummy);
  if VerInfoSize > 0 then
  begin
    GetMem(VerInfo, VerInfoSize);
    try
      try
        GetFileVersionInfo(PChar(FileName), 0, VerInfoSize, VerInfo);
        VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
        with VerValue^ do
        begin
          V1 := dwFileVersionMS shr 16;
          V2 := dwFileVersionMS and $FFFF;
          V3 := dwFileVersionLS shr 16;
          V4 := dwFileVersionLS and $FFFF;
        end;
        Result := IntToStr(v1)+'.'+IntToStr(v2)+'.'+IntToStr(v3)+'.'+IntToStr(v4);
      except
      end;
    finally
      FreeMem(VerInfo, VerInfoSize);
    end;
  end;
{$ELSE}
  FileVersionAttribute := AssemblyFileVersionAttribute(
    AssemblyFileVersionAttribute.GetCustomAttribute(
			&Assembly.GetExecutingAssembly(),
      typeof(AssemblyFileVersionAttribute)
      )
    );
  if FileVersionAttribute = nil then
    Result := '0.0.0.0'
  else
    Result := FileVersionAttribute.Version;
{$ENDIF}
end;

procedure TMainForm.OraSessionAfterConnect(Sender: TObject);
begin
  Caption := 'Учёт SIM-карт ' + GetVersionTextOfModule(ParamStr(0)) + ' - '
    + OraSession.Username;
end;

end.
