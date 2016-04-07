unit Main;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Menus, ComCtrls, ActnList,
  DBAccess, OdacVcl, DB, Ora, ImgList, MemDS,Variants,MemData,CRGrid,
  Vcl.DBCGrids, Vcl.Grids, Vcl.DBGrids, DASQLMonitor, OraSQLMonitor, IniFiles, oraclasses,
  OraCall;

type
  TStr = record
    Name:String;
    Value:String;
  end;

  TMenu = record
    MENU_NAME:String;
    ACTIONLIST_NAME:String;
    IS_VISIBLE:integer;
    USER_NAME:string;
  end;

  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    WindowTileItem: TMenuItem;
    WindowCascadeItem: TMenuItem;
    WindowArrangeItem: TMenuItem;
    HelpContentsItem: TMenuItem;
    HelpSearchItem: TMenuItem;
    HelpHowToUseItem: TMenuItem;
    HelpAboutItem: TMenuItem;
    StatusLine: TStatusBar;
    N1: TMenuItem;
    N2: TMenuItem;
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
    N25: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    N30: TMenuItem;
    N31: TMenuItem;
    N32: TMenuItem;
    N33: TMenuItem;
    N34: TMenuItem;
    miLoadBeelinePayments: TMenuItem;
    miLoadBeelineStatus: TMenuItem;
    miLoadBeelineNachisl: TMenuItem;
    N38: TMenuItem;
    N39: TMenuItem;
    N40: TMenuItem;
    N41: TMenuItem;
    N42: TMenuItem;
    N43: TMenuItem;
    N44: TMenuItem;
    N45: TMenuItem;
    ActionList1: TActionList;
    aRefDocumTypes: TAction;
    aConnect: TAction;
    OraSession: TOraSession;
    ConnectDialog: TConnectDialog;
    ImageList32: TImageList;
    ImageList24: TImageList;
    aRefFilials: TAction;
    aRefUserNames: TAction;
    aRefCountries: TAction;
    aRefRegions: TAction;
    aRefPhoneBlocks: TAction;
    aRefAccounts: TAction;
    aRefTariffs: TAction;
    aRefOperators: TAction;
    aRefContractCancelTypes: TAction;
    aRefAbonents: TAction;
    aJornalAll: TAction;
    ImageList16: TImageList;
    aReportBalance: TAction;
    aReportActiveNumberNoContracts: TAction;
    aReportDiscounts: TAction;
    aRefStartBalances: TAction;
    aReportPhoneStat: TAction;
    aReportLoadingLogs: TAction;
    qCheckUserPrivileges: TOraQuery;
    aReportSummaryMinutes: TAction;
    aReportProfit: TAction;
    aReportNumWithoutAbonPay: TAction;
    aBlockJournal: TAction;
    aUnBlockJournal: TAction;
    aReportAbonPay: TAction;
    aSendSMSJournal: TAction;
    aReportPhonePayments: TAction;
    aRefTariffOptions: TAction;
    aReportTariffViolations: TAction;
    aReportPhoneNumberViolations: TAction;
    aRefSendSMSParametres: TAction;
    aRefSendMailParametres: TAction;
    aRefMailRecipients: TAction;
    aRefFixBalance: TAction;
    aSendSMSEndMonthJournal: TAction;
    miLoadBeeline: TMenuItem;
    aBeelineLoadPayments: TAction;
    aBeelineLoadStatuses: TAction;
    aBeelineLoadCosts: TAction;
    aRefDiscounts: TAction;
    aReportBills: TAction;
    N47: TMenuItem;
    N46: TMenuItem;
    aReportPhoneForBlockSave: TAction;
    N48: TMenuItem;
    aReportPhoneForUnblockSave: TAction;
    N49: TMenuItem;
    N50: TMenuItem;
    aReportDilerPayments: TAction;
    N51: TMenuItem;
    aBeelineLoadBaseStationMsk: TAction;
    aBeelineLoadBaseStationMO: TAction;
    miLoadBeelineKodBaseStat: TMenuItem;
    miLoadBeelineKodBaseStatMO: TMenuItem;
    N54: TMenuItem;
    aReportBalanceOnEndMonth: TAction;
    N55: TMenuItem;
    aRefForwardingPhoneNumber: TAction;
    N56: TMenuItem;
    aReportSityPhoneNumbers: TAction;
    N57: TMenuItem;
    aReportFieldDetails: TAction;
    N58: TMenuItem;
    miLoadBeelineBills: TMenuItem;
    aBeelineLoadBill: TAction;
    miLoadBeelineContract: TMenuItem;
    aBeelineLoadContracts: TAction;
    qConstants: TOraQuery;
    aRefPhoneWithDailyAbon: TAction;
    N61: TMenuItem;
    aReportAntiFraudBlocked: TAction;
    N62: TMenuItem;
    aReportAccountPhones: TAction;
    mniReportAccountPhones: TMenuItem;
    aReportUSSDSend: TAction;
    USSD1: TMenuItem;
    aReportPaymentWithoutContracts: TAction;
    N63: TMenuItem;
    aBeelineLoadClose: TAction;
    miLoadBeelineRastorzh: TMenuItem;
    N65: TMenuItem;
    aReportContractHandBlock: TAction;
    N66: TMenuItem;
    aReportKolNomFrm: TAction;
    aReportVirtualPaymets: TAction;
    N67: TMenuItem;
    N68: TMenuItem;
    Attention_btn: TSpeedButton;
    Timer1: TTimer;
    qBalanceChange: TOraQuery;
    N69: TMenuItem;
    aReportHotBillingDelay: TAction;
    N70: TMenuItem;
    aReportBalanceChange: TAction;
    Attention_btn1: TSpeedButton;
    qHBWArning: TOraQuery;
    qUserRigthsType_EncryptPwd: TOraQuery;
    aShowUserStat: TAction;
    N71: TMenuItem;
    aRefRightsTypeAccount: TAction;
    Attention_btn2: TSpeedButton;

    qLoadLog: TOraQuery;
    qParams: TOraQuery;
    qReadLog: TOraStoredProc;
    Attention_btn3: TSpeedButton;
    qHackers: TOraQuery;
    N72: TMenuItem;
    aRefCopyDatabase: TAction;
    N73: TMenuItem;
    aRefParameters: TAction;
    aBeelineLoadDetail: TAction;
    miLoadBeelineDetails: TMenuItem;
    aRefBlockPhoneNoContract: TAction;
    N75: TMenuItem;
    aRefAccountBillLoad: TAction;
    N76: TMenuItem;
    N77: TMenuItem;
    aShowHackers: TAction;
    aReportBillViols: TAction;
    N78: TMenuItem;
    aReportFinance: TAction;
    aReportFinance1: TMenuItem;
    aBeelineLoadMobiPay: TAction;
    miLoadBeelineMobiPay: TMenuItem;
    spFilialId: TOraStoredProc;
    N79: TMenuItem;
    aRefDopStatus: TAction;
    aReportYearBillsDayAbon: TAction;
    N80: TMenuItem;
    aReportDebitorka: TAction;
    N81: TMenuItem;
    aReportMobPay: TAction;
    MobPay1: TMenuItem;
    aRefAbonDiscountAndRassroch: TAction;
    N82: TMenuItem;
    aReportBillsNoDiscount: TAction;
    C201: TMenuItem;
    N83: TMenuItem;
    aRefDealers: TAction;
    aBeelineLoadChangeTariffs: TAction;
    miLoadBeelineChangeTp: TMenuItem;
    N85: TMenuItem;
    aReportAccountInfo: TAction;
    aReportPaymentPromised: TAction;
    N86: TMenuItem;
    aReportTariffOptionPhones: TAction;
    N87: TMenuItem;
    aReportMissingPhones: TAction;
    N88: TMenuItem;
    aReportBillNegative: TAction;
    N89: TMenuItem;
    aRefContractGroups: TAction;
    N90: TMenuItem;
    miLoadBeelineDopPhoneInfo: TMenuItem;
    aBeelineLoadDopPhoneInfo: TAction;
    aReportBalanceOnDate: TAction;
    N91: TMenuItem;
    qCheckROPrivileges: TOraQuery;
    N35: TMenuItem;
    N36: TMenuItem;
    Attention_btn4: TSpeedButton;
    ActionList2: TActionList;
    miBeelineLoaderSettings: TMenuItem;
    aBeelineLoaderSettings: TAction;
    aCollectorStates: TAction;
    N52: TMenuItem;
    miCollectorStates: TMenuItem;
    N37: TMenuItem;
    N59: TMenuItem;
    N110: TMenuItem;
    aRefTariffOptionBenefits: TAction;
    N53: TMenuItem;
    N60: TMenuItem;
    aReportFinanceHistoryPhoneActiv: TAction;
    N64: TMenuItem;
    aReportFinanceInflowOutflow: TAction;
    N74: TMenuItem;
    N84: TMenuItem;
    N92: TMenuItem;
    aReportFinanceSumBills: TAction;
    aReportSumPositiveBalance: TAction;
    N95: TMenuItem;
    N93: TMenuItem;
    N94: TMenuItem;
    aBeelineLoadChangeDopStatus: TAction;
    miLoadBeelineChangeDopStatus: TMenuItem;
    aRefTypePayments: TAction;
    aRefTypePayments1: TMenuItem;
    N96: TMenuItem;
    aReportPhoneInactivity: TAction;
    aBeelineLoadReceivedPayments: TAction;
    miLoadBeelineReceivedPayments: TMenuItem;
    aRefPhoneUsernameForm: TAction;
    N97: TMenuItem;
    aRefMNP: TAction;
    MNP1: TMenuItem;
    aRefVip_Abonents: TAction;
    VIP1: TMenuItem;
    aReportPaymentPassenger: TAction;
    miMob_pay: TMenuItem;
    V1: TMenuItem;
    miPhoneReport: TMenuItem;
    OraSQLMonitor1: TOraSQLMonitor;
    mRefInactivePhoneLessContract: TMenuItem;
    aRefInactivePhoneLessContract: TAction;
    miCurrentQueueSMS: TMenuItem;
    aReportCurrentQueueSMS: TAction;
    aReportPhoneOnBan: TAction;
    aReportPhoneOnBan1: TMenuItem;
    aReportAccount4Period: TAction;
    mniReportAccount4Period: TMenuItem;
    aReportAPIRejectBlocks: TAction;
    mniReportAPIRejectBlocks: TMenuItem;
    aReportHotBillingFiles: TAction;
    miReportHotBillingFiles: TMenuItem;
    aReportRecoveryCloseContracts: TAction;
    mniReportRecoveryCloseContracts: TMenuItem;

    Logs: TMenuItem;
    aReportChangeStatusPresaleBlock: TAction;
    mniReportChangeStatusPresaleBlock: TMenuItem;
    aReportReBlock: TAction;
    N98: TMenuItem;
    N99: TMenuItem;
    aReportLoadAccounts: TAction;
    mnReportLoadAccounts: TMenuItem;
    send_mail_detail: TOraStoredProc;
    qLoadLog_Error: TOraQuery;
    Timer2: TTimer;
    aReportPhonesRashod: TAction;
    N100: TMenuItem;
    aReportReceivables: TAction;
    aReportAccPay4Equip: TAction;
    N101: TMenuItem;
    N102: TMenuItem;
    aRefLoadBlockUnblock: TAction;
    miRefLoadBlockUnblock: TMenuItem;
    aBeelineLoadBlockUnblock: TAction;
    miLoadBeelineBlockUnblock: TMenuItem;

    procedure FormCreate(Sender: TObject);
    procedure ShowHint(Sender: TObject);
    procedure WindowTile(Sender: TObject);
    procedure WindowCascade(Sender: TObject);
    procedure WindowArrange(Sender: TObject);
    procedure HelpContents(Sender: TObject);
    procedure HelpSearch(Sender: TObject);
    procedure HelpHowToUse(Sender: TObject);
    procedure HelpAbout(Sender: TObject);
    procedure aRefDocumTypesExecute(Sender: TObject);
    procedure aConnectExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure aRefFilialsExecute(Sender: TObject);
    procedure aRefUserNamesExecute(Sender: TObject);
    procedure aRefCountriesExecute(Sender: TObject);
    procedure aRefRegionsExecute(Sender: TObject);
    procedure aRefPhoneBlocksExecute(Sender: TObject);
    procedure aRefAccountsExecute(Sender: TObject);
    procedure aRefServicesExecute(Sender: TObject);
    procedure aRefTariffsExecute(Sender: TObject);
    procedure aRefOperatorsExecute(Sender: TObject);
    procedure aRefContractCancelTypesExecute(Sender: TObject);
    procedure aRefAbonentsExecute(Sender: TObject);
    procedure aJornalAllExecute(Sender: TObject);
    procedure OraSessionAfterConnect(Sender: TObject);
    procedure aReportBalanceExecute(Sender: TObject);
    procedure aReportActiveNumberNoContractsExecute(Sender: TObject);
    procedure aReportDiscountsExecute(Sender: TObject);
    procedure aRefStartBalancesExecute(Sender: TObject);
    procedure aReportPhoneStatExecute(Sender: TObject);
    procedure aReportLoadingLogsExecute(Sender: TObject);
    procedure aReportSummaryMinutesExecute(Sender: TObject);
    procedure aReportProfitExecute(Sender: TObject);
    procedure aReportNumWithoutAbonPayExecute(Sender: TObject);
    procedure ProviredClick(Sender: TObject);
    procedure aBlockJournalExecute(Sender: TObject);
    procedure aUnBlockJournalExecute(Sender: TObject);
  //  procedure N32Click(Sender: TObject);
    procedure aReportAbonPayExecute(Sender: TObject);
    procedure aSendSMSJournalExecute(Sender: TObject);
    procedure aReportPhonePaymentsExecute(Sender: TObject);
    procedure aRefTariffOptionsExecute(Sender: TObject);
    procedure aReportTariffViolationsExecute(Sender: TObject);
    procedure aReportPhoneNumberViolationsExecute(Sender: TObject);
    procedure aRefSendSMSParametresExecute(Sender: TObject);
    procedure aRefSendMailParametresExecute(Sender: TObject);
    procedure aRefMailRecipientsExecute(Sender: TObject);
    procedure aRefFixBalanceExecute(Sender: TObject);
    procedure aSendSMSEndMonthJournalExecute(Sender: TObject);
    procedure aBeelineLoadPaymentsExecute(Sender: TObject);
    procedure aBeelineLoadBillExecute(Sender: TObject);
    procedure aBeelineLoadStatusesExecute(Sender: TObject);
    procedure aBeelineLoadCostsExecute(Sender: TObject);
    procedure CheckAdminPrivileges;
    function UserRightsType:integer;
    function Allow_account:integer;
    function CheckUser:string;
    function CheckAdminMenu(user_name, action_name:string):boolean;
    function CheckMenuAccess(user_name, action_name:string):boolean;
    procedure aRefDiscountsExecute(Sender: TObject);
    procedure aReportBillsExecute(Sender: TObject);
    procedure aReportPhoneForBlockSaveExecute(Sender: TObject);
    procedure aReportPhoneForUnblockSaveExecute(Sender: TObject);
    procedure aReportDilerPaymentsExecute(Sender: TObject);
    procedure aBeelineLoadBaseStationMskExecute(Sender: TObject);
    procedure aBeelineLoadBaseStationMOExecute(Sender: TObject);
    procedure aReportBalanceOnEndMonthExecute(Sender: TObject);
    procedure aRefForwardingPhoneNumberExecute(Sender: TObject);
    procedure aReportSityPhoneNumbersExecute(Sender: TObject);
    procedure aReportFieldDetailsExecute(Sender: TObject);
    procedure aBeelineLoadContractsExecute(Sender: TObject);
    procedure aRefPhoneWithDailyAbonExecute(Sender: TObject);
    procedure aReportAntiFraudBlockedExecute(Sender: TObject);
    procedure aReportAccountPhonesExecute(Sender: TObject);
    procedure aReportUSSDSendExecute(Sender: TObject);
    procedure aReportPaymentWithoutContractsExecute(Sender: TObject);
    procedure aBeelineLoadCloseExecute(Sender: TObject);
    procedure aReportContractHandBlockExecute(Sender: TObject);
    procedure aReportKolNomFrmExecute(Sender: TObject);
    procedure aReportVirtualPaymetsExecute(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Attention_btnClick(Sender: TObject);
    procedure aReportHotBillingDelayExecute(Sender: TObject);
    procedure aReportBalanceChangeExecute(Sender: TObject);
    procedure aShowUserStatExecute(Sender: TObject);
    procedure aRefRightsTypeAccountExecute(Sender: TObject);
    procedure Attention_btn2Click(Sender: TObject);
    procedure Attention_btn3Click(Sender: TObject);
    procedure aRefParametersExecute(Sender: TObject);
    procedure aRefCopyDatabaseExecute(Sender: TObject);
    procedure aBeelineLoadDetailExecute(Sender: TObject);
    procedure aRefBlockPhoneNoContractExecute(Sender: TObject);
    procedure aRefAccountBillLoadExecute(Sender: TObject);
    procedure aShowHackersExecute(Sender: TObject);
    procedure aReportBillViolsExecute(Sender: TObject);
    procedure aReportFinanceExecute(Sender: TObject);
    procedure aBeelineLoadMobiPayExecute(Sender: TObject);
    procedure aRefDopStatusExecute(Sender: TObject);
    procedure aReportYearBillsDayAbonExecute(Sender: TObject);
    procedure OraSessionConnectionLost(Sender: TObject; Component: TComponent;
      ConnLostCause: TConnLostCause; var RetryMode: TRetryMode);
    procedure aReportDebitorkaExecute(Sender: TObject);
    procedure aReportMobPayExecute(Sender: TObject);
    procedure aRefAbonDiscountAndRassrochExecute(Sender: TObject);
    procedure aReportBillsNoDiscountExecute(Sender: TObject);
    procedure aRefDealersExecute(Sender: TObject);
    procedure aBeelineLoadChangeTariffsExecute(Sender: TObject);
    procedure aReportAccountInfoExecute(Sender: TObject);
    procedure aReportPaymentPromisedExecute(Sender: TObject);
    procedure aReportTariffOptionPhonesExecute(Sender: TObject);
    procedure aReportMissingPhonesExecute(Sender: TObject);
    procedure aReportBillNegativeExecute(Sender: TObject);
    procedure aRefContractGroupsExecute(Sender: TObject);
    procedure aBeelineLoadDopPhoneInfoExecute(Sender: TObject);
    procedure aReportBalanceOnDateExecute(Sender: TObject);
    procedure StatusLineDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure N36Click(Sender: TObject);
    procedure aBeelineLoaderSettingsExecute(Sender: TObject);
    procedure aCollectorStatesExecute(Sender: TObject);
    procedure N37Click(Sender: TObject);
    procedure N59Click(Sender: TObject);
    procedure N110Click(Sender: TObject);
    procedure aRefTariffOptionBenefitsExecute(Sender: TObject);
    procedure aReportFinanceHistoryPhoneActivExecute(Sender: TObject);
    procedure aReportFinanceInflowOutflowExecute(Sender: TObject);
    procedure N84Click(Sender: TObject);
    procedure aReportFinanceSumBillsExecute(Sender: TObject);
    procedure aReportSumPositiveBalanceExecute(Sender: TObject);
    procedure N93Click(Sender: TObject);
    procedure N94Click(Sender: TObject);
    procedure aBeelineLoadChangeDopStatusExecute(Sender: TObject);
    procedure aRefTypePaymentsExecute(Sender: TObject);
    procedure aReportPhoneInactivityExecute(Sender: TObject);
    procedure aBeelineLoadReceivedPaymentsExecute(Sender: TObject);
    procedure aRefPhoneUsernameFormExecute(Sender: TObject);
    procedure aRefMNPExecute(Sender: TObject);
    procedure aRefVip_AbonentsExecute(Sender: TObject);
    procedure V1Click(Sender: TObject);
    procedure aReportPaymentPassengerExecute(Sender: TObject);
    procedure miPhoneReportClick(Sender: TObject);
    procedure aRefInactivePhoneLessContractExecute(Sender: TObject);
    procedure aReportCurrentQueueSMSExecute(Sender: TObject);
    procedure aReportPhoneOnBanExecute(Sender: TObject);
    procedure aReportAccount4PeriodExecute(Sender: TObject);
    procedure aReportAPIRejectBlocksExecute(Sender: TObject);
    procedure aReportHotBillingFilesExecute(Sender: TObject);
    procedure aReportRecoveryCloseContractsExecute(Sender: TObject);
    procedure aReportChangeStatusPresaleBlockExecute(Sender: TObject);
    procedure aReportReBlockExecute(Sender: TObject);
    procedure aReportLoadAccountsExecute(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure aReportPhonesRashodExecute(Sender: TObject);
    procedure aReportReceivablesExecute(Sender: TObject);
    procedure aReportAccPay4EquipExecute(Sender: TObject);
    procedure aRefLoadBlockUnblockExecute(Sender: TObject);
    procedure aBeelineLoadBlockUnblockExecute(Sender: TObject);
  private
    FFilialId :  integer;
  public
    FFilial: integer;
    IsMonitorRun: boolean;
    IsMonitorEvRun: boolean;
    FUserRightsType:integer;
    FIsAdmin:integer;
    FCheckAllow:integer;
    FUseFilialBlockAccess: boolean;
    FConnected : Boolean;
    FConstantSettings : array of TStr;
    FConstantSettingsCount : integer;
    FParamSettings : array of TStr;
    FParamSettingsCount : integer;
    FUser: string;
    procedure CheckAdminPrivs(var IsAdmin: Boolean);
    procedure CheckROPrivs(var IsRO: Boolean);
    function encrypt_password:boolean;
  end;

var
  MainForm: TMainForm;
  api,e_care,old_cab:integer;

implementation

{$r *.dfm}

uses RefDocumTypesFrm, RefFilials, RefUserNames, RefCountries, RefRegions,
  RefPhoneBlocks, RefAccounts, RefServices, RefTariffs, RefOperators,
  RefContractCancelTypes, RefAbonents, JornalAll, ReportBalance,
  ReportActiveNumberNoContracts, ReportDiscounts, RefStartBalances,
  ReportPhoneStat, ReportPhonePayments, ReportSummaryMinutes, ReportProfit,
  ReportNumWithoutAbonPay, RefSendSMSParametres, ReportSendSms, BlockList,
  UnBlockList, ReportAbonPay, RefTariffOptions, ContractsRegistration_Utils,
  ReportTariffViolations, ReportPhoneNumberViolations, RefSendMailParametres,
  RefMailRecipients, RefFixingBalances, ReportSendSmsEndMonth, BeelineLoadFrm,
  RefDiscounts, ReportBills, ReportPhoneForBlockSave, ReportPhoneForUnblockSave,
  ReportBalanceOnEndMonth, RefForwardingSMS, ReportSityPhoneNumbers,
  ReportFieldDetails, JornalAllFilter, MonitorEvents,
  ReportAntiFraudBlocked, ReportAccountPhones,ReportUSSDSend, LoadDetail,
  ReportPaymentWithoutContracts, ReportKolNom, ReportContractHandBlock,
  ReportVirtualPayments, ShowBalanceChange,ReportHotBillingDelay,ReportBalanceChange,
  SelectContract, ShowUserStat, RefRightsTypeAccount,ShowHackers, RefParameters,
  RefCopyDatabase, ChangePassword, RefAutoBlockPhoneNoContract, RefAccountBillLoad,
  ReportBillViols, ReportFinanceModule, RefDopStatusFrm, ReportYearBilssDayAbon,
  ReportDebitorka, ReportMobPayments, RefAbonDiscountAndRassroch,
  ReportBillNoDiscountYear, RefDealersFrm, ChangeTariffArray, ReportAccountInfo,
  ReportPaymentsPromised, ReportTariffOptionPhones, ReportMissingPhones, ReportBillNegative,
  RefContractGroups, ReportBalancesOnDate,RefPhonesWithDailyAbon,MonitorServices,
  RefAllSendMail,RefAllLogs, ReportDopStatus, DMUnit, RefTariffOptionBenefits,
  ReportFinanceHistoryPhoneActiv, ReportFinanceInflowOutflow, RepCalcBalance, ReportFinanceSumBills,
  RepPhoneWhisContract, RepAllPhones,ReportSumPositiveBalance, ChangeDopStatusArray, PaymentTypesFrm,
  ReportPhoneInactivity, RegisterPaymentsArray, RefPhoneUsername,refMNP,refvip_abonents, ReportPaymentPassenger,
  ReportListPhones, RefInactivePhoneLessCont, ReportCurrentQueueSMS ,
  ReportPhoneOnBan, ReportAccountPeriod, ReportAPIRejectBlocks, ReportHotBillingFiles,
  ReportRecoveryCloseContracts, ReportChangeStatusPresaleBlock, ReportPhoneReBlock,
  ReportLoadAccounts, RepRaschodPhones, ReportAccPay4Equip, ReportReceivables,
  RefLoadBlockUnblock;

  var     f1 : TMonitorServ;
          f2 : TMonitorEv;


procedure TMainForm.FormCreate(Sender: TObject);
begin
//регистрация горячих клавиш

//--------------------------
IsMonitorRun:=false;
IsMonitorEvRun:=false;
  Application.OnHint := ShowHint;
  with Attention_btn do
    begin
      Parent := StatusLine;
      Top := 2;
      Left := 2;
      Height := Statusline.Height - Top;
      Width := statusline.Panels[0].Width-left;
      hint:='ВНИМАНИЕ!!! Снижение баланса.';
      visible:=false;
    end;
   with Attention_btn1 do
    begin
      Parent := StatusLine;
      Top := 2;
      Left := statusline.Panels[0].Width+2;
      Height := Statusline.Height - Top;
      Width := statusline.Panels[1].Width-2;
      hint:='ВНИМАНИЕ!!! Задержка горячего биллинга.';
      visible:=false;
    end;
   with Attention_btn2 do
    begin
      Parent := StatusLine;
      Top := 2;
      Left := statusline.Panels[0].Width+statusline.Panels[1].Width+2;
      Height := Statusline.Height - Top;
      Width := statusline.Panels[2].Width-2;
      visible:=false;
    end;

   with Attention_btn3 do         // 7.11.12 г. А. Пискунов
    begin
      Parent := StatusLine;
      Top := 2;
      Left := statusline.Panels[0].Width+statusline.Panels[1].Width+statusline.Panels[2].Width+2;
      Height := Statusline.Height - Top;
      Width := statusline.Panels[3].Width-2;
      hint:='ВНИМАНИЕ!!! Обнаружены мошенники!';
      visible:=False;
    end;
    FUserRightsType:=-1;
    FIsAdmin:=-1;
    FCheckAllow:=-1;
    api:=0;old_cab:=0;e_care:=0;
end;

procedure TMainForm.ShowHint(Sender: TObject);
begin
  StatusLine.panels[4].Text := Application.Hint;
end;

procedure TMainForm.StatusLineDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
     with StatusLine.Canvas do
               begin
                 case Panel.Index of
                   5: //API
                   begin
                     //Brush.Color := clRed;
                     if api=0 then
                       begin
                       Font.Color := clRed;
                       Font.Style := [fsBold];
                       end
                     else
                       begin
                       Font.Color := clGreen;
                       Font.Style := [];
                       end;
                   end;
                   6: //e-care
                   begin
                     //Brush.Color := clRed;
                     if e_care=0 then
                       begin
                       Font.Color := clRed;
                       Font.Style := [fsBold];
                       end
                     else
                       begin
                       Font.Color := clGreen;
                       Font.Style := [];
                       end;
                   end;
                   7: //cabinet.beeline.ru
                   begin
                     //Brush.Color := clRed;
                     if old_cab=0 then
                       begin
                       Font.Color := clRed;
                       Font.Style := [fsBold];
                       end
                     else
                       begin
                       Font.Color := clGreen;
                       Font.Style := [];
                       end;
                   end;
                 end;
             //Panel background color
             FillRect(Rect) ;

             //Panel Text
             TextRect(Rect,2 +Rect.Left, 10 + Rect.Top,Panel.Text) ;
   end;
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
var
  hint:string;
  Qora:TOraQuery;
  iLeft,iTop,iRight,iBottom,i:integer;
begin
if UserRightsType <> 3 then  begin
 if (GetConstantValue('DO_CHECK_BALANCE_CHANGE')='1') then begin
   qBalanceChange.Open;
   if (qBalanceChange.FieldByName('cnt').AsInteger > 0)
   then Attention_btn.Visible:=true
   else Attention_btn.Visible:=false;
   qBalanceChange.close;
 end;

 if (GetConstantValue('DO_CHECK_HOT_BIL_LOAD_LOG')='1') then begin
  //Проверка наличия ошибок в загрузках.
  qReadLog.ExecSQL;
  if qReadLog.ParamByName('Result').AsInteger = 1
  then hint:=hint+' Закончилась память на сервере.';
 end;

 if (GetConstantValue('DO_CHECK_LOAD_LOG')='1') then begin
//  qLoadLog.ParamByName('LOAD_LOGS_TIME_ERR').AsInteger:=strtoint(GetParamValue('LOAD_LOGS_TIME_ERR'));
//  qLoadLog.ParamByName('DAY_LOAD_BILLS_ERR').AsInteger:=strtoint(GetParamValue('DAY_LOAD_BILLS_ERR'));
  qLoadLog.Open;
  if qLoadLog.RecordCount > 0
  then hint:=hint+' Ошибки при загрузке платежей или отчетов по начислениям или в тек.месяце нет загруженных счетов.';
  qLoadLog.Close;
 end;
 if hint <> ''
 then Attention_btn2.Visible:=true
 else Attention_btn2.Visible:=false;
 Attention_btn2.Hint:='ВНИМАНИЕ!!!'+hint;


 if (GetConstantValue('DO_CHECK_HACKERS')='1') then begin
  qHackers.Open;
  if qHackers.FieldByName('cnt').AsInteger > 0
  then Attention_btn3.Visible:=true
  else Attention_btn3.Visible:=false;
  qHackers.Close;
 end;

  if (GetConstantValue('SERVER_NAME')='CORP_MOBILE') or (GetConstantValue('SERVER_NAME')='GSM_CORP') then
  begin
  StatusLine.Panels[5].Text:='API';
  StatusLine.Panels[6].Text:='e-Care';
  StatusLine.Panels[7].Text:='С.каб.';
    try
    qOra:=TOraQuery.Create(nil);
        with qOra do begin
         sql.Text:='select * from v_status_bar_loader_test';
         Execute;
         api:=FieldByName('api').AsInteger;
         e_care:=FieldByName('e_care').AsInteger;
         old_cab:=FieldByName('old_cab').AsInteger;
        end;
    finally
      qOra:=nil;
    end;

  for I := 0 to StatusLine.Panels.Count-1 do  begin
                  iLeft:=StatusLine.Left+iRight;
                  iTop:=StatusLine.Top;
                  iRight:=iRight+StatusLine.Panels[i].Width;
                  iBottom:=StatusLine.Top+StatusLine.Height;
                  StatusLineDrawPanel(StatusLine,StatusLine.Panels[i],Rect(iLeft,iTop,iRight,iBottom));

  end;
      end;
end;
  if (GetConstantValue('DO_CHECK_HOT_BIL_LOAD')='1') then begin
  qHBWArning.Open;
  if qHBWArning.FieldByName('cnt').AsInteger>0
  then Attention_btn1.Visible:=true
  else Attention_btn1.Visible:=false;
  qHBWArning.close;
 end;
 timer1.Enabled:=false;
end;

procedure TMainForm.Timer2Timer(Sender: TObject);
var
  FStringStream: TStringStream;
  s:string;
  OraQuery:TOraQuery;
  function Td(S: string): string;
  begin
    Result:='<td>'+S+'</td>';
  end;
begin
 try
   FStringStream:=TStringStream.Create;
   qLoadLog_Error.ParamByName('INTERVAL_CHECK_LOG_ERROR').AsInteger:=StrToInt(GetConstantValue('INTERVAL_CHECK_LOG_ERROR'));
   qLoadLog_Error.open;
   if qLoadLog_Error.RecordCount > 0 then
   begin
      FStringStream.Position:=0;
      FStringStream.WriteString('<html><body>');
      FStringStream.WriteString('<h1>Ошибки загрузки</h1>');
      //Формирование заголовков столбцов
      FStringStream.WriteString('<table cellpadding="10" cellspacing="0" style="border:#666666 1px solid;">');
      FStringStream.WriteString('<tr style="font-weight: bold">');
      FStringStream.WriteString(Td('Л/с'));
      FStringStream.WriteString(Td('Ошибка')+'</tr>');

      while not qLoadLog_Error.Eof do begin
        FStringStream.WriteString('<tr>'+Td(qLoadLog_Error.FieldByName('login').AsString));
        if qLoadLog_Error.FieldByName('account_load_type_id').AsInteger = 1 then
          FStringStream.WriteString(Td('Не загружаются платежи.')+'</tr>');
        if qLoadLog_Error.FieldByName('account_load_type_id').AsInteger = 6 then
          FStringStream.WriteString(Td('Не загружаются отчеты по начислениям.')+'</tr>');
        if qLoadLog_Error.FieldByName('account_load_type_id').AsInteger = 5 then
          FStringStream.WriteString(Td('В тек.месяце нет загруженных счетов.')+'</tr>');
        if qLoadLog_Error.FieldByName('account_load_type_id').AsInteger = 7 then
          FStringStream.WriteString(Td('В тек.месяце нет загруженных детальных счетов.')+'</tr>');

        qLoadLog_Error.Next;
      end;
      FStringStream.WriteString('</table></body></html>');
      //Задание параметров и отправка письма с прикрепленным файлом
      send_mail_detail.ParamByName('RECIPIENT').AsString:=GetConstantValue('MAIL_LOG_ERROR');
      DateTimeToString(s,'hh:nn:ss dd.mm.yyyy',now);
      send_mail_detail.ParamByName('MESSAGE_TITLE').AsString:='Ошибки загрузок '+s;
      FStringStream.Position := 0;
      send_mail_detail.ParamByName('MAIL_TEXT').AsOraClob.OCISvcCtx := MainForm.OraSession.OCISvcCtx;
      send_mail_detail.ParamByName('MAIL_TEXT').AsOraClob.CreateTemporary(ltClob);
      send_mail_detail.ParamByName('MAIL_TEXT').AsOraClob.LoadFromStream(FStringStream);
      send_mail_detail.ParamByName('MAIL_TEXT').AsOraClob.WriteLob;
      try
        send_mail_detail.ExecSQL;
      except
        on E : Exception do
          MessageDlg('Ошибка при отправке ошибок загрузки.'#13#10 + E.Message , mtError, [mbOK], 0);
      end;
      send_mail_detail.ParamByName('MAIL_TEXT').AsOraClob.FreeLob;
      //Добавление записи в лог
      try
        OraQuery:=TOraQuery.Create(nil);
        OraQuery.Session:=OraSession;
        OraQuery.SQL.Text:='INSERT INTO log_send_mail_error (date_send, note) VALUES(SYSDATE, :note)';
        OraQuery.Prepare;
        OraQuery.ParamByName('note').AsString:=GetConstantValue('MAIL_LOG_ERROR');
        OraQuery.ExecSQL;
        OraSession.Commit;
      finally
        OraQuery.Free;
      end;
   end;
 finally
   FStringStream.Free;
   qLoadLog_Error.Close;
 end;
end;

procedure TMainForm.WindowTile(Sender: TObject);
begin
  Tile;
end;

procedure TMainForm.WindowCascade(Sender: TObject);
begin
  Cascade;
end;

procedure TMainForm.WindowArrange(Sender: TObject);
begin
  ArrangeIcons;
end;

procedure TMainForm.HelpContents(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTENTS, 0);
end;

procedure TMainForm.HelpSearch(Sender: TObject);
const
  EmptyString: PChar = '';
begin
  Application.HelpCommand(HELP_PARTIALKEY, Longint(EmptyString));
end;

procedure TMainForm.N110Click(Sender: TObject);
       var
  RefFrm : TReportDopStatusForm;
begin
  RefFrm := TReportDopStatusForm.Create(Application);

end;

procedure TMainForm.N36Click(Sender: TObject);
begin
 if not IsMonitorRun then begin
  // CheckAdminPrivileges;
  f1 := TMonitorServ.Create(Application);
  MainForm.IsMonitorRun:=true;
  f1.FormStyle := fsMDIChild;
 end
 else begin
  f1.FormActivate(self);
 end;
end;

procedure TMainForm.N37Click(Sender: TObject);
var
  RefFrm : TRefAllSendMailForm;
begin
  RefFrm := TRefAllSendMailForm.Create(Application);
end;

procedure TMainForm.N59Click(Sender: TObject);
var
  RefFrm : TRefAllLogsForm;
begin
  RefFrm := TRefAllLogsForm.Create(Application);

end;

procedure TMainForm.N84Click(Sender: TObject);
 var
  RefFrm1 : TRepCalcBalanceFRM;
begin
//  RefFrm1 := TRepCalcBalanceFRM.Create(Application);
DoRepCalcBalance;

end;

procedure TMainForm.N93Click(Sender: TObject);
begin
DoRepPhoneWhisContract;
end;

procedure TMainForm.N94Click(Sender: TObject);
begin
DoRepAllPhones;
end;

procedure TMainForm.miPhoneReportClick(Sender: TObject);
begin  // Списковый отчет
  fReportListPhones := TfReportListPhones.Create(Nil);
  try
    fReportListPhones.ShowModal;
  finally
    fReportListPhones.Free;
  end;
end;

procedure TMainForm.HelpHowToUse(Sender: TObject);
begin
  Application.HelpCommand(HELP_HELPONHELP, 0);
end;

procedure TMainForm.HelpAbout(Sender: TObject);
begin

  { Add code to show program's About Box }
end;

procedure TMainForm.aReportReBlockExecute(Sender: TObject);
begin
  TReportPhoneReBlockForm.Create(Application).Execute('', False);
end;

procedure TMainForm.aReportReceivablesExecute(Sender: TObject);
begin
  CheckAdminPrivileges;
  DoReportReceivables;
end;

procedure TMainForm.aReportRecoveryCloseContractsExecute(Sender: TObject);
begin
  DoReportRecoveryCloseContracts;
end;

procedure TMainForm.aBeelineLoadBaseStationMOExecute(Sender: TObject);
var
  f : TBeelineLoadForm;
begin
  CheckAdminPrivileges;
  f := TBeelineLoadBS_MO_Form.Create(Application);
  try
    f.Execute;
  finally
    FreeAndNil(f);
  end
end;

procedure TMainForm.aBeelineLoadBaseStationMskExecute(Sender: TObject);
var
  f : TBeelineLoadForm;
begin
  CheckAdminPrivileges;
  f := TBeelineLoadBS_Msk_Form.Create(Application);
  try
    f.Execute;
  finally
    FreeAndNil(f);
  end
end;

procedure TMainForm.aBeelineLoadCostsExecute(Sender: TObject);
var
  f : TBeelineLoadForm;
begin
  CheckAdminPrivileges;
  f := TBeelineLoadCostsForm.Create(Application);
  try
    f.Execute;
  finally
    FreeAndNil(f);
  end
end;

procedure TMainForm.aBeelineLoadDetailExecute(Sender: TObject);
begin
  DoLoadDetail;
end;

procedure TMainForm.aBeelineLoadMobiPayExecute(Sender: TObject);
var
  f : TBeelineLoadForm;
begin
  CheckAdminPrivileges;
  f := TBeelineLoadMobiPayForm.Create(Application);
  try
    f.Execute;
  finally
    FreeAndNil(f);
  end
end;

procedure TMainForm.aBeelineLoadBillExecute(Sender: TObject);
var
  f : TBeelineLoadForm;
begin
  CheckAdminPrivileges;
  f := TBeelineLoadBillForm.Create(Application);
  try
    f.Execute;
  finally
    FreeAndNil(f);
  end
end;

procedure TMainForm.aBeelineLoadBlockUnblockExecute(Sender: TObject);
var
  f : TBeelineLoadForm;
begin
  CheckAdminPrivileges;
  f := TBeelineLoadBlockForm.Create(Application);
  try
    f.Execute;
  finally
    FreeAndNil(f);
  end
end;

procedure TMainForm.aBeelineLoadChangeDopStatusExecute(Sender: TObject);
var RefForm: TChangeDopStatusArrayForm;
begin
  CheckAdminPrivileges;
  RefForm:=TChangeDopStatusArrayForm.Create(Application);
  try
    RefForm.ShowModal;
  finally
    RefForm.Free;
  end;
end;

procedure TMainForm.aBeelineLoadChangeTariffsExecute(Sender: TObject);
var RefForm: TChangeTariffArrayForm;
begin
  CheckAdminPrivileges;
  RefForm:=TChangeTariffArrayForm.Create(Application);
  try
    RefForm.ShowModal;
  finally
    RefForm.Free;
  end;
end;

procedure TMainForm.aBeelineLoadCloseExecute(Sender: TObject);
var
  f : TBeelineLoadForm;
begin
  CheckAdminPrivileges;
  f := TBeelineLoadCloseForm.Create(Application);
  try
    f.Execute;
  finally
    FreeAndNil(f);
  end
end;

procedure TMainForm.aBeelineLoadContractsExecute(Sender: TObject);
var
  f : TBeelineLoadForm;
  qFilial:TORaQuery;
begin

  CheckAdminPrivileges;
  qFilial := ToRaQuery.Create(Self);
  qFilial.SQL.Text := 'select min(filial_id) as FILL from filials';
  qFilial.ExecSQL;
  FFilialId := qFilial.FieldByName('FILL').AsInteger;
  qFilial.Destroy;
  if IntToStr(FFilialId) = '' then
  begin
    MessageDlg('Для добавления документа необходимо сначала выбрать филиал в фильтре', mtConfirmation, [mbOK], 0);
  end
  else
  begin
    f := TBeelineLoadContractsForm.Create(Application);
    f.FFilialId := FFilialId;
    try
      f.Execute;
    finally
      FreeAndNil(f);
    end
  end;
end;

procedure TMainForm.aBeelineLoadPaymentsExecute(Sender: TObject);
var
  f : TBeelineLoadForm;
begin

  CheckAdminPrivileges;
  f := TBeelineLoadPaymentsForm.Create(Application);
  try
    f.Execute;
  finally
    FreeAndNil(f);
  end
end;

procedure TMainForm.aBeelineLoadReceivedPaymentsExecute(Sender: TObject);
var
  f : TRegisterPaymentsArrayForm;
begin

  CheckAdminPrivileges;
  f := TRegisterPaymentsArrayForm.Create(Application);
  try
    f.ShowModal;
  finally
    FreeAndNil(f);
  end
end;

procedure TMainForm.aBeelineLoadStatusesExecute(Sender: TObject);
var
  f : TBeelineLoadForm;
begin
  CheckAdminPrivileges;
  f := TBeelineLoadStatusesForm.Create(Application);
  try
    f.Execute;
  finally
    FreeAndNil(f);
  end
end;

procedure TMainForm.aBlockJournalExecute(Sender: TObject);
begin
  TBlockListFrm.Create(Application).Execute('', False);
end;

procedure TMainForm.aCollectorStatesExecute(Sender: TObject);
var
  f : TBeelineLoadForm;
begin
  CheckAdminPrivileges;
  f := TBeelineCollectorStatesForm.Create(Application);
  try
    f.Execute;
  finally
    FreeAndNil(f);
  end

end;

procedure TMainForm.aConnectExecute(Sender: TObject);
var
  Ini: TIniFile;
begin
  OraSQLMonitor1.Active := False;
  try
    Ini := TIniFile.Create( ChangeFileExt( Application.ExeName, '.INI' ) ); // ParamStr(0)
    try
      OraSQLMonitor1.Active := ('1' = Ini.ReadString('CONNECT', 'DEBUG', '0'));
    finally
      Ini.Free;
    end;
  except // глотаем ошибку
    //
  end;
  OraSession.Connected := False;
  OraSession.Connected := True;
end;

procedure TMainForm.aReportCurrentQueueSMSExecute(Sender: TObject);
var
  fReportCurrentQueueSMS : TfReportCurrentQueueSMS;
begin
  fReportCurrentQueueSMS := TfReportCurrentQueueSMS.Create(nil);
  try
    fReportCurrentQueueSMS.Execute (OraSession);
  finally
    FreeAndNil(fReportCurrentQueueSMS);
  end;
end;

procedure TMainForm.aRefInactivePhoneLessContractExecute(Sender: TObject);
var RefFrm:TRefInactivePhoneLessContForm;
begin
//  CheckAdminPrivileges;
  if CheckMenuAccess(OraSession.Username,'aRefInactivePhoneLessContract') then begin
    RefFrm := TRefInactivePhoneLessContForm.Create(Application);
    RefFrm.FormStyle := fsMDIChild;
  end
  else
  MessageDlg('Доступ к справочнику запрещен!', mtError, [mbOK], 0);
end;

procedure TMainForm.aRefLoadBlockUnblockExecute(Sender: TObject);
begin
  CheckAdminPrivileges;
  DoRefLoadBlockUnblock;
end;

function TmainForm.CheckMenuAccess(user_name, action_name:string):boolean;
var
  i:integer;
begin
  result:=false;
  with dm do
  begin
    qMenuAccess.Close;
    qMenuAccess.ParamByName('USER_NAME').AsString:=UpperCase(user_name);
    qMenuAccess.Open;
    for i := 1 to qMenuAccess.RecordCount do
    begin
      if ( UpperCase(qMenuAccess.FieldByName('ACTIONLIST_NAME').AsString) = UpperCase(action_name) ) and
         ( qMenuAccess.FieldByName('IS_VISIBLE').AsString = '1' ) then begin
        exit(true);
      end;
      qMenuAccess.Next;
    end;
    qMenuAccess.Close;
  end;

end;

procedure TMainForm.aBeelineLoadDopPhoneInfoExecute(Sender: TObject);
var
  f : TBeelineLoadForm;
begin
  CheckAdminPrivileges;
  f := TBeelineLoadDopPhoneInfo.Create(Application);
  try
    f.Execute;
  finally
    FreeAndNil(f);
  end
end;

procedure TMainForm.aBeelineLoaderSettingsExecute(Sender: TObject);
var
  f : TBeelineLoadForm;
begin
  CheckAdminPrivileges;
  f := TBeelineLoaderSettings.Create(Application);
  try
    f.Execute;
  finally
    FreeAndNil(f);
  end

end;

procedure TMainForm.aRefCopyDatabaseExecute(Sender: TObject);
var RefFrmCopy : TRefCopyDataBaseForm;
begin
  CheckAdminPrivileges;
  RefFrmCopy := TRefCopyDataBaseForm.Create(Application);
  RefFrmCopy.FormStyle := fsMDIChild;
end;

procedure TMainForm.aShowHackersExecute(Sender: TObject);
begin
  DoShowHackers;
end;

procedure TMainForm.aShowUserStatExecute(Sender: TObject);
var
  vPhoneNumber : String;
  vContractID : Integer;

begin
  SelectPhoneNumber(vPhoneNumber, vContractID);
  if vPhoneNumber <> '' then
    ShowUserStatByPhoneNumber(vPhoneNumber,vContractID);
end;


procedure TMainForm.aReportUSSDSendExecute(Sender: TObject);
begin
DoReportUSSDSend;
end;

procedure TMainForm.aReportVirtualPaymetsExecute(Sender: TObject);
begin
  DoReportVirtualPayments;
end;

procedure TMainForm.aReportYearBillsDayAbonExecute(Sender: TObject);
begin
  DoReportYearBilssDayAbon;
end;

procedure TMainForm.aRefSendMailParametresExecute(Sender: TObject);
var RefFrm: TSendMailParametresFrm;
begin
  CheckAdminPrivileges;
  RefFrm := TSendMailParametresFrm.Create(Application);
  RefFrm.FormStyle := fsMDIChild;
  RefFrm.aRefresh.Execute;
end;

procedure TMainForm.aSendSMSEndMonthJournalExecute(Sender: TObject);
begin
  TReportSendSmsEndMonthFrm.Create(Application).FormStyle := fsMDIChild;
end;

procedure TMainForm.aSendSMSJournalExecute(Sender: TObject);
begin
  TReportSendSmsFrm.Create(Application).FormStyle := fsMDIChild;
end;

procedure TMainForm.Attention_btn2Click(Sender: TObject);
var
 login,mess1,mess6,mess5,mess7,mess_jobs:string;
 cnt1,cnt6,cnt5,cnt7,cnt_jobs:integer;
 f:tform;
 p:TPageControl;
begin
  //Получает кол-во и полный текст ошибок на разный тип загрузок в разрезе л/с
//  qLoadLog.ParamByName('LOAD_LOGS_TIME_ERR').AsInteger:=strtoint(GetParamValue('LOAD_LOGS_TIME_ERR'));
//  qLoadLog.ParamByName('DAY_LOAD_BILLS_ERR').AsInteger:=strtoint(GetParamValue('DAY_LOAD_BILLS_ERR'));
  qLoadLog.Open;
  while not qLoadLog.Eof do begin
    login:=qLoadLog.FieldByName('login').AsString;
    //Ошибки при загрузках или нет загрузок
    if not (copy(qLoadLog.FieldByName('login').AsString,0,2)='J_') then
      if qLoadLog.FieldByName('cnt').AsInteger = 0 then  begin
        if qLoadLog.FieldByName('account_load_type_id').AsInteger = 1 then begin
          mess1:=mess1+login+' - Не загружаются платежи.'+#13#10;
          inc(cnt1);
        end;
        if qLoadLog.FieldByName('account_load_type_id').AsInteger = 6 then begin
          mess6:=mess6+login+' - Не загружаются отчеты по начислениям.'+#13#10;
          inc(cnt6);
        end;
        if qLoadLog.FieldByName('account_load_type_id').AsInteger = 5 then begin
          mess5:=mess5+login+' - В тек.месяце нет загруженных счетов.'+#13#10;
          inc(cnt5);
        end;
        if qLoadLog.FieldByName('account_load_type_id').AsInteger = 7 then begin
          mess7:=mess7+login+' - В тек.месяце нет загруженных детальных счетов.'+#13#10;
          inc(cnt7);
        end;
      end
      else begin
        if qLoadLog.FieldByName('account_load_type_id').AsInteger = 1 then begin
          mess1:=mess1+login+' - Ошибки при загрузке платежей.'+#13#10;
          inc(cnt1);
        end;
        if qLoadLog.FieldByName('account_load_type_id').AsInteger = 6 then begin
          mess6:=mess6+login+' - Ошибки при загрузке отчетов по начислениям.'+#13#10;
          inc(cnt6);
        end;
      end
    //Есть незапущенные задания
    else begin
      mess_jobs:=mess_jobs+login+' - Задание не запущено.'+#13#10;
      inc(cnt_jobs);
    end;
    qLoadLog.Next;
  end;
  qLoadLog.Close;
  //Создаем и показываем форму с ошибками
  f:=tform.Create(application);
  f.Caption:='Ошибки';
  f.Width:=600;
  f.Height:=400;
  f.BorderStyle:=bsSingle;
  p:=tpagecontrol.Create(application);
  p.Parent:=f;
  p.Align:=alclient;
  //Вкладка ПЛАТЕЖИ
  with TTabSheet.Create(p) do begin
    Visible:=true;
    PageControl:=p;
    Caption:='Платежи('+inttostr(cnt1)+')';
  end;
  with tmemo.Create(application) do begin
    Color:=clBtnFace;
    BorderStyle:=bsNone;
    readonly:=true;
    Parent:=P.Pages[0];
    Text:=mess1;
    Align:=alclient;
    scrollbars:=ssvertical
  end;
  //Вкладка ОТЧЕТЫ ПО НАЧИСЛЕНИЯМ
  with TTabSheet.Create(p) do begin
    Visible:=true;
    PageControl:=p;
    Caption:='Отчеты по начислениям('+inttostr(cnt6)+')';
  end;
  with tmemo.Create(application) do begin
    Color:=clBtnFace;
    BorderStyle:=bsNone;
    readonly:=true;
    Parent:=P.Pages[1];
    Text:=mess6;
    Align:=alclient;
    scrollbars:=ssvertical
  end;
  //Вкладка СЧЕТА
  with TTabSheet.Create(p) do begin
    Visible:=true;
    PageControl:=p;
    Caption:='Счета('+inttostr(cnt5)+')';
  end;
  with tmemo.Create(application) do begin
    Color:=clBtnFace;
    BorderStyle:=bsNone;
    readonly:=true;
    Parent:=P.Pages[2];
    Text:=mess5;
    Align:=alclient;
    scrollbars:=ssvertical
  end;
  //Вкладка ДЕТАЛЬНЫЕ СЧЕТА
  with TTabSheet.Create(p) do begin
    Visible:=true;
    PageControl:=p;
    Caption:='Детальные счета('+inttostr(cnt7)+')';
  end;
  with tmemo.Create(application) do begin
    Color:=clBtnFace;
    BorderStyle:=bsNone;
    readonly:=true;
    Parent:=P.Pages[3];
    Text:=mess7;
    Align:=alclient;
    scrollbars:=ssvertical
  end;
  //Вкладка НЕЗАПУЩЕННЫЕ ЗАДАНИЯ
  with TTabSheet.Create(p) do begin
    Visible:=true;
    PageControl:=p;
    Caption:='Незапущенные задания('+inttostr(cnt_jobs)+')';
  end;
  with tmemo.Create(application) do begin
    Color:=clBtnFace;
    BorderStyle:=bsNone;
    readonly:=true;
    Parent:=P.Pages[4];
    Text:=mess_jobs;
    Align:=alclient;
    scrollbars:=ssvertical
  end;

  // Первоначально синхронизируем Tab с правильной страницей
  P.ActivePage := P.Pages[1];
  P.ActivePage := P.Pages[0];
  f.ShowModal;
end;

procedure TMainForm.Attention_btn3Click(Sender: TObject);
begin
  DoShowHackers;
end;

procedure TMainForm.Attention_btnClick(Sender: TObject);
begin
  DoShowBalanceChange;
end;

procedure TMainForm.aReportAbonPayExecute(Sender: TObject);
begin
 DoReportAbonPay;
end;

function TMainForm.encrypt_password:boolean;
begin
 if ( (GetConstantValue('SERVER_NAME')='CORP_MOBILE') or (GetConstantValue('SERVER_NAME')='GSM_CORP') )and
       (GetConstantValue('ENCRYPT_PASSWORD')='1')
 then
   result:=true
 else result:=false
end;

function TMainForm.CheckUser:string;
begin
  result:=OraSession.Username;
end;

function TMainForm.UserRightsType:integer;
begin
 if FUserRightsType=-1 then begin
  try
    qUserRigthsType_EncryptPwd.ParamByName('USER_NAME').AsString := OraSession.Username;
    qUserRigthsType_EncryptPwd.Open;
    FUserRightsType:=qUserRigthsType_EncryptPwd.FieldByName('rights_type').AsInteger;
    FCheckAllow:=qUserRigthsType_EncryptPwd.FieldByName('CHECK_ALLOW_ACCOUNT').AsInteger;
  finally
    qUserRigthsType_EncryptPwd.close;
  end;
 end;
 result:=FUserRightsType;
end;

procedure TMainForm.V1Click(Sender: TObject);
begin
 if not IsMonitorEvRun then begin
  // CheckAdminPrivileges;
  f2 := TMonitorEv.Create(Application);
  MainForm.IsMonitorEvRun:=true;
  f2.FormStyle := fsMDIChild;
 end
 else begin
  f2.FormActivate(self);
 end;
end;

procedure TMainForm.CheckAdminPrivs(var IsAdmin: Boolean);
 var
  tempbol:boolean;
begin
  if SameText(OraSession.Username, OraSession.Schema) then
    IsAdmin:=true
  else begin
    if FIsAdmin=-1 then begin
      // Под именем схемы работает администратор!
      qCheckUserPrivileges.ParamByName('USER_NAME').AsString := OraSession.Username;
      qCheckUserPrivileges.Open;
      try
        tempbol := not qCheckUserPrivileges.IsEmpty;
        if tempbol then begin
          FIsAdmin:=1;
          IsAdmin:= true;
          end
        else begin
          FIsAdmin:=-1;
          IsAdmin:= false;
        end;
      finally
        qCheckUserPrivileges.Close;
      end;
    end
    else begin
      if FIsAdmin=1 then
        IsAdmin:= true
      else
        IsAdmin:= false;
    end;

  end;
end;

procedure TMainForm.CheckROPrivs(var IsRO: Boolean);
begin
  if SameText(OraSession.Username, OraSession.Schema) then
    IsRo:=true
  else begin
    // Под именем схемы работает администратор!
    qCheckROPrivileges.ParamByName('USER_NAME').AsString := OraSession.Username;
    qCheckROPrivileges.Open;
    try
      IsRo := not qCheckROPrivileges.IsEmpty;
    finally
      qCheckROPrivileges.Close;
    end;
  end;
end;

procedure TMainForm.CheckAdminPrivileges;
var
  IsAdmin : Boolean;
begin
  CheckAdminPrivs(IsAdmin);
  if not IsAdmin then
  begin
    ShowMessage('Это функция доступна только администратору системы!');
    Abort;
  end;
end;

procedure TMainForm.aRefDealersExecute(Sender: TObject);
var RefFrm:TRefDealersForm;
begin
  CheckAdminPrivileges;
  RefFrm := TRefDealersForm.Create(Application);
  RefFrm.FormStyle := fsMDIChild;
end;

procedure TMainForm.aRefDiscountsExecute(Sender: TObject);
var RefFrm: TRefDiscountsForm;
begin
  CheckAdminPrivileges;
  RefFrm := TRefDiscountsForm.Create(Application);
  RefFrm.FormStyle := fsMDIChild;
end;

procedure TMainForm.aRefDocumTypesExecute(Sender: TObject);
var RefFrm : TRefDocumTypesForm;
begin
  CheckAdminPrivileges;
  RefFrm := TRefDocumTypesForm.Create(Application);
  RefFrm.FormStyle := fsMDIChild;
end;

procedure TMainForm.aRefDopStatusExecute(Sender: TObject);
var RefFrm:TRefDopStatusForm;
begin
  CheckAdminPrivileges;
  RefFrm := TRefDopStatusForm.Create(Application);
  RefFrm.FormStyle := fsMDIChild;
end;

procedure TMainForm.aRefFilialsExecute(Sender: TObject);
var RefFrm : TRefFilialsForm;
begin
  CheckAdminPrivileges;
  RefFrm := TRefFilialsForm.Create(Application);
  RefFrm.FormStyle := fsMDIChild;
end;

procedure TMainForm.aRefFixBalanceExecute(Sender: TObject);
begin
  CheckAdminPrivileges;
  DoFixBalance;
end;

procedure TMainForm.aRefForwardingPhoneNumberExecute(Sender: TObject);
var RefForm : TRefForwardingSMSForm;
begin
  CheckAdminPrivileges;
  RefForm:=TRefForwardingSMSForm.Create(Application);
  RefForm.FormStyle := fsMDIChild;
end;

procedure TMainForm.aRefMailRecipientsExecute(Sender: TObject);
var RefFrm : TRefMailRecipientsFrm;
begin
  RefFrm := TRefMailRecipientsFrm.Create(Application);
  RefFrm.FormStyle := fsMDIChild;
end;

procedure TMainForm.aRefMNPExecute(Sender: TObject);
var RefFrm : TMNP_NUMBERS;
begin
  CheckAdminPrivileges;
  RefFrm := TMNP_NUMBERS.Create(Application);
  RefFrm.FormStyle := fsMDIChild;
end;

procedure TMainForm.aRefUserNamesExecute(Sender: TObject);
var RefFrm : TRefUserNamesForm;
begin
  CheckAdminPrivileges;
  RefFrm := TRefUserNamesForm.Create(Application);
  RefFrm.FormStyle := fsMDIChild;
end;

procedure TMainForm.aRefVip_AbonentsExecute(Sender: TObject);
var RefFrm : TVIP_Abonents;
begin
  CheckAdminPrivileges;
  RefFrm := TVIP_Abonents.Create(Application);
  RefFrm.FormStyle := fsMDIChild;
end;

procedure TMainForm.aRefCountriesExecute(Sender: TObject);
var RefFrm : TRefCountriesForm;
begin
  CheckAdminPrivileges;
  RefFrm := TRefCountriesForm.Create(Application);
  RefFrm.FormStyle := fsMDIChild;
end;

procedure TMainForm.aRefRegionsExecute(Sender: TObject);
var RefFrm : TRefRegionsForm;
begin
  CheckAdminPrivileges;
  RefFrm := TRefRegionsForm.Create(Application);
  RefFrm.FormStyle := fsMDIChild;
end;

procedure TMainForm.aRefRightsTypeAccountExecute(Sender: TObject);
var RefFrm : TRefRightsTypeAccountForm;
begin
  CheckAdminPrivileges;
  RefFrm := TRefRightsTypeAccountForm.Create(Application);
  RefFrm.FormStyle := fsMDIChild;
end;

procedure TMainForm.aRefParametersExecute(Sender: TObject);
var RefFrm : TRefParametersForm;
begin
  CheckAdminPrivileges;
  RefFrm := TRefParametersForm.Create(Application);
  RefFrm.FormStyle := fsMDIChild;
end;

procedure TMainForm.aRefPhoneBlocksExecute(Sender: TObject);
var RefFrm : TRefPhoneBlocksForm;
begin
  RefFrm := TRefPhoneBlocksForm.Create(Application);
  RefFrm.FormStyle := fsMDIChild;
end;

procedure TMainForm.aRefPhoneUsernameFormExecute(Sender: TObject);
 var
 RefFrm:TRefPhoneUsernameForm;
begin
  CheckAdminPrivileges;
  RefFrm := TRefPhoneUsernameForm.Create(Application);
  RefFrm.FormStyle := fsMDIChild;
end;

procedure TMainForm.aRefAccountBillLoadExecute(Sender: TObject);
begin
  CheckAdminPrivileges;
  DoRefAccountBillLoad;
end;

procedure TMainForm.aRefAccountsExecute(Sender: TObject);
var RefFrm : TRefAccountsForm;
begin
  CheckAdminPrivileges;
  RefFrm := TRefAccountsForm.Create(Application);
  RefFrm.Execute(False);
end;

procedure TMainForm.aRefBlockPhoneNoContractExecute(Sender: TObject);
begin
  CheckAdminPrivileges;
  DoAutoBlockPhoneNoContract;
end;

procedure TMainForm.aReportBalanceChangeExecute(Sender: TObject);
var ReportFrm : TReportBalanceChangeForm;
begin
  CheckAdminPrivileges;
  ReportFrm := TReportBalanceChangeForm.create(Application);
  ReportFrm.FormStyle := fsMDIChild;

end;

procedure TMainForm.aRefSendSMSParametresExecute(Sender: TObject);
var
  RefFrm : TRefProvidersFrm;
begin
  CheckAdminPrivileges;
  RefFrm := TRefProvidersFrm.Create(Application);
  RefFrm.FormStyle := fsMDIChild;
  RefFrm.aRefresh.Execute;
end;

procedure TMainForm.aRefServicesExecute(Sender: TObject);
var RefFrm : TRefServicesForm;
begin
  CheckAdminPrivileges;
  RefFrm := TRefServicesForm.Create(Application);
  RefFrm.FormStyle := fsMDIChild;
end;

procedure TMainForm.aRefTariffOptionBenefitsExecute(Sender: TObject);
var RefFrm : TRefTariffOptionBenefitsForm;
begin
  CheckAdminPrivileges;
  RefFrm := TRefTariffOptionBenefitsForm.Create(Application);
  RefFrm.FormStyle := fsMDIChild;
end;

procedure TMainForm.aRefTariffOptionsExecute(Sender: TObject);
var RefFrm : TRefTariffOptionsForm;
begin
  CheckAdminPrivileges;
  RefFrm := TRefTariffOptionsForm.Create(Application);
  RefFrm.FormStyle := fsMDIChild;
end;

procedure TMainForm.aRefTariffsExecute(Sender: TObject);
var RefFrm : TRefTariffsForm;
begin
  CheckAdminPrivileges;
  RefFrm := TRefTariffsForm.Create(Application);
  RefFrm.FormStyle := fsMDIChild;
end;

procedure TMainForm.aRefTypePaymentsExecute(Sender: TObject);
 var
 RefFrm:TPaymentTypesForm;
begin
  CheckAdminPrivileges;
  RefFrm := TPaymentTypesForm.Create(Application);
  RefFrm.FormStyle := fsMDIChild;
end;

procedure TMainForm.aRefOperatorsExecute(Sender: TObject);
var RefFrm : TRefOperatorsForm;
begin
  CheckAdminPrivileges;
  RefFrm := TRefOperatorsForm.Create(Application);
  RefFrm.FormStyle := fsMDIChild;
end;

procedure TMainForm.aRefContractCancelTypesExecute(Sender: TObject);
var RefFrm : TRefContractCancelTypesForm;
begin
 // CheckAdminPrivileges;
  RefFrm := TRefContractCancelTypesForm.Create(Application);
  RefFrm.FormStyle := fsMDIChild;
end;

procedure TMainForm.aRefContractGroupsExecute(Sender: TObject);
var RefFrm : TRefContractGroupsForm;
begin

  IF AnsiPos(UpperCase(mainform.OraSession.Username),UpperCase(GetParamValue('USER_TELETIE_EXCEPTION')))=0 then
   CheckAdminPrivileges;
  RefFrm := TRefContractGroupsForm.Create(Application);
  RefFrm.FormStyle := fsMDIChild;
end;

procedure TMainForm.aRefAbonDiscountAndRassrochExecute(Sender: TObject);
begin
  CheckAdminPrivileges;
  DoRefAbonDiscountAndRassroch;
end;

procedure TMainForm.aRefAbonentsExecute(Sender: TObject);
var RefFrm : TRefAbonentsForm;
begin
  RefFrm := TRefAbonentsForm.Create(Application);
  RefFrm.FormStyle := fsMDIChild;
end;

procedure TMainForm.aJornalAllExecute(Sender: TObject);
var RefFrm : TJornalAllForm;
begin
  RefFrm := TJornalAllForm.Create(Application);
  RefFrm.FormStyle := fsMDIChild;
//  FFilialId:=Strtoint(VarToStr(RefFrm.FFilterForm.FilialId));
end;


function TMainForm.Allow_account: integer;
begin
 if FCheckAllow=-1 then begin
  try
    qUserRigthsType_EncryptPwd.ParamByName('USER_NAME').AsString := OraSession.Username;
    qUserRigthsType_EncryptPwd.Open;
    FUserRightsType:=qUserRigthsType_EncryptPwd.FieldByName('rights_type').AsInteger;
    FCheckAllow:=qUserRigthsType_EncryptPwd.FieldByName('CHECK_ALLOW_ACCOUNT').AsInteger;
  finally
    qUserRigthsType_EncryptPwd.close;
  end;
 end;
 result:=FCheckAllow;
end;

procedure TMainForm.aRefPhoneWithDailyAbonExecute(Sender: TObject);
begin
  CheckAdminPrivileges;
  DoPhoneNumberWithDailyAbon();
end;

procedure TMainForm.aReportBalanceExecute(Sender: TObject);
begin
  DoReportBalance();
end;

procedure TMainForm.aReportBalanceOnDateExecute(Sender: TObject);
begin
  DoReportBalancesOnDate;
end;

procedure TMainForm.aReportBalanceOnEndMonthExecute(Sender: TObject);
begin
  DoReportBalanceOnEndMonth;
end;

procedure TMainForm.aReportBillNegativeExecute(Sender: TObject);
begin
  DoReportBillNegative;
end;

procedure TMainForm.aReportBillsExecute(Sender: TObject);
begin
  DoReportBills('BILL');
end;

procedure TMainForm.aReportBillsNoDiscountExecute(Sender: TObject);
begin
  DoReportBillNoDiscount;
end;

procedure TMainForm.aReportBillViolsExecute(Sender: TObject);
begin
  DoReportBillViols;
end;

procedure TMainForm.aReportChangeStatusPresaleBlockExecute(Sender: TObject);
begin
  DoReportChangeStatusPresaleBlock;
end;

procedure TMainForm.aReportContractHandBlockExecute(Sender: TObject);
begin
 DoContractHandBlock;
end;

procedure TMainForm.aReportAccount4PeriodExecute(Sender: TObject);
begin
 DoReportAccount4Period;
end;

procedure TMainForm.aReportAccountInfoExecute(Sender: TObject);
begin
 DoReportAccountInfo;
end;

procedure TMainForm.aReportAccountPhonesExecute(Sender: TObject);
begin
  DoReportAccountPhones;
end;

procedure TMainForm.aReportAccPay4EquipExecute(Sender: TObject);
begin
  CheckAdminPrivileges;
  DoReportAccPay4Equip;
end;

procedure TMainForm.aReportActiveNumberNoContractsExecute(Sender: TObject);
begin
  DoReportActiveNumberNoContracts();
end;

procedure TMainForm.aReportDebitorkaExecute(Sender: TObject);
begin
  CheckAdminPrivileges;
  DoReportDebitorka;
end;

procedure TMainForm.aReportDilerPaymentsExecute(Sender: TObject);
begin
  DoReportBills('KOMISSIYA');
end;

procedure TMainForm.aReportDiscountsExecute(Sender: TObject);
begin
  DoReportDiscounts;
end;

procedure TMainForm.aReportAntiFraudBlockedExecute(Sender: TObject);
begin
 DoReportAntiFraudBlocked;
end;

procedure TMainForm.aReportAPIRejectBlocksExecute(Sender: TObject);
begin
  DoReportAPIRejectBlocks;
end;

procedure TMainForm.aReportFieldDetailsExecute(Sender: TObject);
begin
  DoReportFieldDetails;
end;

procedure TMainForm.aReportFinanceExecute(Sender: TObject);
begin
 DoFinanceReport;
end;

procedure TMainForm.aReportFinanceInflowOutflowExecute(Sender: TObject);
begin
  CheckAdminPrivileges;
  DoReportFinanceInflowOutflow;
end;

procedure TMainForm.aReportFinanceSumBillsExecute(Sender: TObject);
begin
  CheckAdminPrivileges;
  DoReportFinanceSumBills;
end;

procedure TMainForm.aReportFinanceHistoryPhoneActivExecute(Sender: TObject);
begin
  CheckAdminPrivileges;
  DoReportFinancePhoneActivList;
end;

procedure TMainForm.aReportHotBillingDelayExecute(Sender: TObject);
begin
   DoReportHotBillingDelay;
end;

procedure TMainForm.aReportHotBillingFilesExecute(Sender: TObject);
begin
  DoReportHotBillingFiles;
end;

procedure TMainForm.aReportKolNomFrmExecute(Sender: TObject);
begin
  TReportKolNomFrm.Create(Application).FormStyle := fsMDIChild;
end;

procedure TMainForm.aReportNumWithoutAbonPayExecute(Sender: TObject);
begin
  DoReportNumWithoutAbonPay;
end;


procedure TMainForm.aRefStartBalancesExecute(Sender: TObject);
var
  RefFrm : TRefStartBalancesForm;
begin
  RefFrm := TRefStartBalancesForm.Create(Application);
  RefFrm.FormStyle := fsMDIChild;
end;

procedure TMainForm.aReportPaymentWithoutContractsExecute(Sender: TObject);
begin
  DoReportPaymentWithoutContracts;
end;

procedure TMainForm.aReportPhoneForBlockSaveExecute(Sender: TObject);
begin
  TReportPhoneForBlockSaveForm.Create(Application).Execute(False);
end;

procedure TMainForm.aReportPhoneForUnblockSaveExecute(Sender: TObject);
begin
  TReportPhoneForUnblockSaveForm.Create(Application).Execute(False);
end;

procedure TMainForm.aReportPhoneInactivityExecute(Sender: TObject);
begin
  TReportPhoneInactivityForm.Create(Application).Execute(true);
end;

procedure TMainForm.aReportPhoneNumberViolationsExecute(Sender: TObject);
begin
  DoReportPhoneNumberViolations;
end;

procedure TMainForm.aReportPhoneOnBanExecute(Sender: TObject);
var
  BeelineLoaderForm : TBeelineLoaderForm;
begin
  BeelineLoaderForm := TBeelineLoaderForm.Create(nil);
  try
    BeelineLoaderForm.Execute(OraSession);
  finally
    FreeAndNil(BeelineLoaderForm);
  end;
end;

procedure TMainForm.aReportPhonePaymentsExecute(Sender: TObject);
begin
  DoReportPhonePayments;
end;

procedure TMainForm.aReportPhonesRashodExecute(Sender: TObject);
begin
  DoRepRaschodPhones(OraSession);
end;

procedure TMainForm.aReportPhoneStatExecute(Sender: TObject);
begin
  DoReportPhoneStat;
end;

procedure TMainForm.aReportLoadAccountsExecute(Sender: TObject);
begin
  DoReportLoadAccounts(OraSession);
end;

procedure TMainForm.aReportLoadingLogsExecute(Sender: TObject);
var
  RefFrm : TRefAccountsForm;
begin
  RefFrm := TRefAccountsForm.Create(Application);
  RefFrm.Execute(True); // только для контроля!
end;

procedure TMainForm.aReportMissingPhonesExecute(Sender: TObject);
begin
  DoReportMissingPhones;
end;

procedure TMainForm.aReportMobPayExecute(Sender: TObject);
begin
  DoReportMobPay;
end;

procedure TMainForm.aReportSityPhoneNumbersExecute(Sender: TObject);
begin
  TReportSityPhoneNumbersForm.Create(Application).Execute(true);
end;

procedure TMainForm.aReportSummaryMinutesExecute(Sender: TObject);
begin
  DoReportSummaryMinutes;
end;

procedure TMainForm.aReportSumPositiveBalanceExecute(Sender: TObject);
begin
  DoReportSumPositiveBalance;
end;

procedure TMainForm.aReportTariffOptionPhonesExecute(Sender: TObject);
begin
  CheckAdminPrivileges;
  DoReportTariffOptionPhones;
end;

procedure TMainForm.aReportTariffViolationsExecute(Sender: TObject);
begin
  DoReportTariffViolations;
end;

procedure TMainForm.aUnBlockJournalExecute(Sender: TObject);
begin
  TUnBlockListFrm.Create(Application).Execute('', False);
end;

procedure TMainForm.aReportProfitExecute(Sender: TObject);
begin
  DoReportProfit;
end;

function TmainForm.CheckAdminMenu(user_name, action_name:string):boolean;
var
  i:integer;
begin
  result:=true;
  with dm do
  begin
    qMenuAccess.Close;
    qMenuAccess.ParamByName('USER_NAME').AsString:=user_name;
    qMenuAccess.Open;
    for i := 1 to qMenuAccess.RecordCount do
    begin
      if qMenuAccess.FieldByName('ACTIONLIST_NAME').AsString=action_name then begin
        exit(false);
      end;
      qMenuAccess.Next;
    end;
    qMenuAccess.Close;
  end;

end;
procedure TMainForm.aReportPaymentPassengerExecute(Sender: TObject);
begin
  DoReportPaymentPassenger;
end;

procedure TMainForm.aReportPaymentPromisedExecute(Sender: TObject);
begin
  if CheckAdminMenu(OraSession.Username,'aReportPaymentPromised') then
    CheckAdminPrivileges;
  DoReportPromisedPayments;
end;

procedure TMainForm.ProviredClick(Sender: TObject);
var
  RefFrm : TRefProvidersFrm;
begin
  CheckAdminPrivileges;
  RefFrm := TRefProvidersFrm.Create(Application);
  RefFrm.FormStyle := fsMDIChild;

end;

procedure TMainForm.OraSessionConnectionLost(Sender: TObject;
  Component: TComponent; ConnLostCause: TConnLostCause;
  var RetryMode: TRetryMode);
begin
 RetryMode := rmReconnect;
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
  VerInfoSize := GetFileVersionInfoSize(
    PChar(FileName),
    Dummy);
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

procedure TMainForm.FormShow(Sender: TObject);
var Index:integer;
    menuitem:tmenuitem;
    changepassword:TChangePasswordForm;
    i,j:integer;
    alist1:TAction;
    vFlag: boolean;

  procedure SetActionState (Action : TAction; ConstantValue : String; EnabledIfConstantExist : Boolean = False);
  begin
    Action.Visible := True;
    if (ConstantValue = '') or (ConstantValue = '-1') then
      Action.Visible := False
    else if (ConstantValue = '0') and (not EnabledIfConstantExist) then
      Action.Enabled := False
    else
    begin
      Action.Enabled := True;
    end;
  end;
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
    //Чтение констант из БД
    qConstants.ParamByName('ACC_VER').AsFloat:=
      GetVersionValue(GetVersionTextOfModule(ParamStr(0)));
    qConstants.Open;
    qConstants.First;
    Index:=0;
    while not(qConstants.Eof) do
    begin
      SetLength(FconstantSettings, Index+1);
      FconstantSettings[Index].Value:=qConstants.FieldByName('VALUE').AsString;
      FconstantSettings[Index].Name:=qConstants.FieldByName('NAME').AsString;
      Inc(Index);
      FConstantSettingsCount:=index;
      qConstants.Next;
    end;
    qConstants.Close;
    //Чтение прав
    spFilialId.ExecProc;
    FFilial:=spFilialId.ParamByName('RESULT').AsInteger;
    FUseFilialBlockAccess:=(GetConstantValue('USE_FILIAL_BLOCK_ACCESS')='1')
                            and(StrToInt(GetConstantValue('HEAD_OFFICE'))<>FFilial);
    if FUseFilialBlockAccess and (Pos('Тарифер - ', Caption) > 0) then
      Caption:=Copy(Caption, 10, Length(Caption)-9);
    //Чтение параметров из БД
    qParams.Open;
    qParams.First;
    Index:=0;
    while not(qParams.Eof) do
    begin
      SetLength(FParamSettings, Index+1);
      FParamSettings[Index].Value:=qParams.FieldByName('VALUE').AsString;
      FParamSettings[Index].Name:=qParams.FieldByName('NAME').AsString;
      Inc(Index);
      FParamSettingsCount:=index;
      qParams.Next;
    end;
    qParams.Close;
    FConnected := True;
    LoadKeyboardLayout('00000419', KLF_ACTIVATE);//рус
    //Если выставлена константа шифрования пароля, предлогаем пользователю сменить пароль на шифрованный
    //у владельца схемы пароль нешифрованный
    if encrypt_password and
       (not SameText(OraSession.Username, OraSession.Schema))    then
      try
        qUserRigthsType_EncryptPwd.ParamByName('USER_NAME').AsString := OraSession.Username;
        qUserRigthsType_EncryptPwd.Open;
        if qUserRigthsType_EncryptPwd.FieldByName('encrypt_pwd').AsInteger <> 1 then begin
          changepassword:=TChangePasswordForm.Create(application);
          if (changepassword.showmodal = mrCancel) then Close;
        end;
      finally
        qUserRigthsType_EncryptPwd.close;
        ChangePassword.free;
      end;
    //Проверка на доступ "Только просмотр инф. по абоненту"
    if UserRightsType = 3 then begin
      MainMenu.Items.Clear;
      menuitem:=tmenuitem.Create(nil);
      menuitem.Action:=aShowUserStat;
      //menuitem.OnClick:=aShowUserStatexecute;
      timer1.Enabled:=true;
      MainMenu.Items.Insert(MainMenu.Items.Count,menuitem);
      with dm do begin
       qMenuAccess.Close;
       qMenuAccess.ParamByName('USER_NAME').AsString:=mainform.OraSession.Username;
       qMenuAccess.ParamByName('RIGHTS_TYPE').AsInteger:=MainForm.UserRightsType;
       qMenuAccess.ParamByName('CHECK_ALLOW_ACCOUNT').AsInteger:=MainForm.Allow_account;
       qMenuAccess.execsql;
       for I := 0 to qMenuAccess.RecordCount-1 do  begin
        try
         //MainMenu.Items.Find(qformaccess.FieldByName('ACTIONLIST_NAME').AsString).Visible:=(qformaccess.FieldByName('IS_VISIBLE').AsInteger=1);
          for J := 0 to ActionList1.ActionCount-1 do begin
            if ActionList1.Actions[j].Name=qMenuAccess.FieldByName('ACTIONLIST_NAME').AsString then begin
              menuitem:=tmenuitem.Create(nil);
              menuitem.Action:=ActionList1.Actions[j];
              MainMenu.Items.Insert(MainMenu.Items.Count,menuitem);
              Break;
            end;

          end;
          qMenuAccess.Next;
        except
         ShowMessage('Ошибка заполнение имени меню '+qformaccess.FieldByName('MENU_NAME').AsString);
        end;
       end;
       qMenuAccess.Close;
      end;


      //alist1:=(ActionList1.FindComponent('aRefContractGroups') as TAction);
      //menuitem.Action:=alist1;
      //MainMenu.Items.Insert(1,menuitem);

      {if UpperCase(UserName)='SAMORODOV' then begin
        menuitem:=tmenuitem.Create(nil);
        menuitem.Action:=aShowUserStat;
        //menuitem.OnClick:=aShowUserStatexecute;
        MainMenu.Items.Insert(0,menuitem);
      end;}

      exit;
    end;
    aJornalAll.Execute;
    MainForm.aReportTariffViolations.Visible:=(GetConstantValue('SHOW_TARIFF_MISMATCHES')='1');
    MainForm.aRefTypePayments.Visible:=(GetConstantValue('USE_TYPE_PAYMENTS')='1');
    MainForm.aReportPhoneNumberViolations.Visible:=(GetConstantValue('SHOW_PHONE_NUMBER_MISMATCHES')='1');
    MainForm.aRefSendMailParametres.Visible:=(GetConstantValue('SHOW_SEND_MAIL_PARAMETRES')='1');
    MainForm.aRefMailRecipients.Visible:=(GetConstantValue('SHOW_REF_MAIL_RECIPIENT')='1');
    MainForm.miLoadBeeline.Visible:={true;}(GetConstantValue('SHOW_LOAD_BEE_REP')='1');
    MainForm.miLoadBeelinePayments.Visible:=(GetConstantValue('SHOW_LOAD_BEE_REP_PAYMENTS')='1');
    MainForm.miLoadBeelineStatus.Visible:=(GetConstantValue('SHOW_LOAD_BEE_REP_STATUS')='1');
    MainForm.miLoadBeelineNachisl.Visible:=(GetConstantValue('SHOW_LOAD_BEE_REP_NACHISL')='1');
    MainForm.miLoadBeelineKodBaseStat.Visible:=(GetConstantValue('SHOW_LOAD_BEE_REP_KODBASESTAT')='1');
    MainForm.miLoadBeelineKodBaseStatMO.Visible:=(GetConstantValue('SHOW_LOAD_BEE_REP_KODBASESTAMO')='1');
    MainForm.miLoadBeelineBills.Visible:=(GetConstantValue('SHOW_LOAD_BEE_REP_BILLS')='1');
//    MainForm.miLoadBeelineContract.Visible:=(GetConstantValue('SHOW_LOAD_BEE_REP_CONTRACT')='1');
//    MainForm.miLoadBeelineRastorzh.Visible:=(GetConstantValue('SHOW_LOAD_BEE_REP_RASTORZH')='1');
    MainForm.miLoadBeelineDetails.Visible:=(GetConstantValue('SHOW_LOAD_BEE_REP_DETAILS')='1');
    MainForm.miLoadBeelineMobiPay.Visible:=(GetConstantValue('SHOW_LOAD_BEE_REP_MOBIPAY')='1');
    MainForm.miLoadBeelineChangeTp.Visible:=(GetConstantValue('SHOW_LOAD_BEE_REP_CHANGETP')='1');
    MainForm.miLoadBeelineDopPhoneInfo.Visible:=(GetConstantValue('SHOW_LOAD_BEE_REP_DOPPHONEINFO')='1');
    MainForm.miCollectorStates.Visible:=(GetConstantValue('SHOW_COLLECTOR_UPLOAD')='1');
    MainForm.miBeelineLoaderSettings.Visible:=(GetConstantValue('SHOW_COLLECTOR_UPLOAD')='1');
    MainForm.miLoadBeelineChangeDopStatus.Visible:=(GetConstantValue('SHOW_LOAD_BEE_REP_CHANGE_DST')='1');
    mniReportAccountPhones.Visible:= True;//(GetConstantValue('SERVER_NAME')<>'GSM_CORP');
    MainForm.N48.Visible:=(GetConstantValue('SHOW_BLOCK_SAVE')='1');
    MainForm.N49.Visible:=(GetConstantValue('SHOW_UNBLOCK_SAVE')='1');
    N35.Visible:=(GetConstantValue('IS_MONITORING')='1');//Пункт меню Мониторинг
    N36.Visible:=(GetConstantValue('IS_MONITORING_SERV')='1');//Пункт меню Мониторинг сервисов
    MobPay1.Visible:=(GetConstantValue('SHOW_MOBPAY')='1');//Отчеты_Платежи_MobPay
    N77.Visible:=(GetConstantValue('SHOW_SUSPICION_OF_FRAUD')='1');//Отчеты_Подозрение в мошенничестве
    N37.Visible:=(GetConstantValue('SHOW_JOURNAL_OF_SENDING')='1');//Журнал Отправок
    N110.Visible:=(GetConstantValue('SHOW_REP_OF_DOPSTATUS')='1');//Отчет доп.статусов
    N59.Visible:=(GetConstantValue('SHOW_JOURNAL_OF_LOGPHONE')='1');//Журнал логов по номеру телефона
    n53.Visible:=(GetConstantValue('USE_TARIFF_OPTION_GROUP')='1');//Справочник Группы услуг
    n78.Visible:=(GetConstantValue('SHOW_BILLVIOLS')='1');
    aRefPhoneUsernameForm.Visible := (GetConstantValue('SHOW_REF_PHONE_USER_NAME')='1');//Справочник пользователей тел.связи
    MNP1.Visible:=(GetConstantValue('SERVER_NAME')='CORP_MOBILE');
    VIP1.Visible:=(GetConstantValue('SERVER_NAME')='CORP_MOBILE');
    aReportAccount4Period.Visible := (GetConstantValue('SHOW_REPORT_ACCOUNT4PERIOD')='1');//Отчет по счетам за период
    MainForm.mniReportAPIRejectBlocks.Visible := (GetConstantValue('SHOW_REPORT_APIREJECTBLOCKS')='1');  // Отчет Отклоненные блокировки/разблокировки через апи за период
    MainForm.miReportHotBillingFiles.Visible := (GetConstantValue('SHOW_REPORT_HOTBILLINGFILES')='1');  // Отчет о загрузках горячего биллинга
    MainForm.mniReportRecoveryCloseContracts.Visible := (GetConstantValue('SHOW_REP_RECOV_CLOSE_CONTRACTS')='1');  // Отчет Отклоненные блокировки/разблокировки через апи за период
    aReportChangeStatusPresaleBlock.Visible := (GetConstantValue('SHOW_REP_CHNG_STAT_PRESAL_BLC')='1');  // Отчет по статусу "Предпродажная блокировка"

    MainForm.miLoadBeelineBlockUnblock.Visible:=(GetConstantValue('SHOW_LOAD_BEE_BLOCK_UNBLOCK')='1');
    MainForm.miRefLoadBlockUnblock.Visible:=(GetConstantValue('SHOW_LOAD_BEE_BLOCK_UNBLOCK')='1');

    if GetConstantValue('SHOW_BILLVIOLS')='1'  then
    N78.Caption:='Подозрительные счета и номера' ;

    if GetConstantValue('SHOW_BILL_VIOLATION_IN_ACCOUNT')>='1'  then
    N78.Caption:='Нарушения в счетах' ;

    MainForm.aRefDiscounts.Visible:=(GetConstantValue('SHOW_OPERATOR_DISCOUNT')='1');
    MainForm.aReportBills.Visible:=
      (GetConstantValue('SHOW_BILLS_OPERATOR_AND_CLIENT')='1')
        or (GetConstantValue('SERVER_NAME')='SIM_TRADE');
    N46.Visible:=(GetConstantValue('SHOW_AUTO_REPORTS')='1');
    N50.Visible:=(GetConstantValue('SERVER_NAME')='SIM_TRADE');
    N51.Visible:=(GetConstantValue('SERVER_NAME')='CORP_MOBILE');
    N62.Visible:=(GetConstantValue('SERVER_NAME')='CORP_MOBILE');
    //N64.Visible:=(GetConstantValue('SERVER_NAME')='CORP_MOBILE');
    //N69.Visible:=(GetConstantValue('SERVER_NAME')='CORP_MOBILE');
    N69.Visible:=(GetConstantValue('SHOW_HOT_BIL_DELAY')='1');

    //N74.Visible:=(GetConstantValue('SERVER_NAME')='CORP_MOBILE');
    USSD1.Visible:=(GetConstantValue('SERVER_NAME')='CORP_MOBILE');
    N55.Visible:=(GetConstantValue('SERVER_NAME')='GSM_CORP');
    N27.Visible:=(GetConstantValue('SERVER_NAME')<>'LONTANA');//Отчет - Доходность
    N32.Visible:=(GetConstantValue('SERVER_NAME')<>'LONTANA');//Отчет - Абон плата
    N33.Visible:=(GetConstantValue('SERVER_NAME')<>'LONTANA');//Отчет - Платежи
    N40.Visible:=(GetConstantValue('SERVER_NAME')<>'LONTANA');//Справ - Закрытие периодов

    N35.Visible:=(GetConstantValue('IS_MONITORING')='1');//Пункт меню Мониторинг
    N36.Visible:=(GetConstantValue('IS_MONITORING_SERV')='1');//Пункт меню Мониторинг сервисов
    N93.Visible:=(GetConstantValue('SERVER_NAME')='CORP_MOBILE');
    N56.Visible:=(GetConstantValue('FORWARDING_SYSTEM_ENABLE')='1');
    N57.Visible:=(GetConstantValue('SHOW_CITY_NUMBERS')='1');
    N58.Visible:=(GetConstantValue('SERVER_NAME')='GSM_CORP')
              or (GetConstantValue('SERVER_NAME')='CORP_MOBILE');

    N61.Visible:=(GetConstantValue('CALC_ABON_PAYMENT_TO_MONTH_END')='1');
    N80.Visible:=(GetConstantValue('CALC_ABON_PAYMENT_TO_MONTH_END')='1');
    if (GetConstantValue('SERVER_NAME')='GSM_CORP') then
      N58.Caption:='Номера собеседников';
    N63.Visible:=(GetConstantValue('SHOW_PAYMENT_WITHOUT_CONTRACTS')='1');
    N65.Visible:=(GetConstantValue('REPORT_CONTRACTS_HAND_BLOCK')='1');
    N66.Visible:=(GetConstantValue('SHOW_REPORT_ACCOUNT_STAT_NOW')='1');
    N67.Visible:=(GetConstantValue('SHOW_REPORT_VIRTUAL_PAYMENTS')='1');
    N82.Visible:=(GetConstantValue('USE_ABON_DISCOUNTS')='1')
      or (GetConstantValue('USE_INSTALLMENT_PAYMENT')='1');
    //Справочник: Дополнительные статусы
    N79.Visible:=(GetConstantValue('SHOW_CONTRACT_DOP_STATUS')='1');
    //Справочник: Дилеры
    N83.Visible:=(GetConstantValue('SHOW_DEALERS')='1');
    aReportFinance1.Visible:=(GetConstantValue('SERVER_NAME')<>'CORP_MOBILE');
   // N84.Visible:=(GetConstantValue('SERVER_NAME')='CORP_MOBILE');
   N84.Visible:=(GetConstantValue('SERVER_NAME')<>'SIM_TRADE');

    //Отчет: Информация о счетах
    N85.Visible:=(GetConstantValue('SHOW_ACCOUNT_INFO')='1');
    //Отчет: Обещанные платежи(адм.)
    N86.Visible:=(GetConstantValue('USE_PROMISED_PAYMENTS')='1');
    //Отчет: Тарифные опции/услуги(адм.)
    N87.Visible:=(GetConstantValue('SHOW_REPORT_TARIFF_OPT_PHONES')='1');
    //Отчет: Номера исчезнувшие с договоров
    N88.Visible:=(GetConstantValue('SHOW_REPORT_MISSING_PHONE')='1');
    //Отчет: Счета выставленные в минус
    N89.Visible:=(GetConstantValue('SHOW_REPORT_BILL_NEGATIVE')='1');
    //Справочник: Групповые договора
    N90.Visible:=(GetConstantValue('SHOW_CONTRACT_GROUPS')='1');
    //Запускаем таймер проверки выставления счетов (уменьшения баланса)
    if (GetConstantValue('DO_TIMER_ON')='1') then begin
      timer1.Interval:=1000*strtoint(GetConstantValue('INTERVAL_CHECK_BALANCE_CHANGE'));
      timer1.Enabled:=true;
      Timer1Timer(nil);
    end;
    //Запускаем таймер проверки ошибок загрузки
    if (GetConstantValue('DO_TIMER_LOG_ERROR_ON')='1') then begin
      timer2.Interval:=1000*strtoint(GetConstantValue('INTERVAL_CHECK_LOG_ERROR'));
      timer2.Enabled:=true;
      Timer2Timer(nil);
    end;

    // Счета без скидки ГК20%
    C201.Visible:=(GetConstantValue('SERVER_NAME')='SIM_TRADE');
    // Отчет "Балансы по дате"
    N91.Visible:=(GetConstantValue('SHOW_REPORT_BALANCE_ON_DATE')='1');
    // Раздел "Фин. отчеты"
    N64.Visible:=(GetConstantValue('SHOW_FIN_REP_HISTORY_ACT_PHONE')='1');
    N74.Visible:=(GetConstantValue('SHOW_FIN_REP_INFLOW_OUTFLOW')='1');
    N60.Visible:=(GetConstantValue('SHOW_FINANCE_REPORTS')='1');
    N92.Visible:=(GetConstantValue('SHOW_FINANCE_SUM_BILLS')='1');
    CheckAdminPrivs(vFlag);
    N60.Enabled:=vFlag;   // Меню доступно ток админам.
    if FUseFilialBlockAccess then
    begin
      N2.Visible:=false;
      N6.Visible:=false;
      N8.Visible:=false;
      N9.Visible:=false;
      N10.Visible:=false;
      N16.Visible:=false;
      N39.Visible:=false;
      N41.Visible:=false;
      N40.Visible:=false;
      N42.Visible:=false;
      N71.Visible:=false;
      N72.Visible:=false;
      N47.Visible:=false;
      N70.Visible:=false;
      N77.Visible:=false;
      N78.Visible:=false;
    end;
    //Система автоблока номеров без договора
    N75.Visible:=(GetConstantValue('AUTO_BLOCK_PHONE_NO_CONTRACTS')='1');
    //Отчет "Дебиторская задолженность"
    N81.Visible:=(GetConstantValue('SHOW_REPORT_DEBITORKA')='1');
    //Отчет "Суммы положительных балансов"
    N95.Visible:=(GetConstantValue('SHOW_SUM_POSITIVE_BALANCE')='1');
    //Отчет "Номера с отсутствующей активностью"
    N96.Visible:=(GetConstantValue('SHOW_PHONE_INACTIVITY')='1');
    MainForm.miLoadBeelineReceivedPayments.Visible:=(GetConstantValue('SHOW_LOAD_BEE_REP_RECEIVED_PAY')='1');
    //Отчет Пассажирский
    MainForm.miMob_pay.Visible:=(GetConstantValue('SHOW_REPORT_PASSENGER')='1');
    {with dm do begin
     qMenuAccess.Close;
     qMenuAccess.ParamByName('USER_NAME').AsString:=mainform.OraSession.Username;
     qMenuAccess.ParamByName('RIGHTS_TYPE').AsInteger:=MainForm.UserRightsType;
     qMenuAccess.ParamByName('CHECK_ALLOW_ACCOUNT').AsInteger:=MainForm.Allow_account;
     qformaccess.execsql;
     for I := 0 to qMenuAccess.RecordCount-1 do  begin
      try
       MainMenu.Items.Find(qformaccess.FieldByName('MENU_NAME').AsString).Visible:=(qformaccess.FieldByName('IS_VISIBLE').AsInteger=1);
      except
       ShowMessage('Ошибка заполнение имени меню '+qformaccess.FieldByName('MENU_NAME').AsString);
      end;
     end;
    end;}

    // если не админ то отчет не виден    (GetConstantValue(SHOW_PHONE_REPORT')='1')
 //   N98.Visible:=True;  // разделитель - еще неясно нужен ли
    //miPhoneReport.Visible := GetConstantValue('SHOW_REPORT_KONSTRUKTORS')='1');  // меню отчета
    miPhoneReport.Visible := true;  // меню отчета
    //Отчет: "Текущая очередь СМС"
    SetActionState( aReportCurrentQueueSMS, GetConstantValue('BEELINE_SMS_GATEWAY'), True);

    //Отчет "Список номеров на счетах"
    aReportPhoneOnBan.Visible := (GetConstantValue('SHOW_PHONE_ON_BAN_REPORT') = '1');
    //Отчет "Отчет прогрузки счетов"
    aReportLoadAccounts.Visible := (GetConstantValue('SHOW_REPORT_LOAD_ACCOUNTS') = '1');
    //Отчет о расходах, не включенных в абон.плату
    aReportPhonesRashod.Visible := (GetConstantValue('SHOW_REPORT_OVERRUN_ABON_PAY') = '1');
    //Отчет "Дебиторская задолженность по месяцам"
    aReportReceivables.Visible := (GetConstantValue('SHOW_REPORT_RECEIVABLES') = '1');
    //Отчет по выставленным счетам за оборудование
    aReportAccPay4Equip.Visible := (GetConstantValue('SHOW_REPORT_ACC_PAY_4_EQUIP') = '1');
  end
  else
    Close;
end;

procedure TMainForm.OraSessionAfterConnect(Sender: TObject);
begin
  Caption := 'Тарифер - Учет абонентов ' + GetVersionTextOfModule(ParamStr(0)) + ' - '
    + OraSession.Username;
  FUser:=OraSession.Username;
end;

end.
