unit ShowUserStat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, CRGrid, ExtCtrls, MemDS, DBAccess, Ora,
  StdCtrls, ActnList, DBCtrls, Mask, Main, Buttons, ComCtrls,
  EditAbonentFrame, VirtualTable, sMaskEdit, sCustomComboEdit,
  sTooledit, math, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, IdSMTP,
  IdMessage,IdCoderHeader,IdCoderMime, IdCoder, IdCoder3to4, IdAttachmentFile,
  Menus, sBitBtn, DateUtils,ReportReplaceSIM, sCheckBox, ExportGridToExcelPDF,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  dmShowUserStat;

type

 mySMTP = class(TThread)
     SMTP_FROMTXT,SMTP_SRV,SMTP_LOG,SMTP_PASS,SMTP_ATT_FILE,SMTP_ADDR,SMTP_TITLE,SMTP_BODY,SMTP_FROM:string;
     SMTP_PORT:word;
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;


  TShowUserStatForm = class(TForm)
    Panel1: TPanel;
    CRDBGrid1: TCRDBGrid;
    Splitter1: TSplitter;
    Panel2: TPanel;
    mDetailText: TMemo;
    Panel3: TPanel;
    Panel4: TPanel;
    ActionList1: TActionList;
    aSaveDetail: TAction;
    sdDetail: TSaveDialog;
    DBText1: TDBText;
    Label1: TLabel;
    Label12: TLabel;
    DBText12: TDBText;
    Panel5: TPanel;
    btnClose: TBitBtn;
    BitBtn1: TBitBtn;
    PageControl1: TPageControl;
    tsDetail: TTabSheet;
    tsAbonent: TTabSheet;
    EditAbonentFrame: TEditAbonentFrme;
    tsTariffs: TTabSheet;
    CRDBGrid2: TCRDBGrid;
    tsPayments: TTabSheet;
    Panel7: TPanel;
    gPayments: TCRDBGrid;
    tsBills: TTabSheet;
    CRDBGrid4: TCRDBGrid;
    tsOptions: TTabSheet;
    CRDBGrid5: TCRDBGrid;
    tsBalanceRows: TTabSheet;
    dbgDetail: TCRDBGrid;
    BitBtn2: TBitBtn;
    aOpenDetailInExcel: TAction;
    aLinkPayment: TAction;
    aUnlinkPayment: TAction;
    aAddPayment: TAction;
    tsDiscount: TTabSheet;
    dtpNewBeginDate: TDateTimePicker;
    dbtEndDate: TDBText;
    dbtBeginDate: TDBText;
    lBegin: TLabel;
    lEnd: TLabel;
    btSetDiscount: TBitBtn;
    lDate: TLabel;
    lLength: TLabel;
    cbDiscount: TCheckBox;
    eLength: TDBEdit;
    Panel9: TPanel;
    Ds: TBitBtn;
    SaveBtn: TBitBtn;
    pOptions: TPanel;
    cbPeriodsOpt: TComboBox;
    tsClientBills: TTabSheet;
    CRDBGridClientBills: TCRDBGrid;
    Panel10: TPanel;
    btBillClient: TBitBtn;
    PageControl2: TPageControl;
    tsPaymentsReal: TTabSheet;
    PageControl3: TPageControl;
    tsOperatorBills: TTabSheet;
    BitBtn3: TBitBtn;
    PageControl4: TPageControl;
    tsBillsOldFormat: TTabSheet;
    tsBillsNewFormat: TTabSheet;
    PageControl5: TPageControl;
    tsBillBeeline: TTabSheet;
    tsBillClientNew: TTabSheet;
    tsAbonPeriodList: TTabSheet;
    tsRouming: TTabSheet;
    pRouming: TPanel;
    btRouming: TBitBtn;
    pBillClientNew: TPanel;
    btBillClientNew: TBitBtn;
    pBillBeeline: TPanel;
    btBillBeeline: TBitBtn;
    pAbonPeriodList: TPanel;
    btAbonPeriodList: TBitBtn;
    grAbonPeriodList: TCRDBGrid;
    grRouming: TCRDBGrid;
    grBillBeeline: TCRDBGrid;
    grBillClientNew: TCRDBGrid;
    btRefreshOptionList: TBitBtn;
    BitBtn5: TBitBtn;
    Panel13: TPanel;
    BitBtn6: TBitBtn;
    MainMenu1: TMainMenu;
    btUnload: TBitBtn;
    OpenDialog1: TOpenDialog;
    tsDopInfo: TTabSheet;
    blCaptionHLR: TLabel;
    lbIMSI_NUMBER: TDBText;
    lbCaptionSIM: TLabel;
    EChangeSIM: TEdit;
    LChangeSIM: TLabel;
    BChangeSIM: TButton;
    BChangeSIMHist: TButton;
    DBEdit1: TDBEdit;
    cbEXCLUDE_DETAIL: TsCheckBox;
    Panel8: TPanel;
    gPhoneStatuses: TCRDBGrid;
    Panel15: TPanel;
    Panel6: TPanel;
    Label13: TLabel;
    DBText13: TDBText;
    DB_TXT_NEW_TARIF_INFO: TDBText;
    LblState: TLabel;
    lTariffStatusText: TLabel;
    Label19: TLabel;
    DBText18: TDBText;
    lBlockInfo: TLabel;
    lCloseNumber: TLabel;
    Label25: TLabel;
    Label24: TLabel;
    Panel14: TPanel;
    lBalance: TLabel;
    LblBalance: TLabel;
    BtSetPassword: TButton;
    BtSendSms: TButton;
    UnBlockListBt: TButton;
    BlockListBt: TButton;
    BtUnBlock: TButton;
    BtBlock: TButton;
    eSetPassword: TEdit;
    BtSetPasswordOk: TButton;
    RGBlock: TRadioGroup;
    CbHandBlock: TCheckBox;
    ContractType: TLabel;
    BUnbilledCallsList: TButton;
    lCreditLimit: TLabel;
    PopupMenu1: TPopupMenu;
    B1: TMenuItem;
    MonthCalendar1: TMonthCalendar;
    lZayavkiAPI: TLabel;
    cbHideZeroCall: TCheckBox;
    pnlAPI: TPanel;
    crgApiTickets: TCRDBGrid;
    dbgAPI_LOG: TCRDBGrid;
    lblAPI_LOG: TLabel;
    pmStatus: TPopupMenu;
    RemoveStatusMenu: TMenuItem;
    DpLogAPI: TsDateEdit;
    PopupMenuBalanceHistory: TPopupMenu;
    N1: TMenuItem;
    pCurrentOptions: TPanel;
    pOptionHistory: TPanel;
    CRDBGridOptionHistory: TCRDBGrid;
    SplitterOptions: TSplitter;
    btAPITurnOnServises: TBitBtn;
    lbContract: TLabel;
    Image1: TImage;
    pFrame: TPanel;
    gStatistic: TStringGrid;
    Panel16: TPanel;
    Panel17: TPanel;
    Panel18: TPanel;
    Panel19: TPanel;
    pTariffInfoButton: TPanel;
    pBalanceInfo: TPanel;
    pHandBlock: TPanel;
    Panel20: TPanel;
    cbDailyAbonPay: TCheckBox;
    cbDailyAbonPayBanned: TCheckBox;
    tsSummaryPhone: TTabSheet;
    gSummaryPhone: TCRDBGrid;
    tsRest: TTabSheet;
    gRest: TCRDBGrid;
    pRest: TPanel;
    btnaOpenDetailInExcel: TBitBtn;
    btRefresh: TBitBtn;
    vip_group: TLabel;
    lSpiritTelecom: TLabel;
    pSpititTelecom: TPanel;

    procedure dsPeriodsDataChange(Sender: TObject; Field: TField);
    procedure dsTariffInfoDataChange(Sender: TObject; Field: TField);
    procedure CRDBGrid4GetCellParams(Sender: TObject; Field: TField;
      AFont: TFont; var Background: TColor; State: TGridDrawState;
      StateEx: TGridDrawStateEx);
    procedure aOpenDetailInExcelExecute(Sender: TObject);
    procedure qPhoneStatusesPHONE_IS_ACTIVEGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure qPaymentsPAYMENT_STATUS_TEXTGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure BtBlockClick(Sender: TObject);
    procedure BtUnBlockClick(Sender: TObject);
    procedure BtSendSmsClick(Sender: TObject);
    procedure BlockListBtClick(Sender: TObject);
    procedure UnBlockListBtClick(Sender: TObject);

    procedure CbHandBlockExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtSetPasswordClick(Sender: TObject);
    procedure BtSetPasswordOkClick(Sender: TObject);
    procedure eSetPasswordKeyPress(Sender: TObject; var Key: Char);
    procedure tsDetailShow(Sender: TObject);
    procedure qPaymentsAfterOpen(DataSet: TDataSet);
    procedure cbDiscountClick(Sender: TObject);
    procedure btSetDiscountClick(Sender: TObject);
    procedure spSetHandBlockEndDateAfterExecute(Sender: TObject;
      Result: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure CRDBGrid5CellClick(Column: TColumn);
    procedure DsClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure EditAbonentFramePASSPORT_SERChange(Sender: TObject);
    procedure EditAbonentFramePASSPORT_NUMChange(Sender: TObject);
    procedure EditAbonentFramePASSPORT_GETChange(Sender: TObject);
    procedure EditAbonentFramePASSPORT_DATEChange(Sender: TObject);
    procedure EditAbonentFrameCOUNTRY_IDClick(Sender: TObject);
    procedure EditAbonentFrameREGION_IDClick(Sender: TObject);
    procedure EditAbonentFrameSTREET_NAMEChange(Sender: TObject);
    procedure EditAbonentFrameCITY_NAMEChange(Sender: TObject);
    procedure EditAbonentFrameAPARTMENTChange(Sender: TObject);
    procedure EditAbonentFrameHOUSEChange(Sender: TObject);
    procedure EditAbonentFrameCODE_WORDChange(Sender: TObject);
    procedure EditAbonentFrameCONTACT_INFOChange(Sender: TObject);
    procedure EditAbonentFrameEMAILChange(Sender: TObject);
    procedure EditAbonentFrameKORPUSChange(Sender: TObject);
    procedure EditAbonentFrameSURNAMEChange(Sender: TObject);
    procedure EditAbonentFrameCITIZENSHIPClick(Sender: TObject);
    procedure EditAbonentFramePATRONYMICChange(Sender: TObject);
    procedure EditAbonentFrameNAMEChange(Sender: TObject);
    procedure EditAbonentFrameBDATEChange(Sender: TObject);
    procedure EditAbonentFrameIS_VIPClick(Sender: TObject);
    procedure EditAbonentFrameToolButton1Click(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure IS_BS_CHECKClick(Sender: TObject);
    procedure tsOptionsShow(Sender: TObject);
    procedure tsDiscountShow(Sender: TObject);
    procedure tsTariffsShow(Sender: TObject);
    procedure CRDBGrid2CellClick(Column: TColumn);
    procedure cbPeriodsOptChange(Sender: TObject);
    procedure btBillClientClick(Sender: TObject);
    procedure tsClientBillsShow(Sender: TObject);
    procedure tsOperatorBillsShow(Sender: TObject);
    procedure tsPaymentsRealShow(Sender: TObject);
    procedure tsBalanceRowsShow(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure tsAbonPeriodListShow(Sender: TObject);
    procedure tsRoumingShow(Sender: TObject);
    procedure tsBillBeelineShow(Sender: TObject);
    procedure tsBillClientNewShow(Sender: TObject);
    procedure btBillBeelineClick(Sender: TObject);
    procedure btBillClientNewClick(Sender: TObject);
    procedure tsBillsNewFormatShow(Sender: TObject);
    procedure btAbonPeriodListClick(Sender: TObject);
    procedure btRoumingClick(Sender: TObject);
    procedure gPaymentsDblClick(Sender: TObject);
    procedure btRefreshOptionListClick(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure LblBlueOff(Sender: TObject);
    procedure LblBalanceClick(Sender: TObject);
    procedure LblBlueOn(Sender: TObject);
    procedure eNewBlockHBKeyPress(Sender: TObject; var Key: Char);
    procedure eNewNoticeHBKeyPress(Sender: TObject; var Key: Char);
    procedure PageControl1Change(Sender: TObject);
    procedure btUnloadClick(Sender: TObject);
    procedure tsDopInfoShow(Sender: TObject);
    procedure BChangeSIMClick(Sender: TObject);
    procedure LblStateClick(Sender: TObject);
    procedure BChangeSIMHistClick(Sender: TObject);
    procedure cbEXCLUDE_DETAILValueChanged(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dsOptionsDataChange(Sender: TObject; Field: TField);
    procedure CRDBGrid2ColEnter(Sender: TObject);
    procedure BGet_api_servicesClick(Sender: TObject);
    procedure BUnbilledCallsListClick(Sender: TObject);
    procedure B1Click(Sender: TObject);
    procedure MonthCalendar1DblClick(Sender: TObject);
    procedure gPaymentsCellClick(Column: TColumn);
    procedure MonthCalendar1MouseLeave(Sender: TObject);
    procedure cbHideZeroCallClick(Sender: TObject);
    procedure dbgAPI_LOGDblClick(Sender: TObject);
    procedure lblAPI_LOGClick(Sender: TObject);
    procedure RemoveStatusMenuClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure CRDBGrid2GetCellParams(Sender: TObject; Field: TField;
      AFont: TFont; var Background: TColor; State: TGridDrawState;
      StateEx: TGridDrawStateEx);
    procedure CRDBGridOptionHistoryGetCellParams(Sender: TObject; Field: TField;
      AFont: TFont; var Background: TColor; State: TGridDrawState;
      StateEx: TGridDrawStateEx);
    procedure CRDBGrid2DblClick(Sender: TObject);
    procedure btAPITurnOnServisesClick(Sender: TObject);
    procedure cbDailyAbonPayClick(Sender: TObject);
    procedure cbDailyAbonPayBannedClick(Sender: TObject);
    procedure tsSummaryPhoneShow(Sender: TObject);
    procedure gSummaryPhoneCellClick(Column: TColumn);
    procedure gSummaryPhoneDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure qSummaryPhoneBeforeOpen(DataSet: TDataSet);
    procedure btnaOpenDetailInExcelClick(Sender: TObject);
    procedure btRefreshClick(Sender: TObject);
  private
    FYear : Integer;
    FMonth : Integer;
    FDetailText : String;
    FPhoneNumber: String;
    FContractID: Integer;
    FContractDate : TDateTime;
    FHandBlockChecked: Boolean;
    FFilialId: Variant;
    procedure LoadDetailText;
    procedure LoadBillDetailText;
    procedure PrepareDetail;
    procedure RefreshBalanceRows;
    function DecodeServiceType(const Code: String): String;
    function EditcbDailyAbonPayBanned : Boolean;
    procedure BlockPhone (StatusCode : String);
    procedure SetDataModuleSettings;
    procedure RefreshData (pPhone : string);
    procedure ExcelExport;
  public
    procedure Execute(const pPhoneNumber : String; const pContractID : Integer);
    function CheckDate:boolean;
    procedure AddFilter;
    function FindComponentEx(const Name: string): TComponent;
    procedure FillingStatistic;
  end;



  // показать информацию абонента по коду контракта
//  procedure ShowUserStatByContract(const pContractId : Variant);
  // показать информацию абонента по номеру телефона
  procedure ShowUserStatByPhoneNumber(const pPhoneNumber : String; const vContractID : Integer; const PageName : String = '');

//  procedure DoShowUserStat(const pPhoneNumber : String; const pAbonentId : Variant);

implementation

{$R *.dfm}

uses ContractsRegistration_Utils, IntecExportGrid, CRStrUtils, SendSms,
  BlockList, UnBlockList, SelectContract, RegisterPayment, ShowBillDetails,
  DMUnit, PassWord, ShowUserTurnOnOffOption, StrUtils, ShowDetalAPI;

const
  PAYMENT_TYPE_LOADED = 2; // Платёж загружен автоматически (из V_FULL_BALANCE_PAYMENTS.PAYMENT_TYPE)

// Дни до начала контракта, для которых нужно засчитывать платежи
// Это же значение используется в CALC_BALANCE_ROWS2
const DAYS_PAYMENT_BEFORE_CONTRACT = 4;

//номер строки в qHBDetails.SQL, в которую подставляется актуальое имя таблицы
const
  qHBDetailsStrTableNameNum = 23;
var
    cbexcept:integer=1;
    cbexcept1:integer=1;
    qexcept:TOraQuery;
    qexcept1:TOraQuery;
    old_date : string;   //19610
    vdop_status : string;   //19610
    FormatSQL:string;//первоначальный запрос для АПИ_ЛОГОВ
    TableName:string;//Имя таблицы  для извлечения АПИ_ЛОГОВ
    dmShowUserSt : TdmShowUserSt;

{ TShowUserStatForm }

procedure DoShowUserStat(const pPhoneNumber : String; const pContractId : Integer;
  const PageName : String = '');
var
  ShowUserStatForm: TShowUserStatForm;
  AdminPriv : boolean;
begin
  try
    dmShowUserSt := TdmShowUserSt.Create(nil);
    ShowUserStatForm := TShowUserStatForm.Create(nil);
    MainForm.CheckAdminPrivs(AdminPriv);
    if not(AdminPriv) then
    begin
      ShowUserStatForm.tsBillBeeline.Destroy;
      dmShowUserSt.qAbonPeriodListABON_MAIN_OLD.Destroy;
    end;
    try
      if PageName = 'Payments' then
        ShowUserStatForm.PageControl1.ActivePage := ShowUserStatForm.tsPayments;
      dmShowUserSt.qContractID.Close;
      dmShowUserSt.qContractID.ParamByName('PHONE_NUMBER').AsString:=pPhoneNumber;
      dmShowUserSt.qContractID.Open;
      if dmShowUserSt.qContractID.IsEmpty then
      begin
        ShowMessage('Для данного номера не существует контрактов');
        ShowUserStatForm.Execute(pPhoneNumber, 0);
      end
      else begin
        if pContractId=0 then
          ShowUserStatForm.Execute(pPhoneNumber, dmShowUserSt.qContractID.FieldByName('CONTRACT_ID').AsInteger)
        else
          ShowUserStatForm.Execute(pPhoneNumber, pContractId);
      end;
    finally
      ShowUserStatForm.Free;
    end;
  finally
    FreeAndNil(dmShowUserSt);
  end;
end;

{
procedure ShowUserStatByContract(const pContractId : Variant);
var vPhoneNumber : String;
    vAbonentId : Variant;
begin
  if not FindPhoneAndAbonent(pContractID, vPhoneNumber, vAbonentId) then
    MessageDlg('Для договора с кодом '+VarToStr(pContractID)+' не найден действующий номер телефона, внутренняя ошибка.', mtError, [mbOK], 0)
  else
  begin
    // если тут оказались, значит номер телефона обязательно должен быть заполнен
    DoShowUserStat(vPhoneNumber, vAbonentId);
  end;
end;
}

procedure ShowUserStatByPhoneNumber(const pPhoneNumber : String;
  const vContractID : Integer;
  const PageName : String = '');
begin
  if pPhoneNumber = '' then
    MessageDlg('Не возможно показать информацию абонента. Код телефона не определен., внутренняя ошибка.', mtError, [mbOK], 0)
  else
    DoShowUserStat(pPhoneNumber,vContractID, PageName);
end;

procedure TShowUserStatForm.ExcelExport;
begin

end;

procedure TShowUserStatForm.Execute(const pPhoneNumber : String; const pContractID : Integer);
var IsAdmin: boolean;
    balance: double;
    atext: string;
    afontColor: integer;
begin
  // Опредение прав(админ или нет)
  MainForm.CheckAdminPrivs(IsAdmin);
  //
  eSetPassword.Hide;
  btSetPasswordOk.Hide;
  BitBtn3.Visible:=True;
  BitBtn5.Visible:=true;

  if GetConstantValue('ENABLE_INTERNET_KABINET') = '1' then
  begin
    btSetPassword.Show;
    // установление прав на блок/разблок пользователя
    dmShowUserSt.qCheckUserPrivileges.ParamByName('USER_NAME').AsString := MainForm.OraSession.Username;
    dmShowUserSt.qCheckUserPrivileges.Open;
    if (dmShowUserSt.qCheckUserPrivileges.FieldByName('SHOW_BLOCK_UNBLOCK_BTN').AsInteger = 0) AND (not IsAdmin)  then
    begin
      // скрытие кнопок блока и разблока, если не админ
      BtBlock.Enabled := False;
      BtUnBlock.Enabled := False;
    end
    else
    begin
      BtBlock.Enabled := True;
      BtUnBlock.Enabled := True;
    end;
  end
  else
    btSetPassword.Hide;

  //договор
  dmShowUserSt.qContractInfo.ParamByName('CONTRACT_ID').AsInteger := pContractID;
  dmShowUserSt.qContractInfo.Open;
  try
    if dmShowUserSt.qContractInfo.IsEmpty then
    begin
      FContractDate := 0;
      FFilialId := Null;
    end
    else
    begin
      FContractDate := Trunc(dmShowUserSt.qContractInfo.FieldByName('CONTRACT_DATE').AsDateTime);
      FFilialId := dmShowUserSt.qContractInfo.FieldByName('FILIAL_ID').Value;
      lCreditLimit.Visible:=false;
    end;

    Caption := Caption + ' ' + dmShowUserSt.qContractInfo.FieldByName('GROUP_NAME').AsString;

    dmShowUserSt.qVIP_Group.ParamByName('PHONE_NUMBER').AsString := pPhoneNumber;
    dmShowUserSt.qVIP_Group.Open;
    if dmShowUserSt.qVIP_Group.FieldByName('TT').AsInteger = 1 then
    begin
      vip_group.Visible := True;
      Caption := Caption + ' ВИП группа';
    end;

    dmShowUserSt.qSpiritTelecom.Close;
    dmShowUserSt.qSpiritTelecom.ParamByName('P_PHONE').Value := pPhoneNumber;
    dmShowUserSt.qSpiritTelecom.Open;
    pSpititTelecom.Visible := (dmShowUserSt.qSpiritTelecom.FieldByName('IS_SHOW').AsInteger = 1);
    dmShowUserSt.qSpiritTelecom.Close;


    //показываем/скрываем номер договора на вкладке тариф и блокировки.
    pFrame.Visible := false;
    dmShowUserSt.qPrivateContract.ParamByName('pPHONE_NUMBER').AsString := pPhoneNumber;
    dmShowUserSt.qPrivateContract.Open;
    try
      if not dmShowUserSt.qPrivateContract.IsEmpty then
        if not dmShowUserSt.qPrivateContract.FieldByName('ACCOUNT_NUMBER').IsNull then
          if dmShowUserSt.qPrivateContract.FieldByName('ACCOUNT_NUMBER').AsString = '536917834' then
            begin
              lbContract.Caption := 'Договор:    ' + dmShowUserSt.qPrivateContract.FieldByName('ACCOUNT_NUMBER').AsString;
              pFrame.Width := lbContract.Width + 10;
              pFrame.Visible := true;
              pFrame.Color:= clRed;
            end
          else
            // в рамках задачи http://redmine.tarifer.ru/issues/4336 для указанного догоовора - красим зеелным
            if dmShowUserSt.qPrivateContract.FieldByName('ACCOUNT_NUMBER').AsString = '589069901' then
            begin
              lbContract.Caption := 'Договор:    ' + dmShowUserSt.qPrivateContract.FieldByName('ACCOUNT_NUMBER').AsString;
              pFrame.Width := lbContract.Width + 10;
              pFrame.Visible := true;
                pFrame.Color:= clGreen;
            end;
    finally
      dmShowUserSt.qPrivateContract.Close;
    end;
  finally
    dmShowUserSt.qContractInfo.Close;
  end;

  Caption := Caption + ' ' + FormatPhoneNumber(pPhoneNumber);
  FPhoneNumber := pPhoneNumber;
  FContractID:=pContractID;
  //
  dmShowUserSt.qSelBalDate.ParamByName('PHONE_NUMBER').AsString := pPhoneNumber;
  dmShowUserSt.qSelBalDate.ParamByName('CONTRACT_ID').AsInteger := pContractID;
  dmShowUserSt.qSelBalDate.Open;
  //
  if pContractID=0 then
  begin
    SaveBtn.Enabled:=false;
    EditAbonentFrame.PrepareFrameByContractID('DISABLE', 0);
  end
  else
    EditAbonentFrame.PrepareFrameByContractID('EDIT', pContractID);

  Caption := Caption + ' ' +EditAbonentFrame.SURNAME.Text + ' '
                           + EditAbonentFrame.Name.Text  + ' '
                           + EditAbonentFrame.PATRONYMIC.Text
                ;
  //
   dmShowUserSt.qBlocked.ParamByName('phonenum').AsString := pPhoneNumber;
   dmShowUserSt.qBlocked.Open;
  //
  dmShowUserSt.qTariffInfo.ParamByName('PHONE_NUMBER').AsString := pPhoneNumber;
  if dmShowUserSt.qSelBalDate.FieldByName('contract_cancel_date').AsString='' then
    dmShowUserSt.qTariffInfo.ParamByName('pBALANCE_DATE').Clear
  else
    dmShowUserSt.qTariffInfo.ParamByName('pBALANCE_DATE').AsDateTime := dmShowUserSt.qSelBalDate.FieldByName('contract_cancel_date').AsDateTime;

  //
  dmShowUserSt.qPassword.ParamByName('CONTRACT_ID').AsInteger:=pContractID;
  // Платежи
  dmShowUserSt.qPayments.ParamByName('PHONE_NUMBER').AsString := pPhoneNumber;
  //
  dmShowUserSt.qPhoneStatuses.ParamByName('PHONE_NUMBER').AsString := pPhoneNumber;
  dmShowUserSt.qPhoneStatuses.Open;
  //  заявки БИ.
  dmShowUserSt.oqApiTickets.ParamByName('PHONE').AsString := pPhoneNumber;
  dmShowUserSt.oqApiTickets.Open;
  // логи загрузок АПИ
  dmShowUserSt.oqApi_log.ParamByName('PHONE').AsString := pPhoneNumber;
  //oqApi_log.Open;
  //
  if GetConstantValue('SHOW_OPERATOR_DISCOUNT') = '1' then
    tsDiscount.TabVisible:=true
  else
    tsDiscount.TabVisible:=false;

  if GetConstantValue('SHOW_DOP_PHONE_INFO')='1' then
    tsDopInfo.TabVisible:=true
  else
    tsDopInfo.TabVisible:=false;

  PageControl1.ActivePage:=tsTariffs;

  //  Счета (Старый формат до 08.2012)
  dmShowUserSt.qBills.ParamByName('PHONE_NUMBER').AsString := FPhoneNumber;
  dmShowUserSt.qClientBills.ParamByName('PHONE_NUMBER').AsString := FPhoneNumber;
  //  Счета (новый формат с 09.2012)
  dmShowUserSt.qBillBeeline.ParamByName('PHONE_NUMBER').AsString := FPhoneNumber;
  dmShowUserSt.qBillClientNew.ParamByName('PHONE_NUMBER').AsString := FPhoneNumber;
  dmShowUserSt.qRouming.ParamByName('PHONE_NUMBER').AsString := FPhoneNumber;
  dmShowUserSt.qAbonPeriodList.ParamByName('PHONE_NUMBER').AsString := FPhoneNumber;
  //
  PageControl1.ActivePage:=tsTariffs;
  PageControl3.ActivePage:=tsOperatorBills;
  PageControl4.ActivePage:=tsBillsNewFormat;
  PageControl5.ActivePage:=tsBillClientNew;
  //
  dmShowUserSt.qDailyAbonPayBanned.ParamByName('CONTRACT_ID').AsInteger:=FContractID;
  dmShowUserSt.qDailyAbonPay.ParamByName('PHONE_NUMBER').AsString:=FPhoneNumber;
  //
  try
    ShowModal;
  finally
    dmShowUserSt.qBalanceRows.Close;
    dmShowUserSt.qPhoneStatuses.Close;
    dmShowUserSt.qBills.Close;
    dmShowUserSt.qPayments.Close;
    dmShowUserSt.qTariffInfo.Close;
    dmShowUserSt.qBlocked.Close;
    dmShowUserSt.qOptions.Close;
    dmShowUserSt.qPeriods.Close;
    dmShowUserSt.qDeposit.Close;
    dmShowUserSt.qDepositOper.Close;
    dmShowUserSt.qDiscount.Close;
    dmShowUserSt.qHandBlockEndDate.Close;
    dmShowUserSt.qContractInfo.Close;
    dmShowUserSt.qContractDealers.Close;
    dmShowUserSt.oqApiTickets.Close;
  end;
end;

procedure TShowUserStatForm.RefreshBalanceRows;
begin
  dmShowUserSt.qBalanceRows.Close;
  dmShowUserSt.spCalcBalanceRows.ParamByName('pPHONE_NUMBER').AsString := FPhoneNumber;
  dmShowUserSt.spCalcBalanceRows.ParamByName('pBALANCE_DATE').Value := dmShowUserSt.qSelBalDate.FieldByName('contract_cancel_date').Value;
  dmShowUserSt.spCalcBalanceRows.ExecSQL;
  dmShowUserSt.qBalanceRows.Open;
end;

procedure TShowUserStatForm.RefreshData(pPhone: string);
begin

end;

procedure TShowUserStatForm.RemoveStatusMenuClick(Sender: TObject);
var
  proc1:TOraStoredProc;
begin
  proc1:=TOraStoredProc.Create(self);
  proc1.StoredProcName:='DELETE_ACCOUNT_PHONE';
  proc1.PrepareSQL;
  proc1.ParamByName('PPHONE_NUMBER').AsString:=FPhoneNumber;
  proc1.Execute;
  showmessage(proc1.ParamByName('RESULT').AsString);
end;

procedure TShowUserStatForm.spSetHandBlockEndDateAfterExecute(Sender: TObject;
  Result: Boolean);
begin
  dmShowUserSt.qHandBlockEndDate.Close;
  dmShowUserSt.qHandBlockEndDate.Open;
  if (dmShowUserSt.qHandBlockEndDate.FieldByName('HAND_BLOCK').AsInteger=1)
    and(dmShowUserSt.qHandBlockEndDate.FieldByName('HAND_BLOCK_DATE_END').AsDateTime>=Date) then
    FHandBlockChecked:=true
  else
    FHandBlockChecked:=false;
  cbHandBlock.Checked:=FHandBlockChecked;
end;

procedure TShowUserStatForm.dsOptionsDataChange(Sender: TObject; Field: TField);
begin
//19610
 if CRDBGrid2.Col=5   then
  old_date:=CRDBGrid2.DataSource.DataSet.FieldByName('turn_off_date').AsString
  else  old_date:='';

end;

procedure TShowUserStatForm.dsPeriodsDataChange(Sender: TObject;
  Field: TField);
var
  d,AYear, AMonth,noload : Integer;
  stt:string;

begin
  noload:=0;
  AYear := dmShowUserSt.qPeriods.FieldByName('YEAR').AsInteger;
  AMonth := dmShowUserSt.qPeriods.FieldByName('MONTH').AsInteger;


//  FPhoneNumber := qPeriods.FieldByName('PHONE_NUMBER').AsString;
  if (AYear <> FYear) or (FMonth <> AMonth) then
  begin
    FYear := AYear;
    FMonth := AMonth;


    dmShowUserSt.spHB_NO_LOAD.ParamByName('PPHONE_NUMBER').AsString := FPhoneNumber;
    dmShowUserSt.spHB_NO_LOAD.ExecProc;
    noload := dmShowUserSt.spHB_NO_LOAD.ParamByName('RESULT').AsInteger;

    if (GetConstantValue('DB_DETAILS')='0') or (noload > 0) then
    begin
      LoadDetailText;
      PrepareDetail;
    end
    else
    begin
      dmShowUserSt.spGetHBMonth.ParamByName('pYEAR').AsInteger := FYear;
      dmShowUserSt.spGetHBMonth.ParamByName('pMONTH').AsInteger := FMonth;
      dmShowUserSt.spGetHBMonth.ExecProc;
      if dmShowUserSt.spGetHBMonth.ParamByName('RESULT').AsInteger=0 then
      begin
        dmShowUserSt.dsDetail.Enabled:=false;
        dmShowUserSt.dsDetail.DataSet:= dmShowUserSt.vtDetailFile;
        dmShowUserSt.dsDetail.Enabled:=true;
        LoadDetailText;
        PrepareDetail;
      end
      else
      begin
        dmShowUserSt.dsDetail.Enabled := false;
        dmShowUserSt.dsDetail.DataSet := dmShowUserSt.qHBDetails;
        dmShowUserSt.dsDetail.Enabled := true;
        stt:=inttostr(FMonth);
        if length(stt)=1 then
          stt:='0'+stt;
        dmShowUserSt.qHBDetails.SQL.Strings[qHBDetailsStrTableNameNum]:=' from call_'+stt+'_'+inttostr(FYear)+' c10';
        dmShowUserSt.qHBDetails.ParamByName('SUBSCR').AsString := FPhoneNumber;
        dmShowUserSt.qHBDetails.Open;
      end;
    end;

   //заполняем таблицу статистики
   FillingStatistic;
  end;
end;

procedure TShowUserStatForm.Label1Click(Sender: TObject);
var
  qBH:TOraQuery;
begin
  try
    qBH:=TOraQuery.Create(nil);
    with qBH do
    begin
      params.CreateParam(ftString,'p_phone',ptInput);
      params.ParamByName('p_phone').Value:=FPhoneNumber;
      sql.Add('select beeline_api_pckg.phone_report_data(to_number(:p_phone)) RD from dual');
      Execute;
      ShowMessage(FieldByName('RD').AsString);
    end;
  finally
    qbh:=nil;
  end;
end;

procedure TShowUserStatForm.lblAPI_LOGClick(Sender: TObject);
begin
  if FormatSQL='' then
    FormatSQL := dmShowUserSt.oqApi_log.SQL.Text;
  if dmShowUserSt.oqApi_log.Active then
    dmShowUserSt.oqApi_log.Close;
  if trunc(DpLogAPI.Date)=trunc(now) then
    TableName := 'BEELINE_SOAP_API_LOG'
  else
    TableName:='ext_'+Format('%.2d', [dayof(DpLogAPI.Date)])+'_BEELINE_SOAP_API_LOG';
  dmShowUserSt.oqApi_log.SQL.Text:=Format(FormatSQL,[TableName]);
  dmShowUserSt.oqApi_log.Open;
end;

procedure TShowUserStatForm.LblBalanceClick(Sender: TObject);
  procedure Pclose(sender:TObject);
  begin
    (sender as TForm).ModalResult:=mrOk;
    //sender.Destroy;
  end;
var fList:TForm;
    Mcloselsit:TMethod;
    qBH:TOraQuery;
    dsBH:TDataSource;
    tBH:TDBGrid;
begin
  flist:=tform.Create(ShowBillDetailsForm);
  with flist do begin
    //  FormStyle:=fsMDIChild;
    BorderStyle:=bsSingle;
    Caption:='История баланса по номеру '+FPhoneNumber;
    Position:=poScreenCenter;
    Width:=450;
    Height:=350;
  end;
  qBH:=TOraQuery.Create(flist);
  with qBH do begin
    params.CreateParam(ftString,'p_phone',ptInput);
    params.ParamByName('p_phone').Value:=FPhoneNumber;
    sql.Add('select bh.start_time, bh.end_time, bh.last_update, bh.balance from iot_balance_history bh where bh.phone_number=:p_phone');
  end;
  dsBH:=TDataSource.Create(flist);
  with dsBH do begin
    DataSet:=qBH;
    Enabled:=true;
  end;
  tBH:=TDBGrid.Create(flist);
  with tBH do begin
    parent:=fList;
    DataSource:=dsBH;
    align:=alClient;
    Visible:=true;
    Mcloselsit.Code:=@pclose;
    Mcloselsit.Data:=tBH.parent;
    ReadOnly:=true;
    OnDblClick:=TNotifyEvent(Mcloselsit);
  end;
  try
    qBH.open;
  finally
    tbh.Columns.Items[0].Title.caption:='Фиксирован';
    tbh.Columns.Items[1].Title.caption:='Просрочен';
    tbh.Columns.Items[2].Title.caption:='Обновлен';
    tbh.Columns.Items[3].Title.caption:='Баланс';
    if not qbh.Eof then
    begin
    fList.ShowModal;
    end else
    begin
      ShowMessage('Нет данных.');
      flist.Destroy;
    end;
  end;
end;

procedure TShowUserStatForm.LblBlueOn(Sender: TObject);
begin
  (sender as TLabel).Font.Color := clblue;
end;

procedure TShowUserStatForm.LblStateClick(Sender: TObject);
var
  qBH:TOraQuery;
begin
  try
    qBH:=TOraQuery.Create(nil);
    with qBH do
    begin
      params.CreateParam(ftString,'p_phone',ptInput);
      params.ParamByName('p_phone').Value:=FPhoneNumber;
      sql.Add('select beeline_api_pckg.phone_status(to_number(:p_phone)) state from dual');
      Execute;
      ShowMessage(FieldByName('state').AsString);
    end;
  finally
    qbh:=nil;
  end;
end;

procedure TShowUserStatForm.LblBlueOff(Sender: TObject);
begin
  (sender as TLabel).font.color:=clblack;
end;

procedure TShowUserStatForm.LoadDetailText;
var DetailText : String;
begin
  if True then
  begin
    dmShowUserSt.spGetPhoneDetail.ParamByName('pYEAR').AsInteger := FYear;
    dmShowUserSt.spGetPhoneDetail.ParamByName('pMONTH').AsInteger := FMonth;
    dmShowUserSt.spGetPhoneDetail.ParamByName('pPHONE_NUMBER').AsString := FPhoneNumber;
    try
      dmShowUserSt.spGetPhoneDetail.ExecProc;
      DetailText := dmShowUserSt.spGetPhoneDetail.ParamByName('RESULT').AsString;
      FDetailText := DetailText;
    except
      on E : Exception do
      begin
        DetailText := 'Ошибка .'#13#10 + E.Message;
        FDetailText := '';
      end;
    end;
    mDetailText.Lines.Text := DetailText;
  end
  else
  begin // Для отладки !!!
    mDetailText.Lines.LoadFromFile('D:\Work\MobileTariff\Lontana\trunk\2.txt');
    FDetailText := mDetailText.Lines.Text;
  end;
end;

procedure TShowUserStatForm.LoadBillDetailText;
var DetailText : String;
begin
  dmShowUserSt.spGetPhoneBillDetail.ParamByName('pYEAR').AsInteger := FYear;
  dmShowUserSt.spGetPhoneBillDetail.ParamByName('pMONTH').AsInteger := FMonth;
  dmShowUserSt.spGetPhoneBillDetail.ParamByName('pPHONE_NUMBER').AsString := FPhoneNumber;
  try
    dmShowUserSt.spGetPhoneBillDetail.ExecProc;
    DetailText := dmShowUserSt.spGetPhoneBillDetail.ParamByName('RESULT').AsString;
    FDetailText := DetailText;
  except
    on E : Exception do
    begin
      DetailText := 'Ошибка .'#13#10 + E.Message;
      FDetailText := '';
    end;
  end;
  mDetailText.Lines.Text := DetailText;
end;

function TShowUserStatForm.DecodeServiceType(const Code : String) : String;
begin
  if not dmShowUserSt.qServiceCodes.Active then
    dmShowUserSt.qServiceCodes.Open;
  if dmShowUserSt.qServiceCodes.Locate('SERVICE_CODE', Code, []) then
    Result := dmShowUserSt.qServiceCodes.FieldByName('SERVICE_NAME').AsString
  else
    Result := Code;
end;

procedure TShowUserStatForm.DsClick(Sender: TObject);
var
  cr : TCursor;
  ACaption : String;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  ACaption := 'Расшифровка баланса по номеру ' + FPhoneNumber;
  try
    ExportDBGridToExcel(ACaption,'', CRDBGrid5, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TShowUserStatForm.PageControl1Change(Sender: TObject);
var s:string;
    I: Integer;
    sumpay:Double;
    kolMonths:integer;
begin
  dmShowUserSt.qContractInfo.Close;
  dmShowUserSt.qContractInfo.Open;

  if (Sender as TPageControl).ActivePage.Name='tsRest' then
    btRefreshClick(Self);
end;

procedure TShowUserStatForm.PrepareDetail;
var
  i : Integer;
  sl : TStringList;
  s : String;
  Line : String;
  CostNoVatStr: string;
  duration:double;
  Service_type:String;
begin
  try
    sl := TStringList.Create;
    dmShowUserSt.vtDetailFile.DisableControls;
    try
      sl.Text := FDetailText;
      if not dmShowUserSt.vtDetailFile.Active then
        dmShowUserSt.vtDetailFile.Open
      else
        dmShowUserSt.vtDetailFile.Clear;
      for i := 0 to sl.Count-1 do
      begin
        Line := sl[i];
        if GetTokenCount(Line) >= 11 then
        begin
          dmShowUserSt.vtDetailFile.Append;
          dmShowUserSt.vtDetailFile.FieldByName('SELF_NUMBER').AsString := Copy(GetToken(Line, 1), 1, 20);
          dmShowUserSt.vtDetailFile.FieldByName('SERVICE_DATE').AsDateTime := StrToDate(GetToken(Line, 2));
          dmShowUserSt.vtDetailFile.FieldByName('SERVICE_TIME').AsDateTime := StrToTime(GetToken(Line, 3));
          Service_type:=GetToken(Line, 4);
          dmShowUserSt.vtDetailFile.FieldByName('SERVICE_TYPE').AsString := DecodeServiceType(Service_type);
          s := GetToken(Line, 5);
          if s = '1' then
            s := 'Исходящий'
          else if s = '2' then
            s := 'Входящий'
          else if s = '3' then
            s := 'переадресация'
          else
            s := 'Неопределено';
          dmShowUserSt.vtDetailFile.FieldByName('SERVICE_DIRECTION').AsString := s;
          dmShowUserSt.vtDetailFile.FieldByName('OTHER_NUMBER').AsString := Copy(GetToken(Line, 6), 1, 20);
          duration:=StrToFloat2(GetToken(Line, 7));
          dmShowUserSt.vtDetailFile.FieldByName('DURATION').AsFloat := duration;
          //Округляем до минут длительность, только для типа услуги - "Звонок"
          if Service_type='C' then
            //Первые две секунды не тарифицируются
            if duration<=2 then
              dmShowUserSt.vtDetailFile.FieldByName('DURATION_MIN').AsInteger := 0
            else
              dmShowUserSt.vtDetailFile.FieldByName('DURATION_MIN').AsInteger := Ceil(duration/60);

          dmShowUserSt.vtDetailFile.FieldByName('SERVICE_COST').AsFloat := StrToFloat2(GetToken(Line, 8));
          if GetToken(Line, 9) = '1' then
            s := 'Да'
          else
            s := '';
          dmShowUserSt.vtDetailFile.FieldByName('IS_ROAMING').AsString := s;
          dmShowUserSt.vtDetailFile.FieldByName('ROAMING_ZONE').AsString := Copy(GetToken(Line, 10), 1, 50);
          dmShowUserSt.vtDetailFile.FieldByName('ADD_INFO').AsString := Copy(GetToken(Line, 11), 1, 100);
          dmShowUserSt.vtDetailFile.FieldByName('BASE_STATION_CODE').AsString := Copy(GetToken(Line, 12), 1, 10);
          // Стоимость без НДС берём готовую, а если её нет, то рассчитываем
          CostNoVatStr := GetToken(Line, 13);
          if CostNoVATStr = '' then
            CostNoVatStr := FloatToStr(dmShowUserSt.vtDetailFile.FieldByName('SERVICE_COST').AsFloat / 1.18);
          dmShowUserSt.vtDetailFile.FieldByName('COST_NO_VAT').AsFloat := StrToFloat2(CostNoVatStr);
          s:=Copy(GetToken(Line, 14), 1, 50);
          dmShowUserSt.vtDetailFile.FieldByName('BS_PLACE').AsString := s;
          dmShowUserSt.vtDetailFile.Post;
        end;
      end;
      dmShowUserSt.vtDetailFile.First;
    finally
      dmShowUserSt.vtDetailFile.EnableControls;
      FreeAndNil(sl);
    end;
  except
    on E : Exception do
      ShowMessage('Ошибка обработки детализации. '+E.Message);
  end;
end;

procedure TShowUserStatForm.AddFilter;
begin

end;

procedure TShowUserStatForm.dsTariffInfoDataChange(Sender: TObject;
  Field: TField);
var
  AText : String;
  AFontColor : TColor;
  Balance : Double;
  str:string;
  stri:integer;
  qContrClos:TORaQuery;
begin
  // Статус
  if dmShowUserSt.qTariffInfo.EOF then
  begin
    AText := 'Нет данных';
    AFontColor := clWindowText;
  end
  else if dmShowUserSt.qTariffInfo.FieldByName('PHONE_IS_ACTIVE').AsInteger = 0 then
  begin
    AText := 'Блокирован';
    AFontColor := clRed;
  end
  else
  begin
    AText := 'Активный';
    AFontColor := clGreen;
  end;
  if not(dmShowUserSt.qTariffInfo.FieldByName('STATUS_CODE').IsNull) then
    AText:=AText + ' (' + dmShowUserSt.qTariffInfo.FieldByName('STATUS_CODE').AsString + ')';
  if not(dmShowUserSt.qTariffInfo.FieldByName('INFO_COLOR').IsNull) then
    case AnsiIndexStr(dmShowUserSt.qTariffInfo.FieldByName('INFO_COLOR').AsString,
                      ['Red', 'Green', 'Yellow', 'Purple']) of
      0: AFontColor:=clRed;
      1: AFontColor:=clGreen;
      2: AFontColor:=RGB(213,213,0); //clYellow; //только потемнее
      3: AFontColor:=clPurple;
      else AFontColor:=clBlack;
    end;
  lTariffStatusText.Caption := AText;
  lTariffStatusText.Font.Color := AFontColor;

  // Баланс
  if dmShowUserSt.qTariffInfo.EOF then
  begin
    AText := '???';
    AFontColor := clWindowText;
  end
  else
  begin
    Balance := dmShowUserSt.qTariffInfo.FieldByName('CURRENT_BALANCE').AsFloat;
    AText := FloatToStrF(Balance, ffNumber, 15, 2);
    if Balance  < 0 then
      AFontColor := clRed
    else
      AFontColor := clWindowText;
  end;
  lBalance.Caption := AText;
  lBalance.Font.Color := AFontColor;

  // Статус
  if dmShowUserSt.qTariffInfo.EOF then
  begin
    AText := 'Нет данных';
    AFontColor := clWindowText;
  end
  else
    if dmShowUserSt.qTariffInfo.FieldByName('CONSERVATION').AsInteger = 1 then
    begin
      if dmShowUserSt.qTariffInfo.FieldByName('SYSTEM_BLOCK').AsInteger = 1 then
      begin
        AText := 'Мошенничество';
        AFontColor := clRed;
      end
      else begin
        AText := 'На сохранении';
        afontColor := clGreen;
      end
    end
    else if dmShowUserSt.qBlocked.FieldByName('BLOCKED').AsInteger <> 0 then
    begin
      atext := 'Подозрение на мошенничество';
      afontColor := clRed;
    end
    else
    begin
      atext := 'Не по сохранению';
      afontColor := clblack;
    end;
    lBlockInfo.Caption := atext;
    lBlockInfo.Font.Color := afontColor;

    // Статус договора
    if dmShowUserSt.qTariffInfo.Eof then
      begin
        atext := 'Нет данных';
        afontColor := clWindowText;
        lCloseNumber.Visible := false;
      end
    else
    begin
      lCloseNumber.Visible := true;
      str := datetostr(Date);
      stri := strtoint(Copy(str, 7, 4) + Copy(str, 4, 2));
      if dmShowUserSt.qTariffInfo.FieldByName('YEAR_MONTH').AsInteger <> stri then
        atext := 'Номер расторгнут'
      else
      begin
        qContrClos := TOraQuery.Create(Self);
{          qContrClos.SQL.Text :=
            'Select  to_char(contract_date,''dd.mm.yyyy'') as pp, nvl(is_credit_contract,0) cc FROM v_contracts'
            + #13#10 + 'WHERE  CONTRACT_CANCEL_DATE is null' + #13#10 +
            'and (PHONE_NUMBER_FEDERAL=:phoneNumber  or  PHONE_NUMBER_CITY=substr(:phoneNumber,-7))';}
          //19610
        qContrClos.SQL.Text :=
          'Select  to_char(contract_date,''dd.mm.yyyy'') as pp, nvl(is_credit_contract,0) cc FROM v_contracts'
          + #13#10 + 'WHERE  CONTRACT_CANCEL_DATE is null' + #13#10 ;
          //19610  begin
        if dmShowUserSt.qTariffInfo.FieldByName('PHONE_NUMBER_TYPE').AsInteger=1 then
          qContrClos.SQL.Text:=qContrClos.SQL.Text+' and (PHONE_NUMBER_FEDERAL=:phoneNumber  or  PHONE_NUMBER_CITY=substr(:phoneNumber,-7))'
        else
          qContrClos.SQL.Text:=qContrClos.SQL.Text+' and PHONE_NUMBER_FEDERAL=:phoneNumber';
            //19610  end
        qContrClos.ParamByName('phoneNumber').AsString := FPhoneNumber;
        qContrClos.ExecSQL;
        if qContrClos.FieldByName('pp').IsNull then
          atext := 'Договор расторгнут'
        else
          with lCloseNumber do
          begin
            atext := 'Заключен';
            Visible:=True;
            Font.Color:=clBlue;
          end;
        if qContrClos.FieldByName('cc').AsInteger > 0 then
        begin
          ContractType.Caption := 'КРЕДИТНЫЙ';
          ContractType.Visible := true;
        end
        else
          ContractType.Visible := false;
        FreeAndNil(qContrClos);
      end;
    end;
    lCloseNumber.Caption := atext;
end;

procedure TShowUserStatForm.EditAbonentFrameAPARTMENTChange(Sender: TObject);
begin
  EditAbonentFrame.DoChange(Sender);
end;

procedure TShowUserStatForm.EditAbonentFrameBDATEChange(Sender: TObject);
begin
  EditAbonentFrame.BDATEChange(Sender);
end;

procedure TShowUserStatForm.EditAbonentFrameCITIZENSHIPClick(Sender: TObject);
begin
  EditAbonentFrame.DoChange(Sender);
end;

procedure TShowUserStatForm.EditAbonentFrameCITY_NAMEChange(Sender: TObject);
begin
  EditAbonentFrame.DoChange(Sender);
end;

procedure TShowUserStatForm.EditAbonentFrameCODE_WORDChange(Sender: TObject);
begin
  EditAbonentFrame.DoChange(Sender);
end;


procedure TShowUserStatForm.EditAbonentFrameCONTACT_INFOChange
    (Sender: TObject);
begin
  EditAbonentFrame.DoChange(Sender);
end;


procedure TShowUserStatForm.EditAbonentFrameCOUNTRY_IDClick(Sender: TObject);
begin
  EditAbonentFrame.DoChange(Sender);
end;


procedure TShowUserStatForm.EditAbonentFrameEMAILChange(Sender: TObject);
begin
  EditAbonentFrame.DoChange(Sender);
end;

procedure TShowUserStatForm.EditAbonentFrameHOUSEChange(Sender: TObject);
begin
  EditAbonentFrame.DoChange(Sender);
end;

procedure TShowUserStatForm.EditAbonentFrameIS_VIPClick(Sender: TObject);
begin
  EditAbonentFrame.DoChange(Sender);
end;

procedure TShowUserStatForm.EditAbonentFrameKORPUSChange(Sender: TObject);
begin
  EditAbonentFrame.DoChange(Sender);
end;

procedure TShowUserStatForm.EditAbonentFrameNAMEChange(Sender: TObject);
begin
  EditAbonentFrame.DoChange(Sender);
end;

procedure TShowUserStatForm.EditAbonentFramePASSPORT_DATEChange(Sender: TObject);
begin
  EditAbonentFrame.BDATEChange(Sender);
end;

procedure TShowUserStatForm.EditAbonentFramePASSPORT_GETChange(Sender: TObject);
begin
  EditAbonentFrame.DoChange(Sender);
end;

procedure TShowUserStatForm.EditAbonentFramePASSPORT_NUMChange(Sender: TObject);
begin
  EditAbonentFrame.DoChange(Sender);
end;

procedure TShowUserStatForm.EditAbonentFramePASSPORT_SERChange(Sender: TObject);
begin
  EditAbonentFrame.DoChange(Sender);
end;

procedure TShowUserStatForm.EditAbonentFramePATRONYMICChange(Sender: TObject);
begin
  EditAbonentFrame.DoChange(Sender);
end;

procedure TShowUserStatForm.EditAbonentFrameREGION_IDClick(Sender: TObject);
begin
  EditAbonentFrame.DoChange(Sender);
end;

procedure TShowUserStatForm.EditAbonentFrameSTREET_NAMEChange(Sender: TObject);
begin
  EditAbonentFrame.DoChange(Sender);
end;

procedure TShowUserStatForm.EditAbonentFrameSURNAMEChange(Sender: TObject);
begin
  EditAbonentFrame.DoChange(Sender);
end;

procedure TShowUserStatForm.EditAbonentFrameToolButton1Click(Sender: TObject);
begin
  EditAbonentFrame.aFindAbonentExecute(Sender);
end;

function TShowUserStatForm.EditcbDailyAbonPayBanned: Boolean;
begin
  Result := (LowerCase(MainForm.FUser) = LowerCase('MATVEEVNS'))
        or (LowerCase(MainForm.FUser) = LowerCase('ADMIN'));
end;

procedure TShowUserStatForm.eNewBlockHBKeyPress(Sender: TObject; var Key: Char);
begin
 if not(((key>=#48)and(key<=#57))or(key=#45)or(key=#189)or(key=#46)or(key=#8)) then key:=#0;
end;

procedure TShowUserStatForm.eNewNoticeHBKeyPress(Sender: TObject;
  var Key: Char);
begin
 if not(((key>=#48)and(key<=#57))or(key=#45)or(key=#189)or(key=#46)or(key=#8)) then key:=#0;
end;

procedure TShowUserStatForm.eSetPasswordKeyPress(Sender: TObject;
  var Key: Char);
begin
  if ord(Key)=VK_RETURN then
    BtSetPasswordOk.Click;
end;

function TShowUserStatForm.CheckDate: boolean;
begin

end;

procedure TShowUserStatForm.CRDBGrid2CellClick(Column: TColumn);
var Line:string;
    YearMonth:Integer;
    vRecNo:integer;
begin
//  Line:=CRDBGrid2.Columns[0].Field.AsString;
//  qServiceVolumeCheck.Close;
//  qServiceVolumeCheck.ParamByName('opt_code').AsString := Line;
//  qServiceVolumeCheck.Open;
//  Line := datetostr(date);
//  if qServiceVolumeCheck.FieldByName('csr').AsInteger<>0 then
//  begin
//    YearMonth:=StrToInt(Copy(Line, Length(Line)-3,4))*100+StrToInt(Copy(Line, Length(Line)-6,2));
//    DoShowBillDetails(FPhoneNumber, YearMonth, CRDBGrid2.Columns[0].Field.AsString,'SERVICE');
//  end;
//
//  //19610
//   if CRDBGrid2.Col=5   then
//  old_date:=CRDBGrid2.SelectedField.AsString
//  else  old_date:='';
//
//     vRecNo:=qOptions.RecNo;
//
// if old_date<>'' then
//    begin
//      qOptions.Close;
//      qOptions.CachedUpdates:=true;
//      qOptions.ReadOnly:=False;
//      CRDBGrid2.ReadOnly:=False;
//      qOptions.Open;
//      qOptions.RecNo:=vRecNo;
//      CRDBGrid2.EditorMode:=True;
//      CRDBGrid2.Options:=CRDBGrid2.Options+[dgEditing];
//      qOptions.Edit;
//    end
//      else begin
//          qOptions.Close;
//          qOptions.CachedUpdates:=false;
//          qOptions.ReadOnly:=true;
//          CRDBGrid2.ReadOnly:=true;
//          qOptions.Open;
//          CRDBGrid2.Options:=CRDBGrid2.Options-[dgEditing];
//          CRDBGrid2.EditorMode:=False;
//            end;

end;

procedure TShowUserStatForm.CRDBGrid2ColEnter(Sender: TObject);
begin
 //19610
// if (old_date <> '') and (old_date<>CRDBGrid2.SelectedField.AsString) then begin
//MainForm.CheckAdminPrivileges;
//  qOptions.Post;
//  qOptions.ApplyUpdates;
//  qOptions.close;
//  qOptions.Open;
//end;
end;

procedure TShowUserStatForm.CRDBGrid2DblClick(Sender: TObject);
begin
  TurnOnOffOption(FPhoneNumber, 'D', dmShowUserSt.qOptions.FieldByName('OPTION_CODE').AsString );
  dmShowUserSt.qAPIOptionHistory.Close;
  dmShowUserSt.qAPIOptionHistory.Open;
end;

procedure TShowUserStatForm.CRDBGrid2GetCellParams(Sender: TObject;
  Field: TField; AFont: TFont; var Background: TColor; State: TGridDrawState;
  StateEx: TGridDrawStateEx);
begin
  if (dmShowUserSt.qOptions.FieldByName('TURN_OFF_DATE').IsNull) or (dmShowUserSt.qOptions.FieldByName('TURN_OFF_DATE').AsDateTime > Now) then
    AFont.Color := clBlack
  else
    AFont.Color := clGray;
end;

procedure TShowUserStatForm.CRDBGridOptionHistoryGetCellParams(Sender: TObject;
  Field: TField; AFont: TFont; var Background: TColor; State: TGridDrawState;
  StateEx: TGridDrawStateEx);
var Answer, Types: string;
begin
  Answer := dmShowUserSt.qAPIOptionHistory.FieldByName('ANSWER').AsString;
  Types := dmShowUserSt.qAPIOptionHistory.FieldByName('INCLUSION_TYPE').AsString;
  if Answer='Выполнено' then
  begin
    if Types='Подключение' then
      AFont.Color:= $004000
    else if Types='Отключение' then
      AFont.Color:=clMaroon
    else
      AFont.Color:=clRed
  end
  else
    if Answer='Отказано' then
      AFont.Color:=clRed
    else
      AFont.Color:=$404040;
end;

procedure TShowUserStatForm.CRDBGrid4GetCellParams(Sender: TObject;
  Field: TField; AFont: TFont; var Background: TColor;
  State: TGridDrawState; StateEx: TGridDrawStateEx);
begin
  if Field.FieldName = 'BILL_SUM' then
    AFont.Style := [fsBold];
end;

procedure TShowUserStatForm.CRDBGrid5CellClick(Column: TColumn);
var Line:string;
    YearMonth:Integer;
begin
  Line:=CRDBGrid5.Columns[3].Field.AsString;
  if Pos('Счёт', Line)>0 then
  begin
    YearMonth:=StrToInt(Copy(Line, Length(Line)-3,4)+Copy(Line, Length(Line)-6,2));
    DoShowBillDetails(FPhoneNumber, YearMonth, CRDBGrid5.Columns[3].Field.AsString,'BILL');
  end;
end;

procedure TShowUserStatForm.dbgAPI_LOGDblClick(Sender: TObject);
  procedure Pclose(sender:TObject);
  begin
    (sender as TForm).ModalResult:=mrOk;
  //sender.Destroy;
  end;
var fList:TForm;
    Mcloselsit:TMethod;
    qBH:TOraQuery;
    dsBH:TDataSource;
    tBH:TDBMemo;
    q_num:integer;
begin
  if (not dmShowUserSt.oqApi_log.Active) or (dmShowUserSt.oqApi_log.RecordCount<1) then exit;
  flist:=tform.Create(self);
  with flist do
  begin
  //  FormStyle:=fsMDIChild;
    BorderStyle:=bsSingle;
    Caption:='Просмотр пары запрос\ответ АПИ (Скопировано в буфер)';
    Position:=poScreenCenter;
    Width:=760;
    Height:=540;
  end;

  qBH:=TOraQuery.Create(flist);
  with qBH do
  begin
    /////////запрос в лог
    sql.Clear;
    Params.Clear;
    Params.CreateParam(ftString,'q_num',ptInput);
    params.ParamByName('q_num').Value:= dmShowUserSt.oqApi_log.FieldByName('bsal_id').AsString;
    if TableName='BEELINE_SOAP_API_LOG' then
      sql.Add('select to_clob(''----Запрос---- ''||chr(13)||soap_request||chr(13)||''----Ответ----''||chr(13))||t.soap_answer.getclobval() API_STR'+
              ' from '+TableName+' t '+
              ' where t.bsal_id=:q_num')
    else
      sql.Add('select to_clob(''----Запрос---- ''||chr(13)||soap_request||chr(13)||''----Ответ----''||chr(13))||t.soap_answer API_STR'+
            ' from '+TableName+' t '+
            ' where t.bsal_id=:q_num');
  end;

  dsBH:=TDataSource.Create(flist);

  with dsBH do
  begin
    DataSet:=qBH;
    Enabled:=true;
  end;
  tBH:=TDBMemo.Create(flist);
  with tBH do
  begin
    parent:=fList;
    DataSource:=dsBH;
    DataField:='API_STR';
    align:=alClient;
    Visible:=true;
    Mcloselsit.Code:=@pclose;
    Mcloselsit.Data:=tBH.Parent;
    ReadOnly:=true;
    OnDblClick:=TNotifyEvent(Mcloselsit);
    Hint:='Двойной клик, чтобы закрыть';
    ShowHint:=true;
  end;
  try
    qBH.open;
  finally
    tbh.SelectAll;
    tbh.CopyToClipboard;
  end;
  if not qbh.Eof then
    fList.ShowModal
  else
    ShowMessage('Нет данных.');flist.Destroy;
end;

procedure TShowUserStatForm.aOpenDetailInExcelExecute(Sender: TObject);
var
  cr : TCursor;
  ACaption : String;
  ANameFile : string;
  grid : TCRDBGrid;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;

  if PageControl1.ActivePage = tsRest then
  begin
    grid := gRest;
    ACaption := 'Остатки пакетов по номеру ' + FPhoneNumber +
                ' на ' + FormatDateTime('dd.mm.yyyy hh:nn:ss', Now);
    ANameFile := FPhoneNumber + '_Rest_' + FormatDateTime('ddmmyyyyhhnnss', Now);
  end
  else
  begin
    grid := dbgDetail;
    ACaption := 'Детализация по номеру '
      + FPhoneNumber
      + ' за '
      + dmShowUserSt.qPeriods.FieldByName('MONTH').AsString
      + ' - '
      + dmShowUserSt.qPeriods.FieldByName('YEAR').AsString;
    ANameFile:=FPhoneNumber+'_Detail_'+dmShowUserSt.qPeriods.FieldByName('YEAR').AsString+'_'
                +dmShowUserSt.qPeriods.FieldByName('MONTH').AsString+'_';
  end;
  try
  //  ExportDBGridToExcel(ACaption,ANameFile,
   //   dbgDetail, False, True);

    ExportDBGridAndShow(ACaption, '', ANameFile, grid, True);

  finally
    Screen.Cursor := cr;
  end;
end;

procedure TShowUserStatForm.qPaymentsAfterOpen(DataSet: TDataSet);
begin
  dmShowUserSt.qPayments.FieldByName('PAYMENT_REMARK').OnGetText := qPaymentsPAYMENT_STATUS_TEXTGetText;
end;

procedure TShowUserStatForm.qPaymentsPAYMENT_STATUS_TEXTGetText(
  Sender: TField; var Text: String; DisplayText: Boolean);
begin
  if Sender.DataSet.Eof then
    Text := ''
  else if Sender.AsString = '' then
    Text := 'OK'
  else
    Text := Sender.AsString;
end;

procedure TShowUserStatForm.qPhoneStatusesPHONE_IS_ACTIVEGetText(
  Sender: TField; var Text: String; DisplayText: Boolean);
begin
  if Sender.AsInteger = 1 then
    Text := 'Активен'
  else
    Text := 'Блокирован';
end;

procedure TShowUserStatForm.qSummaryPhoneBeforeOpen(DataSet: TDataSet);
begin
  dmShowUserSt.qSummaryPhone.ParamByName('PHONE_NUMBER').AsString := FPhoneNumber;
end;

procedure TShowUserStatForm.tsAbonPeriodListShow(Sender: TObject);
begin
  dmShowUserSt.qAbonPeriodList.Close;
  dmShowUserSt.qAbonPeriodList.Open;
end;

procedure TShowUserStatForm.tsBalanceRowsShow(Sender: TObject);
begin
  RefreshBalanceRows;
end;

procedure TShowUserStatForm.tsBillBeelineShow(Sender: TObject);
begin
  dmShowUserSt.qBillBeeline.Close;
  dmShowUserSt.qBillBeeline.Open;
end;

procedure TShowUserStatForm.tsBillClientNewShow(Sender: TObject);
begin
  dmShowUserSt.qBillClientNew.Close;
  dmShowUserSt.qBillClientNew.Open;
end;

procedure TShowUserStatForm.tsBillsNewFormatShow(Sender: TObject);
begin
  dmShowUserSt.qBillBeeline.Close;
  dmShowUserSt.qBillBeeline.Open;
end;

procedure TShowUserStatForm.tsClientBillsShow(Sender: TObject);
begin
  dmShowUserSt.qClientBills.Close;
  dmShowUserSt.qClientBills.Open;
end;

procedure TShowUserStatForm.tsDetailShow(Sender: TObject);
begin
  dmShowUserSt.qPeriods.Close;
  dmShowUserSt.qPeriods.ParamByName('PHONE_NUMBER').AsString:=FPhoneNumber;
  dmShowUserSt.qPeriods.Open;
end;

procedure TShowUserStatForm.FillingStatistic;
var i, j: Integer;
    rec: boolean;
begin
  with gStatistic do
  begin
    //очищаем грид
    for i:=0 to RowCount do
      Rows[i].Clear;

    //заполняем таблицу
    ColWidths[0] := 200;
    ColWidths[1] := 70;
    i:= -1;
    RowCount := 1;

    rec := false;
    inc(i);
    Cells[0, i] := 'доначислено';
    Cells[1, i] := dmShowUserSt.qPeriods.FieldByName('COST_CHNG').AsString;
    rec := true;


    if rec then
      RowCount := RowCount + 1;
    inc(i);
    Cells[0, i] := 'Б/платных минут';
    Cells[1, i] := dmShowUserSt.qPeriods.FieldByName('ZEROCOST_OUTCOME_MINUTES').AsString;

    inc(i);
    RowCount := RowCount + 4;
    Cells[0, i] := '  - звонков';
    Cells[1, i] := dmShowUserSt.qPeriods.FieldByName('ZEROCOST_OUTCOME_COUNT').AsString;

    inc(i);
    Cells[0, i] := 'Платных минут';
    Cells[1, i] := dmShowUserSt.qPeriods.FieldByName('CALLS_MINUTES').AsString;


    inc(i);
    Cells[0, i] := '  - звонков';
    Cells[1, i] := dmShowUserSt.qPeriods.FieldByName('CALLS_COUNT').AsString;
    inc(i);
    Cells[0, i] := '  - стоимость';
    Cells[1, i] := dmShowUserSt.qPeriods.FieldByName('CALLS_COST').AsString;

    RowCount := RowCount + 4;
    inc(i);

    Cells[0, i] := 'SMS и MMS';
    Cells[1, i] := dmShowUserSt.qPeriods.FieldByName('SMS_MMS_COUNT').AsString;
    inc(i);
    Cells[0, i] := '  - стоимость';
    Cells[1, i] := dmShowUserSt.qPeriods.FieldByName('SMS_MMS_COST').AsString;
    inc(i);
    Cells[0, i] := 'Интернет, Мб';
    Cells[1, i] := dmShowUserSt.qPeriods.FieldByName('INTERNET_MB').AsString;
    inc(i);
    Cells[0, i] := '  - стоимость';
    Cells[1, i] := dmShowUserSt.qPeriods.FieldByName('INTERNET_COST').AsString;

    RowCount := RowCount + 1;
    inc(i);
    Cells[0, i] := 'Прочие услуги';
    Cells[1, i] := dmShowUserSt.qPeriods.FieldByName('OTHER_COST').AsString;
  end;
end;

procedure TShowUserStatForm.tsDiscountShow(Sender: TObject);
begin
  dmShowUserSt.spSetDiscount.ParamByName('PPHONE_NUMBER').AsString := FPhoneNumber;
  dmShowUserSt.qDiscount.Close;
  dmShowUserSt.qDiscount.ParamByName('PHONE_NUMBER').AsString := FPhoneNumber;
  dmShowUserSt.qDiscount.Open;
  if dmShowUserSt.qDiscountIS_DISCOUNT_OPERATOR.AsInteger=1 then
    cbDiscount.Checked:=true
  else
    cbDiscount.Checked:=false;
end;

procedure TShowUserStatForm.tsDopInfoShow(Sender: TObject);
var
  AdminPriv : boolean;
begin
  dmShowUserSt.qDopPhoneInfo.ParamByName('PHONE_NUMBER').AsString:=FPhoneNumber;
  dmShowUserSt.qDopPhoneInfo.Open;
end;

procedure TShowUserStatForm.tsOperatorBillsShow(Sender: TObject);
begin
  dmShowUserSt.qBills.Close;
  dmShowUserSt.qBills.Open;
end;

procedure TShowUserStatForm.tsOptionsShow(Sender: TObject);
var YearMonth:integer;
    vCheck,IsAdmin : Boolean;
begin
  dmShowUserSt.qOptionsPer.Close;
  dmShowUserSt.qOptions.Close;
  dmShowUserSt.qOptions.ParamByName('PHONE_NUMBER').AsString := FPhoneNumber;
  dmShowUserSt.qOptions.ParamByName('PHONE_NUMBER').AsString := FPhoneNumber;
  dmShowUserSt.qOptionsPer.ParamByName('PHONE_NUMBER').AsString:= FPhoneNumber;
  dmShowUserSt.qOptionsPer.Open;
  if cbPeriodsOpt.Items.Count=0 then
    while not dmShowUserSt.qOptionsPer.EOF do
      begin
        YearMonth:= dmShowUserSt.qOptionsPer.FieldByName('YEAR_MONTH').AsInteger;
        cbPeriodsOpt.Items.AddObject(InttoStr(YearMonth div 100)+' - '+InttoStr(YearMonth mod 100), Pointer(YearMonth));
        dmShowUserSt.qOptionsPer.Next;
      end;

  if cbPeriodsOpt.Items.Count > 0 then
    cbPeriodsOpt.ItemIndex := 0;
  cbPeriodsOptChange(Sender);
  dmShowUserSt.qOptions.Open;
  dmShowUserSt.qAPIOptionHistory.Close;
  dmShowUserSt.qAPIOptionHistory.ParamByName('PHONE_NUMBER').AsString := FPhoneNumber;
  MainForm.CheckAdminPrivs(IsAdmin);
  if IsAdmin then
    dmShowUserSt.qAPIOptionHistory.ParamByName('RETARIF').AsInteger := 1
  else
    dmShowUserSt.qAPIOptionHistory.ParamByName('RETARIF').AsInteger := 0;
  dmShowUserSt.qAPIOptionHistory.Open;
end;

procedure TShowUserStatForm.tsPaymentsRealShow(Sender: TObject);
begin
  dmShowUserSt.qPayments.Close;
  dmShowUserSt.qPayments.Open;
end;

procedure TShowUserStatForm.tsRoumingShow(Sender: TObject);
begin
  dmShowUserSt.qRouming.Close;
  dmShowUserSt.qRouming.Open;
end;

procedure TShowUserStatForm.tsSummaryPhoneShow(Sender: TObject);
var SQLTxt: string;
begin
  dmShowUserSt.qSummaryPhone.Close;
  dmShowUserSt.qSummaryPhone.Open;
end;

procedure TShowUserStatForm.tsTariffsShow(Sender: TObject);
var
  AdminPriv, ReadPriv, ROPriv: boolean;
begin

  dmShowUserSt.qHandBlockStart.Close;
  dmShowUserSt.qHandBlockStart.ParamByName('CONTRACT_ID').AsInteger :=FContractID;
  dmShowUserSt.qHandBlockStart.ParamByName('PHONE_NUMBER').AsString := FPhoneNumber;
  dmShowUserSt.qHandBlockStart.Open;
  if dmShowUserSt.qHandBlockStart.IsEmpty then
  begin
    CbHandBlock.Visible:=false;
  end
  else
  begin
    dmShowUserSt.qHandBlock.Close;
    dmShowUserSt.qHandBlock.SQL.Clear;
    dmShowUserSt.qHandBlock.SQL.Add('Select hand_block from v_contracts where Phone_Number_Federal=:PHONE and CONTRACT_ID=:CONTRACT_ID');
    dmShowUserSt.qHandBlock.ParamByName('PHONE').AsString:=FPhoneNumber;
    dmShowUserSt.qHandBlock.ParamByName('CONTRACT_ID').AsString:=VarToStr(FContractID);
    dmShowUserSt.qHandBlock.Prepare;
    dmShowUserSt.qHandBlock.Open;
    FHandBlockChecked := (dmShowUserSt.qHandBlock.FieldByName('hand_block').AsInteger <> 0);
    CbHandBlock.Checked := FHandBlockChecked;
  end;
  dmShowUserSt.qHandBlock.Close;

  dmShowUserSt.qTariffInfo.Close;
  dmShowUserSt.qTariffInfo.Open;
  if dmShowUserSt.qTariffInfo.FieldByName('NEW_CELL_PLAN_CODE').AsString<>'' then
    DB_TXT_NEW_TARIF_INFO.Visible:=true
  else
    DB_TXT_NEW_TARIF_INFO.Visible:=false;


  MainForm.CheckAdminPrivs(AdminPriv);
  MainForm.CheckROPrivs(ROPriv);
  if GetConstantValue('CALC_ABON_PAYMENT_TO_MONTH_END') = '1' then
  begin
    dmShowUserSt.qDailyAbonPay.Close;
    dmShowUserSt.qDailyAbonPay.Open;
    cbDailyAbonPay.OnClick := nil;
    if dmShowUserSt.qDailyAbonPay.FieldByName('PHONE_NUMBER').AsString = FPhoneNumber then
    begin
      cbDailyAbonPay.Checked := true;
      if not (EditcbDailyAbonPayBanned) then
        cbDailyAbonPay.Enabled := False;
    end
    else
      cbDailyAbonPay.Checked := false;

    cbDailyAbonPay.OnClick := cbDailyAbonPayClick;

    dmShowUserSt.qDailyAbonPayBanned.Close;
    dmShowUserSt.qDailyAbonPayBanned.Open;

    if dmShowUserSt.qDailyAbonPayBanned.FieldByName('DAILY_ABON_BANNED').AsInteger = 1 then
    begin
      cbDailyAbonPayBanned.Checked := true;
      if not(EditcbDailyAbonPayBanned) then
        cbDailyAbonPayBanned.Enabled := false;
    end
    else
      cbDailyAbonPayBanned.Checked := false;
  end;
end;

procedure TShowUserStatForm.BtBlockClick(Sender: TObject);
begin
  BlockPhone (GetParamValue('BEELINE_BLOCK_CODE_FOR_BLOCK'));
end;


procedure TShowUserStatForm.BtUnBlockClick(Sender: TObject);
var
  DetailText : String;
  buttonSelected : Integer;
begin
  
  if dmShowUserSt.qBlocked.FieldByName('blocked').AsInteger<>0 then
    buttonSelected:=MessageDlg('Данный номер заблокирован по подозрению в мошенничестве! Вы действительно хотите разблокировать данный номер телефона?', mtWarning, mbOKCancel, 0)
  else
    buttonSelected:=MessageDlg('Вы действительно хотите разблокировать данный номер телефона?', mtCustom, mbOKCancel, 0);
  if buttonSelected = mrCancel  then
    exit;
  if (RGBlock.Visible=true) and (Integer(RGBlock.Items.Objects[RGBlock.ItemIndex])=3) then
  begin
    dmShowUserSt.LoaderUnBlockPhoneNum2.ParamByName('pPHONE_NUMBER').AsString := FPhoneNumber;
    try
      dmShowUserSt.LoaderUnBlockPhoneNum2.ExecProc;
      DetailText := dmShowUserSt.LoaderUnBlockPhoneNum2.ParamByName('RESULT').AsString;
      FDetailText := DetailText;
    except
      on E : Exception do
      begin
        DetailText := 'Ошибка разблокировки.'#13#10 + E.Message;
      end;
    end;
    if DetailText=''  then
      ShowMessage('Операция выполнена успешно')
    else
      MessageDlg(DetailText, mtWarning, [mbOk], 0);
  end
  else
  begin
    dmShowUserSt.LoaderUnBlockPhoneNum.ParamByName('pPHONE_NUMBER').AsString := FPhoneNumber;
    if (RGBlock.Visible=true) and (Integer(RGBlock.Items.Objects[RGBlock.ItemIndex])=2) then
      dmShowUserSt.LoaderUnBlockPhoneNum.ParamByName('PNEW_SITE_METHOD').AsInteger:=1
    else
      dmShowUserSt.LoaderUnBlockPhoneNum.ParamByName('PNEW_SITE_METHOD').Clear;
    try
      dmShowUserSt.LoaderUnBlockPhoneNum.ExecProc;
      DetailText := dmShowUserSt.LoaderUnBlockPhoneNum.ParamByName('RESULT').AsString;
      FDetailText := DetailText;
    except
      on E : Exception do
      begin
        DetailText := 'Ошибка разблокировки.'#13#10 + E.Message;
      end;
    end;
    if DetailText=''  then
      ShowMessage('Операция выполнена успешно')
    else if (RGBlock.Visible=true) and (Integer(RGBlock.Items.Objects[RGBlock.ItemIndex])=2) then
      ShowMessage(DetailText)
    else
      MessageDlg(DetailText, mtWarning, [mbOk], 0);
  end;
end;

procedure TShowUserStatForm.cbDailyAbonPayBannedClick(Sender: TObject);
begin
  if ((cbDailyAbonPayBanned.Checked)
      and (EditcbDailyAbonPayBanned))
      OR (cbDailyAbonPayBanned.Enabled) then
  begin
    dmShowUserSt.qDailyAbonPayBanned.Edit;
    if cbDailyAbonPayBanned.Checked then
      dmShowUserSt.qDailyAbonPayBanned.FieldByName('DAILY_ABON_BANNED').AsInteger := 1
    else
      dmShowUserSt.qDailyAbonPayBanned.FieldByName('DAILY_ABON_BANNED').AsInteger := 0;

    dmShowUserSt.qDailyAbonPayBanned.Post;
    if not(EditcbDailyAbonPayBanned) then
    begin
      cbDailyAbonPay.Enabled := false;
      cbDailyAbonPayBanned.Enabled:=false;
    end;
  end;
end;

procedure TShowUserStatForm.cbDailyAbonPayClick(Sender: TObject);
begin

  if (cbDailyAbonPay.Checked) then
  begin
    if (EditcbDailyAbonPayBanned) OR (cbDailyAbonPayBanned.Enabled) then
    begin
      dmShowUserSt.qDailyAbonPay.Insert;
      dmShowUserSt.qDailyAbonPay.FieldByName('PHONE_NUMBER').AsString := FPhoneNumber;
      dmShowUserSt.qDailyAbonPay.Post;
      if not EditcbDailyAbonPayBanned then
        cbDailyAbonPayBanned.Enabled := False;
    end;
  end
  else
  begin
    if cbDailyAbonPayBanned.Enabled then
      if not(dmShowUserSt.qDailyAbonPay.IsEmpty) then
        dmShowUserSt.qDailyAbonPay.Delete;
  end;

end;

procedure TShowUserStatForm.cbDiscountClick(Sender: TObject);
begin
  if cbDiscount.Checked then
  begin
    eLength.Show;
    lLength.Show;
    btSetDiscount.Show;
    dtpNewBeginDate.Show;
    dtpNewBeginDate.DateTime:= dmShowUserSt.qDiscountDISCOUNT_BEGIN_DATE.AsDateTime;
    lDate.Show;
  end
  else
  begin
    if dmShowUserSt.qDiscountIS_DISCOUNT_OPERATOR.AsInteger=1 then
    begin
      dmShowUserSt.spSetDiscount.ParamByName('PCHECK').AsInteger:=0;
      dmShowUserSt.spSetDiscount.ParamByName('PDISCOUNT_VALIDITY').Value:=null;
      dmShowUserSt.spSetDiscount.ParamByName('PDISCOUNT_BEGIN_DATE').Value:=null;
      dmShowUserSt.spSetDiscount.ExecSQL;
      dmShowUserSt.qDiscount.Close;
      dmShowUserSt.qDiscount.Open;
    end;
    eLength.Hide;
    lLength.Hide;
    btSetDiscount.Hide;
    dtpNewBeginDate.Hide;
    lDate.Hide;
  end;
  if cbDiscount.Checked then
    if dmShowUserSt.qDiscountDISCOUNT_END_DATE.AsDateTime<Date then
      cbDiscount.Font.Color:=clRed
    else
      cbDiscount.Font.Color:=clGreen
  else
    cbDiscount.Font.Color:=clWindowText;
end;

procedure TShowUserStatForm.cbEXCLUDE_DETAILValueChanged(Sender: TObject);
begin
  inc(cbexcept);
  if cbexcept=0 then
    exit;

  if cbEXCLUDE_DETAIL.Checked then
    with qexcept do
    begin
      Append;
      post;
    end
  else
    with qexcept do
    begin
      edit;
      post;
    end;
  qexcept.Refresh;
end;

procedure TShowUserStatForm.BtSendSmsClick(Sender: TObject);
 var
  RefFrm : TSendSmsFrm;
begin
  RefFrm := TSendSmsFrm.Create(Application);
  try
    RefFrm.FPhoneNumber:= FPhoneNumber;
    RefFrm.ShowModal;
  finally
    FreeAndNil(RefFrm);
  end;
end;

procedure TShowUserStatForm.btSetDiscountClick(Sender: TObject);
begin
  dmShowUserSt.spSetDiscount.ParamByName('PCHECK').AsInteger:=1;
  dmShowUserSt.spSetDiscount.ParamByName('PDISCOUNT_VALIDITY').AsInteger:= dmShowUserSt.qDiscountDISCOUNT_VALIDITY.AsInteger;
  dmShowUserSt.spSetDiscount.ParamByName('PDISCOUNT_BEGIN_DATE').AsDateTime:=dtpNewBeginDate.DateTime;
  dmShowUserSt.spSetDiscount.ExecSQL;
  dmShowUserSt.qDiscount.Close;
  dmShowUserSt.qDiscount.Open;
  if cbDiscount.Checked then
    if dmShowUserSt.qDiscountDISCOUNT_END_DATE.AsDateTime<Date then
      cbDiscount.Font.Color:=clRed
    else
      cbDiscount.Font.Color:=clGreen
  else
    cbDiscount.Font.Color:=clWindowText;
end;

procedure TShowUserStatForm.BtSetPasswordClick(Sender: TObject);
begin
  if dmShowUserSt.qPassword.ParamByName('CONTRACT_ID').AsInteger=0 then
    ShowMessage('Для данного номера не существует договора.'+chr(10)+'Задать пароль невозможно.')
  else
  begin
    BtSetPasswordOk.Show;
    eSetPassword.Show;
    BtSetPassword.Hide;
    eSetPassword.Text:='';
    eSetPassword.SetFocus;
  end;
end;

procedure TShowUserStatForm.BtSetPasswordOkClick(Sender: TObject);
begin
  dmShowUserSt.qPassword.ParamByName('PASSWORD').AsString:=eSetPassword.Text;
  dmShowUserSt.qPassword.ExecSql;
  BtSetPasswordOk.Hide;
  eSetPassword.Hide;
  BtSetPassword.Show;
end;

procedure TShowUserStatForm.btnaOpenDetailInExcelClick(Sender: TObject);
var
  cr : TCursor;
  ACaption : String;
  ANameFile : string;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  ANameFile := 'Остатки пакетов по номеру ' + FPhoneNumber;
  ACaption := ANameFile + ' на ' + FormatDateTime('dd.mm.yyyy', Date);
  try
    ExportDBGridToExcel(ACaption, ANameFile, gRest, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TShowUserStatForm.btnCloseClick(Sender: TObject);
begin
 if FContractID<>0 then
   EditAbonentFrame.PrepareFrameByContractID('EDIT', FContractID);
end;

procedure TShowUserStatForm.btRefreshClick(Sender: TObject);
begin
  dmShowUserSt.qRests.Close;
  dmShowUserSt.qRests.ParamByName('PHONE_NUMBER').Value := FPhoneNumber;
  dmShowUserSt.qRests.Open;
end;

procedure TShowUserStatForm.btRoumingClick(Sender: TObject);
var
  cr : TCursor;
  ACaption : String;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  ACaption := 'Периоды тарификации роуминга по номеру '
      + FPhoneNumber;
  try
    ExportDBGridToExcel(ACaption,'',
      grRouming, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TShowUserStatForm.SaveBtnClick(Sender: TObject);
begin
  EditAbonentFrame.SaveData('');
end;

procedure TShowUserStatForm.B1Click(Sender: TObject);
var
  AdminPriv : boolean;
begin
//MainForm.CheckAdminPrivs(AdminPriv);
  MainForm.CheckAdminPrivileges;

  if  (gPayments.Fields[6].AsString = '') then
  begin
    MonthCalendar1.Top:=ScreenToClient(Mouse.CursorPos).Y-gPayments.Top-20;
    MonthCalendar1.Visible:=true;
  end
  else
    MessageDlg('Можно редактировать только платежи загрузки! Ручные редактируются по двойному клику.',mtError, [mbOK], 0);
end;

procedure TShowUserStatForm.BChangeSIMClick(Sender: TObject);
Var buttonSelected:integer;
  DetailText : String;
begin
  buttonSelected:=MessageDlg('Вы действительно хотите поменять SIM карту?', mtCustom, mbOKCancel, 0);
  if buttonSelected = mrCancel then
    exit;
  dmShowUserSt.PReplaceSIM.ParamByName('pPHONE_NUMBER').AsString := FPhoneNumber;
  dmShowUserSt.PReplaceSIM.ParamByName('pICC').AsString := EChangeSIM.Text;
  try
    dmShowUserSt.PReplaceSIM.ExecProc;
    DetailText := dmShowUserSt.PReplaceSIM.ParamByName('RESULT').AsString;
  except
    on E : Exception do
    begin
      DetailText := 'Ошибка смены SIM карты.'#13#10 + E.Message;
    end;
  end;

  if DetailText=''  then
  begin
    //ShowMessage('Операция выполнена успешно');
    ShowMessage('Запрос на замену SIM карты отправлен');
    dmShowUserSt.qDopPhoneInfo.Close;
    dmShowUserSt.qDopPhoneInfo.Open;
  end
  else
    MessageDlg(DetailText, mtWarning, [mbOk], 0);

end;

procedure TShowUserStatForm.BChangeSIMHistClick(Sender: TObject);
VAr IsAdm:boolean;
begin
  MainForm.CheckAdminPrivs(IsAdm);
ExecuteRRS( FPhoneNumber,IsAdm);
end;

procedure TShowUserStatForm.BitBtn3Click(Sender: TObject);
  var
  AYear, AMonth,ARecNo : Integer;
   DetailText,stt : string;
begin
  AYear := dmShowUserSt.qPeriods.FieldByName('YEAR').AsInteger;
  AMonth := dmShowUserSt.qPeriods.FieldByName('MONTH').AsInteger;
  dmShowUserSt.spMsisdnRefresh.ParamByName('PLOADING_YEAR').AsInteger := AYear;
  dmShowUserSt.spMsisdnRefresh.ParamByName('PLOADING_MONTH').AsInteger := AMonth;
  dmShowUserSt.spMsisdnRefresh.ParamByName('PPHONE_NUMBER').AsString := FPhoneNumber;
  dmShowUserSt.spMsisdnRefresh.ExecProc;
  DetailText := dmShowUserSt.spMsisdnRefresh.ParamByName('PERROR').AsString;
  ARecNo:= dmShowUserSt.qPeriods.RecNo;
  dmShowUserSt.qPeriods.Close;
  dmShowUserSt.qPeriods.Open;
  ARecNo:= dmShowUserSt.qPeriods.MoveBy(ARecNo-1);
  FYear := dmShowUserSt.qPeriods.FieldByName('YEAR').AsInteger;
  FMonth := dmShowUserSt.qPeriods.FieldByName('MONTH').AsInteger;
  if (GetConstantValue('DB_DETAILS')='0') then
  begin
    LoadDetailText;
    PrepareDetail;
  end
  else
  begin
    dmShowUserSt.spGetHBMonth.ParamByName('pYEAR').AsInteger := FYear;
    dmShowUserSt.spGetHBMonth.ParamByName('pMONTH').AsInteger := FMonth;
    dmShowUserSt.spGetHBMonth.ExecProc;
    if dmShowUserSt.spGetHBMonth.ParamByName('RESULT').AsInteger=0 then
    begin
      dmShowUserSt.dsDetail.Enabled:=false;
      dmShowUserSt.dsDetail.DataSet:= dmShowUserSt.vtDetailFile;
      dmShowUserSt.dsDetail.Enabled:=true;
      LoadDetailText;
      PrepareDetail;
    end
    else
    begin
      dmShowUserSt.dsDetail.Enabled:=false;
      dmShowUserSt.dsDetail.DataSet:= dmShowUserSt.qHBDetails;
      dmShowUserSt.dsDetail.Enabled:=true;
      stt:=inttostr(FMonth);
      if length(stt)=1 then
        stt:='0'+stt;
      dmShowUserSt.qHBDetails.SQL.Strings[qHBDetailsStrTableNameNum]:=' from call_'+stt+'_'+inttostr(FYear)+' c10';
      dmShowUserSt.qHBDetails.ParamByName('SUBSCR').AsString := FPhoneNumber;
      dmShowUserSt.qHBDetails.Open;
    end;
  end;
 // LoadDetailText;
 // PrepareDetail;
  MessageDlg(DetailText, mtInformation, [mbOk], 0);
end;

procedure TShowUserStatForm.btRefreshOptionListClick(Sender: TObject);
var
 DetailText:string;
 YearMonth:integer;
begin
  btRefreshOptionList.enabled:=false;
  dmShowUserSt.qOptionsPer.Close;
  dmShowUserSt.qOptions.Close;
  dmShowUserSt.spLoadPhoneOptions.ParamByName('pPHONE_NUMBER').AsString := FPhoneNumber;
  dmShowUserSt.spLoadPhoneOptions.ExecProc;
  DetailText:= dmShowUserSt.spLoadPhoneOptions.ParamByName('PERROR').AsString;
  dmShowUserSt.qOptions.ParamByName('PHONE_NUMBER').AsString := FPhoneNumber;
  dmShowUserSt.qOptionsPer.ParamByName('PHONE_NUMBER').AsString:= FPhoneNumber;
  dmShowUserSt.qOptionsPer.Open;
  cbPeriodsOpt.Clear;
  while not dmShowUserSt.qOptionsPer.EOF do
  begin
    YearMonth:= dmShowUserSt.qOptionsPer.FieldByName('YEAR_MONTH').AsInteger;
    cbPeriodsOpt.Items.AddObject(InttoStr(YearMonth div 100)+' - '+InttoStr(YearMonth mod 100), Pointer(YearMonth));
    dmShowUserSt.qOptionsPer.Next;
  end;
  if cbPeriodsOpt.Items.Count > 0 then
    cbPeriodsOpt.ItemIndex := 0;
  cbPeriodsOptChange(Sender);
  btRefreshOptionList.enabled:=true;
  MessageDlg(DetailText, mtInformation, [mbOk], 0);
end;

procedure TShowUserStatForm.BitBtn5Click(Sender: TObject);
begin
  DoShowBillDetails(FPhoneNumber, FYear*100+FMonth, 'SMS/USSD','SMSUSSD');
end;

procedure TShowUserStatForm.BitBtn6Click(Sender: TObject);
var
  cr : TCursor;
  ACaption : String;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  ACaption := 'Расшифровка счетов Билайна по номеру '
      + FPhoneNumber;
  try
    ExportDBGridToExcel(ACaption,'',
      CRDBGrid4, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TShowUserStatForm.btUnloadClick(Sender: TObject);
var OraStoredProc:TOraStoredProc;
begin
  if OpenDialog1.Execute then
  begin
    OraStoredProc := TOraStoredProc.Create(self);
    with OraStoredProc do
    begin
       StoredProcName := 'DOWNLOAD_BILL_BLOB';
       PrepareSQL;  // receive parameters
//          ParamByName('p_ID').AsInteger := 10;
      ParamByName('SFILENAME').AsString := ExtractFileName(OpenDialog1.FileName);
      ParamByName('BDATA').ParamType := ptInput;  // to transfer Lob data to Oracle
      ParamByName('BDATA').AsOraBlob.LoadFromFile(OpenDialog1.FileName);
      Execute;
    end;
    OraStoredProc.Free;
    //OraQuery1.ParamByName('SFILENAME').AsString:=OpenDialog1.FileName;
    //OraQuery1.ParamByName('SDATA').LoadFromFile(OpenDialog1.FileName,ftBlob) ;
    //OraStoredProc1.ParamByName('SFILENAME').AsString:=OpenDialog1.FileName;
    //OraStoredProc1.ParamByName('BDATA').LoadFromFile(OpenDialog1.FileName,ftBlob) ;
    //OraStoredProc1.ExecProc;
    //OraQuery1.ExecSQL;
    //mainform.OraSession.Commit;
  end;
end;

procedure TShowUserStatForm.BUnbilledCallsListClick(Sender: TObject);
var
  fList : TShowDetalAPIForm;
begin
  fList := TShowDetalAPIForm.Create(self, MainForm.OraSession, FPhoneNumber);
  try
    fList.ShowModal;
  finally
    fList.Free;
  end;
end;

procedure TShowUserStatForm.BGet_api_servicesClick(Sender: TObject);
var
  qBH:TOraQuery;
  vRES : string;
begin
  try
    qBH:=TOraQuery.Create(nil);
    with qBH do begin
      params.CreateParam(ftString,'p_phone',ptInput);
      params.ParamByName('p_phone').Value:=FPhoneNumber;
      sql.Add('select beeline_api_pckg.phone_options (to_number(:p_phone)) state from dual');
      Execute;
      vRES := FieldByName('state').AsString;

      // если не наши в сообщении строк ERROR, ERR, то значит ошибок нет
      if ((AnsiPos('ERROR', AnsiUpperCase(vRES))=0) and (AnsiPos('ERR', AnsiUpperCase(vRES))=0))then
        ShowMessage('Результат ответа запроса Билайна: ' + #10#13 + vRES)
      else
        MessageDlg('Внимание! Запрос на получение услуг не выполнен! Ошибка: ' + #10#13 + vRES, mtError, [mbOK], 0)
      ;
    end;
  finally
    qbh:=nil;
  end;
  dmShowUserSt.qOptions.Close;
  dmShowUserSt.qOptions.Open;
  dmShowUserSt.qAPIOptionHistory.Close;
  dmShowUserSt.qAPIOptionHistory.Open;
end;

procedure TShowUserStatForm.BlockListBtClick(Sender: TObject);
var
  RefFrm : TBlockListFrm;
begin
  RefFrm := TBlockListFrm.Create(Application);
  try
    RefFrm.Execute(FPhoneNumber, True);
  finally
    FreeAndNil(RefFrm);
  end;
end;

procedure TShowUserStatForm.BlockPhone(StatusCode: String);
var
  DetailText : String;
  buttonSelected : Integer;
begin
  if Trim (StatusCode) <> '' then
  begin
    buttonSelected := MessageDlg('Вы действительно хотите заблокировать данный номер телефона?', mtCustom, mbOKCancel, 0);

    if buttonSelected = mrCancel then
      exit;
    if (RGBlock.Visible=true) and (Integer(RGBlock.Items.Objects[RGBlock.ItemIndex])=3) then
    begin
      dmShowUserSt.LoaderBlockPhoneNum2.ParamByName('pPHONE_NUMBER').AsString := FPhoneNumber;
      dmShowUserSt.LoaderBlockPhoneNum2.ParamByName('pCODE').AsString := StatusCode;
      try
        dmShowUserSt.LoaderBlockPhoneNum2.ExecProc;
        DetailText := dmShowUserSt.LoaderBlockPhoneNum2.ParamByName('RESULT').AsString;
        FDetailText := DetailText;
      except
        on E : Exception do
        begin
          DetailText := 'Ошибка блокировки.'#13#10 + E.Message;
        end;
      end;
      if DetailText=''  then
        ShowMessage('Операция выполнена успешно')
      else
        MessageDlg(DetailText, mtWarning, [mbOk], 0);
    end
    else
    begin
      dmShowUserSt.LoaderBlockPhoneNum.ParamByName('pPHONE_NUMBER').AsString := FPhoneNumber;
      if (RGBlock.Visible=true) and (Integer(RGBlock.Items.Objects[RGBlock.ItemIndex])=2) then
        dmShowUserSt.LoaderBlockPhoneNum.ParamByName('PNEW_SITE_METHOD').AsInteger:=1
      else
        dmShowUserSt.LoaderBlockPhoneNum.ParamByName('PNEW_SITE_METHOD').Clear;

      try
        dmShowUserSt.LoaderBlockPhoneNum.ExecProc;
        DetailText := dmShowUserSt.LoaderBlockPhoneNum.ParamByName('RESULT').AsString;
        FDetailText := DetailText;
      except
        on E : Exception do
        begin
          DetailText := 'Ошибка блокировки.'#13#10 + E.Message;
        end;
      end;

      if DetailText=''  then
        ShowMessage('Операция выполнена успешно')
      else if (RGBlock.Visible=true) and (Integer(RGBlock.Items.Objects[RGBlock.ItemIndex])=2) then
        ShowMessage(DetailText)
      else
        MessageDlg(DetailText, mtWarning, [mbOk], 0);
    end;
  end;
end;

procedure TShowUserStatForm.btAbonPeriodListClick(Sender: TObject);
var
  cr : TCursor;
  ACaption : String;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  ACaption := 'Периоды тарификации абонентской платы по номеру '
      + FPhoneNumber;
  try
    ExportDBGridToExcel(ACaption,'',
      grAbonPeriodList, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TShowUserStatForm.btAPITurnOnServisesClick(Sender: TObject);
begin
  TurnOnOffOption(FPhoneNumber, 'A', '');
  dmShowUserSt.qAPIOptionHistory.Close;
  dmShowUserSt.qAPIOptionHistory.Open;
end;

procedure TShowUserStatForm.btBillBeelineClick(Sender: TObject);
var
  cr : TCursor;
  ACaption : String;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  ACaption := 'Детальные счета Билайна по номеру '
      + FPhoneNumber;
  try
    ExportDBGridToExcel(ACaption,'',
      grBillBeeline, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TShowUserStatForm.btBillClientClick(Sender: TObject);
var
  cr : TCursor;
  ACaption : String;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  ACaption := 'Расшифровка счетов по номеру '
      + FPhoneNumber;
  try
    ExportDBGridToExcel(ACaption,'',
      CRDBGridClientBills, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TShowUserStatForm.btBillClientNewClick(Sender: TObject);
var
  cr : TCursor;
  ACaption : String;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  ACaption := 'Детальная расшифровка счетов для клиента по номеру '
      + FPhoneNumber;
  try
    ExportDBGridToExcel(ACaption,'',
      grBillClientNew, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TShowUserStatForm.UnBlockListBtClick(Sender: TObject);
var
  RefFrm : TUnBlockListFrm;
begin
  RefFrm := TUnBlockListFrm.Create(Application);
  try
    RefFrm.Execute(FPhoneNumber, True);
  finally
    FreeAndNil(RefFrm);
  end;
end;

procedure TShowUserStatForm.CbHandBlockExit(Sender: TObject);
begin
  dmShowUserSt.qSelBalDate.Close;
  dmShowUserSt.qHandBlock.SQL.Clear;
  dmShowUserSt.qSelBalDate.ParamByName('PHONE_NUMBER').AsString:=FPhoneNumber;
  dmShowUserSt.qSelBalDate.Open;
  if CbHandBlock.Visible and (CbHandBlock.Checked <> FHandBlockChecked) then
  begin
    if CbHandBlock.Checked then
    begin
      dmShowUserSt.qHandBlock.Close;
      dmShowUserSt.qHandBlock.SQL.Add('Update contracts set hand_block=1 where CONTRACT_ID='+InttoStr(FContractID)+' and (PHONE_NUMBER_CITY='+FPhoneNumber+' or PHONE_NUMBER_FEDERAL='+FPhoneNumber+')');
      dmShowUserSt.qHandBlock.Prepare;
      dmShowUserSt.qHandBlock.ExecSql;
    end
    else
    begin
      dmShowUserSt.qHandBlock.Close;
      dmShowUserSt.qHandBlock.SQL.Add('Update contracts set hand_block=0 where CONTRACT_ID='+InttoStr(FContractID)+' and (PHONE_NUMBER_CITY='+FPhoneNumber+' or PHONE_NUMBER_FEDERAL='+FPhoneNumber+')');
      dmShowUserSt.qHandBlock.Prepare;
      dmShowUserSt.qHandBlock.ExecSql;
    end;
    FHandBlockChecked := CbHandBlock.Checked;
  end;
end;

procedure TShowUserStatForm.cbHideZeroCallClick(Sender: TObject);
begin
  if cbHideZeroCall.Checked then
  begin
    dmShowUserSt.vtDetailFile.Filter:='SERVICE_COST<>"0"';
    dmShowUserSt.vtDetailFile.Filtered:=true;
    dmShowUserSt.qHBDetails.Filter:='SERVICE_COST<>"0"';
    dmShowUserSt.qHBDetails.Filtered:=true;
  end
  else
  begin
    dmShowUserSt.vtDetailFile.Filter:='';
    dmShowUserSt.vtDetailFile.Filtered:=false;
    dmShowUserSt.qHBDetails.Filter:='';
    dmShowUserSt.qHBDetails.Filtered:=false;
  end;
end;

procedure TShowUserStatForm.cbPeriodsOptChange(Sender: TObject);
begin
  if cbPeriodsOpt.Items.Count > 0 then
  begin
    dmShowUserSt.qOptions.ParamByName('YEAR_MONTH').AsInteger:=
      Integer(cbPeriodsOpt.Items.objects[cbPeriodsOpt.ItemIndex]);
    dmShowUserSt.qOptions.Close;
    dmShowUserSt.qOptions.Open;
  end;
end;

function TShowUserStatForm.FindComponentEx(const Name: string): TComponent;
var
   FormName: string;
   CompName: string;
   P: Integer;
   Found: Boolean;
   Form: TForm;
   I: Integer;
 begin
   // Split up in a valid form and a valid component name
  P := Pos('.', Name);
   if P = 0 then
   begin
     raise Exception.Create('No valid form name given');
   end;
   FormName := Copy(Name, 1, P - 1);
   CompName := Copy(Name, P + 1, High(Integer));
   Found    := False;
   // find the form
  for I := 0 to Screen.FormCount - 1 do
   begin
     Form := Screen.Forms[I];
     // case insensitive comparing
    if AnsiSameText(Form.Name, FormName) then
     begin
       Found := True;
       Break;
     end;
   end;
   if Found then
   begin
     for I := 0 to Form.ComponentCount - 1 do
     begin
       Result := Form.Components[I];
       if AnsiSameText(Result.Name, CompName) then Exit;
     end;
   end;
   Result := nil;
 end;
procedure TShowUserStatForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FContractID<>0 then
    EditAbonentFrame.PrepareFrameByContractID('EDIT', FContractID);
  dmShowUserSt.qSelBalDate.Close;
  dmShowUserSt.qHandBlock.SQL.Clear;
  dmShowUserSt.qSelBalDate.ParamByName('PHONE_NUMBER').AsString:=FPhoneNumber;
  dmShowUserSt.qSelBalDate.Open;
  if CbHandBlock.Visible and (CbHandBlock.Checked <> FHandBlockChecked) then
  begin
    if CbHandBlock.Checked then
    begin
      dmShowUserSt.qHandBlock.Close;
      dmShowUserSt.qHandBlock.SQL.Add('Update contracts set hand_block=1 where CONTRACT_ID='+InttoStr(FContractID)+' and (PHONE_NUMBER_CITY='+FPhoneNumber+' or PHONE_NUMBER_FEDERAL='+FPhoneNumber+')');
      dmShowUserSt.qHandBlock.Prepare;
      dmShowUserSt.qHandBlock.ExecSql;
    end
    else
    begin
      dmShowUserSt.qHandBlock.Close;
      dmShowUserSt.qHandBlock.SQL.Add('Update contracts set hand_block=0 where CONTRACT_ID='+InttoStr(FContractID)+' and (PHONE_NUMBER_CITY='+FPhoneNumber+' or PHONE_NUMBER_FEDERAL='+FPhoneNumber+')');
      dmShowUserSt.qHandBlock.Prepare;
      dmShowUserSt.qHandBlock.ExecSql;
    end;
    FHandBlockChecked := CbHandBlock.Checked;
  end;
  FreeAndNil(qexcept);

end;

procedure TShowUserStatForm.FormCreate(Sender: TObject);
Var
  IsAdm:boolean;
begin
  SetDataModuleSettings;

  if GetConstantValue('SHOW_DETAIL_API')<>'1' then
    BUnbilledCallsList.Visible:=False;

  if (GetConstantValue('BLOCK_TYPES_ENABLE')='1') then begin
    dmShowUserSt.qRGBlock.Open;
    dmShowUserSt.DsRGBlock.DataSet.First;
    while Not (dmShowUserSt.DsRGBlock.DataSet.Eof) do
    begin
      RGBlock.Items.AddObject(
      dmShowUserSt.qRGBlock.FieldByName('BLOCK_TYPE_NAME').AsString,
      TObject(dmShowUserSt.qRGBlock.FieldByName('BLOCK_TYPE_ID').AsInteger)
      );
      dmShowUserSt.DsRGBlock.DataSet.next;
    end;
    dmShowUserSt.qRGBlock.Close;
    RGBlock.ItemIndex:=1;
  end
  else RGBlock.Visible:=false;
  MainForm.CheckAdminPrivs(IsAdm);
  if (GetConstantValue('REPLACE_SIM_ENABLE')='0')
    or ((GetConstantValue('REPLACE_SIM_ADM_ENABLE')='1') and (NOT isadm)) then
  begin
    LChangeSIM.Visible:=false;
    EChangeSIM.Visible:=false;
    BChangeSIM.Visible:=false;
  end;

  if GetConstantValue('CALC_ABON_PAYMENT_TO_MONTH_END') = '1' then
  begin
    cbDailyAbonPay.Show;
    cbDailyAbonPayBanned.Show;
    if IsAdm then
      cbDailyAbonPay.Enabled:=true
    else
      cbDailyAbonPay.Enabled:=false;
  end
  else
  begin
    cbDailyAbonPay.Hide;
    cbDailyAbonPayBanned.Hide;
  end;
end;

procedure TShowUserStatForm.FormShow(Sender: TObject);
var
i:integer;
C: TComponent;
begin
  with dm do
  begin
    qformaccess.Close;
    qformaccess.ParamByName('FORM_NAME').AsString:='ShowUserStatForm';
    qformaccess.ParamByName('USER_NAME').AsString:=mainform.OraSession.Username;
    qformaccess.ParamByName('RIGHTS_TYPE').AsInteger:=MainForm.UserRightsType;
    qformaccess.ParamByName('CHECK_ALLOW_ACCOUNT').AsInteger:=MainForm.Allow_account;
    qformaccess.execsql;
    for I := 0 to qFormAccess.RecordCount-1 do
    begin
      try
        C := FindComponentex('ShowUserStatForm.'+qformaccess.FieldByName('COMPONENT_NAME').AsString);
        if qformaccess.FieldByName('IS_ACTIVE').AsInteger=1 then
          TWinControl(C).Enabled:=true
        else
          TWinControl(C).Enabled:=false;
        if qformaccess.FieldByName('IS_VISIBLE').AsInteger=1 then
          TWinControl(C).Visible:=true
        else
          TWinControl(C).Visible:=false;
      except
       ShowMessage('Ошибка поиска компонента '+qformaccess.FieldByName('COMPONENT_NAME').AsString);
      end;
    end;
  end;
  //PageControl1.ActivePage:=tsTariffs;
end;

procedure TShowUserStatForm.gPaymentsCellClick(Column: TColumn);
begin
  MonthCalendar1.Visible:=false;
end;

procedure TShowUserStatForm.gPaymentsDblClick(Sender: TObject);
  // 25.10.2012 г. А. Пискунов Изменение платежа
var
  FChangeContractForm : TRegisterPaymentForm;
  FReceivedPaymentID: String;
  AdminPriv : boolean;
  //ChangePaymentFrm: TChangePaymentFrm;     // -- Старая Версия

begin
  //10.12 г. Александр Пискунов - тестирование стандартной функции для изменения формы
  MainForm.CheckAdminPrivs(AdminPriv);
  //AdminPriv := false;  // Временно для отладки
  if AdminPriv then
  begin
    if not (dmShowUserSt.qPaymentsRECEIVED_PAYMENT_ID.AsString = '') then
      begin
        FChangeContractForm := TRegisterPaymentForm.Create(nil);

        FChangeContractForm.TARIFF_ID.Enabled := False;
        FChangeContractForm.FILIAL_ID.Enabled := False;
        FChangeContractForm.PAYMENT_DATE_TIME.Enabled := False;

        try
          FChangeContractForm.PrepareForm('EDIT', dmShowUserSt.qPaymentsRECEIVED_PAYMENT_ID.AsString, Null);
          if (mrOk = FChangeContractForm.ShowModal) then
            dmShowUserSt.qPayments.Refresh;
        finally
          FChangeContractForm.Free;
        end;
      end
    else
      MessageDlg('Можно редактировать только ручные платежи!',mtError, [mbOK], 0);
  end;

end;

procedure TShowUserStatForm.gSummaryPhoneCellClick(Column: TColumn);
var Line:string;
    YearMonth:Integer;
begin
  Line:=gSummaryPhone.Columns[5].Field.AsString;
  if Pos('Счёт', Line)>0 then
  begin
    YearMonth:=StrToInt(Copy(Line, Length(Line)-3,4)+Copy(Line, Length(Line)-6,2));
    DoShowBillDetails(FPhoneNumber, YearMonth, gSummaryPhone.Columns[5].Field.AsString,'BILL');
  end;
end;

procedure TShowUserStatForm.gSummaryPhoneDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var Im1: TBitmap;
    BS: TStream;
begin
  if Column.FieldName = 'IMAGE_BMP' then
    if not dmShowUserSt.qSummaryPhone.FieldByName('IMAGE_BMP').IsNull then
    begin
      gSummaryPhone.Canvas.Brush.Color := clWhite;
      gSummaryPhone.Canvas.FillRect(Rect);

      Im1 := TBitmap.Create;//создание
      try
        Im1.Assign(TBLOBField(dmShowUserSt.qSummaryPhone.FieldByName('IMAGE_BMP')));
        gSummaryPhone.Canvas.Draw(round((Rect.Left+Rect.Right-Im1.Width)/2),Rect.Top,Im1);
      finally
        Im1.Free;
      end;
    end;
end;

procedure TShowUserStatForm.IS_BS_CHECKClick(Sender: TObject);
begin

end;

{ mySMTP }

procedure mySMTP.Execute;
var
c:integer;
idsmtp1:TIdSMTP;
idMessage1:TIdMessage;
//IdSSLIOHandlerSocketOpenSSL:TIdSSLIOHandlerSocketOpenSSL;
begin
if SMTP_PORT<>25 then begin
 try
  {IdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  IdSSLIOHandlerSocketOpenSSL.Destination := SMTP_SRV+':'+IntToStr(SMTP_PORT);
  IdSSLIOHandlerSocketOpenSSL.Host := SMTP_SRV;
  IdSSLIOHandlerSocketOpenSSL.Port := SMTP_PORT;
  IdSSLIOHandlerSocketOpenSSL.DefaultPort := 0;
  IdSSLIOHandlerSocketOpenSSL.SSLOptions.Method := sslvTLSv1;
  IdSSLIOHandlerSocketOpenSSL.SSLOptions.Mode := sslmUnassigned;}
 except
   ShowMessage('Ошибка создания SSL!');
 end;
end;
 try
  idsmtp1:=TIdSMTP.Create();
 except
   ShowMessage('Ошибка создания TIdSMTP!');
 end;
 with idsmtp1 do begin
   Host := SMTP_SRV;
   Username :=SMTP_LOG;
   Password:=SMTP_PASS;
   Port:=SMTP_PORT;
   if SMTP_PORT<>25 then begin
     //IOHandler := IdSSLIOHandlerSocketOpenSSL;
     UseTLS := utUseExplicitTLS;
   end;
 end;
 try
  idMessage1:=TIdMessage.Create();
 except
   ShowMessage('Ошибка создания TIdMessage!');
 end;
 with idMessage1 do begin
 Date := Now;
 From.Text := SMTP_FROM;//SMTP_FROMTXT;
 Recipients.EMailAddresses := SMTP_ADDR;
 Subject := SMTP_TITLE;
 From.Name := SMTP_FROM;//'Агентство связи';
 From.Address := SMTP_LOG;
 ContentTransferEncoding:='8bit';
 ContentType := 'multipart/mixed;';
 CharSet := 'Windows-1251';
 Body.Text := SMTP_BODY;
// Body :=SMTP_BODY;
 end;
 try
   TIdAttachmentFile.Create( idMessage1.MessageParts, SMTP_ATT_FILE+'.xls');
  except
    on e : exception do
  ShowMessage('Ошибка создания TIdAttachmentFile!'#13#10+e.Message);
 end;
  try
     try
     IdSMTP1.Connect;
        try
          IdSMTP1.Send(idMessage1);
          ShowMessage(SMTP_TITLE+': отправлено!');
          try
           if FileExists(SMTP_ATT_FILE+'.xltx') then
            DeleteFile(SMTP_ATT_FILE+'.xltx');
          except
            ShowMessage('Ошибка удаления '+SMTP_ATT_FILE+'.xltx!');
          end;
          try
           if FileExists(SMTP_ATT_FILE+'.xls') then
            DeleteFile(SMTP_ATT_FILE+'.xls');
           except
             ShowMessage('Ошибка удаления '+SMTP_ATT_FILE+'.xls!');
           end;
        finally
          IdSMTP1.Disconnect;
        end;
  except
    on e : exception do
             Application.MessageBox(PChar('Ошибка. Сообщение не отправлено!'#13#10+e.Message),
        'Предупреждение', MB_OK+MB_ICONWARNING);
     end;
  finally
     //очищаем из памяти
      IdMessage1.Clear;
      idsmtp1.Destroy;
      idMessage1.Destroy;
      //if SMTP_PORT<>25 then
      //IdSSLIOHandlerSocketOpenSSL.Free;
//FreeAndNil(idMessage1);
  end;
end;


procedure TShowUserStatForm.SetDataModuleSettings;
begin
  dmShowUserSt.dsTariffInfo.OnDataChange := dsTariffInfoDataChange;
  dmShowUserSt.dsPeriods.OnDataChange := dsPeriodsDataChange;
  dmShowUserSt.dsOptions.OnDataChange := dsOptionsDataChange;
  dmShowUserSt.qPayments.AfterOpen := qPaymentsAfterOpen;
  dmShowUserSt.qPhoneStatusesPHONE_IS_ACTIVE.OnGetText := qPhoneStatusesPHONE_IS_ACTIVEGetText;
  dmShowUserSt.spSetHandBlockEndDate.AfterExecute := spSetHandBlockEndDateAfterExecute;
  dmShowUserSt.qSummaryPhone.BeforeOpen := qSummaryPhoneBeforeOpen;
end;

procedure TShowUserStatForm.MonthCalendar1DblClick(Sender: TObject);
var
  SqlOra : TOraQuery;
  sqltext : string;
begin

  if datetostr(MonthCalendar1.Date)<>gPayments.Fields[0].AsString then
  begin
    if (MonthCalendar1.Date<= dmShowUserSt.qContractInfo.FieldByName('CONTRACT_CANCEL_DATE').AsDateTime)
       and (MonthCalendar1.Date>= dmShowUserSt.qContractInfo.FieldByName('CONTRACT_DATE').AsDateTime) then
    begin

      SqlOra:=TOraQuery.Create(self);
      with SqlOra do
      begin
        try
          sql.Clear;
          sql.Add ('insert into many_logs ');
          sql.Add('(log_source_id, year_month, phone_number, date_on, text_messages,login_session)');
          sql.Add (' values(12, to_char(sysdate,''YYYYMM''),'+FPhoneNumber+', sysdate, ''изменение даты платежа №'+gPayments.Fields[2].AsString+' с '+gPayments.Fields[0].AsString+' на '+datetostr(MonthCalendar1.Date)+''','''+MainForm.OraSession.Username+''')');
          ExecSQL;
        except
          on e : exception do
            MessageDlg('Ошибка вставки записи в таблицу логирования (many_logs)', mtError, [mbOK], 0);
        end;

        try
          sql.Clear;
          sql.Add ('update db_loader_payments set PAYMENT_DATE=to_date('''+datetostr(MonthCalendar1.Date)+''',''dd.mm.yyyy'') where PHONE_NUMBER='+FPhoneNumber+' and ');
          sql.Add(' PAYMENT_DATE=to_date('''+gPayments.Fields[0].AsString+''',''dd.mm.yyyy'') and PAYMENT_SUM='+gPayments.Fields[1].AsString+' and PAYMENT_NUMBER='+gPayments.Fields[2].AsString);

         {sqltext:='update db_loader_payments set PAYMENT_DATE=to_date('''+datetostr(MonthCalendar1.Date)+''',''dd.mm.yyyy'') where PHONE_NUMBER='+FPhoneNumber+' and ';
         sqltext:=sqltext+' PAYMENT_DATE=to_date('''+gPayments.Fields[0].AsString+''',''dd.mm.yyyy'') and PAYMENT_SUM='+gPayments.Fields[1].AsString+' and PAYMENT_NUMBER='+gPayments.Fields[2].AsString;
         ShowMessage(sqltext); }

          ExecSQL;
        except
          on e : exception do
            MessageDlg('Ошибка изменения записи в таблицу загр.платежей (db_loader_payments)', mtError, [mbOK], 0);
        end;

      end;

      dmShowUserSt.qPayments.Refresh;
      MonthCalendar1.Visible:=false;
    end
    else
      MessageDlg('Выбанная вами дата лежит вне диапазова действия контракта. Для изменения даты выбрите другую дату.', mtError, [mbOK], 0);

  end
  else
    MessageDlg('Выбанная вами дата равна дате платежа. Для изменения даты выбрите другую дату.', mtError, [mbOK], 0);

end;

procedure TShowUserStatForm.MonthCalendar1MouseLeave(Sender: TObject);
begin
  MonthCalendar1.Visible:=false;
end;

end.


