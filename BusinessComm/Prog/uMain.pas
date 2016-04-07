unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Data.DB,
  Vcl.Menus, Vcl.ActnList, Vcl.Imaging.jpeg, Vcl.Buttons,
  OraCall, OraClasses, Ora, OdacVcl,
  uDm, Func_Const, TimedMsgBox, ChildFrm, Vcl.StdActns, sStatusBar,
  dxRibbonSkins, cxPC, cxPCdxBarPopupMenu, dxTabbedMDI, dxBar, cxClasses,
  dxRibbon, cxControls, Vcl.ImgList, cxGraphics, dxStatusBar, dxRibbonStatusBar;

type
  TMyRef = class of TChildForm;

Type
  TListClass = array of TMyRef;

type
  TMainForm = class(TForm)
    ActionList: TActionList;
    aConnect: TAction;
    aRefUserNames: TAction;
    aCloseWind: TAction;
    WindowClose1: TWindowClose;
    WindowArrange1: TWindowArrange;
    WindowCascade1: TWindowCascade;
    WindowMinimizeAll1: TWindowMinimizeAll;
    WindowTileHorizontal1: TWindowTileHorizontal;
    WindowTileVertical1: TWindowTileVertical;
    aWindChengeMDI: TAction;
    aAboutProg: TAction;
    aRefMobilOperators: TAction;
    aRefAccounts: TAction;
    aRefPhones: TAction;
    aRefPhoneOnAccount: TAction;
    aSettingProgr: TAction;
    aRefVirtualOperators: TAction;
    aRefCountry: TAction;
    aRefRegions: TAction;
    aRefAbonents: TAction;
    aRefFilials: TAction;
    aRefTariffs: TAction;
    aRefDocum_Types: TAction;
    aRefContract: TAction;
    aRepLoaderBills: TAction;
    aRepLoaderBillsLog: TAction;
    aRefPeriods: TAction;
    aRefDocuments: TAction;
    aRepPayments: TAction;
    aRepPaymentsHist: TAction;
    aRefAgent: TAction;
    aRefSubAgent: TAction;
    aRefAgent_Subgent: TAction;
    aRefLocal_Phone_Statuses: TAction;
    aRefOperatorPhoneStatuses: TAction;
    aRefOperatorAccountNames: TAction;
    aRefOperatorSubAccount: TAction;
    aRefProjects: TAction;
    dxRibbon1: TdxRibbon;
    dxtsReference: TdxRibbonTab;
    dxBarManager1: TdxBarManager;
    dxPartners: TdxBar;
    dxAccounts: TdxBar;
    dxStatuses: TdxBar;
    dxAgentsAndSubAgents: TdxBarButton;
    dxPhonesAccounts: TdxBarButton;
    dxPhoneAndAccounts: TdxBarButton;
    dxBarButton1: TdxBarButton;
    dxLocalStatuses: TdxBarLargeButton;
    dxOperators: TdxBarButton;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    dxBarButton4: TdxBarButton;
    dxstatOprators: TdxBarButton;
    dxbtCountryes: TdxBarButton;
    dxbRegions: TdxBarButton;
    dxbtRegions: TdxBarButton;
    dxTabbedMDIManager1: TdxTabbedMDIManager;
    dxbrAccesses: TdxBar;
    dxbrUsers: TdxBarLargeButton;
    cxLargeImages: TcxImageList;
    cxSmallImages: TcxImageList;
    dxbrMobOperators: TdxBar;
    dxbtMobOperators: TdxBarButton;
    dxbrPhones: TdxBar;
    dxbrAbonents: TdxBar;
    dxbrsAbonents: TdxBarLargeButton;
    dxbtFilials: TdxBarButton;
    dxbrTypes: TdxBar;
    dxbtTariffs: TdxBarButton;
    dxbtDocumentTypes: TdxBarButton;
    dxbrContracts: TdxBar;
    dxbrlContracts: TdxBarLargeButton;
    dxbtPeriods: TdxBarButton;
    dxbtProjects: TdxBarButton;
    dxtsLogs: TdxRibbonTab;
    dxbrOperatorBillings: TdxBar;
    dxbrBLoadBillingFiles: TdxBarLargeButton;
    dxbtlLoaderBills: TdxBarLargeButton;
    dxbrPayments: TdxBar;
    dxbrlPayments: TdxBarLargeButton;
    dxbrlPaymentHistory: TdxBarLargeButton;
    dxbrConnection: TdxBar;
    dxtsManage: TdxRibbonTab;
    dxbrlChangeUser: TdxBarLargeButton;
    dxbrSettings: TdxBar;
    dxbrlSettingsProg: TdxBarLargeButton;
    dxbrAbout: TdxBar;
    dxbrlAbout: TdxBarLargeButton;
    dxbrlPhones: TdxBarLargeButton;
    dxBarButton5: TdxBarButton;
    dxBarButton6: TdxBarButton;
    dxBarButton7: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    dxBarButton8: TdxBarButton;
    dxBarButton9: TdxBarButton;
    dxBarButton10: TdxBarButton;
    statusLine: TdxRibbonStatusBar;
    aRefPaymentsType: TAction;
    dxBarButton11: TdxBarButton;
    dxBarLargeButton1: TdxBarLargeButton;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure ShowHint(Sender: TObject);

    procedure SetStateAction;
    procedure aConnectExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CommonClickMenu(Sender: TObject);
    procedure SetActiveScreen;
    procedure aCloseWindExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure NewWinProcedure(var Msg: TMessage);
    procedure aWindChengeMDIExecute(Sender: TObject);
    procedure ChengeMDI;
    procedure aAboutProgExecute(Sender: TObject);
    procedure MessageReceiverMoveNext(var Msg: TMessage); message WM_NOTIFY_GO_ON_THE;
    procedure MessageReceiver(var Msg: TMessage); message WM_NOTIFY_CLSMDI;
    procedure MessageReceiver2(var Msg: TMessage); message WM_NOTIFY_CHGMODE;
    procedure MessageReceiver3(var Msg: TMessage); message WM_NOTIFY_CHMODE;
    procedure aSettingProgrExecute(Sender: TObject);
  private
    ListClass: TListClass;
    NameForm: string;
    fr: TMyRef;
    New_F: TChildForm;
    itm: Integer;
    OutCanvas: TCanvas;
    OldWinProc, NewWinProc: Pointer;
    closeProg, EditChildForm, CloseNow, runcnt: Boolean;
    procedure WMSysCommand(var Msg: TWMSysCommand); message WM_SYSCOMMAND;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses RefUserNames, RefMobilOperator, RefAccounts, RefPhones,
  SettingProg, RefVirtual_Operators, RefCountries, RefRegions, RefAbonents,
  RefFilial, RefTariffs, RefDocum_Types, RefContract, RepLoaderBill, uRepPayments,
  RepLoaderBillLoadLog, RefPeriods, RefDocument, RefFrm, uRepPaymentsHist,
  RefAgent, RefSubAgent, RefLocal_Phone_Statuses, RefPhonesOnAcc,
  RefOperatorPhoneStatuses, RefOperatorAccountNames, RefOperatorSubAccount,
  RefProjects, RefAgentAndSubAgent, RefPaymentsType;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  ListClass := TListClass.Create(TRefUserNamesForm, TRefMobilOperatorForm, TRefAccountsForm, TRefPhonesForm, TRefPhonesOnAccFrm,
  //                                     1                  2                    3                 4                     5
  // Значение  Tag у Action, вызвавшей эту форму
    TRefVirtual_OperatorsForm, TRefCountriesForm, TRefRegionsForm, TRefAbonentsForm, TRefFilialForm, TRefTariffsForm, TRefDocum_TypesForm,
  //            6                      7                8               9                   10             11                12
   TRefContractForm, TRepLoaderBillFrm, TRepLoaderBillLoadLogFrm, TRefPeriodsForm, TRefDocumentForm,
  //     13                 14                   15                     16                17
  TRepPayments, TRepPaymentsHist, TRefAgentForm, TRefSubAgentForm, TfrmRefAgentAndSubAgent, TRefLocal_Phone_StatusesForm, TRefOperatorPhoneStatusesForm,
  //  18               19             20                21               22                   23                         24
  TRefOperatorAccountNamesForm, TRefOperatorSubAccountForm, TRefProjectsForm, TRefPaymentsTypefrm
  //          25                            26                    27                  28
  );

  //Position := poScreenCenter;
  Caption := 'Тарифер - Учет абонентов ' + dm.VersionOfModule + ' - ' + dm.UserFIO + '; ' + Dm.OraSession.Username;
  statusLine.Hint := 'Уважаем. ' + dm.UserFIO + ', приятной Вам работы!';
  dm.MainCaption := Caption;
  dm.applMainForm := self;
  aWindChengeMDI.Checked := dm.MDI_State;
  ChengeMDI;
  OutCanvas := TCanvas.Create;
  Application.OnHint := ShowHint;
  SetStateAction;
  runcnt := True;
  CloseNow := False;
  LoadKeyboardLayout('00000419', KLF_ACTIVATE); // рус
  Dm.MainWnd := Handle;
  dxtsReference.Active := true;
end;



// внимание - в процедуре указаны зависимости пунктов меню от action
procedure TMainForm.SetStateAction;
begin
  //aRefUserNames.Visible                 := aRefUserNames.Visible               and dm.IsAdmin;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  if runcnt then // вызываем метод только 1
  // изменение стиля формы Self.FormStyle := fsMDIForm вызывает самостоятельно метод FormShow;
  begin
    if not dm.FConnected then
      dm.OraSession_Connect;
    if dm.FConnected then
    begin
      if Dm.ChangeKeyboardLayout then
        LoadKeyboardLayout('00000419', KLF_ACTIVATE); // рус
      if not dm.splashDone then
      begin
        dm.splashDone := True;
        dm.SplScreen.Hide;
      end;
      AnimateWindow(Handle, 500, AW_CENTER or AW_ACTIVATE);
    end
    else
    begin
      Close;
    end;
    runcnt := False;
  end;
  
end;

procedure TMainForm.aAboutProgExecute(Sender: TObject);
begin
  dm.SplScreenCloseOnClick := True;
  dm.SplScreen.Show();
end;

procedure TMainForm.aCloseWindExecute(Sender: TObject);
begin
  NameForm := 'Тарифер - Учет абонентов ' + dm.VersionOfModule + ' - ' + dm.UserFIO;;
  itm := 0;
  Caption := dm.MainCaption;
  SetActiveScreen;
  self.OnKeyDown := FormKeyDown;
  self.OnKeyPress := FormKeyPress;
end;

procedure TMainForm.aConnectExecute(Sender: TObject);
var
  i: Integer;
  Password, UserName : string;
begin
  UserName := dm.OraSession.Username;
  Password := dm.OraSession.Password;
  Dm.ConnectDialog.Caption := 'Войти под другим пользователем';
  try
    dm.OraSession_Connect;
    case Dm.LogonError of
      0 : begin
          end;
      1: begin
           dm.OraSession.Username := UserName;
           dm.OraSession.Password := Password;
           dm.OraSession.LoginPrompt := False;
           dm.OraSession.Connected := true;
           dm.OraSession.LoginPrompt := True;
         end;
    end;
    if not dm.splashDone then
    begin
      dm.splashDone := True;
      dm.SplScreen.Hide;
    end;
   if dm.OraSession.Username <> UserName then
   begin

     if not dm.qUserNames.Active then
       dm.qUserNames.Open;
     dm.UserFIO := VarToStr(dm.qUserNames.Lookup('USER_NAME', UpperCase(dm.OraSession.Username), 'USER_FIO'));
     dm.qUserNames.Close;


     Caption := 'Тарифер - Учет абонентов ' + dm.VersionOfModule + ' - ' + dm.UserFIO + '; ' + Dm.OraSession.Username;
     statusLine.Hint := 'Уважаем. ' + dm.UserFIO + ', приятной Вам работы!';
     if dm.MDI_State then // МДИ режим
       for i := 0 to MDIChildCount - 1 do
         MDIChildren[i].Close
     else
       aCloseWind.Execute;
     TimedMessageBox('Успешная смена пользователя.', 'Приятной работы!', mtInformation, [mbOK], mbOK, 10, 3);
   end;
  except
    TimedMessageBox('   Неуспешная смена пользователя. Программа будет закрыта. ' + #10 + #13 + 'Проверьте сеть и запустите программу снова.', 'Проблемная ошибка!',
      mtError, [mbOK], mbOK, 10, 3);
    CloseNow := True;
    Close;
  end;
end;

procedure TMainForm.aSettingProgrExecute(Sender: TObject);
var
  spf : TChildForm;
begin
  spf := TSettingProgForm.Create(nil, spf, 'Настройки программы', true);
  try
    if spf.ShowModal = mrOk then
    begin

    end;
  finally
    spf.Free;
  end;
end;

procedure TMainForm.aWindChengeMDIExecute(Sender: TObject);
begin
  dm.MDI_State := not dm.MDI_State;
  ChengeMDI;
end;

procedure TMainForm.ChengeMDI;
begin
  if dm.MDI_State then
  begin
    aCloseWind.Visible := False;
    WindowClose1.Visible := True;
    WindowArrange1.Visible := True;
    WindowCascade1.Visible := True;
    WindowMinimizeAll1.Visible := True;
    WindowTileHorizontal1.Visible := True;
    WindowTileVertical1.Visible := True;
    self.FormStyle := fsMDIForm;
    if Dm.UsePictForFon then
    begin
      NewWinProc := MakeObjectInstance(NewWinProcedure);
      OldWinProc := Pointer(SetWindowLong(ClientHandle, gwl_WndProc,Cardinal(NewWinProc)));
    end;
    aWindChengeMDI.Caption := 'Однооконный режим';
    aWindChengeMDI.Hint := 'Переключить в Однооконный режим';
  end
  else
  begin
    aCloseWind.Visible := True;
    WindowClose1.Visible := False;
    WindowArrange1.Visible := False;
    WindowCascade1.Visible := False;
    WindowMinimizeAll1.Visible := False;
    WindowTileHorizontal1.Visible := False;
    WindowTileVertical1.Visible := False;
    self.FormStyle := fsNormal;
    aWindChengeMDI.Caption := 'Многооконный режим';
    aWindChengeMDI.Hint := 'Переключить в многооконный режим';
  end;
end;


procedure TMainForm.ShowHint(Sender: TObject);
begin
  StatusLine.panels[0].Text := Application.Hint;
end;

procedure TMainForm.FormHide(Sender: TObject);
begin
  AnimateWindow(Handle, 500, AW_CENTER or AW_HIDE);
  ShowWindow(Application.Handle, sw_Hide);
  Application.ShowMainform := False;
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
    Close;
end;

procedure TMainForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  // if (key = '1') then
  // close;
end;

procedure TMainForm.CommonClickMenu(Sender: TObject);
var
  act: TAction;
begin
  act := Sender AS TAction;
  itm := act.Tag;
  NameForm := act.Caption;
  fr := TMyRef(ListClass[(itm - 1)]);
  SetActiveScreen;
  Resizing(wsNormal);
end;

procedure TMainForm.SetActiveScreen;
var
  i: Integer;
  MDIChildFound: Boolean;
begin
  self.OnKeyDown := FormKeyDown;
  self.OnKeyPress := FormKeyPress;
  if dm.MDI_State then // МДИ режим
  begin
    MDIChildFound := False;
    for i := 0 to MDIChildCount - 1 do
      if MDIChildren[i] is fr then
      begin
        MDIChildren[i].Show;
        MDIChildFound := True;
        Break;
      end;
    if (not MDIChildFound) and (itm <> 0) then
    begin
      New_F := fr.Create(ChildForm,itm, New_F, self.Handle, NameForm);
      Dm.CurrentWnd := New_F.Handle;
      New_F.Show;
    end;
    aWindChengeMDI.Enabled := (MDIChildCount = 0);
  end;
end;

procedure TMainForm.MessageReceiverMoveNext(var Msg: TMessage);
var
  txt: PChar;
  i : Integer;
begin
  txt := PChar(Msg.lParam);
  Msg.Result := 1;
  Caption := txt;
  for i := 0 to MDIChildCount - 1 do
    SendMessage(MDIChildren[i].Handle, WM_NOTIFY_GO_ON_THE, 0, DWORD(PChar(txt)));
end;

procedure TMainForm.MessageReceiver(var Msg: TMessage);
begin
  Msg.Result := 1;
  aCloseWind.Enabled := False;
  OnKeyDown := FormKeyDown;
  OnKeyPress := FormKeyPress;
  aWindChengeMDI.Enabled := (MDIChildCount <= 1);
end;

procedure TMainForm.MessageReceiver2(var Msg: TMessage);
begin
  Msg.Result := 1;
  aCloseWind.Enabled := False;
  EditChildForm := True;
end;

procedure TMainForm.MessageReceiver3(var Msg: TMessage);
begin
  Msg.Result := 1;
  aCloseWind.Enabled := True;
  EditChildForm := False;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  Rez, i: Integer;
  ss: string;
begin
  CanClose := False;
  if CloseNow then
  begin
    CanClose := True;
    exit;
  end;

  if EditChildForm then
    ss := 'Данные изменены! Вы действительно хотите завершить работу с программой c потерей данных?'
  else
    ss := 'Вы действительно хотите завершить работу с программой ?';
  Rez := TimedMessageBox(ss, 'Пожалуйста, будьте внимательны!', mtConfirmation,[mbYes, mbNo], mbNo, 10, 3);
  Application.ProcessMessages;
  if Rez = IDYES then
  begin
    if dm.MDI_State then // МДИ режим
      for i := 0 to MDIChildCount - 1 do
      begin
        //
        if MDIChildren[i] <> nil then
        begin
          SendMessage(MDIChildren[i].Handle , WM_NOTIFY_GLOSE_GLOBAL, 0, DWORD(PChar('close all')));
          MDIChildren[i].Close;
        end;
      end;
    CanClose := True;
  end;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
var
  i: Integer;
begin
  OutCanvas.Free;
  for i := Low(ListClass) to High(ListClass) do
    ListClass[i] := nil;
  SetLength(ListClass, 0);
  closeProg := True;
end;

procedure TMainForm.NewWinProcedure(var Msg: TMessage);
var
  BmpWidth, BmpHeight: Integer;
  i, j: Integer;
begin
  Msg.Result := CallWindowProc(OldWinProc, ClientHandle, Msg.Msg, Msg.wParam,
    Msg.lParam);
  if Msg.Msg = wm_EraseBkgnd then
  begin
    BmpWidth := dm.ClientImg.Width;
    BmpHeight := dm.ClientImg.Height;
    if (BmpWidth <> 0) and (BmpHeight <> 0) then
    begin
      OutCanvas.Handle := Msg.wParam;
      for i := 0 to MainForm.ClientWidth div BmpWidth do
        for j := 0 to MainForm.ClientHeight div BmpHeight do
          OutCanvas.Draw(i * BmpWidth, j * BmpHeight, dm.ClientImg.Graphic);
    end;
  end;
end;

procedure TMainForm.WMSysCommand;
begin
  if Msg.CmdType = SC_MINIMIZE then
  begin
    inherited;
    // ShowMessage('Попытка свернуть форму');
  end
  else
    inherited;
end;


end.
