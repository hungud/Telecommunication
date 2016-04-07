unit uDm;

interface

uses
  SysUtils, Classes, DB, MemDS, DBAccess, Dialogs,
  Winapi.Windows, Winapi.Messages, System.Variants, Vcl.Forms,
  Vcl.Graphics, ImgList, AdvSmoothSplashScreen, ShellAPI, TypInfo,
  Vcl.Controls, Vcl.ExtCtrls, Vcl.Menus, Vcl.Imaging.jpeg, System.StrUtils,
  OraCall, Ora, OdacVcl, acAlphaHints, sHintManager,
  DASQLMonitor, acAlphaImageList, MemData, OraSQLMonitor, Func_Const,
  TimedMsgBox, Vcl.ExtDlgs, VirtualTable, OraSmart;

type
  TDm = class(TDataModule)
    ImageList32: TImageList;
    ImageList16: TImageList;
    ConnectDialog: TConnectDialog;
    OraSession: TOraSession;
    TrayIcon1: TTrayIcon;
    ImageListForTrIcon: TImageList;
    MenuForTrayIcon: TPopupMenu;
    P1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    C1: TMenuItem;
    SplScreen: TAdvSmoothSplashScreen;
    tmrSplash: TTimer;
    sHintManager1: TsHintManager;
    OraSQLMon: TOraSQLMonitor;
    ImageList24: TImageList;
    dlgOpen: TOpenDialog;
    dlgSave: TSaveDialog;
    dlgOpenPic: TOpenPictureDialog;
    dlgSavePic: TSavePictureDialog;
    vt: TVirtualTable;
    vtint: TIntegerField;
    vtbool: TBooleanField;
    vtstr: TStringField;
    dsvt: TDataSource;
    qUserNames: TOraQuery;
    qUserNamesUSER_FIO: TStringField;
    qUserNamesUSER_NAME: TStringField;
    qUserNamesPASSWORD: TStringField;
    dsqCheckAllow: TDataSource;
    dsqRightNames: TDataSource;
    vtCheckAllow: TVirtualTable;
    vtCheckAllowint: TIntegerField;
    vtCheckAllowstr: TStringField;
    vtActive: TVirtualTable;
    dsvtActive: TDataSource;
    vtqSystemBilling: TVirtualTable;
    IntegerField3: TIntegerField;
    StringField5: TStringField;
    dsqSystemBilling: TDataSource;
    qUserNamesUSER_NAME_ID: TFloatField;
    vtRightNames: TVirtualTable;
    vtRightNamesint: TIntegerField;
    vtRightNamesstr: TStringField;
    vtActiveint: TIntegerField;
    vtActivestr: TStringField;
    dsPatamsTypes: TDataSource;
    PatamsTypes: TVirtualTable;
    PatamsTypesType: TStringField;
    PatamsTypesTypeName: TStringField;
    ImageListHot24: TImageList;
    dsqUserNames: TOraDataSource;
    qUserNamesENCRYPT_PWD: TFloatField;
    qUserNamesENCRYPT_PWD_STR: TStringField;
    qMob_Operators: TOraQuery;
    dsqMob_Operators: TOraDataSource;
    qMob_OperatorsMOBILE_OPERATOR_NAME_ID: TFloatField;
    qMob_OperatorsMOBILE_OPERATOR_NAME: TStringField;
    qAccounts: TOraQuery;
    dsqAccounts: TOraDataSource;
    qAccountsACCOUNT_ID: TFloatField;
    qAccountsACCOUNT_NUMBER: TFloatField;
    qAccountsLOGIN: TStringField;
    qAccountsPASSWORD: TStringField;
    qPhones: TOraQuery;
    dsqPhones: TOraDataSource;
    qPhonesPHONE_ID: TFloatField;
    qPhonesPHONE_NUMBER: TFloatField;
    qPhonesPHONE_NUMBER_CITY: TFloatField;
    qPhonesIS_NUMBER_CITY: TFloatField;
    qPhonesIS_NUMBER_CITY_: TBooleanField;
    qPhonForAccHist: TOraQuery;
    dsqPhonForAccHist: TOraDataSource;
    qPhonForAccHistPHONE_NUMBER: TStringField;
    qPhonForAccHistPHONE_NUMBER_CITY: TStringField;
    qPhonForAccHistPHONE_IS_ACTIVE_STR: TStringField;
    qPhonForAccHistACCOUNT_NUMBER: TFloatField;
    qPhonForAccHistSTATE: TStringField;
    qPhonForAccHistUSER_FIO: TStringField;
    qPhonForAccHistDATE_CREATED: TDateTimeField;
    qVirtual_Operator: TOraQuery;
    dsvirtual_operator: TOraDataSource;
    qVirtual_OperatorVIRTUAL_ACCOUNTS_ID: TFloatField;
    qVirtual_OperatorVIRTUAL_ACCOUNTS_NAME: TStringField;
    qVirtual_OperatorVIRTUAL_ACCOUNTS_IS_ACTIVE: TFloatField;
    qCountry: TOraQuery;
    qCountryCOUNTRY_ID: TFloatField;
    qCountryCOUNTRY_NAME: TStringField;
    dsqCountry: TOraDataSource;
    qVirtual_OperatorIS_ACTIVE_NAME: TBooleanField;
    qCountryIS_DEF_NAME: TBooleanField;
    qCountryIS_DEFAULT: TFloatField;
    qRegions: TOraQuery;
    dsqRegions: TOraDataSource;
    qRegionsREGIONS_ID: TFloatField;
    qRegionsREGIONS_NAME: TStringField;
    qRegionsCOUNTRY_ID: TFloatField;
    qRegionsCOUNTRY_NAME: TStringField;
    qRegionsCOUNTRY_NM: TStringField;
    qAbonents: TOraQuery;
    dsqAbonents: TOraDataSource;
    qAbonentsABONENT_ID: TFloatField;
    qAbonentsSURNAME: TStringField;
    qAbonentsNAME: TStringField;
    qAbonentsPATRONYMIC: TStringField;
    qAbonentsBORN_DATE: TDateTimeField;
    qAbonentsPASSPORT_SER: TStringField;
    qAbonentsPASSPORT_NUM: TStringField;
    qAbonentsPASSPORT_DATE: TDateTimeField;
    qAbonentsPASSPORT_GET: TStringField;
    qAbonentsCOUNTRY_ID_CITIZENSHIP: TFloatField;
    qAbonentsREGION_ID: TFloatField;
    qAbonentsCOUNTRY_ID: TFloatField;
    qAbonentsCITY_NAME: TStringField;
    qAbonentsSTREET_NAME: TStringField;
    qAbonentsHOUSE: TStringField;
    qAbonentsKORPUS: TStringField;
    qAbonentsAPARTMENT: TStringField;
    qAbonentsCONTACT_INFO: TStringField;
    qAbonentsIS_VIP: TFloatField;
    qAbonentsEMAIL: TStringField;
    qAbonentsDESCRIPTION: TStringField;
    qAbonentsCOUNTRY_CITIZ: TStringField;
    qAbonentsCOUNTRY_I: TStringField;
    qRegions_Country: TOraQuery;
    dsqRegions_Country: TOraDataSource;
    qRegions_CountryREGIONS_ID: TFloatField;
    qRegions_CountryREGIONS_NAME: TStringField;
    qRegions_CountryCOUNTRY_ID: TFloatField;
    qAbonentsREGION_I: TStringField;
    qAbonentsIS_VIP_NAME: TBooleanField;
    qSQL_TEMP: TOraQuery;
    qFilials: TOraQuery;
    dsqFilials: TOraDataSource;
    qFilialsFILIAL_ID: TFloatField;
    qFilialsFILIAL_NAME: TStringField;
    qTariffs: TOraQuery;
    dsqTariffs: TOraDataSource;
    qTariffsTARIFF_ID: TFloatField;
    qTariffsTARIFF_CODE: TStringField;
    qTariffsTARIFF_NAME: TStringField;
    qTariffsIS_ACTIVE: TFloatField;
    qTariffsSTART_BALANCE: TFloatField;
    qTariffsCONNECT_PRICE: TFloatField;
    qTariffsMONTHLY_PAYMENT: TFloatField;
    qTariffsCALC_KOEFF: TFloatField;
    qTariffsTARIFF_ADD_COST: TFloatField;
    qTariffsCALC_KOEFF_DETAL: TFloatField;
    qTariffsIS_ACTIVE_: TBooleanField;
    qDocum_Types: TOraQuery;
    dsqDocum_Types: TOraDataSource;
    qDocum_TypesDOCUM_TYPE_ID: TFloatField;
    qDocum_TypesDOCUM_TYPE_NAME: TStringField;
    qContracts: TOraQuery;
    dsqContracts: TOraDataSource;
    qContractsCONTRACT_ID: TFloatField;
    qContractsCONTRACT_NUM: TFloatField;
    qContractsCONTRACT_DATE: TDateTimeField;
    qContractsPHONE_NUMBER_TYPE: TFloatField;
    qContractsVIRTUAL_ACCOUNTS_ID: TFloatField;
    qContractsPHONE_ON_ACCOUNTS_ID: TFloatField;
    qContractsFILIAL_ID: TFloatField;
    qContractsTARIFF_ID: TFloatField;
    qContractsABONENT_ID: TFloatField;
    qContractsSIM_NUMBER: TStringField;
    vtstr2: TStringField;
    qContractsPhone_Type: TStringField;
    qContractsVIRT_ACC: TStringField;
    qContractsPHONE_: TStringField;
    qContractsTARIF_NAME: TStringField;
    qContractsFILIAL_NAME: TStringField;
    qContractsABON_NAME: TStringField;
    qAbonentsFIO: TStringField;
    qMob_OperatorsUSER_CREATED_FIO: TStringField;
    qMob_OperatorsDATE_CREATED_: TDateTimeField;
    qMob_OperatorsUSER_LAST_UPDATED_FIO: TStringField;
    qMob_OperatorsDATE_LAST_UPDATED_: TDateTimeField;
    qAccountsUSER_CREATED_FIO: TStringField;
    qAccountsDATE_CREATED_: TDateTimeField;
    qAccountsUSER_LAST_UPDATED_FIO: TStringField;
    qAccountsDATE_LAST_UPDATED_: TDateTimeField;
    qVirtual_OperatorUSER_CREATED_FIO: TStringField;
    qVirtual_OperatorDATE_CREATED_: TDateTimeField;
    qVirtual_OperatorUSER_LAST_UPDATED_FIO: TStringField;
    qVirtual_OperatorDATE_LAST_UPDATED_: TDateTimeField;
    qCountryUSER_CREATED_FIO: TStringField;
    qCountryDATE_CREATED_: TDateTimeField;
    qCountryUSER_LAST_UPDATED_FIO: TStringField;
    qCountryDATE_LAST_UPDATED_: TDateTimeField;
    qRegionsUSER_CREATED_FIO: TStringField;
    qRegionsDATE_CREATED_: TDateTimeField;
    qRegionsUSER_LAST_UPDATED_FIO: TStringField;
    qRegionsDATE_LAST_UPDATED_: TDateTimeField;
    qAbonentsUSER_CREATED_FIO: TStringField;
    qAbonentsDATE_CREATED_: TDateTimeField;
    qAbonentsUSER_LAST_UPDATED_FIO: TStringField;
    qAbonentsDATE_LAST_UPDATED_: TDateTimeField;
    qFilialsUSER_CREATED_FIO: TStringField;
    qFilialsDATE_CREATED_: TDateTimeField;
    qFilialsUSER_LAST_UPDATED_FIO: TStringField;
    qFilialsDATE_LAST_UPDATED_: TDateTimeField;
    qTariffsUSER_CREATED_FIO: TStringField;
    qTariffsDATE_CREATED_: TDateTimeField;
    qTariffsUSER_LAST_UPDATED_FIO: TStringField;
    qTariffsDATE_LAST_UPDATED_: TDateTimeField;
    qDocum_TypesUSER_CREATED_FIO: TStringField;
    qDocum_TypesDATE_CREATED_: TDateTimeField;
    qDocum_TypesUSER_LAST_UPDATED_FIO: TStringField;
    qDocum_TypesDATE_LAST_UPDATED_: TDateTimeField;
    qContractsUSER_CREATED_FIO: TStringField;
    qContractsDATE_CREATED_: TDateTimeField;
    qContractsUSER_LAST_UPDATED_FIO: TStringField;
    qContractsDATE_LAST_UPDATED_: TDateTimeField;
    qUserNamesUSER_CREATED_FIO: TStringField;
    qUserNamesDATE_CREATED_: TDateTimeField;
    qUserNamesUSER_LAST_UPDATED_FIO: TStringField;
    qUserNamesDATE_LAST_UPDATED_: TDateTimeField;
    qVirtual_OperatorCOMMENTS: TStringField;
    qContractsCONTRACT_DISCOUNT: TFloatField;
    YEAR_MONTH_LOADER_BILLS: TOraQuery;
    YEAR_MONTH_LOADER_BILLSCUR_YEAR_MONTH: TFloatField;
    qVirtual_OperatorINN: TStringField;
    qPeriods: TOraQuery;
    dsqPeriods: TOraDataSource;
    qPeriodsYEARS: TFloatField;
    qPeriodsMONTHS: TFloatField;
    qPeriodsYEAR_MONTH: TFloatField;
    qPeriodsYEAR_MONTH_NAME: TStringField;
    qPeriodsIS_ACTIVE: TFloatField;
    qPeriodsACTIVE: TBooleanField;
    LastPeriod: TOraQuery;
    LastPeriodYEARS: TFloatField;
    LastPeriodMONTHS: TFloatField;
    spTemp: TOraStoredProc;
    qFilials_find: TOraQuery;
    qFilials_findID: TFloatField;
    qFilials_findNAME: TStringField;
    qTarif_option: TOraQuery;
    dsqTarif_option: TOraDataSource;
    qTarif_optionID_TARIFF_OPTIONS: TFloatField;
    qTarif_optionNAME_TARIFF_OPTIONS: TStringField;
    qTarif_optionUSER_CREATED_FIO: TStringField;
    qTarif_optionDATE_CREATED_: TDateTimeField;
    qTarif_optionUSER_LAST_UPDATED_FIO: TStringField;
    qTarif_optionDATE_LAST_UPDATED_: TDateTimeField;
    qTarif_For_Oper: TOraQuery;
    FloatField1: TFloatField;
    StringField1: TStringField;
    StringField2: TStringField;
    BooleanField1: TBooleanField;
    FloatField3: TFloatField;
    FloatField4: TFloatField;
    FloatField5: TFloatField;
    FloatField6: TFloatField;
    FloatField7: TFloatField;
    FloatField8: TFloatField;
    FloatField9: TFloatField;
    StringField4: TStringField;
    DateTimeField1: TDateTimeField;
    StringField6: TStringField;
    DateTimeField2: TDateTimeField;
    dsqTarif_For_Oper: TOraDataSource;
    qVirtual_OperatorEMAIL: TStringField;
    qAbonentsKEY_WORD: TStringField;
    qAbonentsINN: TStringField;
    qAbonentsLEGAL_ADDRESS: TStringField;
    qAbonentsDELIVERY_ADDRESS: TStringField;
    qAbonentsOGRN: TStringField;
    qAbonentsCONTACT_PERSON: TStringField;
    qAgent: TOraQuery;
    dsqAgent: TOraDataSource;
    qAgentAGENT_ID: TFloatField;
    qAgentAGENT_NAME: TStringField;
    qAgentPAYABLE: TFloatField;
    qAgentPHONE_NUMBER_1: TStringField;
    qAgentPHONE_NUMBER_2: TStringField;
    qAgentPHONE_NUMBER_3: TStringField;
    qAgentPHONE_NUMBER_4: TStringField;
    qAgentEMAIL: TStringField;
    qAgentADDRESS: TStringField;
    qAgentUSER_CREATED_FIO: TStringField;
    qAgentDATE_CREATED_: TDateTimeField;
    qAgentUSER_LAST_UPDATED_FIO: TStringField;
    qAgentDATE_LAST_UPDATED_: TDateTimeField;
    vtActivestr1: TStringField;
    qAgentIS_PAY: TStringField;
    qSubAgent: TOraQuery;
    dsqSubAgent: TOraDataSource;
    qSubAgentSUB_AGENT_ID: TFloatField;
    qSubAgentSUB_AGENT_NAME: TStringField;
    qSubAgentUSER_CREATED_FIO: TStringField;
    qSubAgentDATE_CREATED_: TDateTimeField;
    qSubAgentUSER_LAST_UPDATED_FIO: TStringField;
    qSubAgentDATE_LAST_UPDATED_: TDateTimeField;
    qAgentSubAgent: TOraQuery;
    dsqAgentSubAgent: TOraDataSource;
    qAgentSubAgentAGENTS_AND_SUBAGENT_ID: TFloatField;
    qAgentSubAgentAGENT_ID: TFloatField;
    qAgentSubAgentSUB_AGENT_ID: TFloatField;
    qAgentSubAgentUSER_CREATED_FIO: TStringField;
    qAgentSubAgentDATE_CREATED_: TDateTimeField;
    qAgentSubAgentUSER_LAST_UPDATED_FIO: TStringField;
    qAgentSubAgentDATE_LAST_UPDATED_: TDateTimeField;
    qAgentSubAgentAgent_Name: TStringField;
    qAgentSubAgentSubAgent_Name: TStringField;
    qAgentSubAgentPH_N1: TStringField;
    qLocal_Phone_Statuses: TOraQuery;
    dsqLocal_Phone_Statuses: TOraDataSource;
    qLocal_Phone_StatusesLOCAL_PHONE_STATUSE_ID: TFloatField;
    qLocal_Phone_StatusesSTATUS_NAME: TStringField;
    qLocal_Phone_StatusesUSER_CREATED_FIO: TStringField;
    qLocal_Phone_StatusesDATE_CREATED_: TDateTimeField;
    qLocal_Phone_StatusesUSER_LAST_UPDATED_FIO: TStringField;
    qLocal_Phone_StatusesDATE_LAST_UPDATED_: TDateTimeField;
    qOperator_Phone_Statuses: TOraQuery;
    dsqOperator_Phone_Statuses: TOraDataSource;
    qOperator_Phone_StatusesOPERATOR_PHONE_STATUSE_ID: TFloatField;
    qOperator_Phone_StatusesSTATUS_NAME: TStringField;
    qOperator_Phone_StatusesUSER_CREATED_FIO: TStringField;
    qOperator_Phone_StatusesDATE_CREATED_: TDateTimeField;
    qOperator_Phone_StatusesUSER_LAST_UPDATED_FIO: TStringField;
    qOperator_Phone_StatusesDATE_LAST_UPDATED_: TDateTimeField;
    qOperator_Phone_StatusesMOB_OPER: TStringField;
    qOperator_Account_Names: TOraQuery;
    dsqOperator_Account_Names: TOraDataSource;
    qOperator_Account_NamesOPERATOR_ACCOUNT_NAME_ID: TFloatField;
    qOperator_Account_NamesACCOUNT_NAME: TStringField;
    qOperator_Account_NamesUSER_CREATED_FIO: TStringField;
    qOperator_Account_NamesDATE_CREATED_: TDateTimeField;
    qOperator_Account_NamesUSER_LAST_UPDATED_FIO: TStringField;
    qOperator_Account_NamesDATE_LAST_UPDATED_: TDateTimeField;
    qPhonesPHONE_FOR_VIEW: TStringField;
    qPhonesREGION: TStringField;
    qOperatorSubAccounts: TOraQuery;
    dsqOperatorSubAccounts: TOraDataSource;
    qOperatorSubAccountsSUB_ACCOUNT_ID: TFloatField;
    qOperatorSubAccountsSUB_ACCOUNT_NUMBER: TStringField;
    qOperatorSubAccountsCOMMENTS: TStringField;
    qProjects: TOraQuery;
    dsqProjects: TOraDataSource;
    qProjectsPROJECT_ID: TFloatField;
    qProjectsPROJECT_NAME: TStringField;
    qProjectsCOMMENTS: TStringField;
    qProjectsUSER_CREATED_FIO: TStringField;
    qProjectsDATE_CREATED_: TDateTimeField;
    qProjectsUSER_LAST_UPDATED_FIO: TStringField;
    qProjectsDATE_LAST_UPDATED_: TDateTimeField;
    qContractsOPERATOR_PHONE_STATUSE_ID: TFloatField;
    qContractsOP_PHONE_STATUS: TStringField;
    qContractsLOCAL_PHONE_STATUSE_ID: TFloatField;
    qContractsLOC_PHONE_STATUSE: TStringField;
    qContractsSALE_COST: TFloatField;
    qContractsSALE_DATE: TDateTimeField;
    qContractsOPERATOR_ACCOUNT_NAME_ID: TFloatField;
    qContractsPROJECT_ID: TFloatField;
    qContractsSUB_ACCOUNT_ID: TFloatField;
    qContractsAGENT_DATE_DISPATCH: TDateTimeField;
    qContractsAGENT_ID: TFloatField;
    qContractsOPER_ACC_NAME: TStringField;
    qContractsProjectName: TStringField;
    qContractsSub_AccountName: TStringField;
    qContractsAgentName: TStringField;
    qPhonesOnAccount: TOraQuery;
    dsqPhonesOnAccount: TOraDataSource;
    qPhonesOnAccountPHONE_ON_ACCOUNTS_ID: TFloatField;
    qPhonesOnAccountACCOUNT_ID: TFloatField;
    qPhonesOnAccountPHONE_ID: TFloatField;
    qPhonesOnAccountPHONE_IS_ACTIVE: TFloatField;
    qPhonesOnAccountUSER_CREATED_FIO: TStringField;
    qPhonesOnAccountDATE_CREATED_: TDateTimeField;
    qPhonesOnAccountUSER_LAST_UPDATED_FIO: TStringField;
    qPhonesOnAccountDATE_LAST_UPDATED_: TDateTimeField;
    qPhonesOnAccountPHONE_NUMBER: TStringField;
    qPhonesOnAccountPHONE_IS_ACTIVE_STR: TStringField;
    qPhonesOnAccountACCOUNT_NUMBER: TStringField;
    qFilialsBRANCH: TStringField;
    qFilialsMOBILE_OPERATOR_NAME_ID: TFloatField;
    qFilialsMOBILE_OPERATOR_NAME: TStringField;
    qMob_OperatorsMOBILE_OPERATOR_NAME_FOR_URL: TStringField;
    qOperator_Phone_StatusesFILIAL_ID: TFloatField;
    qTariffsFILIAL_ID: TFloatField;
    strngfldTariffsFILIAL_NAME: TStringField;
    qAccountsFILIAL_ID: TFloatField;
    qAccountsFILIAL_NAME: TStringField;
    strngfldAccountsOperatorName: TStringField;
    qPhonesOnAccountFILIAL_NAME: TStringField;
    qPhonForAccHistFILIAL_NAME: TStringField;
    qTarif_For_OperFILIAL_ID: TFloatField;
    qTarif_For_OperFILIAL_NAME: TStringField;
    qOperatorSubAccountsFILIAL_ID: TFloatField;
    qOperatorSubAccountsFField_name: TStringField;
    qOperator_Account_NamesFILIAL_ID: TFloatField;
    qOperator_Account_NamesFILIAL_NAME: TStringField;
    qPAYMENTS_TYPE: TOraQuery;
    dsqPAYMENTS_TYPE: TOraDataSource;
    qPAYMENTS_TYPEID_PAYMENTS_TYPE: TFloatField;
    qPAYMENTS_TYPENAME_PAYMENTS_TYPE: TStringField;
    qPAYMENTS_TYPEUSER_CREATED_FIO: TStringField;
    qPAYMENTS_TYPEDATE_CREATED_: TDateTimeField;
    qPAYMENTS_TYPEUSER_LAST_UPDATED_FIO: TStringField;
    qPAYMENTS_TYPEDATE_LAST_UPDATED_: TDateTimeField;
    qVirtual_OperatorDATE_BALANCE: TDateTimeField;
    qVirtual_OperatorSUM_BALANCE: TFloatField;
    procedure N1Click(Sender: TObject);
    procedure P1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure tmrSplashTimer(Sender: TObject);
    procedure OraSessionAfterConnect(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure InitPict;
    function MoveNextHint():string;
    function MovePrevHint():string;
    procedure OraSessionConnectionLost(Sender: TObject; Component: TComponent;
      ConnLostCause: TConnLostCause; var RetryMode: TRetryMode);
    procedure OraSession_Connect;
    procedure SplScreenClick(Sender: TObject);

    procedure qPhonesPHONE_NUMBERChange(Sender: TField);
    procedure qPhonesPHONE_NUMBERValidate(Sender: TField);
    procedure qPhonesIS_NUMBER_CITY_Change(Sender: TField);
    procedure qAccountForPhonesAfterOpen(DataSet: TDataSet);
    procedure qAbonentsCOUNTRY_IDChange(Sender: TField);
    procedure qPhonesIS_NUMBER_CITY_GetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure qContractsAfterScroll(DataSet: TDataSet);
    procedure qPhonesOnAccountPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure qVirtual_OperatorBeforeOpen(DataSet: TDataSet);

  private
    { Private declarations }
  public
    FilePict, PictExt, UserFIO, PersonalPath, FileNameProg, FileNameIni: string;
    ClientImg: TPicture;
    applMainForm: TForm;
    filtrReg, showZastav, splashDone: boolean;
    VersionOfModule: string;
    VersionValue: double;
    CountryDef_Id, FIsAdmin, FCheckAllow : integer;
    OraSQLMon_Active, IsAdmin, FConnected: boolean;
    fPassword, fServer, fUserName, fSchemaName: string;
    // из ини файла
    month_year_withLastData, MoveNext, modal_rez_ChangePassword: integer;
    MDI_State, ConFormDestroy, SplScreenCloseOnClick: boolean;
    MainCaption: string;
    ShowInfoChanger, ShowInfoCreator, ChangeKeyboardLayout, UsePictForFon,
    AskExcelFileName, DebugMode, NewIcon: boolean;
    MainWnd, CurrentWnd: hwnd;
    LogonError : Integer;
  end;

var
  Dm: TDm;

implementation

{$R *.dfm}

//uses ChangePassword, ConnForm;

function TDm.MoveNextHint():string;
begin
  Result := 'Вперед на ' + IntToStr(MoveNext) + ' записей. Смотри меню -> Помощь -> Настройки программы';
end;

function TDm.MovePrevHint():string;
begin
  Result := 'Назад на ' + IntToStr(MoveNext) + ' записей. Смотри меню -> Помощь -> Настройки программы';
end;

procedure TDm.DataModuleCreate(Sender: TObject);
var
  i: integer;
  str_: string;
begin
  NewIcon := false;
  FileNameProg := Application.ExeName;

  PersonalPath := GetSystemPath(Personal) + ChangeFileExt(ExtractFileName(FileNameProg),'') + '\';
  SysUtils.ForceDirectories(PersonalPath);
  FileNameIni := PersonalPath + ChangeFileExt(ExtractFileName(FileNameProg), '.INI');
  ClientImg := TPicture.Create;
  IsAdmin := false;
  FIsAdmin := -1;
  FCheckAllow := -1;
  FConnected := false;
  VersionOfModule := GetVersionTextOfModule(FileNameProg);
  VersionValue := GetVersionValue(VersionOfModule);
  SplScreenCloseOnClick := false;
  SplScreen.BasicProgramInfo.ProgramVersion.Text := 'Версия ' + VersionOfModule;
  //SplScreen.MainForm :=  fmConn;
  SplScreen.Show();
  splashDone := false;
 //Application.m
  // tmrSplash.Enabled := True;
  for i := 0 to ComponentCount - 1 do
  begin
    if (Components[i].ClassName = 'TOraQuery') then
    begin
      (Components[i] as TOraQuery).Session := OraSession;
      (Components[i] as TOraQuery).Close;
    end;
    if (Components[i].ClassName = 'TOraStoredProc') then
    begin
      (Components[i] as TOraStoredProc).Session := OraSession;
    end;
  end;
  showZastav := true;
  //если файл есть то читаем из него
  //если нет, то устанавливаем параметры по дефолту
  if not FileExists(FileNameIni) then
  begin
    DebugMode := false;
    MDI_State := true;
    AskExcelFileName := false;
    MoveNext := 0;
    UsePictForFon := false;
    ChangeKeyboardLayout := false;
    ShowInfoCreator := false;
  end
  else
  begin
    ReadIniParams(FileNameIni, fUserName, fServer, fSchemaName, fPassword);
    ReadIniDebug(FileNameIni, OraSQLMon_Active);

    ReadIniAny(FileNameIni, 'CONNECT', 'DEBUG', str_);

    DebugMode := not((str_ = '0') or (str_ = ''));

    ReadIniAny(FileNameIni, 'MAIN_WINDOWS', 'VSTROENOE', str_);
    MDI_State := (str_ = '0') or (str_ = '');

    ReadIniAny(FileNameIni, 'MAIN_WINDOWS', 'ASKEXCELFILENAME', str_);
    AskExcelFileName := not((str_ = '0') or (str_ = ''));

    ReadIniAny(FileNameIni, 'MAIN_WINDOWS', 'MOVENEXT', str_);
    if (str_ = '0') or (str_ = '') then
      MoveNext := 0
    else
      MoveNext := StrToInt(str_);

    ReadIniAny(FileNameIni, 'MAIN_WINDOWS', 'USEPICTFORFON', str_);
    UsePictForFon := not((str_ = '0') or (str_ = ''));

    ReadIniAny(FileNameIni, 'MAIN_WINDOWS', 'CHANGEKEYBOARDLAYOUT', str_);
    ChangeKeyboardLayout := not((str_ = '0') or (str_ = ''));

    ReadIniAny(FileNameIni, 'MAIN_WINDOWS', 'SHOWINFOCREATOR', str_);
    ShowInfoCreator := not((str_ = '0') or (str_ = ''));


    ReadIniAny(FileNameIni, 'MAIN_WINDOWS', 'SHOWINFOCHANGER', str_);
    ShowInfoChanger := not((str_ = '0') or (str_ = ''));

    ReadIniAny(FileNameIni, 'MAIN_WINDOWS', 'PICTEXT', PictExt);

  end;

  if PictExt = ''  then
    PictExt := '.jpg';
  FilePict := PersonalPath +  'img' + PictExt;
  OraSQLMon.Active := DebugMode;
  OraSession_Connect;

  //InitPict;
 end;

procedure TDm.DataModuleDestroy(Sender: TObject);
var
  str_: string;
begin
  if SysUtils.DirectoryExists(PersonalPath) then
  begin
    if FConnected then
      WriteIniParams(FileNameIni, OraSession.Username, OraSession.Server, OraSession.Schema, OraSession.Password);

    if MDI_State then
      str_ := '0'
    else
      str_ := '1';
    WriteIniAny(FileNameIni, 'MAIN_WINDOWS', 'VSTROENOE', str_);

    if AskExcelFileName then
      str_ := '1'
    else
      str_ := '0';
    WriteIniAny(FileNameIni, 'MAIN_WINDOWS', 'ASKEXCELFILENAME', str_);

    str_ := IntToStr(MoveNext);
    WriteIniAny(FileNameIni, 'MAIN_WINDOWS', 'MOVENEXT', str_);

    if UsePictForFon then
      str_ := '1'
    else
      str_ := '0';
    WriteIniAny(FileNameIni, 'MAIN_WINDOWS', 'USEPICTFORFON', str_);


    if ChangeKeyboardLayout then
      str_ := '1'
    else
      str_ := '0';
    WriteIniAny(FileNameIni, 'MAIN_WINDOWS', 'CHANGEKEYBOARDLAYOUT', str_);

    if ShowInfoCreator then
      str_ := '1'
    else
      str_ := '0';
    WriteIniAny(FileNameIni, 'MAIN_WINDOWS', 'SHOWINFOCREATOR', str_);

    if ShowInfoChanger then
      str_ := '1'
    else
      str_ := '0';
    WriteIniAny(FileNameIni, 'MAIN_WINDOWS', 'SHOWINFOCHANGER', str_);

    WriteIniAny(FileNameIni, 'MAIN_WINDOWS', 'PICTEXT', PictExt);

    if UsePictForFon then
    begin
      if (ClientImg <> nil) then
        ClientImg.SaveToFile(FilePict);
    end else begin
      DeleteFile(PWideChar(FilePict));
    end;
  end;
  ClientImg.Free;
end;

procedure TDm.InitPict;
var
  rStream: TResourceStream;
begin
  if UsePictForFon then
  begin
    if FileExists(FilePict) then
    begin
      try
        ClientImg.LoadFromFile(FilePict)
      except
        DeleteFile(PWideChar(FilePict));
        rStream := TResourceStream.Create(hInstance, 'JpgImage_1', RT_RCDATA);
        rStream.Position := 0;
        try
          PictExt := '.jpg';

          FilePict := PersonalPath + 'img'+ PictExt;
          rStream.SaveToFile(FilePict);
        finally
          rStream.Free;
        end;
        ClientImg.LoadFromFile(FilePict); // Так грузить JPG!!!
      end;
    end
    else
    begin
      rStream := TResourceStream.Create(hInstance, 'JpgImage_1', RT_RCDATA);
      rStream.Position := 0;
      try
        PictExt := '.jpg';
        FilePict := PersonalPath + 'img'+ PictExt;
        rStream.SaveToFile(FilePict);
      finally
        rStream.Free;
      end;
      ClientImg.LoadFromFile(FilePict); // Так грузить JPG!!!
    end;
  end;
end;

procedure TDm.OraSession_Connect;
begin
  OraSQLMon_Active := OraSQLMon_Active;
  FConnected := false;;
  OraSession.Connected := false;
  try
    OraSession.Connected := true;
    FConnected := true;
    LogonError := 0;
  except
    on eAbort: exception do
      LogonError := 1;
    on E: EDatabaseError do
      LogonError := 2;
  end;
end;

procedure TDm.N1Click(Sender: TObject);
begin
  applMainForm.WindowState := wsMinimized;
  ShowWindow(Application.Handle, sw_Hide);
  Application.ShowMainform := false;

end;

procedure TDm.N2Click(Sender: TObject);
begin
  applMainForm.WindowState := wsNormal;
  Application.BringToFront();
  ShowWindow(Application.Handle, sw_Show);
  Application.ShowMainform := true;
end;

procedure TDm.OraSessionAfterConnect(Sender: TObject);
begin
  // опять покажем заставку
  // прячем на время отладки
  if not DebugMode then
  begin
    splashDone := false;
    SplScreen.Show();
  end;
  UserFIO := OraSession.Username;


  if not qUserNames.Active then
  begin
    qUserNames.ParamByName('USER_NAME').Value := OraSession.Username;
    qUserNames.Open;
    //UserFIO := VarToStr(qUserNames.Lookup('USER_NAME', UpperCase(OraSession.Username), 'USER_FIO'));
    //UserFIO := qUserNames.FieldByName('USER_NAME').Value;
    UserFIO := qUserNames.FieldByName('USER_NAME').AsString;
    qUserNames.Close;
    qUserNames.ParamByName('USER_NAME').Clear;
  end;

  if SameText(OraSession.Username, OraSession.Schema) then
    // Под именем схемы работает администратор!
    IsAdmin := true
  else
  begin
    IsAdmin := False;
  end;

  qSQL_TEMP.SQL.Clear;
  qSQL_TEMP.SQL.Add('select COUNTRY_ID from COUNTRIES where IS_DEFAULT = 1 AND ROWNUM <= 1 ');
  qSQL_TEMP.Open;

  if qSQL_TEMP.IsEmpty then
    CountryDef_Id := -1
  else
    CountryDef_Id := qSQL_TEMP.Fields[0].AsInteger;

  qSQL_TEMP.close;

  YEAR_MONTH_LOADER_BILLS.Open;
  month_year_withLastData := YEAR_MONTH_LOADER_BILLS.FieldByName('CUR_YEAR_MONTH').AsInteger;
  YEAR_MONTH_LOADER_BILLS.Close;
end;

procedure TDm.SplScreenClick(Sender: TObject);
begin
  if SplScreenCloseOnClick then
    SplScreen.Hide;
  SplScreenCloseOnClick := false;
end;

procedure TDm.OraSessionConnectionLost(Sender: TObject; Component: TComponent;
  ConnLostCause: TConnLostCause; var RetryMode: TRetryMode);
begin
  RetryMode := rmReconnect;
end;

procedure TDm.P1Click(Sender: TObject);
begin
  applMainForm.Close;
end;


procedure TDm.qAbonentsCOUNTRY_IDChange(Sender: TField);
begin
  if filtrReg then
  begin
    qRegions.Filtered := False;
    qRegions.Filter := 'COUNTRY_ID = ' + Sender.AsString;
    qRegions.Filtered := True;
  end;
end;

procedure TDm.qAccountForPhonesAfterOpen(DataSet: TDataSet);
begin
  qPhonesOnAccount.Open;
end;


procedure TDm.qContractsAfterScroll(DataSet: TDataSet);
begin
//  qTarif_For_Oper.Close;
//  qTarif_For_Oper.ParamByName('p_phone_id').AsInteger := DataSet.FieldByName('PHONE_').AsInteger;
//  qTarif_For_Oper.Open;
end;

procedure TDm.qPhonesOnAccountPostError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
begin
  if pos('00001', e.Message) > 0 then
   raise EAbort.Create('Такая запись уже есть!');
  //Action := daAbort;
end;

procedure TDm.qPhonesIS_NUMBER_CITY_Change(Sender: TField);
begin
  if Sender.AsBoolean and (Sender.DataSet.FieldByName('PHONE_NUMBER_CITY').AsString = '') then
    Sender.DataSet.FieldByName('PHONE_NUMBER_CITY').AsString := Copy(Sender.DataSet.FieldByName('PHONE_NUMBER').AsString,4,7);
  if not Sender.AsBoolean and (Sender.DataSet.FieldByName('PHONE_NUMBER_CITY').AsString <> '') then
    Sender.DataSet.FieldByName('PHONE_NUMBER_CITY').AsString := '';
end;

procedure TDm.qPhonesIS_NUMBER_CITY_GetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if Sender.Value then
    Text := 'Да'
  else
    Text := 'Нет';
end;

procedure TDm.qPhonesPHONE_NUMBERChange(Sender: TField);
begin
  if Length(Sender.AsString) = 10 then
    if  Sender.DataSet.FieldByName('IS_NUMBER_CITY').AsInteger = 1 then
      Sender.DataSet.FieldByName('PHONE_NUMBER_CITY').AsString := Copy(Sender.AsString,4,7);
end;

procedure TDm.qPhonesPHONE_NUMBERValidate(Sender: TField);
begin
  if Length(Sender.AsString) <> 10 then
   raise EAbort.Create('');
end;
procedure TDm.qVirtual_OperatorBeforeOpen(DataSet: TDataSet);
begin
//  qVirtual_Operator.ParamByName('YEAR_MONTH').AsInteger := month_year_withLastData;
end;

{
procedure TDm.qTariffsAfterInsert(DataSet: TDataSet);
begin
  DataSet.FieldByName('IS_ACTIVE').AsInteger := 0;
end;


{procedure TDm.qTariffsDeleteError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
begin
  if AnsiContainsText(E.Message, 'CONTRACTS_FK_TARIFF_ID') then
  begin
    TimedMessageBox('Эта запись используется в справочнике договоров.  Удаление невозможно!', 'Пожалуйста, будьте внимательны!', mtWarning, [mbOK], mbOK, 15, 3);
    Action := daAbort;
  end;
end;   }

procedure TDm.tmrSplashTimer(Sender: TObject);
begin
  tmrSplash.Enabled := false;
end;

procedure TDm.TrayIcon1DblClick(Sender: TObject);
begin
  applMainForm.Show();
  applMainForm.WindowState := wsNormal;
  Application.BringToFront();
end;

end.
