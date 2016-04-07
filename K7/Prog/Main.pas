unit Main;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Menus, ComCtrls, ActnList,
  DBAccess, OdacVcl, DB, Ora, ImgList, MemDS,Variants,MemData,CRGrid,
  Vcl.DBCGrids, Vcl.Grids, Vcl.DBGrids, DASQLMonitor, OraSQLMonitor, IniFiles, oraclasses,
  OraCall, ReportPotentialActivity, DMUnit, PicShow, Func_Const, TimedMsgBox, ChildFrm;

type
  TMyRef = class of TChildForm;

Type
  TListClass = array of TMyRef;

type
  TMainFrmTmr1 = class(TThread)
  private
    fAttentionBbtnVisible: Boolean;
    fAttentionBtn3Visible: Boolean;
    fAttentionBtn1Visible: Boolean;
    fCheckBalanceChange: Boolean;
    fCheckHotBilLoadLog: Boolean;
    FCheckHotBilLoad: Boolean;
    fCheckHackers: Boolean;
    fCheckLoadLog: Boolean;
    fApi, fE_care, fOld_cab, fUserRightsType_: Integer;
    qBalanceChange: TOraQuery;
    qReadLog: TOraStoredProc;
    qLoadLog: TOraQuery;
    qHackers: TOraQuery;
    TmpQuery: TOraQuery;
    qHBWArning: TOraQuery;
    fOraSession: TOraSession;
    fLocalFrm: TForm;
    fHint: string;
    razdelit: string;
    procedure SetOraSession(const Value: TOraSession);
    procedure SetLocalFrm(const Value: TForm);
  protected
    procedure Execute; override;
    procedure UpdateAttentionBtn;
  public
    constructor Create;
    destructor Destroy; override;
    property UserRightsType_: Integer read fUserRightsType_ write fUserRightsType_;
    property CheckBalanceChange: Boolean read fCheckBalanceChange
      write fCheckBalanceChange;
    property CheckHotBilLoad: Boolean read FCheckHotBilLoad
      write FCheckHotBilLoad;
    property CheckHotBilLoadLog: Boolean read fCheckHotBilLoadLog
      write fCheckHotBilLoadLog;
    property CheckLoadLog: Boolean read fCheckLoadLog write fCheckLoadLog;
    property CheckHackers: Boolean read fCheckHackers write fCheckHackers;
    property OraSession: TOraSession read fOraSession write SetOraSession;
    property LocalFrm: TForm read fLocalFrm write SetLocalFrm;
  end;

type
  TMainFrmTmr2 = class(TThread)
  private
    fOraSession: TOraSession;
    qLoadLog_Error: TOraQuery;
    send_mail_detail: TOraStoredProc;
    TmpQuery: TOraQuery;
    FStringStream: TStringStream;
    fIntervalCheckLogError: Integer;
    fMailLogError: String;
    fErrorMess: String;
    procedure SetOraSession(const Value: TOraSession);
    function Td(S: string): string;
  protected
    procedure Execute; override;
    procedure SayAboutError;
  public
    constructor Create;
    destructor Destroy; override;
    property IntervalCheckLogError: Integer read fIntervalCheckLogError
      write fIntervalCheckLogError;
    property MailLogError: String read fMailLogError write fMailLogError;
    property ErrorMess: string read fErrorMess write fErrorMess;
    property OraSession: TOraSession read fOraSession write SetOraSession;
  end;

type
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
    qUserRigthsType_EncryptPwd__: TOraQuery;
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
    aReportStartPayment: TAction;
    aBlockPhoneWithDopStatus: TAction;
    N103: TMenuItem;
    aReportHoldBlocks: TAction;
    miReportHoldBlocks: TMenuItem;
    N104: TMenuItem;
    aReportAutoTurnInternetCurr: TAction;
    aReportMassRemovalDopStatus: TAction;
    N105: TMenuItem;
    aReportAutoTurnInternetPrev: TAction;
    N106: TMenuItem;
    aReportPhoneState: TAction;
    miReportPhoneState: TMenuItem;
    aReportCreditNumber: TAction;
    N107: TMenuItem;
    aReportBetweenBills: TAction;
    miReportBetweenBills: TMenuItem;
    aReportAbonTarifer: TAction;
    aReportAbonTarifer1: TMenuItem;
    aReportHotBillingMissing: TAction;
    miReportHotBillingMissing: TMenuItem;
    aRefTurnTariffOptions: TAction;
    miRefTurnTariffOptions: TMenuItem;
    N108: TMenuItem;
    N109: TMenuItem;
    aRefRoamingProviders: TAction;
    miRefRoamingProveders: TMenuItem;
    aReportMNRoaming: TAction;
    N111: TMenuItem;
    miReportPotencialActivity: TMenuItem;
    aReportPotencialActivity: TAction;
    aReportMonitorAutoTurnInternet: TAction;
    N112: TMenuItem;
    aReportPhonePaymentLC: TAction;
    miReportPhonePaymentLC: TMenuItem;
    aReportLossPhoneNumber: TAction;
    miReportLossPhoneNumber: TMenuItem;
    aWindChengeMDI: TAction;
    aCloseWind: TAction;
    aRefReportType: TAction;
    d1: TMenuItem;
    WindowClose1: TAction;
    WindowArrange1: TAction;
    WindowCascade1: TAction;
    WindowMinimizeAll1: TAction;
    WindowTileHorizontal1: TAction;
    WindowTileVertical1: TAction;
    windowVert: TMenuItem;
    WindowMinimaze: TMenuItem;
    CloseWindVstr: TMenuItem;
    CloseWindMDI: TMenuItem;
    mi_vstr: TMenuItem;
    aRefSpecialBans: TAction;
    miRefSpecialBans: TMenuItem;
    aReportControlFlowTraffDraveMon: TAction;
    N113: TMenuItem;
    aUnReportBills: TAction;
    miUnReportBills: TMenuItem;
    aReportAutoTurnInternetLimit: TAction;
    mnReportAutoTurnInternetLimit: TMenuItem;
    aReportAbonLK: TAction;
    N114: TMenuItem;
    aReportControlTrafficPckgAllPhone: TAction;
    N115: TMenuItem;

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
    procedure aReportStartPaymentExecute(Sender: TObject);
    procedure aBlockPhoneWithDopStatusExecute(Sender: TObject);
    procedure aReportHoldBlocksExecute(Sender: TObject);
    procedure aReportAutoTurnInternetCurrExecute(Sender: TObject);
    procedure aReportMassRemovalDopStatusExecute(Sender: TObject);
    procedure aReportAutoTurnInternetPrevExecute(Sender: TObject);
    procedure aReportPhoneStateExecute(Sender: TObject);
    procedure aReportCreditNumberExecute(Sender: TObject);
    procedure aReportBetweenBillsExecute(Sender: TObject);
    procedure aReportAbonTariferExecute(Sender: TObject);
    procedure aReportHotBillingMissingExecute(Sender: TObject);
    procedure aRefTurnTariffOptionsExecute(Sender: TObject);
    procedure aRefRoamingProvidersExecute(Sender: TObject);
    procedure aReportMNRoamingExecute(Sender: TObject);
    procedure aReportPotencialActivityExecute(Sender: TObject);
    procedure aReportMonitorAutoTurnInternetExecute(Sender: TObject);
    procedure aReportPhonePaymentLCExecute(Sender: TObject);
    procedure aReportLossPhoneNumberExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure InitBtn;
    procedure InitPsh;
    procedure PicShowDblClick(Sender: TObject);
    procedure aWindChengeMDIExecute(Sender: TObject);
    procedure aCloseWindExecute(Sender: TObject);
    procedure ChengeMDI;
    procedure SetStateAction;
    procedure NewWinProcedure(var Msg: TMessage);
    procedure SetActiveScreen;
    procedure CommonClickMenu(Sender: TObject);

    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure aRefSpecialBansExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure aReportControlFlowTraffDraveMonExecute(Sender: TObject);
    procedure aUnReportBillsExecute(Sender: TObject);
    procedure aReportAutoTurnInternetLimitExecute(Sender: TObject);
    procedure aReportAbonLKExecute(Sender: TObject);
    procedure aReportControlTrafficPckgAllPhoneExecute(Sender: TObject);

  private
    FFilialId :  integer;
    ListClass: TListClass;
    NameForm: string;
    fr: TMyRef;
    New_F: TChildForm;
    itm: Integer;
    PSh: TPicShow;
    OutCanvas: TCanvas;
    OldWinProc{, NewWinProc}: Pointer;
    // dscr : HWND;
    closeProg, EditChildForm, CloseNow, runcnt: Boolean;
    procedure WMSysCommand(var Msg: TWMSysCommand); message WM_SYSCOMMAND;

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
  ReportAntiFraudBlocked, ReportAccountPhones, ReportUSSDSend, LoadDetail,
  ReportPaymentWithoutContracts, ReportKolNom, ReportContractHandBlock,
  ReportVirtualPayments, ShowBalanceChange, ReportHotBillingDelay,
  ReportBalanceChange, SelectContract, ShowUserStat, RefRightsTypeAccount,
  ShowHackers, RefParameters, RefCopyDatabase, ChangePassword,
  RefAutoBlockPhoneNoContract, RefAccountBillLoad, ReportBillViols,
  ReportFinanceModule, RefDopStatusFrm, ReportYearBilssDayAbon, ReportDebitorka,
  ReportMobPayments, RefAbonDiscountAndRassroch, ReportBillNoDiscountYear,
  RefDealersFrm, ChangeTariffArray, ReportAccountInfo, ReportPaymentsPromised,
  ReportTariffOptionPhones, ReportMissingPhones, ReportBillNegative,
  RefContractGroups, ReportBalancesOnDate,RefPhonesWithDailyAbon,MonitorServices,
  RefAllSendMail, RefAllLogs, ReportDopStatus, RefTariffOptionBenefits,
  ReportFinanceHistoryPhoneActiv, ReportFinanceInflowOutflow, RepCalcBalance,
  ReportFinanceSumBills, RepPhoneWhisContract, RepAllPhones,
  ReportSumPositiveBalance, ChangeDopStatusArray, PaymentTypesFrm,
  ReportPhoneInactivity, RegisterPaymentsArray, RefPhoneUsername, refMNP,
  refvip_abonents, ReportPaymentPassenger, ReportListPhones,
  RefInactivePhoneLessCont, ReportCurrentQueueSMS, ReportPhoneOnBan,
  ReportAccountPeriod, ReportAPIRejectBlocks, ReportHotBillingFiles,
  ReportRecoveryCloseContracts, ReportChangeStatusPresaleBlock,
  ReportPhoneReBlock, ReportLoadAccounts, RepRaschodPhones, ReportAccPay4Equip,
  ReportReceivables, ReportStartPayment, BlockPhoneWithDopStatus, ReportBlocks,
  ReportAutoTurnInternetCurr, MassRemovalDopStatus, ReportAutoTurnInternetPrev,
  ReportCreditNumber, uReportPhoneState, ReportDiffBetweenBills,
  ReportAbonTarifer, ReportHotBillingMissing, RefTurnTariffOptions,
  RefRoamingProviders,  RefReportType, ReportMNRoaming,
  ReportMonitorAutoTurnInternet, ReportPhonePaymentsLC, ReportLossPhoneNumber,
  RefSpecialBans, ReportControlFlowTraffDraveMon, UnReportBills, ReportAutoTurnInternetLimit, ReportAbonLK,
  ReportControlTrafficPckgAllPhone;


  var     f1 : TMonitorServ;
          f2 : TMonitorEv;

procedure TMainForm.FormCreate(Sender: TObject);
var
  i : Integer;

begin
  ListClass := TListClass.Create(TRefFilialsForm, TRefUserNamesForm, TRefDocumTypesForm, TRefCountriesForm,
   //                                  1                2                 3                   4
  TRefRegionsForm, TRefPhoneBlocksForm, TRefOperatorsForm, TRefTariffsForm, TRefDiscountsForm, TRefReportTypeFrm,
  //    5                  6                   7                  8                9                 10
  TRefMailRecipientsFrm, TfrmRefSpecialBans, TMNP_NUMBERS
  //    11                12                      13
                               );
  Position := poScreenCenter;
  Caption := 'Тарифер - Учет абонентов ' + dm.VersionOfModule + ' - ' + dm.OraSession.Username;
  dm.MainCaption := Caption;
  dm.applMainForm := self;
  PSh := TPicShow.Create(self);
  InitPsh;
  aWindChengeMDI.Checked := dm.MDI_State;
  dm.MDI_State := True;
  OutCanvas := TCanvas.Create;
  Application.OnHint := ShowHint;
  InitBtn;

  IsMonitorRun:=false;
  IsMonitorEvRun:=false;

  FUserRightsType := -1;
  FUserRightsType := Dm.FUserRightsType;
  FIsAdmin:=-1;
  FIsAdmin := Dm.FIsAdmin;
  FCheckAllow:=-1;
  api:=0;
  old_cab:=0;
  e_care:=0;


  SetStateAction;

  //runcnt := True;
  CloseNow := False;
   for i := 0 to ComponentCount - 1 do
  begin
    if (Components[i].ClassName = 'TOraQuery') then
    begin
      (Components[i] as TOraQuery).Session := Dm.OraSession;
      (Components[i] as TOraQuery).Close;
    end;
    if (Components[i].ClassName = 'TOraStoredProc') then
    begin
      (Components[i] as TOraStoredProc).Session := Dm.OraSession;
    end;
  end;

end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
ss : string;
Rez, i : Integer;
begin
   ss := 'Вы действительно хотите завершить работу с программой ?';
  Rez := TimedMessageBox(ss, 'Пожалуйста, будьте внимательны!', mtConfirmation, [mbYes, mbNo], mbNo, 10, 3);
  Application.ProcessMessages;
  if Rez = IDYES then
  begin
    if dm.MDI_State then // МДИ режим
      for i := 0 to MDIChildCount - 1 do
        MDIChildren[i].Close;
    CanClose := True;
  end
  else
  begin // if Rez = IDYES
    CanClose := False;
    if not EditChildForm then
    begin
      NameForm := 'Тарифер - Учет абонентов ' + dm.VersionOfModule + ' - ' +
        dm.OraSession.Username;
      itm := 0;
      Caption := dm.MainCaption;
      SetActiveScreen;
      OnKeyDown := FormKeyDown;
      OnKeyPress := FormKeyPress;
      if not dm.MDI_State then
        PicShowDblClick(PSh);
    end;
  end; // if Rez = IDYES
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
    PSh.Visible := False;
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
      New_F := fr.Create(ChildForm, itm, New_F, self.Handle, NameForm);
      New_F.Show;
    end;
    aWindChengeMDI.Enabled := (MDIChildCount = 0);
  end
  else // не МДИ режим - встроенное в главную форму
  begin
    PSh.Visible := True;

    // OnKeyDown := nil;
    // OnKeyPress := nil;
    aCloseWind.Enabled := (itm <> 0);
    if Assigned(New_F) then
    begin
      New_F.Free;
      New_F := nil;
    end;
    if (itm <> 0) then
    begin
      StatusLine.Align := alnone;
      StatusLine.Visible := False;
      New_F := fr.Create(ChildForm, self, itm, New_F, self.Handle, NameForm);
      New_F.Show;
      StatusLine.Align := alBottom;
      StatusLine.Visible := True;
    end;
    aWindChengeMDI.Enabled := (itm = 0);
  end;
end;

// внимание - в процедуре указаны зависимости пунктов меню от action
procedure TMainForm.SetStateAction;
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

var
  s1, s2, s3, s4: string;
  menuitem: TMenuItem;
  i, j: Integer;
  ActionName: string;
  Index:integer;
  vFlag: boolean;

begin
      //Чтение констант из БД
      Dm.qConstants.Open;
      Dm.qConstants.First;
      Index:=0;
      while not(Dm.qConstants.Eof) do
      begin
        SetLength(FconstantSettings, Index+1);
        FconstantSettings[Index].Value:=Dm.qConstants.FieldByName('VALUE').AsString;
        FconstantSettings[Index].Name:=Dm.qConstants.FieldByName('NAME').AsString;
        Inc(Index);
        FConstantSettingsCount:=index;
        Dm.qConstants.Next;
      end;
      Dm.qConstants.Close;


      //Чтение прав
      FFilial := Dm.FFilial;
      FUseFilialBlockAccess := Dm.FUseFilialBlockAccess;
      Dm.qParams.First;
      Index:=0;
      while not(Dm.qParams.Eof) do
      begin
        SetLength(FParamSettings, Index+1);
        FParamSettings[Index].Value := Dm.qParams.FieldByName('VALUE').AsString;
        FParamSettings[Index].Name := Dm.qParams.FieldByName('NAME').AsString;
        Inc(Index);
        FParamSettingsCount:=index;
        Dm.qParams.Next;
      end;
      FConnected := True;


  // Проверка на доступ "Только просмотр инф. по абоненту"
  if dm.fUserRightsType = 3 then
  begin
    MainMenu.Items.Clear;
    menuitem := TMenuItem.Create(nil);
    menuitem.Action := aShowUserStat;
    MainMenu.Items.Insert(MainMenu.Items.Count, menuitem);
    begin
      dm.qMenuAccess.Close;
      dm.qMenuAccess.Prepare;
      dm.qMenuAccess.open;
      for i := 0 to dm.qMenuAccess.RecordCount - 1 do
      begin
        try
          for j := 0 to ActionList1.ActionCount - 1 do
          begin
            ActionName := ActionList1.Actions[j].Name;
            if ActionName = dm.qMenuAccess.FieldByName('ACTIONLIST_NAME').AsString
            then
            begin
              menuitem := TMenuItem.Create(nil);
              menuitem.Action := ActionList1.Actions[j];
              MainMenu.Items.Insert(MainMenu.Items.Count, menuitem);
              Break;
            end;

          end;
          dm.qMenuAccess.Next;
        except
          ShowMessage('Ошибка заполнения имени меню ' + ActionName);
        end;
      end;
      dm.qMenuAccess.Close;
    end;
    exit;
  end;

  // эта программа только для CORP_MOBILE, все что не относиться к ней закрываем
  s1 := GetConstantValue('INTERVAL_CHECK_BALANCE_CHANGE');
  s2 := GetConstantValue('INTERVAL_CHECK_LOG_ERROR');
  s3 := GetConstantValue('DO_TIMER_ON');
  s4 := GetConstantValue('DO_TIMER_LOG_ERROR_ON');

  if (GetConstantValue('DO_TIMER_ON') = '1') then
  begin
    Timer1.Interval := 1000 * StrToIntDef
      (GetConstantValue('INTERVAL_CHECK_BALANCE_CHANGE'), 0);
    Timer1.Enabled := True;
    Timer1Timer(nil);
  end;
  // Запускаем таймер проверки ошибок загрузки
  if (GetConstantValue('DO_TIMER_LOG_ERROR_ON') = '1') then
  begin
    Timer2.Interval := 1000 * StrToIntDef
      (GetConstantValue('INTERVAL_CHECK_LOG_ERROR'), 0);
    Timer2.Enabled := True;
    Timer2Timer(nil);
  end;

  // Автоотчеты   полностью
  N46.Visible := (GetConstantValue('SHOW_AUTO_REPORTS') = '1');                                       // N46 Верхний пункт меню                Автоотчеты
  if N46.Visible then
  begin
    aReportTariffViolations.Visible      := (GetConstantValue('SHOW_TARIFF_MISMATCHES') = '1');       // N43   Нарушения в тарифах
    aReportPhoneNumberViolations.Visible := (GetConstantValue('SHOW_PHONE_NUMBER_MISMATCHES') = '1'); // N44   Несанкционированные номера
    aReportPhoneForBlockSave.Visible     := (GetConstantValue('SHOW_BLOCK_SAVE') = '1');              // N48   Блокировка на сохранение
    aReportPhoneForUnblockSave.Visible   := (GetConstantValue('SHOW_UNBLOCK_SAVE') = '1');            // N49   Разблокировка из сохранения
  end;

  // Журналы     полностью
  // aJornalAll  // -- видно всегда     // N18           Журнал документов


  // Загрузки     полностью
  miLoadBeeline.Visible                := (GetConstantValue('SHOW_LOAD_BEE_REP') = '1');              // Верхний пункт меню        &Загрузки Билайн
  aBeelineLoadPayments.Visible         := (GetConstantValue('SHOW_LOAD_BEE_REP_PAYMENTS') = '1');     // miLoadBeelinePayments     Платежи Билайн
  aBeelineLoadStatuses.Visible         := (GetConstantValue('SHOW_LOAD_BEE_REP_STATUS') = '1');       // miLoadBeelineStatus       Статусы Билайн
  aBeelineLoadCosts.Visible            := (GetConstantValue('SHOW_LOAD_BEE_REP_NACHISL') = '1');      // miLoadBeelineNachisl      Начисления Билайн
  aBeelineLoadBaseStationMsk.Visible   := (GetConstantValue('SHOW_LOAD_BEE_REP_KODBASESTAT') = '1');  // miLoadBeelineKodBaseStat  Коды базовых станций Москвы
  aBeelineLoadBaseStationMO.Visible    := (GetConstantValue('SHOW_LOAD_BEE_REP_KODBASESTAMO') = '1'); // miLoadBeelineKodBaseStatMO        Коды базовых станций МО
  aBeelineLoadBill.Visible             := (GetConstantValue('SHOW_LOAD_BEE_REP_BILLS') = '1');        // miLoadBeelineBills                Счета Билайн
  aBeelineLoadContracts.Visible        := (GetConstantValue('SHOW_LOAD_BEE_REP_CONTRACT') = '1');     // miLoadBeelineContract             Контракты Билайн
  aBeelineLoadClose.Visible            := (GetConstantValue('SHOW_LOAD_BEE_REP_RASTORZH') = '1');     // miLoadBeelineRastorzh             Расторжения договоров
  aBeelineLoadDetail.Visible           := (GetConstantValue('SHOW_LOAD_BEE_REP_DETAILS') = '1');      // miLoadBeelineDetails              Детализации Билайн
  aBeelineLoadMobiPay.Visible          := (GetConstantValue('SHOW_LOAD_BEE_REP_MOBIPAY') = '1');      // miLoadBeelineMobiPay              MobiPay
  aBeelineLoadChangeTariffs.Visible    := (GetConstantValue('SHOW_LOAD_BEE_REP_CHANGETP') = '1');     // miLoadBeelineChangeTp             Массовая смена ТП
  aBeelineLoadDopPhoneInfo.Visible     := (GetConstantValue('SHOW_LOAD_BEE_REP_DOPPHONEINFO') = '1'); // miLoadBeelineDopPhoneInfo         Загрузка дополнительной информации по номерам
  aCollectorStates.Visible             := (GetConstantValue('SHOW_COLLECTOR_UPLOAD') = '1');          // miCollectorStates                 Статусы коллекторского договора
  aBeelineLoaderSettings.Visible       := (GetConstantValue('SHOW_COLLECTOR_UPLOAD') = '1');          // miBeelineLoaderSettings           Загрузить тех.данные для колл.счёта
  aBeelineLoadChangeDopStatus.Visible  := (GetConstantValue('SHOW_LOAD_BEE_REP_CHANGE_DST') = '1');   // miLoadBeelineChangeDopStatus      Массовая смена доп.статусов
  aBeelineLoadReceivedPayments.Visible := (GetConstantValue('SHOW_LOAD_BEE_REP_RECEIVED_PAY') = '1'); // miLoadBeelineReceivedPayments     Ручные платежи Билайн



  // Мониторинг   полностью
  N35.Visible          := (GetConstantValue('IS_MONITORING') = '1');       // N35 Верхний пункт меню  Мониторинг
  //aMonitorServ.Visible := (GetConstantValue('IS_MONITORING_SERV') = '1');  // N36                     Мониторинг сервисов
 // aMonitorSob.Visible  := True;                                            // V1                      Мониторинг событий


  N1.Enabled          := dm.IsAdmin;
  // Справочники   полностью
  aRefDocumTypes.Visible                := aRefDocumTypes.Visible              and dm.IsAdmin;
  aRefFilials.Visible                   := aRefFilials.Visible                 and dm.IsAdmin;
  aRefUserNames.Visible                 := aRefUserNames.Visible               and dm.IsAdmin;
  aRefCountries.Visible                 := aRefCountries.Visible               and dm.IsAdmin;
  aRefRegions.Visible                   := aRefRegions.Visible                 and dm.IsAdmin;
  aRefPhoneBlocks.Visible               := aRefPhoneBlocks.Visible;
  aRefAccounts.Visible                  := aRefAccounts.Visible                and dm.IsAdmin;
  aRefOperators.Visible                 := aRefOperators.Visible               and dm.IsAdmin;
  aRefContractCancelTypes.Visible       := aRefContractCancelTypes.Visible;
  aRefTariffs.Visible                   := aRefTariffs.Visible                 and dm.IsAdmin;
  aRefTariffOptions.Visible             := aRefTariffOptions.Visible           and dm.IsAdmin;
  aRefTariffOptionBenefits.Visible      := (GetConstantValue('USE_TARIFF_OPTION_GROUP') = '1');
  aRefTariffOptionBenefits.Visible      := aRefTariffOptionBenefits.Visible    and dm.IsAdmin;
  aRefDiscounts.Visible                 := aRefDiscounts.Visible               and dm.IsAdmin;
 // aRefReportType.Visible                := (GetConstantValue('SHOW_REF_MAIL_RECIPIENT') = '1');
 // aRefReportType.Visible                := aRefReportType.Visible              and False;  //  создан для aRefMailRecipients
  aRefMailRecipients.Visible            := (GetConstantValue('SHOW_REF_MAIL_RECIPIENT') = '1');
  aRefStartBalances.Visible             := aRefStartBalances.Visible;
  aRefFixBalance.Visible                := aRefFixBalance.Visible              and dm.IsAdmin;
  aRefPhoneWithDailyAbon.Visible        := (GetConstantValue('CALC_ABON_PAYMENT_TO_MONTH_END') = '1');
  aRefPhoneWithDailyAbon.Visible        := aRefPhoneWithDailyAbon.Visible      and dm.IsAdmin;
  aRefAbonents.Visible                  := aRefAbonents.Visible;
  aRefAbonDiscountAndRassroch.Visible   := (GetConstantValue('USE_ABON_DISCOUNTS') = '1') or (GetConstantValue('USE_INSTALLMENT_PAYMENT') = '1');
  aRefAbonDiscountAndRassroch.Visible   := aRefAbonDiscountAndRassroch.Visible and dm.IsAdmin;
  aRefForwardingPhoneNumber.Visible     := (GetConstantValue('FORWARDING_SYSTEM_ENABLE') = '1');
  aRefForwardingPhoneNumber.Visible     := aRefForwardingPhoneNumber.Visible   and dm.IsAdmin;
  aRefSendSMSParametres.Visible         := aRefSendSMSParametres.Visible       and dm.IsAdmin;
  aRefSendMailParametres.Visible        := (GetConstantValue('SHOW_SEND_MAIL_PARAMETRES') = '1');
  aRefSendMailParametres.Visible        := aRefSendMailParametres.Visible      and dm.IsAdmin;
  aRefRightsTypeAccount.Visible         := aRefRightsTypeAccount.Visible       and dm.IsAdmin;
  aRefParameters.Visible                := aRefParameters.Visible              and dm.IsAdmin;
  aRefCopyDatabase.Visible              := aRefCopyDatabase.Visible            and dm.IsAdmin;
  aRefBlockPhoneNoContract.Visible      := (GetConstantValue('AUTO_BLOCK_PHONE_NO_CONTRACTS') = '1');
  aRefBlockPhoneNoContract.Visible      := aRefBlockPhoneNoContract.Visible    and dm.IsAdmin;
  aRefAccountBillLoad.Visible           := aRefAccountBillLoad.Visible         and dm.IsAdmin;
  aRefDopStatus.Visible                 := (GetConstantValue('SHOW_CONTRACT_DOP_STATUS') = '1');
  aRefDopStatus.Visible                 := aRefDopStatus.Visible               and dm.IsAdmin;
  aRefDealers.Visible                   := (GetConstantValue('SHOW_DEALERS') = '1');
  aRefDealers.Visible                   := aRefDealers.Visible                 and dm.IsAdmin;

  aRefContractGroups.Visible            := (GetConstantValue('SHOW_CONTRACT_GROUPS') = '1');
  IF AnsiPos(UpperCase(dm.OraSession.Username), UpperCase(GetParamValue('USER_TELETIE_EXCEPTION')))=0 then
    aRefContractGroups.Visible          := aRefContractGroups.Visible          and dm.IsAdmin;

  aRefTypePayments.Visible              := (GetConstantValue('USE_TYPE_PAYMENTS') = '1');
  aRefTypePayments.Visible              := aRefTypePayments.Visible            and dm.IsAdmin;
  aRefPhoneUsernameForm.Visible         := (GetConstantValue('SHOW_REF_PHONE_USER_NAME') = '1');
  aRefPhoneUsernameForm.Visible         := aRefPhoneUsernameForm.Visible       and dm.IsAdmin;
  aRefMNP.Visible                       := aRefMNP.Visible                     and dm.IsAdmin;
  aRefVip_Abonents.Visible              := aRefVip_Abonents.Visible and dm.IsAdmin;
  aRefInactivePhoneLessContract.Visible := CheckMenuAccess(Dm.OraSession.Username,'aRefInactivePhoneLessContract');
  aRefTurnTariffOptions.Visible         := aRefTurnTariffOptions.Visible; // видно всегда
  aRefRoamingProviders.Visible          := aRefRoamingProviders.Visible;  // видно всегда
 // aRefMaskBeauty.Visible                := aRefMaskBeauty.Visible;        // видно всегда

  if dm.FUseFilialBlockAccess then
  begin
    aRefDocumTypes.Visible         := False;
    aRefFilials.Visible            := False;
    aRefCountries.Visible          := False;
    aRefRegions.Visible            := False;
    aRefPhoneBlocks.Visible        := False;
    aRefAbonents.Visible           := False;
    aRefSendSMSParametres.Visible  := False;
    aRefSendMailParametres.Visible := False;
    aRefFixBalance.Visible         := False;
    aRefMailRecipients.Visible     := False;
    aRefRightsTypeAccount.Visible  := False;
    aRefParameters.Visible         := False;
  end;

   N12.Enabled          := dm.IsAdmin;
  // Отчеты      полностью
  aReportAccountPhones.Visible   := aReportAccountPhones.Visible;                            // (GetConstantValue('SERVER_NAME')<>'GSM_CORP');        // mniReportAccountPhones            Отчеты по "всем номерам"-Списки номеров
  aReportMobPay.Visible          := (GetConstantValue('SHOW_MOBPAY') = '1');                        // MobPay1                  Платежи_MobPay
  aShowHackers.Visible           := (GetConstantValue('SHOW_SUSPICION_OF_FRAUD') = '1');             // N77                      Подозрительные или мошенники_Подозрение в мошенничестве
  if aShowHackers.Visible and dm.FUseFilialBlockAccess then
    aShowHackers.Visible         := False;                                                         // N77                      Подозрительные или мошенники_Подозрение в мошенничестве
//  aJornalSenging.Visible         := (GetConstantValue('SHOW_JOURNAL_OF_SENDING') = '1');           // N37                      Журналы_Журнал Отправок
//  aDopolnStatus.Visible          := (GetConstantValue('SHOW_REP_OF_DOPSTATUS') = '1');              // N110                     Отчеты по доп. статусам_Отчет доп.статусов
// aJornalLog.Visible             := (GetConstantValue('SHOW_JOURNAL_OF_LOGPHONE') = '1');              // N59                      Журналы_Журнал логов по номеру телефона
  aReportBillViols.Visible       := (GetConstantValue('SHOW_BILLVIOLS') = '1');                  // n78                      Подозрительные или мошенники_Подозрительные счета и номера
  if (GetConstantValue('SHOW_BILLVIOLS') = '1') then
    aReportBillViols.Caption     := 'Подозрительные счета и номера';
  if (GetConstantValue('SHOW_BILL_VIOLATION_IN_ACCOUNT') = '1') then
    aReportBillViols.Caption     := 'Нарушения в счетах';
  if aReportBillViols.Visible and dm.FUseFilialBlockAccess then
    aReportBillViols.Visible     := False;                                                     // N78                      Подозрительные или мошенники_Подозрительные счета и номера
  aReportAccount4Period.Visible  := (GetConstantValue('SHOW_REPORT_ACCOUNT4PERIOD') = '1');    // mniReportAccount4Period  Отчет по счетам за период
  aReportAPIRejectBlocks.Visible := (GetConstantValue('SHOW_REPORT_APIREJECTBLOCKS') = '1');   // mniReportAPIRejectBlocks          Журналы_Отклоненные блокировки/разблокировки через API
  aReportHotBillingFiles.Visible := (GetConstantValue('SHOW_REPORT_HOTBILLINGFILES') = '1');   // miReportHotBillingFiles           Отчет о загрузках горячего биллинга
  aReportRecoveryCloseContracts.Visible :=
    (GetConstantValue('SHOW_REP_RECOV_CLOSE_CONTRACTS') = '1');
  // mniReportRecoveryCloseContracts   Анализ базы номеров (отток\подключения)
  aReportChangeStatusPresaleBlock.Visible :=
    (GetConstantValue('SHOW_REP_CHNG_STAT_PRESAL_BLC') = '1');
  // mniReportChangeStatusPresaleBlock Отчеты по доп. статусам_Отчет по статусу "Предпродажная блокировка"
  // aRefDiscounts.Visible := (GetConstantValue('SHOW_OPERATOR_DISCOUNT') = '1');
  // N21                               Скидка оператора
  aReportBills.Visible := (GetConstantValue('SHOW_BILLS_OPERATOR_AND_CLIENT')
    = '1'); // or  // N47                               Счета
  // (GetConstantValue('SERVER_NAME')='SIM_TRADE');
  if aReportBills.Visible and dm.FUseFilialBlockAccess then
  begin
    aReportBills.Visible := False; // N47                                Счета
  end;
  aReportPhoneForBlockSave.Visible := False;   // := (GetConstantValue('SERVER_NAME')='SIM_TRADE');               // N50                               Блокировка на сохранение
  aReportDilerPayments.Visible := True;        // := (GetConstantValue('SERVER_NAME')='CORP_MOBILE');             // N51                               Комиссия дилерам
  aReportAntiFraudBlocked.Visible := True;     // := (GetConstantValue('SERVER_NAME')='CORP_MOBILE');             // N62                               Подозрительные или мошенники_Блокированные по подозрению в мошеничестве
  aReportHotBillingDelay.Visible := (GetConstantValue('SHOW_HOT_BIL_DELAY') = '1');                  // N69                               Задержки в файлах горячего биллинга
  aReportUSSDSend.Visible := True;   // := (GetConstantValue('SERVER_NAME')='CORP_MOBILE');             // USSD1                             Журналы_Отчет об отправленных USSD
  aReportBalanceOnEndMonth.Visible := False;    // := (GetConstantValue('SERVER_NAME')='GSM_CORP');                // N55                               Балансы на конец месяца
  aReportProfit.Visible := True;     // := (GetConstantValue('SERVER_NAME')<>'LONTANA');                // N27                               Доходность
  aReportAbonPay.Visible := True;     // := (GetConstantValue('SERVER_NAME')<>'LONTANA');                // N32                               Абонентская плата
  aReportPhonePayments.Visible := True;    // := (GetConstantValue('SERVER_NAME')<>'LONTANA');                // N33                               Платежи
  aRefFixBalance.Visible := True;     // := (GetConstantValue('SERVER_NAME')<>'LONTANA');                // N40                               Закрытие периодов (только администратор) периодов
 // aReportPhoneWithContract.Visible := True;
  // := (GetConstantValue('SERVER_NAME')='CORP_MOBILE');             // N93                               Отчет по номерам телефонов с договором
  aReportSityPhoneNumbers.Visible := (GetConstantValue('SHOW_CITY_NUMBERS') = '1');  // N57                               Городские номера
  aReportFieldDetails.Visible := True;
  // := (GetConstantValue('SERVER_NAME')='GSM_CORP')  or             // N58                               Неописанные БС
  // (GetConstantValue('SERVER_NAME')='CORP_MOBILE');
  // if (GetConstantValue('SERVER_NAME')= 'GSM_CORP') then
  // aReportFieldDetails.Caption := 'Номера собеседников';

  aReportYearBillsDayAbon.Visible := (GetConstantValue('CALC_ABON_PAYMENT_TO_MONTH_END') = '1');          // N80                               Счета за год
  aReportPaymentWithoutContracts.Visible := (GetConstantValue('SHOW_PAYMENT_WITHOUT_CONTRACTS') = '1');   // N63                               Платежи без договоров
  aReportContractHandBlock.Visible := (GetConstantValue('REPORT_CONTRACTS_HAND_BLOCK') = '1');            // N65                               Отчеты по доп. статусам_Договора с ручной блокировкой
  aReportKolNomFrm.Visible := (GetConstantValue('SHOW_REPORT_ACCOUNT_STAT_NOW') = '1');                   // N66                               Количество номеров на лицевом счёте
  aReportVirtualPaymets.Visible := (GetConstantValue('SHOW_REPORT_VIRTUAL_PAYMENTS') = '1');              // N67                               Виртуальные платежи
  aReportFinance.Visible := False;// := (GetConstantValue('SERVER_NAME')<>'CORP_MOBILE');                 // aReportFinance1                   Финансовый отчёт
  N84.Visible := True; // := (GetConstantValue('SERVER_NAME')<>'SIM_TRADE');                              // N84           Подменю_Отчет по виртуальным балансам
  aReportAccountInfo.Visible := (GetConstantValue('SHOW_ACCOUNT_INFO') = '1');                            // N85                               Информация о счетах
  aReportPaymentPromised.Visible := (GetConstantValue('USE_PROMISED_PAYMENTS') = '1');                    // N86                               Обещанные платежи(администраторы)
  aReportTariffOptionPhones.Visible := (GetConstantValue('SHOW_REPORT_TARIFF_OPT_PHONES') = '1');         // N87                               Тарифные опции/услуги(адм.)
  aReportMissingPhones.Visible := (GetConstantValue('SHOW_REPORT_MISSING_PHONE') = '1');                  // N88                               Номера исчезнувшие с договоров
  aReportBillNegative.Visible := (GetConstantValue('SHOW_REPORT_BILL_NEGATIVE') = '1');                   // N89                               Счета выставленные в минус
  aReportBillsNoDiscount.Visible := False;                                                       // := (GetConstantValue('SERVER_NAME')='SIM_TRADE');               // C201                              Cчета без скидки ГК20%
  aReportBalanceOnDate.Visible := (GetConstantValue('SHOW_REPORT_BALANCE_ON_DATE') = '1');                // N91                               Балансы по дате
  N60.Visible := (GetConstantValue('SHOW_FINANCE_REPORTS') = '1');                                        // N60           Подменю_Фин. отчеты (только админ.)
  N60.Enabled := dm.IsAdmin;                                    // N60           Меню доступно ток админам.
  aReportFinanceHistoryPhoneActiv.Visible := (GetConstantValue('SHOW_FIN_REP_HISTORY_ACT_PHONE') = '1');  // N64                               Списки активных номеров
  aReportFinanceInflowOutflow.Visible := (GetConstantValue('SHOW_FIN_REP_INFLOW_OUTFLOW') = '1');         // N74                               Приток и отток номеров
  aReportFinanceSumBills.Visible := (GetConstantValue('SHOW_FINANCE_SUM_BILLS') = '1');                   // N92                               Сумма счетов и платежей
  if dm.FUseFilialBlockAccess then
  begin
    aReportBalanceChange.Visible := False; // N70                               Изменения балансов (только администратор)
    aRefPhoneBlocks.Visible := False;      // N10                               Блоки телефонных номеров
  end;
  aReportDebitorka.Visible := (GetConstantValue('SHOW_REPORT_DEBITORKA') = '1'); // N81                               Дебиторская задолженность(админ)
  aReportSumPositiveBalance.Visible := (GetConstantValue('SHOW_SUM_POSITIVE_BALANCE') = '1'); // N95                               Суммы положительных балансов
  aReportPhoneInactivity.Visible :=   (GetConstantValue('SHOW_PHONE_INACTIVITY') = '1');   // N96                               Номера с отсутствующей активностью
  aReportPaymentPassenger.Visible :=  (GetConstantValue('SHOW_REPORT_PASSENGER') = '1');  // miMob_pay                         Платежи_Пассажирский
//  aReportPhone.Visible := True;     // miPhoneReport                     Списковый отчет (администратор
  aReportCurrentQueueSMS.Visible := (GetConstantValue('BEELINE_SMS_GATEWAY') = '1');   // miCurrentQueueSMS                 Текущая очередь СМС
  aReportPhoneOnBan.Visible := (GetConstantValue('SHOW_PHONE_ON_BAN_REPORT') = '1'); // aReportPhoneOnBan1                 Отчет "Список номеров на счетах"
  aReportLoadAccounts.Visible := (GetConstantValue('SHOW_REPORT_LOAD_ACCOUNTS') = '1'); // mnReportLoadAccounts               Отчет прогрузки счетов
  aReportPhonesRashod.Visible := (GetConstantValue('SHOW_REPORT_OVERRUN_ABON_PAY') = '1'); // N100                               Отчет о расходах, не включенных в абон.плату
  aReportReceivables.Visible := (GetConstantValue('SHOW_REPORT_RECEIVABLES') = '1'); // N101                               Дебиторская задолженность по месяцам (админ)
  aReportAccPay4Equip.Visible :=  (GetConstantValue('SHOW_REPORT_ACC_PAY_4_EQUIP') = '1');  // N102                               Отчет по выставленным счетам за оборудование (админ)

  aReportBalance.Visible := True;   // N19                                Текущие балансы
  aReportActiveNumberNoContracts.Visible := True;   // N20                                Активные номера без контрактов
  aReportPhoneStat.Visible := True;      // N23                                Детализации
  aReportPhoneState.Visible := True;   // miReportPhoneState                 Отчет о состоянии номеров по датам
  aReportLoadingLogs.Visible := True;    // N25                                Журнал загрузки
  aReportSummaryMinutes.Visible := True;    // N26                                Количество бесплатных минут
  aReportNumWithoutAbonPay.Visible := True;    // N29                                Номера без трафика с абонентской платой
  aBlockJournal.Visible := True;           // N30                                Журнал блокировки
  aUnBlockJournal.Visible := True;      // N31                                Журнал разблокировки
  aSendSMSJournal.Visible := True;      // N28                                Журнал отправленных SMS
  aSendSMSEndMonthJournal.Visible := True;     // N45                                Журнал SMS предупреждений о конце месяца
  aReportReBlock.Visible := True;            // N98                                Журнал переблокировки на сохранение
  aReportStartPayment.Visible := True;       // nn                                 Отчет по поступившим стартовым платежам
  aBlockPhoneWithDopStatus.Visible := True;    // N103                               Блокировка номеров с доп. статусом
  aReportHoldBlocks.Visible := True;           // miReportHoldBlocks                 Отчет "Отложенная блокировка"
  aReportAutoTurnInternetCurr.Visible := True;    // N104                               Автоподключения интернет-опций (текущий месяц)
  aReportAutoTurnInternetPrev.Visible := True;     // N106                               Автоподключения интернет-опций (прошлые месяца)
  aReportMassRemovalDopStatus.Visible := True;     // N105                               Массовое удаление доп. статусов
  aReportCreditNumber.Visible := True;            // N107                               Отчет по кредитным номерам
  aReportBetweenBills.Visible := True;              // miReportBetweenBills               Отчет "Сравнение счетов (по звонкам)"
  aReportAbonTarifer.Visible := True;              // aReportAbonTarifer1                Отчет по абон.платам, выставленным тарифером за месяц
  aReportHotBillingMissing.Visible := True;        // miReportHotBillingMissing          Отчет "Пропажи гор. биллинга (звонки)"
  aReportMNRoaming.Visible := True;               // N111                               Международный роуминг
  if dm.FUseFilialBlockAccess then
  begin
    aReportBills.Visible         := false;
    aReportBalanceChange.Visible := false;
    aShowHackers.Visible         := false;
    aReportBillViols.Visible     := false;
  end;

  //if runcnt then // вызываем метод только 1 раз
  // изменение стиля формы Self.FormStyle := fsMDIForm вызывает самостоятельно метод FormShow;
  begin
    if not dm.FConnected then
      dm.OraSession_Connect;
    if dm.FConnected then
    begin
      if dm.FUseFilialBlockAccess and (Pos('Тарифер - ', Caption) > 0) then
        Caption := Copy(Caption, 10, Length(Caption) - 9);
    end
    else
    begin
      Close;
    end;


    if Dm.OraSession.Connected then
    begin
     {
      //Чтение констант из БД
      Dm.qConstants.Open;
      Dm.qConstants.First;
      Index:=0;
      while not(Dm.qConstants.Eof) do
      begin
        SetLength(FconstantSettings, Index+1);
        FconstantSettings[Index].Value:=Dm.qConstants.FieldByName('VALUE').AsString;
        FconstantSettings[Index].Name:=Dm.qConstants.FieldByName('NAME').AsString;
        Inc(Index);
        FConstantSettingsCount:=index;
        Dm.qConstants.Next;
      end;
      Dm.qConstants.Close;


      //Чтение прав
      FFilial := Dm.FFilial;
      FUseFilialBlockAccess := Dm.FUseFilialBlockAccess;
      Dm.qParams.First;
      Index:=0;
      while not(Dm.qParams.Eof) do
      begin
        SetLength(FParamSettings, Index+1);
        FParamSettings[Index].Value := Dm.qParams.FieldByName('VALUE').AsString;
        FParamSettings[Index].Name := Dm.qParams.FieldByName('NAME').AsString;
        Inc(Index);
        FParamSettingsCount:=index;
        Dm.qParams.Next;
      end;
      FConnected := True;
      }

      aReportTariffViolations.Visible:=(GetConstantValue('SHOW_TARIFF_MISMATCHES')='1');
      aRefTypePayments.Visible:=(GetConstantValue('USE_TYPE_PAYMENTS')='1');
      aReportPhoneNumberViolations.Visible:=(GetConstantValue('SHOW_PHONE_NUMBER_MISMATCHES')='1');
      aRefSendMailParametres.Visible:=(GetConstantValue('SHOW_SEND_MAIL_PARAMETRES')='1');
      aRefMailRecipients.Visible:=(GetConstantValue('SHOW_REF_MAIL_RECIPIENT')='1');
      miLoadBeeline.Visible :=  (GetConstantValue('SHOW_LOAD_BEE_REP')='1');
      miLoadBeelinePayments.Visible:=(GetConstantValue('SHOW_LOAD_BEE_REP_PAYMENTS')='1');
      miLoadBeelineStatus.Visible:=(GetConstantValue('SHOW_LOAD_BEE_REP_STATUS')='1');
      miLoadBeelineNachisl.Visible:=(GetConstantValue('SHOW_LOAD_BEE_REP_NACHISL')='1');
      miLoadBeelineKodBaseStat.Visible:=(GetConstantValue('SHOW_LOAD_BEE_REP_KODBASESTAT')='1');
      miLoadBeelineKodBaseStatMO.Visible:=(GetConstantValue('SHOW_LOAD_BEE_REP_KODBASESTAMO')='1');
      miLoadBeelineBills.Visible:=(GetConstantValue('SHOW_LOAD_BEE_REP_BILLS')='1');
      miLoadBeelineContract.Visible:=(GetConstantValue('SHOW_LOAD_BEE_REP_CONTRACT')='1');
      miLoadBeelineRastorzh.Visible:=(GetConstantValue('SHOW_LOAD_BEE_REP_RASTORZH')='1');
      miLoadBeelineDetails.Visible:=(GetConstantValue('SHOW_LOAD_BEE_REP_DETAILS')='1');
      miLoadBeelineMobiPay.Visible:=(GetConstantValue('SHOW_LOAD_BEE_REP_MOBIPAY')='1');
      miLoadBeelineChangeTp.Visible:=(GetConstantValue('SHOW_LOAD_BEE_REP_CHANGETP')='1');
      miLoadBeelineDopPhoneInfo.Visible:=(GetConstantValue('SHOW_LOAD_BEE_REP_DOPPHONEINFO')='1');
      miCollectorStates.Visible:=(GetConstantValue('SHOW_COLLECTOR_UPLOAD')='1');
      miBeelineLoaderSettings.Visible:=(GetConstantValue('SHOW_COLLECTOR_UPLOAD')='1');
      miLoadBeelineChangeDopStatus.Visible:=(GetConstantValue('SHOW_LOAD_BEE_REP_CHANGE_DST')='1');
      mniReportAccountPhones.Visible:= True;//(GetConstantValue('SERVER_NAME')<>'GSM_CORP');
      N48.Visible:=(GetConstantValue('SHOW_BLOCK_SAVE')='1');
      N49.Visible:=(GetConstantValue('SHOW_UNBLOCK_SAVE')='1');
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
      mniReportAPIRejectBlocks.Visible := (GetConstantValue('SHOW_REPORT_APIREJECTBLOCKS')='1');  // Отчет Отклоненные блокировки/разблокировки через апи за период
      miReportHotBillingFiles.Visible := (GetConstantValue('SHOW_REPORT_HOTBILLINGFILES')='1');  // Отчет о загрузках горячего биллинга
      mniReportRecoveryCloseContracts.Visible := (GetConstantValue('SHOW_REP_RECOV_CLOSE_CONTRACTS')='1');  // Отчет Отклоненные блокировки/разблокировки через апи за период
      aReportChangeStatusPresaleBlock.Visible := (GetConstantValue('SHOW_REP_CHNG_STAT_PRESAL_BLC')='1');  // Отчет по статусу "Предпродажная блокировка"

      if GetConstantValue('SHOW_BILLVIOLS')='1'  then
        N78.Caption:='Подозрительные счета и номера' ;

      if GetConstantValue('SHOW_BILL_VIOLATION_IN_ACCOUNT')>='1'  then
        N78.Caption:='Нарушения в счетах' ;

      aRefDiscounts.Visible:=(GetConstantValue('SHOW_OPERATOR_DISCOUNT')='1');
      aReportBills.Visible:= (GetConstantValue('SHOW_BILLS_OPERATOR_AND_CLIENT')='1') or (GetConstantValue('SERVER_NAME')='SIM_TRADE');
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
      N82.Visible:=(GetConstantValue('USE_ABON_DISCOUNTS')='1') or (GetConstantValue('USE_INSTALLMENT_PAYMENT')='1');
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
      miLoadBeelineReceivedPayments.Visible:=(GetConstantValue('SHOW_LOAD_BEE_REP_RECEIVED_PAY')='1');
      //Отчет Пассажирский
      miMob_pay.Visible:=(GetConstantValue('SHOW_REPORT_PASSENGER')='1');
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

    aRefDiscounts.Visible := True;
    aRefDiscounts.Enabled := True;

    //runcnt := False;
  end;

end;

procedure TMainForm.ChengeMDI;
begin
  if dm.MDI_State then
  begin
    PSh.Visible := False;
    aCloseWind.Visible := False;
    WindowClose1.Visible := True;
    WindowArrange1.Visible := True;
    WindowCascade1.Visible := True;
    WindowMinimizeAll1.Visible := True;
    WindowTileHorizontal1.Visible := True;
    WindowTileVertical1.Visible := True;
    self.FormStyle := fsMDIForm;
    //NewWinProc := MakeObjectInstance(NewWinProcedure);
    //OldWinProc := Pointer(SetWindowLong(ClientHandle, gwl_WndProc,Cardinal(NewWinProc)));
    aWindChengeMDI.Caption := 'Однооконный режим';
    aWindChengeMDI.Hint := 'Переключить в Однооконный режим';
  end
  else
  begin
    PSh.Visible := True;
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

procedure TMainForm.InitBtn;
begin
  Attention_btn.Parent := StatusLine;
  Attention_btn.Top := 3;
  Attention_btn.Left := 0;
  Attention_btn.Hint := ' ВНИМАНИЕ!!! Снижение баланса.';
  Attention_btn.Visible := False;

  Attention_btn1.Parent := StatusLine;
  Attention_btn1.Top := 3;
  Attention_btn1.Left := StatusLine.panels[0].Width + 1;
  Attention_btn1.Hint := ' ВНИМАНИЕ!!! Задержка горячего биллинга.';
  Attention_btn1.Visible := False;

  Attention_btn2.Parent := StatusLine;
  Attention_btn2.Top := 3;
  Attention_btn2.Left := StatusLine.panels[0].Width + StatusLine.panels[1]
    .Width + 2;
  Attention_btn2.Visible := False;

  Attention_btn3.Parent := StatusLine;
  Attention_btn3.Top := 3;
  Attention_btn3.Left := StatusLine.panels[0].Width + StatusLine.panels[1].Width
    + StatusLine.panels[2].Width + 3;
  Attention_btn3.Hint := ' ВНИМАНИЕ!!! Обнаружены мошенники!';
  Attention_btn3.Visible := False;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
var
  i: Integer;
begin
  PSh.Free;

  OutCanvas.Free;
  for i := Low(ListClass) to High(ListClass) do
    ListClass[i] := nil;
  SetLength(ListClass, 0);
  closeProg := True;
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
    Close;
end;

procedure TMainForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
//
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  if not dm.MDI_State then
    PicShowDblClick(PSh);
  ChengeMDI;
  if dm.fUserRightsType <> 3 then
    aJornalAll.Execute;
  if not dm.splashDone then
  begin
    dm.splashDone := True;
    dm.SplScreen.Hide;
  end;
  LoadKeyboardLayout('00000419', KLF_ACTIVATE); // рус
  AnimateWindow(Handle, 500, AW_CENTER or AW_ACTIVATE);
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
    FillRect(Rect) ;
    TextRect(Rect,2 +Rect.Left, 10 + Rect.Top,Panel.Text) ;
  end;
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
var
  MThread: TMainFrmTmr1;
begin
  MThread := TMainFrmTmr1.Create();
  MThread.OraSession := dm.OraSession;
  MThread.UserRightsType_ := dm.fUserRightsType;
  MThread.CheckBalanceChange := (GetConstantValue('DO_CHECK_BALANCE_CHANGE') = '1');
  MThread.CheckHotBilLoadLog := (GetConstantValue('DO_CHECK_HOT_BIL_LOAD_LOG') = '1');
  MThread.CheckLoadLog := (GetConstantValue('DO_CHECK_LOAD_LOG') = '1');
  MThread.CheckHackers := (GetConstantValue('DO_CHECK_HACKERS') = '1');
  MThread.CheckHotBilLoad := (GetConstantValue('DO_CHECK_HOT_BIL_LOAD') = '1');
  MThread.FreeOnTerminate := True;
  MThread.Start;
end;

procedure TMainForm.Timer2Timer(Sender: TObject);
var
  MThread: TMainFrmTmr2;
begin
  MThread := TMainFrmTmr2.Create();
  MThread.OraSession := dm.OraSession;
  MThread.IntervalCheckLogError :=
    StrToIntDef(GetConstantValue('INTERVAL_CHECK_LOG_ERROR'), 0);
  MThread.MailLogError := GetConstantValue('MAIL_LOG_ERROR');
  MThread.FreeOnTerminate := True;
  MThread.Start;
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
    //   var
  //RefFrm : TReportDopStatusForm;
begin
  //RefFrm :=
  TReportDopStatusForm.Create(Application);

end;



procedure TMainForm.N36Click(Sender: TObject);
begin
 if not IsMonitorRun then
 begin
  // CheckAdminPrivileges;
   f1 := TMonitorServ.Create(Application);
   IsMonitorRun:=true;
   f1.FormStyle := fsMDIChild;
 end
 else
 begin
   f1.FormActivate(self);
 end;
end;

procedure TMainForm.N37Click(Sender: TObject);
//var
 // RefFrm : TRefAllSendMailForm;
begin
  //RefFrm :=
  TRefAllSendMailForm.Create(Application);
end;

procedure TMainForm.N59Click(Sender: TObject);
//var
 // RefFrm : TRefAllLogsForm;
begin
  //RefFrm :=
  TRefAllLogsForm.Create(Application);

end;

procedure TMainForm.N84Click(Sender: TObject);
// var
 // RefFrm1 : TRepCalcBalanceFRM;
begin
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

procedure TMainForm.aBlockPhoneWithDopStatusExecute(Sender: TObject);
var RefForm: TBlockPhoneWithDopStatusForm;
begin
  CheckAdminPrivileges;
  RefForm:=TBlockPhoneWithDopStatusForm.Create(Application);
  try
    RefForm.ShowModal;
  finally
    RefForm.Free;
  end;
end;

procedure TMainForm.aCloseWindExecute(Sender: TObject);
begin
 NameForm := 'Тарифер - Учет абонентов ' + dm.VersionOfModule + ' - ' + dm.OraSession.Username;
  itm := 0;
  Caption := dm.MainCaption;
  SetActiveScreen;
  self.OnKeyDown := FormKeyDown;
  self.OnKeyPress := FormKeyPress;
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
  Dm.OraSQLMon.Active := False;
  try
    Ini := TIniFile.Create( ChangeFileExt( Application.ExeName, '.INI' ) ); // ParamStr(0)
    try
      Dm.OraSQLMon.Active := ('1' = Ini.ReadString('CONNECT', 'DEBUG', '0'));
    finally
      Ini.Free;
    end;
  except // глотаем ошибку
    //
  end;
  Dm.OraSession.Connected := False;
  Dm.OraSession.Connected := True;
end;

procedure TMainForm.aRefRoamingProvidersExecute(Sender: TObject);
begin
  TfrmRefRoamingProviders.ShowAsMDIChild;
end;

procedure TMainForm.aReportCurrentQueueSMSExecute(Sender: TObject);
var
  fReportCurrentQueueSMS : TfReportCurrentQueueSMS;
begin
  fReportCurrentQueueSMS := TfReportCurrentQueueSMS.Create(nil);
  try
    fReportCurrentQueueSMS.Execute (Dm.OraSession);
  finally
    FreeAndNil(fReportCurrentQueueSMS);
  end;
end;

procedure TMainForm.aRefInactivePhoneLessContractExecute(Sender: TObject);
var RefFrm:TRefInactivePhoneLessContForm;
begin
//  CheckAdminPrivileges;
  if CheckMenuAccess(Dm.OraSession.Username,'aRefInactivePhoneLessContract') then begin
    RefFrm := TRefInactivePhoneLessContForm.Create(Application);
    RefFrm.FormStyle := fsMDIChild;
  end
  else
  MessageDlg('Доступ к справочнику запрещен!', mtError, [mbOK], 0);
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
  //DoShowBalanceChange;
  Timer1.Enabled:=false;
  DoShowModalBalanceChange;
  Timer1.Enabled:=true;
  Timer1Timer(nil);
end;

procedure TMainForm.aReportAbonLKExecute(Sender: TObject);
begin
 DoShowReportAbonLK;
end;

procedure TMainForm.aReportAbonPayExecute(Sender: TObject);
begin
 DoReportAbonPay;
end;

procedure TMainForm.aReportAbonTariferExecute(Sender: TObject);
begin
 DoReportAbonTarifer;
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
  result:=Dm.OraSession.Username;
end;

function TMainForm.UserRightsType:integer;
begin
 if FUserRightsType=-1 then begin
  try
    qUserRigthsType_EncryptPwd__.ParamByName('USER_NAME').AsString := Dm.OraSession.Username;
    qUserRigthsType_EncryptPwd__.Open;
    FUserRightsType:=qUserRigthsType_EncryptPwd__.FieldByName('rights_type').AsInteger;
    FCheckAllow:=qUserRigthsType_EncryptPwd__.FieldByName('CHECK_ALLOW_ACCOUNT').AsInteger;
  finally
    qUserRigthsType_EncryptPwd__.close;
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
 else
 begin
   f2.FormActivate(self);
 end;
end;

procedure TMainForm.CheckAdminPrivs(var IsAdmin: Boolean);
 var
  tempbol:boolean;
begin
  if SameText(Dm.OraSession.Username, Dm.OraSession.Schema) then
    IsAdmin:=true
  else
  begin
    if FIsAdmin=-1 then begin
      // Под именем схемы работает администратор!
      qCheckUserPrivileges.ParamByName('USER_NAME').AsString := Dm.OraSession.Username;
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
    else
    begin
      if FIsAdmin=1 then
        IsAdmin:= true
      else
        IsAdmin:= false;
    end;

  end;
end;

procedure TMainForm.CheckROPrivs(var IsRO: Boolean);
begin
  if SameText(Dm.OraSession.Username, Dm.OraSession.Schema) then
    IsRo:=true
  else begin
    // Под именем схемы работает администратор!
    qCheckROPrivileges.ParamByName('USER_NAME').AsString := Dm.OraSession.Username;
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
begin
  CheckAdminPrivileges;
  CommonClickMenu(Sender);
end;

procedure TMainForm.aRefDocumTypesExecute(Sender: TObject);
begin
  CheckAdminPrivileges;
  CommonClickMenu(Sender);
end;

procedure TMainForm.aRefDopStatusExecute(Sender: TObject);
var RefFrm:TRefDopStatusForm;
begin
  CheckAdminPrivileges;
  RefFrm := TRefDopStatusForm.Create(Application);
  RefFrm.FormStyle := fsMDIChild;
end;

procedure TMainForm.aRefFilialsExecute(Sender: TObject);
begin
  CheckAdminPrivileges;
  CommonClickMenu(Sender);
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
begin
  CommonClickMenu(Sender);
end;

procedure TMainForm.aRefMNPExecute(Sender: TObject);
var RefFrm : TMNP_NUMBERS;
begin
//  CheckAdminPrivileges;
//  RefFrm := TMNP_NUMBERS.Create(Application);
 // RefFrm.FormStyle := fsMDIChild;
end;

procedure TMainForm.aRefUserNamesExecute(Sender: TObject);
begin
  CheckAdminPrivileges;
  CommonClickMenu(Sender);
end;

procedure TMainForm.aRefVip_AbonentsExecute(Sender: TObject);
var RefFrm : TVIP_Abonents;
begin
  CheckAdminPrivileges;
  RefFrm := TVIP_Abonents.Create(Application);
  RefFrm.FormStyle := fsMDIChild;
end;

procedure TMainForm.aRefCountriesExecute(Sender: TObject);
begin
  CheckAdminPrivileges;
  CommonClickMenu(Sender);
end;

procedure TMainForm.aRefRegionsExecute(Sender: TObject);
begin
  CheckAdminPrivileges;
  CommonClickMenu(Sender);
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
begin
  CommonClickMenu(Sender);
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

procedure TMainForm.aRefSpecialBansExecute(Sender: TObject);
begin
  CheckAdminPrivileges;
  CommonClickMenu(Sender);
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
begin
  CheckAdminPrivileges;
  CommonClickMenu(Sender);
end;

procedure TMainForm.aRefTurnTariffOptionsExecute(Sender: TObject);
begin
  DoTurnTariffOptions('');
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
begin
  CheckAdminPrivileges;
  CommonClickMenu(Sender);
end;

procedure TMainForm.aRefContractCancelTypesExecute(Sender: TObject);
var RefFrm : TRefContractCancelTypesForm;
begin
  CheckAdminPrivileges;
  RefFrm := TRefContractCancelTypesForm.Create(Application);
  RefFrm.FormStyle := fsMDIChild;
end;

procedure TMainForm.aRefContractGroupsExecute(Sender: TObject);
var RefFrm : TRefContractGroupsForm;
begin

  IF AnsiPos(UpperCase(Dm.OraSession.Username),UpperCase(GetParamValue('USER_TELETIE_EXCEPTION')))=0 then
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
 if FCheckAllow = -1 then begin
  try
    qUserRigthsType_EncryptPwd__.ParamByName('USER_NAME').AsString := Dm.OraSession.Username;
    qUserRigthsType_EncryptPwd__.Open;
    FUserRightsType := qUserRigthsType_EncryptPwd__.FieldByName('rights_type').AsInteger;
    FCheckAllow:=qUserRigthsType_EncryptPwd__.FieldByName('CHECK_ALLOW_ACCOUNT').AsInteger;
  finally
    qUserRigthsType_EncryptPwd__.close;
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

procedure TMainForm.aReportBetweenBillsExecute(Sender: TObject);
begin
  DoRepDiffBetweenBills;
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

procedure TMainForm.aReportHoldBlocksExecute(Sender: TObject);
begin
  // Отчет по отложеннолй блокировке
  DoReportBlocks;
end;

procedure TMainForm.aReportChangeStatusPresaleBlockExecute(Sender: TObject);
begin
  DoReportChangeStatusPresaleBlock;
end;

procedure TMainForm.aReportContractHandBlockExecute(Sender: TObject);
begin
 DoContractHandBlock;
end;

procedure TMainForm.aReportControlFlowTraffDraveMonExecute(Sender: TObject);
begin
  CheckAdminPrivileges;
  DoReportControlFlowTraffDraveMon;
end;

procedure TMainForm.aReportCreditNumberExecute(Sender: TObject);
begin
  DoReportCreditNumber;
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

procedure TMainForm.aReportAutoTurnInternetCurrExecute(Sender: TObject);
begin
 DoReportAutoTurnInternetCurr;
end;

procedure TMainForm.aReportAutoTurnInternetLimitExecute(Sender: TObject);
begin
  CheckAdminPrivileges;
  DoReportAutoTurnInternetLimit;
end;

procedure TMainForm.aReportAutoTurnInternetPrevExecute(Sender: TObject);
begin
 DoReportAutoTurnInternetPrev;
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

procedure TMainForm.aReportHotBillingMissingExecute(Sender: TObject);
begin// Пропажи гор.билинга
  DofrmHotBilling;
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
    BeelineLoaderForm.Execute(Dm.OraSession);
  finally
    FreeAndNil(BeelineLoaderForm);
  end;
end;

procedure TMainForm.aReportPhonePaymentLCExecute(Sender: TObject);
begin
  TReportPhonePaymentsFrmLC.ShowReport;
end;

procedure TMainForm.aReportPhonePaymentsExecute(Sender: TObject);
begin
  DoReportPhonePayments;
end;

procedure TMainForm.aReportPhonesRashodExecute(Sender: TObject);
begin
  DoRepRaschodPhones(Dm.OraSession);
end;

procedure TMainForm.aReportPhoneStateExecute(Sender: TObject);
begin
  DoReportPhoneState;
end;

procedure TMainForm.aReportPhoneStatExecute(Sender: TObject);
begin
  CheckAdminPrivileges;
  DoReportPhoneStat;
end;

procedure TMainForm.aReportPotencialActivityExecute(Sender: TObject);
begin
  TReportPotencialActivityFrm.ShowReport;
end;

procedure TMainForm.aReportLoadAccountsExecute(Sender: TObject);
begin
  DoReportLoadAccounts(Dm.OraSession);
end;

procedure TMainForm.aReportLoadingLogsExecute(Sender: TObject);
var
  RefFrm : TRefAccountsForm;
begin
  RefFrm := TRefAccountsForm.Create(Application);
  RefFrm.Execute(True); // только для контроля!
end;

procedure TMainForm.aReportLossPhoneNumberExecute(Sender: TObject);
begin
  TReportLossPhoneNumber.ShowReport;
end;

procedure TMainForm.aReportMassRemovalDopStatusExecute(Sender: TObject);
begin
  CheckAdminPrivileges;
  DoReportMassRemovalDopStatus;
end;

procedure TMainForm.aReportMissingPhonesExecute(Sender: TObject);
begin
  DoReportMissingPhones;
end;

procedure TMainForm.aReportMNRoamingExecute(Sender: TObject);
begin
  TfReportMNRoaming.ShowReport;
end;

procedure TMainForm.aReportMobPayExecute(Sender: TObject);
begin
  DoReportMobPay;
end;

procedure TMainForm.aReportMonitorAutoTurnInternetExecute(Sender: TObject);
begin
  CheckAdminPrivileges;
  DoReportMonitorAutoTurnInternet;
end;

procedure TMainForm.aReportSityPhoneNumbersExecute(Sender: TObject);
begin
  TReportSityPhoneNumbersForm.Create(Application).Execute(true);
end;

procedure TMainForm.aReportStartPaymentExecute(Sender: TObject);
begin
 DoReportStartPayment;
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

procedure TMainForm.aUnReportBillsExecute(Sender: TObject);
begin // Отчет по биллингу для сетей
  DoShowReportBills;
end;

procedure TMainForm.aWindChengeMDIExecute(Sender: TObject);
begin
  dm.MDI_State := not dm.MDI_State;
  ChengeMDI;
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
  if CheckAdminMenu(Dm.OraSession.Username,'aReportPaymentPromised') then
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

procedure TMainForm.aReportControlTrafficPckgAllPhoneExecute(Sender: TObject);
begin
  CheckAdminPrivileges;
  DoReportControlTrafficPckgAllPhone;
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

procedure TMainForm.OraSessionAfterConnect(Sender: TObject);
begin
  Caption := 'Тарифер - Учет абонентов ' + GetVersionTextOfModule(ParamStr(0)) + ' - ' + Dm.OraSession.Username;
  FUser:=Dm.OraSession.Username;
end;



procedure TMainForm.InitPsh;
begin
  if dm.showZastav then
  begin
    PSh := TPicShow.Create(self);
    PSh.Parent := self;
    PSh.OverDraw := False;
    PSh.ParentColor := False;
    PSh.BgMode := bmTiled;
    PSh.Center := True;
    PSh.Color := clGradientActiveCaption;
    PSh.AutoSize := True;
    PSh.Enabled := True;
    PSh.Picture := dm.ClientImg;
    PSh.Step := 2;
    PSh.Stretch := True;
    PSh.StretchFine := True;
    PSh.Style := 103;
    PSh.Threaded := True;
    PSh.ThreadPriority := tpHigher;
    PSh.Visible := True;
    PSh.Reverse := False;
    PSh.OnDblClick := PicShowDblClick;
    PSh.Align := alClient;
    PicShowDblClick(PSh);
  end;
end;

procedure TMainForm.PicShowDblClick(Sender: TObject);
begin
  if Sender is (TPicShow) then
  begin
    TPicShow(Sender).Enabled := False; // To perevent reentrance
    TPicShow(Sender).BgMode := bmNone;
    TPicShow(Sender).Refresh;
    try
      TPicShow(Sender).Execute;
    finally
      TPicShow(Sender).Enabled := True;
      TPicShow(Sender).BgMode := bmStretched;
      TPicShow(Sender).Refresh;
      TPicShow(Sender).Show;
      TPicShow(Sender).Repaint;
    end;
  end;
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
    // WindowState := wsMinimized;
    // ShowWindow(Application.Handle, sw_Hide);
    // Application.ShowMainform := false;
    inherited;
    // ShowMessage('Попытка свернуть форму');
  end
  else
    inherited;
end;

/// ///=======================
constructor TMainFrmTmr1.Create;
begin
  inherited Create(True);
  qBalanceChange := TOraQuery.Create(nil);
  qBalanceChange.SQL.Clear;
  qBalanceChange.SQL.Add
    ('SELECT count(b.account_id) cnt from balance_change b WHERE b.user_last_updated IS NULL');
  fHint := '';
  qReadLog := TOraStoredProc.Create(nil);
  qReadLog.StoredProcName := 'READ_LOG';
  qLoadLog := TOraQuery.Create(nil);
  qLoadLog.SQL.Clear;
  qLoadLog.SQL.Add
    ('SELECT account_id, login, account_load_type_id, is_success, cnt FROM VPR_MAINFORM_QLOADLOG_MAT');
  razdelit := ';';
  qHackers := TOraQuery.Create(nil);
  qHackers.SQL.Clear;
  qHackers.SQL.Add
    ('SELECT count(hackers_id) cnt FROM hackers WHERE CHECKED_TYPE_ID = 1');
  TmpQuery := TOraQuery.Create(nil);
  TmpQuery.SQL.Clear;
  TmpQuery.SQL.Add('select * from v_status_bar_loader_test');
  qHBWArning := TOraQuery.Create(nil);
  qHBWArning.SQL.Clear;
  qHBWArning.SQL.Add
    ('select max(t) cnt from ( select count(*) as t from hot_billing_files hbf '
    + ' where hbf.load_edate is null and substr(hbf.file_name,-3) = ''dbf'' and '
    + ' hbf.load_sdate <= sysdate - to_number(MS_params.GET_PARAM_VALUE ' +
    '(''MAX_HOUR_HOT_BILL_FILE_WORK''))/24 union all ' +
    ' select case when max(to_date(substr(hbf.file_name, -19, 15), ''yyyymmdd-hh24miss'')) '
    + '<= sysdate - to_number(MS_params.GET_PARAM_VALUE ' +
    '(''MAX_DELAY_NEXT_HOT_BILL_FILE''))/24 then 1 else 0 end case from hot_billing_files '
    + ' hbf where substr(hbf.file_name,-3) = ''dbf'') ');

end;

destructor TMainFrmTmr1.Destroy;
begin
  qBalanceChange.Free;
  qReadLog.Free;
  qHackers.Free;
  TmpQuery.Free;
  qHBWArning.Free;

  inherited;
end;

procedure TMainFrmTmr1.SetOraSession(const Value: TOraSession);
begin
  fOraSession := Value;
  qReadLog.Session := Value;
  qBalanceChange.Session := Value;
  qLoadLog.Session := Value;
  qHackers.Session := Value;
  TmpQuery.Session := Value;
  qHBWArning.Session := Value;
end;

procedure TMainFrmTmr1.SetLocalFrm(const Value: TForm);
begin
  fLocalFrm := Value;
end;

procedure TMainFrmTmr1.Execute;
begin
  if UserRightsType_ <> 3 then
  begin
    if CheckBalanceChange then
    begin
      qBalanceChange.open;
      if (qBalanceChange.FieldByName('cnt').AsInteger > 0) then
        fAttentionBbtnVisible := True
      else
        fAttentionBbtnVisible := False;
      qBalanceChange.Close;
    end;
    if CheckHotBilLoadLog then
    begin
      qReadLog.ExecSQL;
      if qReadLog.ParamByName('Result').AsInteger = 1 then
        if fHint <> '' then
          fHint := fHint + razdelit + ' Закончилась память на сервере.'
        else
          fHint := fHint + ' Закончилась память на сервере.';
    end;
    if CheckLoadLog then
    begin
      qLoadLog.open;
      if qLoadLog.RecordCount > 0 then
        if fHint <> '' then
          fHint := fHint + razdelit +
            ' Ошибки при загрузке платежей или отчетов по начислениям или в тек.месяце нет загруженных счетов.'
        else
          fHint := fHint +
            ' Ошибки при загрузке платежей или отчетов по начислениям или в тек.месяце нет загруженных счетов.';
      qLoadLog.Close;
    end;
    if CheckHackers then
    begin
      qHackers.open;
      if qHackers.FieldByName('cnt').AsInteger > 0 then
        fAttentionBtn3Visible := True
      else
        fAttentionBtn3Visible := False;
      qHackers.Close;
    end;
    TmpQuery.open;
    fApi := TmpQuery.FieldByName('api').AsInteger;
    fE_care := TmpQuery.FieldByName('e_care').AsInteger;
    fOld_cab := TmpQuery.FieldByName('old_cab').AsInteger;
    TmpQuery.Close;
  end;
  if CheckHotBilLoad then
  begin
    qHBWArning.open;
    if qHBWArning.FieldByName('cnt').AsInteger > 0 then
      fAttentionBtn1Visible := True
    else
      fAttentionBtn1Visible := False;
    qHBWArning.Close;
  end;
  Synchronize(UpdateAttentionBtn);
end;

procedure TMainFrmTmr1.UpdateAttentionBtn;
var
  iRight, iLeft, iTop, iBottom, i: Integer;
begin
  if UserRightsType_ <> 3 then
  begin
    MainForm.Attention_btn.Visible := fAttentionBbtnVisible;
    if fHint <> '' then
    begin
      MainForm.Attention_btn2.Hint := ' ВНИМАНИЕ!!! ' + fHint;
      MainForm.Attention_btn2.Visible := True;
    end
    else
      MainForm.Attention_btn2.Visible := False;
    MainForm.Attention_btn3.Visible := fAttentionBtn3Visible;
    MainForm.StatusLine.panels[5].Text := 'API';
    MainForm.StatusLine.panels[6].Text := 'e-Care';
    MainForm.StatusLine.panels[7].Text := 'С.каб.';
    dm.api := fApi;
    dm.e_care := fE_care;
    dm.old_cab := fOld_cab;
    iRight := 0;
    for i := 0 to MainForm.StatusLine.panels.Count - 1 do
    begin
      iRight := iRight + MainForm.StatusLine.panels[i].Width;
      iLeft := MainForm.StatusLine.Left + iRight;
      iTop := MainForm.StatusLine.Top;
      iBottom := MainForm.StatusLine.Top + MainForm.StatusLine.Height;
      MainForm.StatusLineDrawPanel(MainForm.StatusLine,
        MainForm.StatusLine.panels[i], Rect(iLeft, iTop, iRight, iBottom));
    end;
  end;
  MainForm.Attention_btn1.Visible := fAttentionBtn1Visible;
end;

constructor TMainFrmTmr2.Create;
begin
  inherited Create(True);
  FStringStream := TStringStream.Create;
  qLoadLog_Error := TOraQuery.Create(nil);
  qLoadLog_Error.SQL.Clear;
  qLoadLog_Error.SQL.Add
    ('SELECT account_id, login, account_load_type_id, is_success, cnt FROM VPR_MAINFORM_QLOADLOG_MAT WHERE cnt = 0 AND '
    + ' not exists(select * from log_send_mail_error m where m.date_send > sysdate -(:INTERVAL_CHECK_LOG_ERROR-1)/(24*60*60)) ORDER BY 1');
  send_mail_detail := TOraStoredProc.Create(nil);
  send_mail_detail.StoredProcName := 'SEND_MAIL1';
  send_mail_detail.Params.CreateParam(ftString, 'RECIPIENT', ptInput);
  send_mail_detail.Params.CreateParam(ftString, 'MESSAGE_TITLE', ptInput);
  send_mail_detail.Params.CreateParam(ftOraClob, 'MAIL_TEXT', ptInput);

  TmpQuery := TOraQuery.Create(nil);
  TmpQuery.SQL.Clear;
  TmpQuery.SQL.Add
    ('INSERT INTO log_send_mail_error (date_send, note) VALUES(SYSDATE, :note)');
end;

destructor TMainFrmTmr2.Destroy;
begin
  qLoadLog_Error.Free;
  send_mail_detail.Free;
  TmpQuery.Free;
  FStringStream.Free;
  inherited;
end;

procedure TMainFrmTmr2.SetOraSession(const Value: TOraSession);
begin
  fOraSession := Value;
  qLoadLog_Error.Session := Value;
  send_mail_detail.Session := Value;

  TmpQuery.Session := Value;
end;

function TMainFrmTmr2.Td(S: string): string;
begin
  Result := '<td>' + S + '</td>';
end;

procedure TMainFrmTmr2.Execute;
var
  S: string;
  ol: TOraLob;
begin
  ErrorMess := '';
  qLoadLog_Error.ParamByName('INTERVAL_CHECK_LOG_ERROR').AsInteger :=
    IntervalCheckLogError;
  qLoadLog_Error.open;
  if qLoadLog_Error.RecordCount > 0 then
  begin
    FStringStream.Position := 0;
    FStringStream.WriteString('<html><body>');
    FStringStream.WriteString('<h1>Ошибки загрузки</h1>');
    FStringStream.WriteString
      ('<table cellpadding="10" cellspacing="0" style="border:#666666 1px solid;">');
    FStringStream.WriteString('<tr style="font-weight: bold">');
    FStringStream.WriteString(Td('Л/с'));
    FStringStream.WriteString(Td('Ошибка') + '</tr>');
    qLoadLog_Error.First;
    while not qLoadLog_Error.Eof do
    begin
      FStringStream.WriteString('<tr>' + Td(qLoadLog_Error.FieldByName('login')
        .AsString));
      if qLoadLog_Error.FieldByName('account_load_type_id').AsInteger = 1 then
        FStringStream.WriteString(Td('Не загружаются платежи.') + '</tr>');
      if qLoadLog_Error.FieldByName('account_load_type_id').AsInteger = 6 then
        FStringStream.WriteString(Td('Не загружаются отчеты по начислениям.')
          + '</tr>');
      if qLoadLog_Error.FieldByName('account_load_type_id').AsInteger = 5 then
        FStringStream.WriteString(Td('В тек.месяце нет загруженных счетов.')
          + '</tr>');
      if qLoadLog_Error.FieldByName('account_load_type_id').AsInteger = 7 then
        FStringStream.WriteString
          (Td('В тек.месяце нет загруженных детальных счетов.') + '</tr>');
      qLoadLog_Error.Next;
    end;
    FStringStream.WriteString('</table></body></html>');

    ol := send_mail_detail.ParamByName('MAIL_TEXT').AsOraClob;
    send_mail_detail.ParamByName('RECIPIENT').AsString := MailLogError;
    DateTimeToString(S, 'hh:nn:ss dd.mm.yyyy', now);

    send_mail_detail.ParamByName('MESSAGE_TITLE').AsString :=
      'Ошибки загрузок ' + S;
    FStringStream.Position := 0;
    ol.OCISvcCtx := OraSession.OCISvcCtx;
    ol.CreateTemporary(ltClob);
    ol.LoadFromStream(FStringStream);
    ol.WriteLob;

    // send_mail_detail.ParamByName('MAIL_TEXT').AsOraClob.OCISvcCtx := OraSession.OCISvcCtx;
    // send_mail_detail.ParamByName('MAIL_TEXT').AsOraClob.CreateTemporary(ltClob);
    // send_mail_detail.ParamByName('MAIL_TEXT').AsOraClob.LoadFromStream(FStringStream);
    // send_mail_detail.ParamByName('MAIL_TEXT').AsOraClob.WriteLob;
    try
      send_mail_detail.ExecSQL;
    except
      on E: Exception do
        ErrorMess := 'Ошибка при отправке ошибок загрузки.'#13#10 + E.Message;
    end;
    // send_mail_detail.ParamByName('MAIL_TEXT').AsOraClob.FreeLob;
    ol.FreeLob;
    TmpQuery.Prepare;
    TmpQuery.ParamByName('note').AsString := MailLogError;
    TmpQuery.ExecSQL;
    OraSession.Commit;
  end;
  if ErrorMess <> '' then
  begin
    Synchronize(SayAboutError);
  end;
end;

procedure TMainFrmTmr2.SayAboutError;
begin
  TimedMessageBox(ErrorMess, 'Пожалуйста, будьте внимательны!', mtError, [mbOK],
    mbOK, 0, 0);
end;


end.

