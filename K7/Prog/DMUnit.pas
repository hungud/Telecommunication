unit DMUnit;

interface

uses
  SysUtils, Classes, DB, MemDS, DBAccess, Dialogs,
  Winapi.Windows, Winapi.Messages, System.Variants, Vcl.Forms,
  Vcl.Graphics, ImgList, AdvSmoothSplashScreen, ShellAPI, TypInfo,
  Vcl.Controls, Vcl.ExtCtrls, FileCtrl, Vcl.Menus, Vcl.Imaging.jpeg,
  OraCall, Ora, OdacVcl, acAlphaHints, sHintManager,
  DASQLMonitor, acAlphaImageList, MemData, OraSQLMonitor, Func_Const,
  TimedMsgBox, Vcl.ExtDlgs, VirtualTable, OraSmart;

type
  TDm = class(TDataModule)
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
    qDefaultCountry: TOraQuery;
    qDefaultregion: TOraQuery;
    qFreeValue: TOraStoredProc;
    qGetNextNum: TOraStoredProc;
    qDefaultFilial: TOraQuery;
    qContract: TOraQuery;
    qGetConstant: TOraStoredProc;
    qConstants: TOraQuery;
    spFilialId: TOraStoredProc;
    qParams: TOraQuery;
    qUserRigthsType_EncryptPwd: TOraQuery;
    qUserRigthsType_EncryptPwdUSER_NAME_ID: TFloatField;
    qUserRigthsType_EncryptPwdUSER_FIO: TStringField;
    qUserRigthsType_EncryptPwdUSER_NAME: TStringField;
    qUserRigthsType_EncryptPwdPASSWORD2: TStringField;
    qUserRigthsType_EncryptPwdFILIAL_ID: TFloatField;
    qUserRigthsType_EncryptPwdRIGHTS_TYPE: TFloatField;
    qUserRigthsType_EncryptPwdUSER_NAME_CREATED: TStringField;
    qUserRigthsType_EncryptPwdDATE_CREATED: TDateTimeField;
    qUserRigthsType_EncryptPwdUSER_NAME_LAST_UPDATED: TStringField;
    qUserRigthsType_EncryptPwdDATE_LAST_UPDATED: TDateTimeField;
    qUserRigthsType_EncryptPwdCHECK_ALLOW_ACCOUNT: TIntegerField;
    qUserRigthsType_EncryptPwdENCRYPT_PWD: TIntegerField;
    qUserRigthsType_EncryptPwdUSER_NAME_OKTEL: TStringField;
    qUserRigthsType_EncryptPwdPASSWORD_OKTEL: TStringField;
    qUserRigthsType_EncryptPwdMAX_PROMISED_PAYMENT: TFloatField;
    alter_user_encrypt_pwd: TOraStoredProc;
    qMenuAccess: TOraQuery;
    qMenuAccessMENU_NAME: TStringField;
    qMenuAccessACTIONLIST_NAME: TStringField;
    qMenuAccessIS_VISIBLE: TFloatField;
    qMenuAccessUSER_NAME: TStringField;
    qMenuAccessRIGHTS_TYPE: TFloatField;
    qMenuAccessCHECK_ALLOW_ACCOUNT: TFloatField;
    qConstantsNAME: TStringField;
    qConstantsVALUE: TStringField;
    qParamsNAME: TStringField;
    qParamsVALUE: TStringField;
    TmpQuery: TOraQuery;
    qCheckUserPrivileges: TOraQuery;
    qCheckUserPrivilegesCNT: TFloatField;
    OraSQLMon: TOraSQLMonitor;
    dlgOpen: TOpenDialog;
    dlgSave: TSaveDialog;
    dlgOpenPic: TOpenPictureDialog;
    SavePictureDialog: TSavePictureDialog;
    OpenTextFileDialog: TOpenTextFileDialog;
    SaveTextFileDialog: TSaveTextFileDialog;
    qCountry: TOraQuery;
    qFilial: TOraQuery;
    qFilialFILIAL_ID: TFloatField;
    qFilialFILIAL_NAME: TStringField;
    qCountryCOUNTRY_ID: TFloatField;
    qCountryCOUNTRY_NAME: TStringField;
    qCountryIS_DEFAULT: TIntegerField;
    vt: TVirtualTable;
    vtint: TIntegerField;
    vtbool: TBooleanField;
    vtstr: TStringField;
    dsvt: TDataSource;
    qRegions: TOraQuery;
    dsqRegions: TOraDataSource;
    qRegionsREGION_ID: TFloatField;
    qRegionsREGION_NAME: TStringField;
    qRegionsORDER_NUMBER: TFloatField;
    qRegionsIS_DEFAULT: TIntegerField;
    qRegionsCOUNTRY_ID: TFloatField;
    dsqFilial: TOraDataSource;
    dsqCountry: TOraDataSource;
    qRegionsCOUNTRY_NAME: TStringField;
    qRegionsIS_DEFAULT_: TStringField;
    qAbonents: TOraQuery;
    qAbonentsABONENT_ID: TFloatField;
    qAbonentsSURNAME: TStringField;
    qAbonentsNAME: TStringField;
    qAbonentsPATRONYMIC: TStringField;
    qAbonentsBDATE: TDateTimeField;
    qAbonentsPASSPORT_SER: TStringField;
    qAbonentsPASSPORT_NUM: TStringField;
    qAbonentsPASSPORT_DATE: TDateTimeField;
    qAbonentsPASSPORT_GET: TStringField;
    qAbonentsCITIZEN_COUNTRY_NAME: TStringField;
    qAbonentsCITY_NAME: TStringField;
    qAbonentsSTREET_NAME: TStringField;
    qAbonentsKORPUS: TStringField;
    qAbonentsHOUSE: TStringField;
    qAbonentsAPARTMENT: TStringField;
    qAbonentsCONTACT_INFO: TStringField;
    qAbonentsCODE_WORD: TStringField;
    qAbonentsIS_VIP_NAME_: TStringField;
    qAbonentsCITIZENSHIP: TFloatField;
    qAbonentsCOUNTRY_ID: TFloatField;
    qAbonentsREGION_ID: TFloatField;
    qAbonentsIS_VIP: TIntegerField;
    dsqAbonents: TOraDataSource;
    qCountries_Citizen: TOraQuery;
    dsqCountry_Citizen: TOraDataSource;
    qRegionsRREGION_NAMECCOUNTRY_NAME: TStringField;
    qCONTRACT_CANCEL_TYPE: TOraQuery;
    qCONTRACT_CANCEL_TYPECONTRACT_CANCEL_TYPE_ID: TFloatField;
    qCONTRACT_CANCEL_TYPECONTRACT_CANCEL_TYPE_NAME: TStringField;
    dsqCONTRACT_CANCEL_TYPE: TOraDataSource;
    qSendSMSParametres: TOraQuery;
    qSendSMSParametresPROVIDER_ID: TFloatField;
    qSendSMSParametresPROVIDER_NAME: TStringField;
    qSendSMSParametresSENDER_NAME: TStringField;
    qSendSMSParametresLOGIN: TStringField;
    qSendSMSParametresPASSWORD: TStringField;
    qSendSMSParametresSTATUS: TFloatField;
    dsqSendSMSParametres: TOraDataSource;
    qPhoneBlocks: TOraQuery;
    qPhoneBlocksPHONE_NUMBER_BEGIN: TStringField;
    qPhoneBlocksPHONE_NUMBER_END: TStringField;
    qPhoneBlocksOPERATOR_ID: TFloatField;
    dsqPhoneBlocks: TOraDataSource;
    qOperators: TOraQuery;
    qOperatorsOPERATOR_ID: TFloatField;
    qOperatorsOPERATOR_NAME: TStringField;
    dsqOperator: TOraDataSource;
    qPhoneBlocksOPERATOR_NAME: TStringField;
    qStartBalances: TOraQuery;
    qStartBalancesPHONE_NUMBER: TStringField;
    qStartBalancesPHONE_BALANCE_ID: TFloatField;
    qStartBalancesBALANCE_DATE: TDateTimeField;
    qStartBalancesBALANCE_VALUE: TFloatField;
    qStartBalancesUSER_LAST_UPDATED: TStringField;
    qStartBalancesDATE_LAST_UPDATED: TDateTimeField;
    dsqStartBalances: TOraDataSource;
    qPhonesWithDailyAbon: TOraQuery;
    StringField1: TStringField;
    FloatField1: TFloatField;
    DateTimeField1: TDateTimeField;
    FloatField2: TFloatField;
    StringField2: TStringField;
    DateTimeField2: TDateTimeField;
    dsqPhonesWithDailyAbon: TOraDataSource;
    qForwardingSMS: TOraQuery;
    qForwardingSMSPHONE_NUMBER: TStringField;
    qForwardingSMSPHONE_NUMBER_RECIPIENT: TStringField;
    qForwardingSMSCheck: TStringField;
    qForwardingSMSFORWARDING_ENABLE: TFloatField;
    qForwardingSMSSMS_TEXT_ADD: TStringField;
    qForwardingSMSDATE_LAST_UPDATE: TDateTimeField;
    qForwardingSMSUSER_LAST_UPDATE: TStringField;
    dsqForwardingSMS: TOraDataSource;
    qSendMailParametres: TOraQuery;
    qSendMailParametresSMTP_SERVER: TStringField;
    qSendMailParametresSMTP_PORT: TFloatField;
    qSendMailParametresUSER_LOGIN: TStringField;
    qSendMailParametresUSER_PASSWORD: TStringField;
    dsqSendMailParametres: TOraDataSource;
    qMailRecipients: TOraQuery;
    dsqMailRecipients: TOraDataSource;
    qReportType: TOraQuery;
    dsqReportType: TOraDataSource;
    dsqUserNames: TOraDataSource;
    qUserNames: TOraQuery;
    qUserNamesUSER_FIO: TStringField;
    qUserNamesUSER_NAME: TStringField;
    qUserNamesPASSWORD: TStringField;
    qUserNamesRIGHTS_TYPE: TFloatField;
    qUserNamesFILIAL_ID: TFloatField;
    qUserNamesFILIAL_NAME_: TStringField;
    qUserNamesCHECK_ALLOW_ACCOUNT: TIntegerField;
    qUserNamesCHECK_ALLOW_NAME: TStringField;
    qUserNamesENCRYPT_PWD: TIntegerField;
    qUserNamesENCRYPT_PWD_STR: TStringField;
    qUserNamesUSER_NAME_OKTEL: TStringField;
    qUserNamesPASSWORD_OKTEL: TStringField;
    qUserNamesMAX_PROMISED_PAYMENT: TFloatField;
    dsqCheckAllow: TDataSource;
    dsqRightNames: TDataSource;
    vtCheckAllow: TVirtualTable;
    vtCheckAllowint: TIntegerField;
    vtCheckAllowstr: TStringField;
    qUserNamesRIGHTS_NAME: TStringField;
    dsqParams: TOraDataSource;
    qParamsPARAM_ID: TFloatField;
    qParamsTYPE: TStringField;
    qParamsDESCR: TStringField;
    qRightsTypeAccount: TOraQuery;
    qRightsTypeAccountRIGHT_NMA: TStringField;
    qRightsTypeAccountLOGIN: TStringField;
    qRightsTypeAccountRIGHTS_TYPE: TFloatField;
    qRightsTypeAccountID: TFloatField;
    qRightsTypeAccountACCOUNT_ID: TFloatField;
    dsqRightsTypeAccount: TOraDataSource;
    vtActive: TVirtualTable;
    dsvtActive: TDataSource;
    qAccount: TOraQuery;
    qAccountACCOUNT_ID: TFloatField;
    qAccountLOGIN: TStringField;
    qDOP_STATUS: TOraQuery;
    qDOP_STATUSDOP_STATUS_ID: TFloatField;
    qDOP_STATUSDOP_STATUS_NAME: TStringField;
    qDOP_STATUSDO_BLOCK_PHONE: TIntegerField;
    qDOP_STATUSDO_BLOCK_PHONE_NAME: TStringField;
    dsqAccount: TOraDataSource;
    dsqDOP_STATUS: TOraDataSource;
    qDEALER: TOraQuery;
    qDEALERDEALER_KOD: TFloatField;
    qDEALERDEALER_NAME: TStringField;
    qDEALERPATTERN: TStringField;
    qDEALERREPLACEMENT: TStringField;
    qDEALERSENDER_NAME: TStringField;
    qDEALERWELCOME_SMS: TStringField;
    dsqDEALER: TOraDataSource;
    qContractGroup: TOraQuery;
    qContractGroupGROUP_ID: TFloatField;
    qContractGroupBALANCE: TFloatField;
    qContractGroupCNT: TFloatField;
    dsqContractGroup: TOraDataSource;
    qPaymentType: TOraQuery;
    qPaymentTypeRECEIVED_PAYMENT_TYPE_ID: TFloatField;
    qPaymentTypeRECEIVED_PAYMENT_TYPE_NAME: TStringField;
    dsqPaymentType: TOraDataSource;
    qMNP: TOraQuery;
    qMNPPHONE_NUMBER: TStringField;
    qMNPTEMP_PHONE_NUMBER: TStringField;
    qMNPIS_ACTIVE: TIntegerField;
    dsqMNP: TOraDataSource;
    qMNPIS_ACTIVE_: TStringField;
    qAbonentVIP: TOraQuery;
    dsqqAbonentVIP: TOraDataSource;
    qAbonentVIPABONENTS_VIP_ID: TFloatField;
    qAbonentVIPPHONE_NUMBER: TFloatField;
    qAbonentVIPINFO: TStringField;
    qAbonentVIPUSER_CREATED: TStringField;
    qAbonentVIPDATE_LAST_UPDATE: TDateTimeField;
    qInactivePhoneLessCont: TOraQuery;
    qInactivePhoneLessContPHONE_NUMBER: TStringField;
    qInactivePhoneLessContSIM_NUMBER: TStringField;
    qInactivePhoneLessContDATE_CREATED: TDateTimeField;
    qInactivePhoneLessContSYSTEM_BILLING: TFloatField;
    qInactivePhoneLessContSYSTEM_PAID_NAME: TStringField;
    qInactivePhoneLessContPAID: TFloatField;
    qInactivePhoneLessContDOP_INFO: TStringField;
    qInactivePhoneLessContMASK_BEAUTY_ID: TFloatField;
    qInactivePhoneLessContPATTERN: TStringField;
    qInactivePhoneLessContPRICE: TFloatField;
    qInactivePhoneLessContEXISTS_CONTRACT: TStringField;
    qInactivePhoneLessContINACTIVE_PHONE_ID: TFloatField;
    dsqInactivePhoneLessCont: TOraDataSource;
    vtqSystemBilling: TVirtualTable;
    IntegerField3: TIntegerField;
    StringField5: TStringField;
    dsqSystemBilling: TDataSource;
    qMaskBeauty: TOraQuery;
    dsqMaskBeauty: TOraDataSource;
    qTurnTariffOptions: TOraQuery;
    dsqTurnTariffOptions: TOraDataSource;
    qTarffOptions: TOraQuery;
    dsqTarffOptions: TOraDataSource;
    qTurnTariffOptionsDELAYED_TURN_TO_ID: TFloatField;
    qTurnTariffOptionsPHONE_NUMBER: TStringField;
    qTurnTariffOptionsOPTION_CODE: TStringField;
    qTurnTariffOptionsACTION_TYPE: TIntegerField;
    qTurnTariffOptionsACTION_DATE: TDateTimeField;
    qTurnTariffOptionsDATE_CREATED: TDateTimeField;
    qTurnTariffOptionsUSER_CREATED: TStringField;
    qTurnTariffOptionsDATE_LAST_UPDATED: TDateTimeField;
    qTurnTariffOptionsUSER_LAST_UPDATED: TStringField;
    qTurnTariffOptionsOPTION_NAME: TStringField;
    vtqTurnTariffOptions: TVirtualTable;
    IntegerField4: TIntegerField;
    StringField6: TStringField;
    dsvqTurnTariffOptions: TDataSource;
    qTurnTariffOptionsACTION_NAME: TStringField;
    qMaskBeautyMASK_BEAUTY_ID: TFloatField;
    qMaskBeautyPATTERN: TStringField;
    qDocumTypes: TOraQuery;
    dsqDocumTypes: TOraDataSource;
    qDocumTypesDOCUM_TYPE_ID: TFloatField;
    qDocumTypesDOCUM_TYPE_NAME: TStringField;
    qUserNamesUSER_NAME_ID: TFloatField;
    vtRightNames: TVirtualTable;
    vtRightNamesint: TIntegerField;
    vtRightNamesstr: TStringField;
    qCountryIS_DEFAULT_NAME: TStringField;
    qOperatorsORDER_NUMBER: TIntegerField;
    qTariffs: TOraQuery;
    dsqTariffs: TOraDataSource;
    qTariffsTARIFF_ID: TFloatField;
    qTariffsTARIFF_CODE: TStringField;
    qTariffsOPERATOR_ID: TFloatField;
    qTariffsTARIFF_NAME: TStringField;
    qTariffsSTART_BALANCE: TFloatField;
    qTariffsCONNECT_PRICE: TFloatField;
    qTariffsADVANCE_PAYMENT: TFloatField;
    qTariffsDAYLY_PAYMENT: TFloatField;
    qTariffsDAYLY_PAYMENT_LOCKED: TFloatField;
    qTariffsMONTHLY_PAYMENT: TFloatField;
    qTariffsMONTHLY_PAYMENT_LOCKED: TFloatField;
    qTariffsCALC_KOEFF: TFloatField;
    qTariffsFREE_MONTH_MINUTES_CNT_FOR_RPT: TIntegerField;
    qTariffsBALANCE_BLOCK: TFloatField;
    qTariffsBALANCE_UNBLOCK: TFloatField;
    qTariffsBALANCE_NOTICE: TFloatField;
    qTariffsTARIFF_ADD_COST: TFloatField;
    qTariffsBALANCE_BLOCK_CREDIT: TFloatField;
    qTariffsBALANCE_UNBLOCK_CREDIT: TFloatField;
    qTariffsBALANCE_NOTICE_CREDIT: TFloatField;
    qTariffsTARIFF_CODE_CRM: TStringField;
    qTariffsTARIFF_ABON_DAILY_PAY: TFloatField;
    qTariffsTARIFF_ACTION_PLUS_SMS: TFloatField;
    qTariffsFILIAL_ID: TFloatField;
    qTariffsOPERATOR_MONTHLY_ABON_ACTIV: TFloatField;
    qTariffsOPERATOR_MONTHLY_ABON_BLOCK: TFloatField;
    qTariffsCALC_KOEFF_DETAL: TFloatField;
    qTariffsTRAFFIC_NOT_IGNOR_FOR_INACTIVE: TFloatField;
    qTariffsIS_AUTO_INTERNET: TIntegerField;
    qTariffsNOT_USE_REP_PHONE_WITHOUT_TRAF: TFloatField;
    qTariffsREST_AUTO_INTERNET: TFloatField;
    qTariffsIS_INTERNET_TARIFF: TIntegerField;
    qTariffsOPERATOR_NAME: TStringField;
    qPhoneNumberTypes: TOraQuery;
    dsqPhoneNumberTypes: TOraDataSource;
    qTariffsPHONE_NUMBER_TYPE_NAME: TStringField;
    vtActiveint: TIntegerField;
    vtActivestr: TStringField;
    qTariffsIS_ACTIVE_NAME: TStringField;
    qTariffsFILIAL_NAME: TStringField;
    qTariffsTrafNotIgnor4InactName: TStringField;
    qTariffsIS_INTERNET_TARIFF_NAME: TStringField;
    qTariffsNOTUSEREPPHONEWITHOUTTRAFNAME: TStringField;
    qReportTypeREPORT_TYPE_ID: TFloatField;
    qReportTypeTYPE_REPORT: TStringField;
    qReportTypeREPORT_NAME: TStringField;
    qReportTypeSEND_REPORT: TIntegerField;
    qReportTypeSend_r: TStringField;
    qMailRecipientsRECORD_ID: TFloatField;
    qMailRecipientsTYPE_REPORT: TStringField;
    qMailRecipientsMAIL_ADRESS: TStringField;
    qMailRecipientsREPORT_NAME: TStringField;
    qDiscounts: TOraQuery;
    dsqDiscounts: TOraDataSource;
    qDiscountsPHONE_NUMBER: TStringField;
    qDiscountsIS_DISCOUNT_OPERATOR: TIntegerField;
    qDiscountsDISCOUNT_BEGIN_DATE: TDateTimeField;
    qDiscountsDISCOUNT_VALIDITY: TFloatField;
    qDiscountsis_discount: TStringField;
    qAbonentsREGION_NAME: TStringField;
    qCountries_CitizenCOUNTRY_ID: TFloatField;
    qCountries_CitizenCOUNTRY_NAME: TStringField;
    qAbonentsCOUNTRY_NAME: TStringField;
    qAbonentsREGION_NAME2: TStringField;
    qForwardingSMSFORWARDING_ID: TFloatField;
    qPhoneNumberTypesPHONE_NUMBER_TYPE: TIntegerField;
    qPhoneNumberTypesPHONE_NUMBER_TYPE_NAME: TStringField;
    dsPatamsTypes: TDataSource;
    PatamsTypes: TVirtualTable;
    PatamsTypesType: TStringField;
    PatamsTypesTypeName: TStringField;
    qParamsTypeName: TStringField;
    qCrm_PhoneUnref: TOraQuery;
    qContractGroupGROUP_NAME: TStringField;
    dsqCrm_PhoneUnref: TOraDataSource;
    qMNPDATE_ACTIVATE: TDateTimeField;
    qFormAccess: TOraQuery;
    OraQuery1: TOraQuery;
    qAccounts: TOraQuery;
    qPeriods: TOraQuery;
    dsPeriods: TDataSource;
    qMonthYearforRepFrm: TOraQuery;
    qMonthYearforRepFrmYEAR_MONTH: TFloatField;
    qMonthYearforRepFrmYEAR_MONTH_NAME: TStringField;
    ImageList32: TImageList;
    ImageList24: TImageList;
    ImageList16: TImageList;
    qTarif_Option_New_Cost: TOraQuery;
    TARIFF_OPTION_ID: TFloatField;
    OPTION_CODE: TStringField;
    OPTION_NAME: TStringField;
    KOEF_KOMISS_O: TFloatField;
    CALC_UNBLOCK_O: TStringField;
    DISCR_SPISANIE: TStringField;
    OPTION_NAME_FOR_AB: TStringField;
    qTarif_Option_New_CostBEGIN_DATE: TDateTimeField;
    qTarif_Option_New_CostEND_DATE: TDateTimeField;
    TURN_ON_COST_O: TFloatField;
    MONTHLY_COST_O: TFloatField;
    OPERATOR_TURN_ON_COST: TFloatField;
    OPERATOR_MONTHLY_COST: TFloatField;
    TURN_ON_COST: TFloatField;
    MONTHLY_COST: TFloatField;
    TURN_ON_COST_FOR_BILLS: TFloatField;
    MONTHLY_COST_FOR_BILLS: TFloatField;
    TRF_OTP_COST_ID: TFloatField;
    TARIFF_OPTION_COST_ID: TFloatField;
    TARIFF_OPTION_NEW_COST_ID: TFloatField;
    TCN_TARIFF_ID: TFloatField;
    dsqTarif_Option_New_Cost: TOraDataSource;
    qReport: TOraQuery;
    qReportACCOUNT_ID: TFloatField;
    qReportLOGIN: TStringField;
    qReportBALANCE: TFloatField;
    qReportLAG_BALANCE: TFloatField;
    qReportDATE_CREATED: TDateTimeField;
    qReportDATE_LAST_UPDATED: TDateTimeField;
    qReportUSER_LAST_UPDATED: TStringField;
    dsqReport: TOraDataSource;
    qTariffsTARIFF_URL: TStringField;
    qTariffsUSSD_TURN_ON_COMMAND: TStringField;
    qTariffsCHANGE_FROM_T: TBooleanField;
    qTariffsCHANGE_TO_T: TBooleanField;
    qTariffsCHANGE_TO_TARIFF: TFloatField;
    qTariffsCHANGE_FROM_TARIFF: TFloatField;
    qTariffsIS_ACTIV_N: TBooleanField;
    qTariffsPHONE_NUMBER_T: TBooleanField;
    qTariffsTARIFF_PRIORIT: TBooleanField;
    qTariffsIS_ACTIVE: TFloatField;
    qTariffsPHONE_NUMBER_TYPE: TFloatField;
    qTariffsTARIFF_PRIORITY: TFloatField;
    qTariff_options: TOraQuery;
    qTariff_optionsOPERATOR_NAME: TStringField;
    qTariff_optionsOPTION_CODE: TStringField;
    qTariff_optionsKOEF_KOMISS: TFloatField;
    qTariff_optionsOPTION_NAME: TStringField;
    qTariff_optionsDiscr_SPIS: TBooleanField;
    qTariff_optionsCAN_BE_TURNED_BY_OPERATOR: TFloatField;
    qTariff_optionsCAN_BE_TUR: TBooleanField;
    qTariff_optionsOPTION_NAME_FOR_AB: TStringField;
    qTariff_optionsCAN_BE_ABONENT: TBooleanField;
    qTariff_optionsCAN_BE_TURNED_BY_ABONENT: TFloatField;
    qTariff_optionsUSSD_TURN_ON_COMMAND: TStringField;
    qTariff_optionsUSSD_TURN_OFF_COMMAND: TStringField;
    qTariff_optionsIS_AUTO_INTER: TBooleanField;
    qTariff_optionsIS_AUTO_INTERNET: TFloatField;
    qTariff_optionsINTERNET_VOLUME: TFloatField;
    qTariff_optionsIS_UNLIM_INTE: TBooleanField;
    qTariff_optionsIS_UNLIM_INTERNET: TFloatField;
    qTariff_optionsTARIFF_OPTION_ID: TFloatField;
    qTariff_optionsOPERATOR_ID: TFloatField;
    qTariff_optionsDISCR_SPISANIE: TFloatField;
    dsqTariff_options: TOraDataSource;
    qTariffsDETAILED_TARIFF_NAME: TStringField;
    dsSPECIAL_BANS: TOraDataSource;
    qTariffsSPECIAL_BAN_ID: TFloatField;
    qTariffsSPECIAL_BAN_NAME: TStringField;
    qSPECIAL_BANS: TOraQuery;
    qSPECIAL_BANSSPECIAL_BAN_ID: TFloatField;
    qSPECIAL_BANSSPECIAL_BAN_NAME: TStringField;
    qSPECIAL_BANSUSER_CREATED: TStringField;
    qSPECIAL_BANSDATE_CREATED: TDateTimeField;
    qSPECIAL_BANSUSER_LAST_UPDATED: TStringField;
    qSPECIAL_BANSDATE_LAST_UPDATED: TDateTimeField;
    qmnp_remove: TOraQuery;
    qmnp_removePHONE_NUMBER: TStringField;
    qmnp_removeTEMP_PHONE_NUMBER: TStringField;
    qmnp_removeDATE_ACTIVATE: TDateTimeField;
    qmnp_removeIS_ACTIVE: TIntegerField;
    dsqmnp_remove: TOraDataSource;
    qmnp_removeIS_ACTIVE_: TBooleanField;
    qmnp_removeUSER_CREATED: TStringField;
    qmnp_removeDATE_CREATED: TDateTimeField;
    qmnp_removeUSER_CREATED_FIO: TStringField;
    qOrganization_users: TOraQuery;
    qUserNamesOrganization_NAME: TStringField;
    qUserNamesOrganization_ID: TFloatField;
    dsqOrganization_users: TDataSource;
    procedure N1Click(Sender: TObject);
    procedure P1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure tmrSplashTimer(Sender: TObject);
    // function GetConstantValue(const Name:string):string;
    // function GetParamValue(const Name:string):string;
    function GetDefaultCountry: Variant;
    function GetDefaultRegion: Variant;
    function GetNextContractNum: String;
    procedure FreeContractNum(const pFreeNum: integer);
    function FindAbonentId(const pPhoneNumber: String; const vContNum: integer;
      var pAbonentId: Variant): boolean;
    function CheckBANByPhoneNumber(pPhone: String): boolean;
    function GetMaxPROMISED_PAYMENT(pUser_Name: string): Variant;
    procedure OraSessionAfterConnect(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure InitPict;

    procedure OraSessionConnectionLost(Sender: TObject; Component: TComponent;
      ConnLostCause: TConnLostCause; var RetryMode: TRetryMode);
    procedure OraSession_Connect;
    function ChangeOldPassword(txt: String): String;
    // function UserRightsType : integer;
    function Allow_account: integer;
    procedure qMenuAccessBeforeOpen(DataSet: TDataSet);
    function GetValue(const query: TOraQuery; const Name: string): string;
    procedure SplScreenClick(Sender: TObject);
    procedure qSPECIAL_BANSAfterPost(DataSet: TDataSet);


    // Function GetSystemPath(SystemPath:TSystemPath):string;

  private
    { Private declarations }
    FFilialId: integer;
  public
    PersonalPath: string;
    ClientImg: TPicture;
    applMainForm: TForm;
    splashDone: boolean;
    showZastav: boolean;
    VersionOfModule: string;
    VersionValue: double;
    api, e_care, old_cab, FFilial, FUserRightsType, FIsAdmin, FCheckAllow,
      FConstantSettingsCount, FParamSettingsCount: integer;
    IsMonitorRun, IsMonitorEvRun, FUseFilialBlockAccess, OraSQLMon_Active,
      IsAdmin, FConnected: boolean;
    // FConstantSettings : array of TStr;
    // FParamSettings    : array of TStr;
    fPassword, fServer, fUserName, fSchemaName, fFileName: string;
    // из ини файла
    modal_rez_ChangePassword: integer;
    MDI_State, ConFormDestroy, SplScreenCloseOnClick: boolean;
    MainCaption: string;
    DebugMode, NewIcon: boolean;

  end;

var
  Dm: TDm;

implementation

{$R *.dfm}

uses ChangePassword;

procedure TDm.DataModuleCreate(Sender: TObject);
var
  i: integer;
  str_: string;
begin
  NewIcon := false;
  PersonalPath := GetSystemPath(Personal);
  ClientImg := TPicture.Create;
  IsMonitorRun := false;
  IsMonitorEvRun := false;
  IsAdmin := false;
  FUserRightsType := -1;
  FIsAdmin := -1;
  FCheckAllow := -1;
  api := 0;
  old_cab := 0;
  e_care := 0;
  FConnected := false;
  fFileName := Application.ExeName;
  fFileName := ParamStr(0);
  VersionOfModule := GetVersionTextOfModule(fFileName);
  VersionValue := GetVersionValue(VersionOfModule);
  ReadIniParams(fFileName, fUserName, fServer, fSchemaName, fPassword);
  ReadIniDebug(fFileName, OraSQLMon_Active);
  SplScreenCloseOnClick := false;
  SplScreen.BasicProgramInfo.ProgramVersion.Text := 'Версия ' + VersionOfModule;
  SplScreen.Show();
  splashDone := false;
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
  ReadIniAny(fFileName, 'CONNECT', 'DEBUG', str_);
  if (str_ = '0') or (str_ = '') then
    DebugMode := false
  else
    DebugMode := true;

  DebugMode := true;

  OraSession_Connect;

  ReadIniAny(fFileName, 'MAIN_WINDOWS', 'VSTROENOE', str_);
  if (str_ = '0') or (str_ = '') then
    MDI_State := true
  else
    MDI_State := false;

  OraSQLMon.Active := DebugMode;
  InitPict;
end;

procedure TDm.DataModuleDestroy(Sender: TObject);
var
  str_: string;
begin
  if FConnected then
    WriteIniParams(fFileName, OraSession.Username, OraSession.Server,
      OraSession.Schema, OraSession.Password);
  if MDI_State then
    str_ := '0'
  else
    str_ := '1';
  WriteIniAny(fFileName, 'MAIN_WINDOWS', 'VSTROENOE', str_);
  ClientImg.SaveToFile(PersonalPath + 'img.jpg');
  ClientImg.Free;
end;

procedure TDm.InitPict;
var
  rStream: TResourceStream;
  fname: string;
begin
  fname := PersonalPath + 'img.jpg';
  if FileExists(fname) then
    ClientImg.LoadFromFile(fname)
  else
  begin
    rStream := TResourceStream.Create(hInstance, 'JpgImage_1', RT_RCDATA);
    rStream.Position := 0;
    try
      rStream.SaveToFile(fname);
    finally
      rStream.Free;
    end;
    ClientImg.LoadFromFile(fname); // Так грузить JPG!!!
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
  except
    on eAbort: exception do
      OraSQLMon_Active := false;
    on E: EDatabaseError do
      OraSQLMon_Active := false;
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
var
  i: integer;
  ChangePassword: TChangePasswordForm;
  EncryptPwd: boolean;
begin
  // опять покажем заставку
  // прячем на время отладки
  {
  if not DebugMode then
  begin
 //   splashDone := false;
  //  SplScreen.Show();
  end;
  }
  // tmrSplash.Enabled := True;
  // Чтение констант из БД
  qConstants.ParamByName('ACC_VER').AsFloat := VersionValue;
  // всегда открыты
  qConstants.Open;
  qParams.Open;
  // всегда открыты

  // Чтение прав
  spFilialId.ExecProc;
  FFilial := spFilialId.ParamByName('RESULT').AsInteger;
  FUseFilialBlockAccess := (GetValue(qConstants, 'USE_FILIAL_BLOCK_ACCESS')
    = '1') and (StrToInt(GetValue(qConstants, 'HEAD_OFFICE')) <> FFilial);
  // GetConstantValue('HEAD_OFFICE')) <> FFilial);

  // Если выставлена константа шифрования пароля, предлогаем пользователю сменить пароль на шифрованный
  // у владельца схемы пароль нешифрованный

  EncryptPwd := (GetValue(qConstants, 'ENCRYPT_PASSWORD') = '1');
  // (GetConstantValue('ENCRYPT_PASSWORD') = '1');
  if EncryptPwd and (not SameText(OraSession.Username, OraSession.Schema)) then
  begin
    if not qUserRigthsType_EncryptPwd.Active then
    begin
      qUserRigthsType_EncryptPwd.ParamByName('USER_NAME').AsString := OraSession.Username;
      qUserRigthsType_EncryptPwd.Open;
    end;
    EncryptPwd := qUserRigthsType_EncryptPwd.FieldByName('encrypt_pwd').AsInteger <> 1;
    qUserRigthsType_EncryptPwd.Close;
    if EncryptPwd then
    begin
      ChangePassword := TChangePasswordForm.Create(nil);
      modal_rez_ChangePassword := ChangePassword.ShowModal;
      ChangePassword.Free;
    end;
  end;

  if SameText(OraSession.Username, OraSession.Schema) then
    // Под именем схемы работает администратор!
    IsAdmin := true
  else
  begin
    if FIsAdmin = -1 then
    begin
      qCheckUserPrivileges.ParamByName('USER_NAME').AsString := OraSession.Username;
      try
        qCheckUserPrivileges.Open;
        if qCheckUserPrivileges.FieldByName('CNT').AsInteger > 0 then
        begin
          FIsAdmin := 1;
          IsAdmin := true;
          FUserRightsType := 1;
        end
        else
        begin
          FIsAdmin := -1;
          IsAdmin := false;
          FUserRightsType := 3;
        end;
      finally
        qCheckUserPrivileges.Close;
      end;
    end
    else
    begin
      if FIsAdmin = 1 then
        IsAdmin := true
      else
        IsAdmin := false;
    end;
  end;

  if not IsAdmin then
  try
    if not qUserRigthsType_EncryptPwd.Active then
    begin
      qUserRigthsType_EncryptPwd.ParamByName('USER_NAME').AsString := OraSession.Username;
      qUserRigthsType_EncryptPwd.Open;
    end;
    FUserRightsType := qUserRigthsType_EncryptPwd.FieldByName('rights_type').AsInteger;
    FCheckAllow := qUserRigthsType_EncryptPwd.FieldByName('CHECK_ALLOW_ACCOUNT').AsInteger;
  finally
    qUserRigthsType_EncryptPwd.Close;
  end;



end;

function TDm.Allow_account: integer;
begin
  if FCheckAllow = -1 then
  begin
    try
      qUserRigthsType_EncryptPwd.ParamByName('USER_NAME').AsString := OraSession.Username;
      qUserRigthsType_EncryptPwd.Open;
      FUserRightsType := qUserRigthsType_EncryptPwd.FieldByName('rights_type').AsInteger;
      FCheckAllow := qUserRigthsType_EncryptPwd.FieldByName('CHECK_ALLOW_ACCOUNT').AsInteger;
    finally
      qUserRigthsType_EncryptPwd.Close;
    end;
  end;
  result := FCheckAllow;
end;

procedure TDm.qMenuAccessBeforeOpen(DataSet: TDataSet);
begin
  qMenuAccess.ParamByName('USER_NAME').AsString := OraSession.Username;
  qMenuAccess.ParamByName('RIGHTS_TYPE').AsInteger := FUserRightsType;
  qMenuAccess.ParamByName('CHECK_ALLOW_ACCOUNT').AsInteger := FCheckAllow;

end;

procedure TDm.qSPECIAL_BANSAfterPost(DataSet: TDataSet);
begin
    qSPECIAL_BANS.Refresh;
end;

procedure TDm.SplScreenClick(Sender: TObject);
begin
  if SplScreenCloseOnClick then
    SplScreen.Hide;
  SplScreenCloseOnClick := false;
end;

function TDm.ChangeOldPassword(txt: String): String;
begin
  result := 'Ok';
  try
    alter_user_encrypt_pwd.ParamByName('p_USER_NAME').AsString :=
      OraSession.Username;
    alter_user_encrypt_pwd.ParamByName('p_PASSWORD').AsString := md5_30(txt);
    alter_user_encrypt_pwd.ExecSQL;
  except
    on E: exception do
      result := E.Message;
  end;
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

procedure TDm.tmrSplashTimer(Sender: TObject);
begin
  tmrSplash.Enabled := false;
  // splashDone := true;
  // SplScreen.Hide;
end;

procedure TDm.TrayIcon1DblClick(Sender: TObject);
begin
  applMainForm.Show();
  applMainForm.WindowState := wsNormal;
  Application.BringToFront();
end;

function TDm.GetValue(const query: TOraQuery; const Name: string): string;
var
  Itog: Variant;
begin
  if not query.Active then
    query.Open;
  Itog := query.Lookup('name', Name, 'value');
  if Itog = Unassigned then
    result := ''
  else
    result := VarToStr(Itog);
end;

function TDm.GetDefaultCountry: Variant;
begin
  result := Null;
  try
    qDefaultCountry.Close;
    qDefaultCountry.Open;
    if qDefaultCountry.RecordCount > 0 then
      result := qDefaultCountry.FieldByName('COUNTRY_ID').Value;
  except
    on E: exception do; // глотаем ошибку
  end;
end;

function TDm.GetDefaultRegion: Variant;
begin
  result := Null;
  try
    qDefaultregion.Close;
    qDefaultregion.Open;
    if qDefaultregion.RecordCount > 0 then
      result := qDefaultregion.FieldByName('REGION_ID').Value;
  except
    on E: exception do; // глотаем ошибку
  end;
end;

function TDm.GetNextContractNum: String;
begin
  result := '';
  try
    qGetNextNum.ExecSQL;
    result := qGetNextNum.ParamByName('RESULT').AsString;
  except
    on E: exception do
      MessageDlg('Ошибка при получении следующего номера договора.', mtError,
        [mbOK], 0);
  end;
end;

procedure TDm.FreeContractNum(const pFreeNum: integer);
begin
  try
    qFreeValue.ParamByName('PCONTRACT_NUM').Value := pFreeNum;
    qFreeValue.ExecSQL;
  except
    on E: exception do
      MessageDlg('Ошибка при освобождении номера.', mtError, [mbOK], 0);
  end;
end;

function TDm.FindAbonentId(const pPhoneNumber: String; const vContNum: integer;
  var pAbonentId: Variant): boolean;
begin
  result := false;
  try
    qContract.Close;
    qContract.ParamByName('CONTRACT_ID').Value := Null;
    qContract.ParamByName('PHONE_NUMBER').Value := pPhoneNumber;
    qContract.ParamByName('CONTRACT_NUM').Value := vContNum;
    qContract.Open;
    if not qContract.IsEmpty then
    begin
      pAbonentId := qContract.FieldByName('ABONENT_ID').Value;
      result := true;
    end
    else
      pAbonentId := 0;
  except
    on E: exception do
      MessageDlg('Ошибка при определении кода абонента.'#13#10 + E.Message,
        mtError, [mbOK], 0);
  end;
end;

// определяет максимальную сумму обещанного платежа пользователя
function TDm.GetMaxPROMISED_PAYMENT(pUser_Name: string): Variant;
var
  qS: TOraQuery;
begin
  result := Null;
  qS := TOraQuery.Create(nil);
  qS.Session := OraSession;
  try
    qS.SQL.Text :=
      'SELECT MAX_PROMISED_PAYMENT FROM USER_NAMES WHERE USER_NAME = UPPER(:pUSER_NAME)';
    qS.ParamByName('pUSER_NAME').AsString := pUser_Name;
    qS.Open;
    result := qS.FieldByName('MAX_PROMISED_PAYMENT').AsVariant;
  finally
    FreeAndNil(qS);
  end;
end;

// проверка доступности пользователя к лиц. счету в зависимости от номера тел.
// доступ устанавливается указанием доступных BAN
function TDm.CheckBANByPhoneNumber(pPhone: String): boolean;
var
  qS: TOraQuery;
begin
  result := true;
  if (GetValue(qConstants, 'SHOW_USER_NAME_ACCOUNTS') = '1') then
  // (GetConstantValue('SHOW_USER_NAME_ACCOUNTS')='1') then
  begin
    qS := TOraQuery.Create(nil);
    qS.Session := OraSession;
    try
      // проверяем имеется ли ограничение для пользователя по лиц. счетам
      qS.SQL.Text :=
        'SELECT COUNT(ac.ACCOUNT_ID) AccCount FROM USER_NAME_ACCOUNTS ac ' +
        ' LEFT JOIN USER_NAMES us ON us. USER_NAME_ID = ac. USER_NAME_ID ' +
        ' WHERE us.USER_NAME = UPPER(:pUSER_NAME)';
      qS.ParamByName('pUSER_NAME').AsString := OraSession.Username;
      qS.Open;
      // если ограничения имеются
      if qS.FieldByName('AccCount').AsInteger <> 0 then
      begin
        qS.Close;
        qS.SQL.Text :=
          'SELECT DISTINCT(PHONE_NUMBER) PHONE_NUMBE FROM DB_LOADER_ACCOUNT_PHONES '
          + ' WHERE PHONE_NUMBER = :pPHONE_NUMBER AND ACCOUNT_ID IN ' +
          ' (SELECT ac.ACCOUNT_ID FROM USER_NAME_ACCOUNTS ac ' +
          ' LEFT JOIN USER_NAMES us ON us. USER_NAME_ID = ac. USER_NAME_ID ' +
          ' WHERE us.USER_NAME = UPPER(:pUSER_NAME))';
        qS.ParamByName('pUSER_NAME').AsString := OraSession.Username;
        qS.ParamByName('pPHONE_NUMBER').AsString := pPhone;
        qS.Open;
        result := (not qS.IsEmpty);
      end;
    finally
      FreeAndNil(qS);
    end;
  end;
end;

end.
