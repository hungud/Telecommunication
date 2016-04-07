// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : C:\Users\TARIFER\Desktop\Текущие файлики для клиентов\робот DOL\DOLBeline.wsdl
//  >Import : C:\Users\TARIFER\Desktop\Текущие файлики для клиентов\робот DOL\DOLBeline.wsdl>0
// (12.12.2014 13:55:45 - - $Rev: 45757 $)
// ************************************************************************ //

unit DOLBeline;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_UNBD = $0002;
  IS_NLBL = $0004;
  IS_ATTR = $0010;
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:dateTime        - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"[Gbl]

  ContractImport       = class;                 { "http://beeline.ru/ws/dol/2006"[Lit][GblElm] }
  ContractImport4      = class;                 { "http://beeline.ru/ws/dol/2006"[Lit][GblElm] }
  ContractImport2      = class;                 { "http://beeline.ru/ws/dol/2006"[Lit][GblElm] }
  ContractImport3      = class;                 { "http://beeline.ru/ws/dol/2006"[Lit][GblElm] }
  LibraryVersions      = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  GetCertificatePermission = class;             { "http://beeline.ru/ws/dol/2006"[Lit][GblElm] }
  GetCertificatePermissionResponse = class;     { "http://beeline.ru/ws/dol/2006"[Lit][GblElm] }
  Ping                 = class;                 { "http://beeline.ru/ws/dol/2006"[Lit][GblElm] }
  GetLibraryResponse   = class;                 { "http://beeline.ru/ws/dol/2006"[Lit][GblElm] }
  GetLibVersions       = class;                 { "http://beeline.ru/ws/dol/2006"[Lit][GblElm] }
  PingResponse         = class;                 { "http://beeline.ru/ws/dol/2006"[Lit][GblElm] }
  GetTransferNumberRequestsStatusResponse = class;   { "http://beeline.ru/ws/dol/2006"[Lit][GblElm] }
  GetSubscriberDataResponse = class;            { "http://beeline.ru/ws/dol/2006"[Lit][GblElm] }
  GetDealerType        = class;                 { "http://beeline.ru/ws/dol/2006"[Lit][GblElm] }
  ArrayOfChoice1       = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  GetDealerTypeResponse = class;                { "http://beeline.ru/ws/dol/2006"[Lit][GblElm] }
  ReguestStatusesResponse = class;              { "http://beeline.ru/ws/dol/2006"[Lit][GblElm] }
  ReguestStatuses      = class;                 { "http://beeline.ru/ws/dol/2006"[Lit][GblElm] }
  ReguestStatuses2     = class;                 { "http://beeline.ru/ws/dol/2006"[Lit][GblElm] }
  Request              = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  ContractABSInfo      = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  GetTransferNumberRequestsStatus = class;      { "http://beeline.ru/ws/dol/2006"[Lit][GblElm] }
  GetLibrary           = class;                 { "http://beeline.ru/ws/dol/2006"[Lit][GblElm] }
  GetLibVersionResponse = class;                { "http://beeline.ru/ws/dol/2006"[Lit][GblElm] }
  CertificatePermission = class;                { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  Library_             = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  DealerPoint          = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  GetLibVersionsResponse = class;               { "http://beeline.ru/ws/dol/2006"[Lit][GblElm] }
  LibraryVersion       = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  Point                = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  GetLibVersion        = class;                 { "http://beeline.ru/ws/dol/2006"[Lit][GblElm] }
  ResponseContractStatus = class;               { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  ValidateClass        = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  Connection           = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  Mobile               = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  PhoneInfo            = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  AddressStreet        = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  AddressPlace         = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  AddressInfo          = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  ContractDelivery     = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  ContractDeliveryAddress = class;              { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  ContractDeliveryFax  = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  ContractDeliveryEmail = class;                { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  ContractCustomer     = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  ContractConnections  = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  ContractContact      = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  Mobile4              = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  ContractConnections4 = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  ContractDealerInfo   = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  Contract             = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  ReguestStatuses2Response = class;             { "http://beeline.ru/ws/dol/2006"[Lit][GblElm] }
  ResponseContractStatus2 = class;              { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  AddressBuilding      = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  ContractConnections2 = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  GetSubscriberData    = class;                 { "http://beeline.ru/ws/dol/2006"[Lit][GblElm] }
  ContractImport2Response = class;              { "http://beeline.ru/ws/dol/2006"[Lit][GblElm] }
  ContractImport3Response = class;              { "http://beeline.ru/ws/dol/2006"[Lit][GblElm] }
  ContractImport4Response = class;              { "http://beeline.ru/ws/dol/2006"[Lit][GblElm] }
  ContractImportResponse = class;               { "http://beeline.ru/ws/dol/2006"[Lit][GblElm] }
  Contract2            = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  BankProperty         = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  CustomerInfo         = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  PersonInfo           = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  CompanyInfo          = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  AddressRoom          = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  ContractDocument     = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  Name_                = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  BankProperties       = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  LibRow               = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  RowId                = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  RowPrintForms        = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  RowBank              = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  RowCountry           = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  RowScladLink         = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  RowScladLinkHistory  = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  RowBPlanService      = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  RowIdName            = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  RowIdNameAddress     = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  RowIdNameShortName   = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  RowIdNameCode        = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  RowProduct           = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  RowBillPlan          = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  RowLogParam          = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  Contract4            = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  Contract3            = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  Connection2          = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  GetSubscriberDataResult = class;              { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  Connection4          = class;                 { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  TransferNumberRequestsStatus = class;         { "http://beeline.ru/ws/dol/2006"[GblCplx] }

  {$SCOPEDENUMS ON}
  { "http://beeline.ru/ws/dol/2006"[GblSmpl] }
  ContractStatus = (
      ErrDealerAuto, 
      ErrDealerVisControl, 
      ErrCompanyAuto, 
      InDealerVisControl, 
      SendToDealer, 
      Sending, 
      Suspending, 
      New, 
      InCompany, 
      ErrCompanyVisControl, 
      ReadyToABS, 
      RegABSManual, 
      RegABSAuto, 
      ErrCompanyRegABS, 
      ErrCompanyOld, 
      ErrCompanyRegABSFotal, 
      PartialReg, 
      TransferNumberPending
  );

  { "http://beeline.ru/ws/dol/2006"[GblSmpl] }
  LinkType = (_0, _1, _2, _3);

  {$SCOPEDENUMS OFF}



  // ************************************************************************ //
  // XML       : ContractImport, global, <element>
  // Namespace : http://beeline.ru/ws/dol/2006
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  ContractImport = class(TRemotable)
  private
    FCONTRACT: Contract;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property CONTRACT: Contract  Index (IS_NLBL) read FCONTRACT write FCONTRACT;
  end;

  ArrayOfTransferNumberRequestsStatus = array of TransferNumberRequestsStatus;   { "http://beeline.ru/ws/dol/2006"[GblCplx] }


  // ************************************************************************ //
  // XML       : ContractImport4, global, <element>
  // Namespace : http://beeline.ru/ws/dol/2006
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  ContractImport4 = class(TRemotable)
  private
    FCONTRACT: Contract4;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property CONTRACT: Contract4  Index (IS_NLBL) read FCONTRACT write FCONTRACT;
  end;



  // ************************************************************************ //
  // XML       : ContractImport2, global, <element>
  // Namespace : http://beeline.ru/ws/dol/2006
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  ContractImport2 = class(TRemotable)
  private
    FCONTRACT: Contract2;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property CONTRACT: Contract2  Index (IS_NLBL) read FCONTRACT write FCONTRACT;
  end;



  // ************************************************************************ //
  // XML       : ContractImport3, global, <element>
  // Namespace : http://beeline.ru/ws/dol/2006
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  ContractImport3 = class(TRemotable)
  private
    FCONTRACT: Contract3;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property CONTRACT: Contract3  Index (IS_NLBL) read FCONTRACT write FCONTRACT;
  end;

  ArrayOfGetSubscriberDataResult = array of GetSubscriberDataResult;   { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  ArrayOfLibraryVersion = array of LibraryVersion;   { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  ArrayOfDealerPoint = array of DealerPoint;    { "http://beeline.ru/ws/dol/2006"[GblCplx] }
  Array_Of_RowScladLinkHistory = array of RowScladLinkHistory;   { "http://beeline.ru/ws/dol/2006"[GblUbnd] }
  Array_Of_RowBPlanService = array of RowBPlanService;   { "http://beeline.ru/ws/dol/2006"[GblUbnd] }
  Array_Of_RowBillPlan = array of RowBillPlan;   { "http://beeline.ru/ws/dol/2006"[GblUbnd] }
  Array_Of_RowIdName = array of RowIdName;      { "http://beeline.ru/ws/dol/2006"[GblUbnd] }
  Array_Of_Connection2 = array of Connection2;   { "http://beeline.ru/ws/dol/2006"[GblUbnd] }
  Array_Of_Connection4 = array of Connection4;   { "http://beeline.ru/ws/dol/2006"[GblUbnd] }
  Array_Of_Point = array of Point;              { "http://beeline.ru/ws/dol/2006"[GblUbnd] }


  // ************************************************************************ //
  // XML       : LibraryVersions, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  LibraryVersions = class(TRemotable)
  private
    FPUBLIC_: ArrayOfLibraryVersion;
    FPUBLIC__Specified: boolean;
    FPOINT: Array_Of_Point;
    FPOINT_Specified: boolean;
    procedure SetPUBLIC_(Index: Integer; const AArrayOfLibraryVersion: ArrayOfLibraryVersion);
    function  PUBLIC__Specified(Index: Integer): boolean;
    procedure SetPOINT(Index: Integer; const AArray_Of_Point: Array_Of_Point);
    function  POINT_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property PUBLIC_: ArrayOfLibraryVersion  Index (IS_OPTN) read FPUBLIC_ write SetPUBLIC_ stored PUBLIC__Specified;
    property POINT:   Array_Of_Point         Index (IS_OPTN or IS_UNBD) read FPOINT write SetPOINT stored POINT_Specified;
  end;

  Array_Of_RowPrintForms = array of RowPrintForms;   { "http://beeline.ru/ws/dol/2006"[GblUbnd] }
  Array_Of_RowScladLink = array of RowScladLink;   { "http://beeline.ru/ws/dol/2006"[GblUbnd] }
  Array_Of_RowProduct = array of RowProduct;    { "http://beeline.ru/ws/dol/2006"[GblUbnd] }
  Array_Of_RowCountry = array of RowCountry;    { "http://beeline.ru/ws/dol/2006"[GblUbnd] }
  Array_Of_RowIdNameCode = array of RowIdNameCode;   { "http://beeline.ru/ws/dol/2006"[GblUbnd] }
  Array_Of_RowIdNameAddress = array of RowIdNameAddress;   { "http://beeline.ru/ws/dol/2006"[GblUbnd] }
  Array_Of_RowBank = array of RowBank;          { "http://beeline.ru/ws/dol/2006"[GblUbnd] }
  Array_Of_RowIdNameShortName = array of RowIdNameShortName;   { "http://beeline.ru/ws/dol/2006"[GblUbnd] }
  Array_Of_BankProperty = array of BankProperty;   { "http://beeline.ru/ws/dol/2006"[GblUbnd] }


  // ************************************************************************ //
  // XML       : GetCertificatePermission, global, <element>
  // Namespace : http://beeline.ru/ws/dol/2006
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  GetCertificatePermission = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // XML       : GetCertificatePermissionResponse, global, <element>
  // Namespace : http://beeline.ru/ws/dol/2006
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  GetCertificatePermissionResponse = class(TRemotable)
  private
    FGetCertificatePermissionResult: CertificatePermission;
    FGetCertificatePermissionResult_Specified: boolean;
    procedure SetGetCertificatePermissionResult(Index: Integer; const ACertificatePermission: CertificatePermission);
    function  GetCertificatePermissionResult_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property GetCertificatePermissionResult: CertificatePermission  Index (IS_OPTN) read FGetCertificatePermissionResult write SetGetCertificatePermissionResult stored GetCertificatePermissionResult_Specified;
  end;



  // ************************************************************************ //
  // XML       : Ping, global, <element>
  // Namespace : http://beeline.ru/ws/dol/2006
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  Ping = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // XML       : GetLibraryResponse, global, <element>
  // Namespace : http://beeline.ru/ws/dol/2006
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  GetLibraryResponse = class(TRemotable)
  private
    FLIBRARY_: Library_;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property LIBRARY_: Library_  Index (IS_NLBL) read FLIBRARY_ write FLIBRARY_;
  end;



  // ************************************************************************ //
  // XML       : GetLibVersions, global, <element>
  // Namespace : http://beeline.ru/ws/dol/2006
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  GetLibVersions = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // XML       : PingResponse, global, <element>
  // Namespace : http://beeline.ru/ws/dol/2006
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  PingResponse = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // XML       : GetTransferNumberRequestsStatusResponse, global, <element>
  // Namespace : http://beeline.ru/ws/dol/2006
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  GetTransferNumberRequestsStatusResponse = class(TRemotable)
  private
    FGetTransferNumberRequestsStatusResult: ArrayOfTransferNumberRequestsStatus;
    FGetTransferNumberRequestsStatusResult_Specified: boolean;
    procedure SetGetTransferNumberRequestsStatusResult(Index: Integer; const AArrayOfTransferNumberRequestsStatus: ArrayOfTransferNumberRequestsStatus);
    function  GetTransferNumberRequestsStatusResult_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property GetTransferNumberRequestsStatusResult: ArrayOfTransferNumberRequestsStatus  Index (IS_OPTN) read FGetTransferNumberRequestsStatusResult write SetGetTransferNumberRequestsStatusResult stored GetTransferNumberRequestsStatusResult_Specified;
  end;

  Array_Of_Connection = array of Connection;    { "http://beeline.ru/ws/dol/2006"[GblUbnd] }


  // ************************************************************************ //
  // XML       : GetSubscriberDataResponse, global, <element>
  // Namespace : http://beeline.ru/ws/dol/2006
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  GetSubscriberDataResponse = class(TRemotable)
  private
    FGetSubscriberDataResult: ArrayOfGetSubscriberDataResult;
    FGetSubscriberDataResult_Specified: boolean;
    procedure SetGetSubscriberDataResult(Index: Integer; const AArrayOfGetSubscriberDataResult: ArrayOfGetSubscriberDataResult);
    function  GetSubscriberDataResult_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property GetSubscriberDataResult: ArrayOfGetSubscriberDataResult  Index (IS_OPTN) read FGetSubscriberDataResult write SetGetSubscriberDataResult stored GetSubscriberDataResult_Specified;
  end;



  // ************************************************************************ //
  // XML       : GetDealerType, global, <element>
  // Namespace : http://beeline.ru/ws/dol/2006
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  GetDealerType = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;

  ArrayOfRowLogParam = array of RowLogParam;    { "http://beeline.ru/ws/dol/2006"[GblCplx] }


  // ************************************************************************ //
  // XML       : ArrayOfChoice1, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  ArrayOfChoice1 = class(TRemotable)
  private
    FRowLogParam: ArrayOfRowLogParam;
    FRowLogParam_Specified: boolean;
    FRowIdName: Array_Of_RowIdName;
    FRowIdName_Specified: boolean;
    FRowScladLinkHistory: Array_Of_RowScladLinkHistory;
    FRowScladLinkHistory_Specified: boolean;
    FRowBPlanService: Array_Of_RowBPlanService;
    FRowBPlanService_Specified: boolean;
    FRowBillPlan: Array_Of_RowBillPlan;
    FRowBillPlan_Specified: boolean;
    FRowPrintForms: Array_Of_RowPrintForms;
    FRowPrintForms_Specified: boolean;
    FRowIdNameAddress: Array_Of_RowIdNameAddress;
    FRowIdNameAddress_Specified: boolean;
    FRowBank: Array_Of_RowBank;
    FRowBank_Specified: boolean;
    FRowIdNameShortName: Array_Of_RowIdNameShortName;
    FRowIdNameShortName_Specified: boolean;
    FRowIdNameCode: Array_Of_RowIdNameCode;
    FRowIdNameCode_Specified: boolean;
    FRowScladLink: Array_Of_RowScladLink;
    FRowScladLink_Specified: boolean;
    FRowProduct: Array_Of_RowProduct;
    FRowProduct_Specified: boolean;
    FRowCountry: Array_Of_RowCountry;
    FRowCountry_Specified: boolean;
    procedure SetRowLogParam(Index: Integer; const AArrayOfRowLogParam: ArrayOfRowLogParam);
    function  RowLogParam_Specified(Index: Integer): boolean;
    procedure SetRowIdName(Index: Integer; const AArray_Of_RowIdName: Array_Of_RowIdName);
    function  RowIdName_Specified(Index: Integer): boolean;
    procedure SetRowScladLinkHistory(Index: Integer; const AArray_Of_RowScladLinkHistory: Array_Of_RowScladLinkHistory);
    function  RowScladLinkHistory_Specified(Index: Integer): boolean;
    procedure SetRowBPlanService(Index: Integer; const AArray_Of_RowBPlanService: Array_Of_RowBPlanService);
    function  RowBPlanService_Specified(Index: Integer): boolean;
    procedure SetRowBillPlan(Index: Integer; const AArray_Of_RowBillPlan: Array_Of_RowBillPlan);
    function  RowBillPlan_Specified(Index: Integer): boolean;
    procedure SetRowPrintForms(Index: Integer; const AArray_Of_RowPrintForms: Array_Of_RowPrintForms);
    function  RowPrintForms_Specified(Index: Integer): boolean;
    procedure SetRowIdNameAddress(Index: Integer; const AArray_Of_RowIdNameAddress: Array_Of_RowIdNameAddress);
    function  RowIdNameAddress_Specified(Index: Integer): boolean;
    procedure SetRowBank(Index: Integer; const AArray_Of_RowBank: Array_Of_RowBank);
    function  RowBank_Specified(Index: Integer): boolean;
    procedure SetRowIdNameShortName(Index: Integer; const AArray_Of_RowIdNameShortName: Array_Of_RowIdNameShortName);
    function  RowIdNameShortName_Specified(Index: Integer): boolean;
    procedure SetRowIdNameCode(Index: Integer; const AArray_Of_RowIdNameCode: Array_Of_RowIdNameCode);
    function  RowIdNameCode_Specified(Index: Integer): boolean;
    procedure SetRowScladLink(Index: Integer; const AArray_Of_RowScladLink: Array_Of_RowScladLink);
    function  RowScladLink_Specified(Index: Integer): boolean;
    procedure SetRowProduct(Index: Integer; const AArray_Of_RowProduct: Array_Of_RowProduct);
    function  RowProduct_Specified(Index: Integer): boolean;
    procedure SetRowCountry(Index: Integer; const AArray_Of_RowCountry: Array_Of_RowCountry);
    function  RowCountry_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property RowLogParam:         ArrayOfRowLogParam            Index (IS_OPTN or IS_UNBD or IS_NLBL) read FRowLogParam write SetRowLogParam stored RowLogParam_Specified;
    property RowIdName:           Array_Of_RowIdName            Index (IS_OPTN or IS_UNBD or IS_NLBL) read FRowIdName write SetRowIdName stored RowIdName_Specified;
    property RowScladLinkHistory: Array_Of_RowScladLinkHistory  Index (IS_OPTN or IS_UNBD or IS_NLBL) read FRowScladLinkHistory write SetRowScladLinkHistory stored RowScladLinkHistory_Specified;
    property RowBPlanService:     Array_Of_RowBPlanService      Index (IS_OPTN or IS_UNBD or IS_NLBL) read FRowBPlanService write SetRowBPlanService stored RowBPlanService_Specified;
    property RowBillPlan:         Array_Of_RowBillPlan          Index (IS_OPTN or IS_UNBD or IS_NLBL) read FRowBillPlan write SetRowBillPlan stored RowBillPlan_Specified;
    property RowPrintForms:       Array_Of_RowPrintForms        Index (IS_OPTN or IS_UNBD or IS_NLBL) read FRowPrintForms write SetRowPrintForms stored RowPrintForms_Specified;
    property RowIdNameAddress:    Array_Of_RowIdNameAddress     Index (IS_OPTN or IS_UNBD or IS_NLBL) read FRowIdNameAddress write SetRowIdNameAddress stored RowIdNameAddress_Specified;
    property RowBank:             Array_Of_RowBank              Index (IS_OPTN or IS_UNBD or IS_NLBL) read FRowBank write SetRowBank stored RowBank_Specified;
    property RowIdNameShortName:  Array_Of_RowIdNameShortName   Index (IS_OPTN or IS_UNBD or IS_NLBL) read FRowIdNameShortName write SetRowIdNameShortName stored RowIdNameShortName_Specified;
    property RowIdNameCode:       Array_Of_RowIdNameCode        Index (IS_OPTN or IS_UNBD or IS_NLBL) read FRowIdNameCode write SetRowIdNameCode stored RowIdNameCode_Specified;
    property RowScladLink:        Array_Of_RowScladLink         Index (IS_OPTN or IS_UNBD or IS_NLBL) read FRowScladLink write SetRowScladLink stored RowScladLink_Specified;
    property RowProduct:          Array_Of_RowProduct           Index (IS_OPTN or IS_UNBD or IS_NLBL) read FRowProduct write SetRowProduct stored RowProduct_Specified;
    property RowCountry:          Array_Of_RowCountry           Index (IS_OPTN or IS_UNBD or IS_NLBL) read FRowCountry write SetRowCountry stored RowCountry_Specified;
  end;

  ArrayOfInt = array of Integer;                { "http://beeline.ru/ws/dol/2006"[GblCplx] }


  // ************************************************************************ //
  // XML       : GetDealerTypeResponse, global, <element>
  // Namespace : http://beeline.ru/ws/dol/2006
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  GetDealerTypeResponse = class(TRemotable)
  private
    FGetDealerTypeResult: Integer;
  public
    constructor Create; override;
  published
    property GetDealerTypeResult: Integer  read FGetDealerTypeResult write FGetDealerTypeResult;
  end;

  ArrayOfResponseContractStatus = array of ResponseContractStatus;   { "http://beeline.ru/ws/dol/2006"[GblCplx] }


  // ************************************************************************ //
  // XML       : ReguestStatusesResponse, global, <element>
  // Namespace : http://beeline.ru/ws/dol/2006
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  ReguestStatusesResponse = class(TRemotable)
  private
    FReguestStatusesResult: ArrayOfResponseContractStatus;
    FReguestStatusesResult_Specified: boolean;
    procedure SetReguestStatusesResult(Index: Integer; const AArrayOfResponseContractStatus: ArrayOfResponseContractStatus);
    function  ReguestStatusesResult_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property ReguestStatusesResult: ArrayOfResponseContractStatus  Index (IS_OPTN) read FReguestStatusesResult write SetReguestStatusesResult stored ReguestStatusesResult_Specified;
  end;

  ArrayOfRequest = array of Request;            { "http://beeline.ru/ws/dol/2006"[GblCplx] }


  // ************************************************************************ //
  // XML       : ReguestStatuses, global, <element>
  // Namespace : http://beeline.ru/ws/dol/2006
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  ReguestStatuses = class(TRemotable)
  private
    Frequests: ArrayOfRequest;
    Frequests_Specified: boolean;
    procedure Setrequests(Index: Integer; const AArrayOfRequest: ArrayOfRequest);
    function  requests_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property requests: ArrayOfRequest  Index (IS_OPTN) read Frequests write Setrequests stored requests_Specified;
  end;



  // ************************************************************************ //
  // XML       : ReguestStatuses2, global, <element>
  // Namespace : http://beeline.ru/ws/dol/2006
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  ReguestStatuses2 = class(TRemotable)
  private
    Frequests: ArrayOfRequest;
    Frequests_Specified: boolean;
    procedure Setrequests(Index: Integer; const AArrayOfRequest: ArrayOfRequest);
    function  requests_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property requests: ArrayOfRequest  Index (IS_OPTN) read Frequests write Setrequests stored requests_Specified;
  end;



  // ************************************************************************ //
  // XML       : Request, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  Request = class(TRemotable)
  private
    FPointCode: string;
    FPointCode_Specified: boolean;
    FCode: string;
    FCode_Specified: boolean;
    procedure SetPointCode(Index: Integer; const Astring: string);
    function  PointCode_Specified(Index: Integer): boolean;
    procedure SetCode(Index: Integer; const Astring: string);
    function  Code_Specified(Index: Integer): boolean;
  published
    property PointCode: string  Index (IS_ATTR or IS_OPTN) read FPointCode write SetPointCode stored PointCode_Specified;
    property Code:      string  Index (IS_ATTR or IS_OPTN) read FCode write SetCode stored Code_Specified;
  end;



  // ************************************************************************ //
  // XML       : ContractABSInfo, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  ContractABSInfo = class(TRemotable)
  private
    FCode: string;
    FCode_Specified: boolean;
    FDate: TXSDateTime;
    procedure SetCode(Index: Integer; const Astring: string);
    function  Code_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Code: string       Index (IS_ATTR or IS_OPTN) read FCode write SetCode stored Code_Specified;
    property Date: TXSDateTime  Index (IS_ATTR) read FDate write FDate;
  end;



  // ************************************************************************ //
  // XML       : GetTransferNumberRequestsStatus, global, <element>
  // Namespace : http://beeline.ru/ws/dol/2006
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  GetTransferNumberRequestsStatus = class(TRemotable)
  private
    FtransferIdentifier: string;
    FtransferIdentifier_Specified: boolean;
    Fctn: string;
    Fctn_Specified: boolean;
    procedure SettransferIdentifier(Index: Integer; const Astring: string);
    function  transferIdentifier_Specified(Index: Integer): boolean;
    procedure Setctn(Index: Integer; const Astring: string);
    function  ctn_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
  published
    property transferIdentifier: string  Index (IS_OPTN) read FtransferIdentifier write SettransferIdentifier stored transferIdentifier_Specified;
    property ctn:                string  Index (IS_OPTN) read Fctn write Setctn stored ctn_Specified;
  end;



  // ************************************************************************ //
  // XML       : GetLibrary, global, <element>
  // Namespace : http://beeline.ru/ws/dol/2006
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  GetLibrary = class(TRemotable)
  private
    FlibraryCode: string;
    FlibraryCode_Specified: boolean;
    procedure SetlibraryCode(Index: Integer; const Astring: string);
    function  libraryCode_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
  published
    property libraryCode: string  Index (IS_OPTN) read FlibraryCode write SetlibraryCode stored libraryCode_Specified;
  end;



  // ************************************************************************ //
  // XML       : GetLibVersionResponse, global, <element>
  // Namespace : http://beeline.ru/ws/dol/2006
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  GetLibVersionResponse = class(TRemotable)
  private
    FGetLibVersionResult: string;
    FGetLibVersionResult_Specified: boolean;
    procedure SetGetLibVersionResult(Index: Integer; const Astring: string);
    function  GetLibVersionResult_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
  published
    property GetLibVersionResult: string  Index (IS_OPTN) read FGetLibVersionResult write SetGetLibVersionResult stored GetLibVersionResult_Specified;
  end;



  // ************************************************************************ //
  // XML       : CertificatePermission, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  CertificatePermission = class(TRemotable)
  private
    FOwnerPointCode: string;
    FOwnerPointCode_Specified: boolean;
    FOwnerName: string;
    FOwnerName_Specified: boolean;
    FPoints: ArrayOfDealerPoint;
    FPoints_Specified: boolean;
    procedure SetOwnerPointCode(Index: Integer; const Astring: string);
    function  OwnerPointCode_Specified(Index: Integer): boolean;
    procedure SetOwnerName(Index: Integer; const Astring: string);
    function  OwnerName_Specified(Index: Integer): boolean;
    procedure SetPoints(Index: Integer; const AArrayOfDealerPoint: ArrayOfDealerPoint);
    function  Points_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property OwnerPointCode: string              Index (IS_OPTN) read FOwnerPointCode write SetOwnerPointCode stored OwnerPointCode_Specified;
    property OwnerName:      string              Index (IS_OPTN) read FOwnerName write SetOwnerName stored OwnerName_Specified;
    property Points:         ArrayOfDealerPoint  Index (IS_OPTN) read FPoints write SetPoints stored Points_Specified;
  end;



  // ************************************************************************ //
  // XML       : Library, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  Library_ = class(TRemotable)
  private
    FCode: string;
    FCode_Specified: boolean;
    FVersion: string;
    FVersion_Specified: boolean;
    FITEM: ArrayOfChoice1;
    FITEM_Specified: boolean;
    procedure SetCode(Index: Integer; const Astring: string);
    function  Code_Specified(Index: Integer): boolean;
    procedure SetVersion(Index: Integer; const Astring: string);
    function  Version_Specified(Index: Integer): boolean;
    procedure SetITEM(Index: Integer; const AArrayOfChoice1: ArrayOfChoice1);
    function  ITEM_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Code:    string          Index (IS_ATTR or IS_OPTN) read FCode write SetCode stored Code_Specified;
    property Version: string          Index (IS_ATTR or IS_OPTN) read FVersion write SetVersion stored Version_Specified;
    property ITEM:    ArrayOfChoice1  Index (IS_OPTN) read FITEM write SetITEM stored ITEM_Specified;
  end;

  CertificateAccesses =  type string;      { "http://beeline.ru/ws/dol/2006"[GblSmpl] }


  // ************************************************************************ //
  // XML       : DealerPoint, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  DealerPoint = class(TRemotable)
  private
    FCertificateId: Integer;
    FDealerId: Integer;
    FDealerCode: string;
    FDealerCode_Specified: boolean;
    FDealerName: string;
    FDealerName_Specified: boolean;
    FId: Integer;
    FFilialId: Integer;
    FRegionsId: Integer;
    FPointCode: string;
    FPointCode_Specified: boolean;
    FName_: string;
    FName__Specified: boolean;
    FAccess: CertificateAccesses;
    procedure SetDealerCode(Index: Integer; const Astring: string);
    function  DealerCode_Specified(Index: Integer): boolean;
    procedure SetDealerName(Index: Integer; const Astring: string);
    function  DealerName_Specified(Index: Integer): boolean;
    procedure SetPointCode(Index: Integer; const Astring: string);
    function  PointCode_Specified(Index: Integer): boolean;
    procedure SetName_(Index: Integer; const Astring: string);
    function  Name__Specified(Index: Integer): boolean;
  published
    property CertificateId: Integer              Index (IS_NLBL) read FCertificateId write FCertificateId;
    property DealerId:      Integer              Index (IS_NLBL) read FDealerId write FDealerId;
    property DealerCode:    string               Index (IS_OPTN) read FDealerCode write SetDealerCode stored DealerCode_Specified;
    property DealerName:    string               Index (IS_OPTN) read FDealerName write SetDealerName stored DealerName_Specified;
    property Id:            Integer              Index (IS_NLBL) read FId write FId;
    property FilialId:      Integer              Index (IS_NLBL) read FFilialId write FFilialId;
    property RegionsId:     Integer              Index (IS_NLBL) read FRegionsId write FRegionsId;
    property PointCode:     string               Index (IS_OPTN) read FPointCode write SetPointCode stored PointCode_Specified;
    property Name_:         string               Index (IS_OPTN) read FName_ write SetName_ stored Name__Specified;
    property Access:        CertificateAccesses  read FAccess write FAccess;
  end;

  ArrayOfAnyType = array of string;             { "http://beeline.ru/ws/dol/2006"[GblCplx] }


  // ************************************************************************ //
  // XML       : GetLibVersionsResponse, global, <element>
  // Namespace : http://beeline.ru/ws/dol/2006
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  GetLibVersionsResponse = class(TRemotable)
  private
    FGetLibVersionsResult: LibraryVersions;
    FGetLibVersionsResult_Specified: boolean;
    Ferrors: ArrayOfAnyType;
    Ferrors_Specified: boolean;
    procedure SetGetLibVersionsResult(Index: Integer; const ALibraryVersions: LibraryVersions);
    function  GetLibVersionsResult_Specified(Index: Integer): boolean;
    procedure Seterrors(Index: Integer; const AArrayOfAnyType: ArrayOfAnyType);
    function  errors_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property GetLibVersionsResult: LibraryVersions  Index (IS_OPTN) read FGetLibVersionsResult write SetGetLibVersionsResult stored GetLibVersionsResult_Specified;
    property errors:               ArrayOfAnyType   Index (IS_OPTN) read Ferrors write Seterrors stored errors_Specified;
  end;



  // ************************************************************************ //
  // XML       : LibraryVersion, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  LibraryVersion = class(TRemotable)
  private
    FCode: string;
    FCode_Specified: boolean;
    FVersion: string;
    FVersion_Specified: boolean;
    procedure SetCode(Index: Integer; const Astring: string);
    function  Code_Specified(Index: Integer): boolean;
    procedure SetVersion(Index: Integer; const Astring: string);
    function  Version_Specified(Index: Integer): boolean;
  published
    property Code:    string  Index (IS_ATTR or IS_OPTN) read FCode write SetCode stored Code_Specified;
    property Version: string  Index (IS_ATTR or IS_OPTN) read FVersion write SetVersion stored Version_Specified;
  end;



  // ************************************************************************ //
  // XML       : Point, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  Point = class(TRemotable)
  private
    FCode: string;
    FCode_Specified: boolean;
    FITEM: ArrayOfLibraryVersion;
    FITEM_Specified: boolean;
    procedure SetCode(Index: Integer; const Astring: string);
    function  Code_Specified(Index: Integer): boolean;
    procedure SetITEM(Index: Integer; const AArrayOfLibraryVersion: ArrayOfLibraryVersion);
    function  ITEM_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Code: string                 Index (IS_ATTR or IS_OPTN) read FCode write SetCode stored Code_Specified;
    property ITEM: ArrayOfLibraryVersion  Index (IS_OPTN or IS_UNBD) read FITEM write SetITEM stored ITEM_Specified;
  end;



  // ************************************************************************ //
  // XML       : GetLibVersion, global, <element>
  // Namespace : http://beeline.ru/ws/dol/2006
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  GetLibVersion = class(TRemotable)
  private
    Fcode: string;
    Fcode_Specified: boolean;
    procedure Setcode(Index: Integer; const Astring: string);
    function  code_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
  published
    property code: string  Index (IS_OPTN) read Fcode write Setcode stored code_Specified;
  end;

  ArrayOfString = array of string;              { "http://beeline.ru/ws/dol/2006"[GblCplx] }


  // ************************************************************************ //
  // XML       : ResponseContractStatus, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  ResponseContractStatus = class(TRemotable)
  private
    FPointCode: string;
    FPointCode_Specified: boolean;
    FCode: string;
    FCode_Specified: boolean;
    FStatus: Integer;
    FABSContractCode: string;
    FABSContractCode_Specified: boolean;
    FABSContractDate: TXSDateTime;
    FSystemError: string;
    FSystemError_Specified: boolean;
    FErrors: ArrayOfString;
    FErrors_Specified: boolean;
    procedure SetPointCode(Index: Integer; const Astring: string);
    function  PointCode_Specified(Index: Integer): boolean;
    procedure SetCode(Index: Integer; const Astring: string);
    function  Code_Specified(Index: Integer): boolean;
    procedure SetABSContractCode(Index: Integer; const Astring: string);
    function  ABSContractCode_Specified(Index: Integer): boolean;
    procedure SetSystemError(Index: Integer; const Astring: string);
    function  SystemError_Specified(Index: Integer): boolean;
    procedure SetErrors(Index: Integer; const AArrayOfString: ArrayOfString);
    function  Errors_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property PointCode:       string         Index (IS_ATTR or IS_OPTN) read FPointCode write SetPointCode stored PointCode_Specified;
    property Code:            string         Index (IS_ATTR or IS_OPTN) read FCode write SetCode stored Code_Specified;
    property Status:          Integer        Index (IS_ATTR) read FStatus write FStatus;
    property ABSContractCode: string         Index (IS_ATTR or IS_OPTN) read FABSContractCode write SetABSContractCode stored ABSContractCode_Specified;
    property ABSContractDate: TXSDateTime    Index (IS_ATTR) read FABSContractDate write FABSContractDate;
    property SystemError:     string         Index (IS_ATTR or IS_OPTN) read FSystemError write SetSystemError stored SystemError_Specified;
    property Errors:          ArrayOfString  Index (IS_OPTN) read FErrors write SetErrors stored Errors_Specified;
  end;



  // ************************************************************************ //
  // XML       : ValidateClass, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  ValidateClass = class(TRemotable)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : Connection, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  Connection = class(ValidateClass)
  private
    FProductsId: Integer;
    FPhoneOwner: Integer;
    FIMSI: string;
    FIMSI_Specified: boolean;
    FSimLock: Integer;
    FSerNumber: string;
    FSerNumber_Specified: boolean;
    FCellNetsId: Integer;
    FMOBILES: Mobile;
    FMOBILES_Specified: boolean;
    procedure SetIMSI(Index: Integer; const Astring: string);
    function  IMSI_Specified(Index: Integer): boolean;
    procedure SetSerNumber(Index: Integer; const Astring: string);
    function  SerNumber_Specified(Index: Integer): boolean;
    procedure SetMOBILES(Index: Integer; const AMobile: Mobile);
    function  MOBILES_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property ProductsId: Integer  Index (IS_ATTR) read FProductsId write FProductsId;
    property PhoneOwner: Integer  Index (IS_ATTR) read FPhoneOwner write FPhoneOwner;
    property IMSI:       string   Index (IS_ATTR or IS_OPTN) read FIMSI write SetIMSI stored IMSI_Specified;
    property SimLock:    Integer  Index (IS_ATTR) read FSimLock write FSimLock;
    property SerNumber:  string   Index (IS_ATTR or IS_OPTN) read FSerNumber write SetSerNumber stored SerNumber_Specified;
    property CellNetsId: Integer  Index (IS_ATTR) read FCellNetsId write FCellNetsId;
    property MOBILES:    Mobile   Index (IS_OPTN) read FMOBILES write SetMOBILES stored MOBILES_Specified;
  end;



  // ************************************************************************ //
  // XML       : Mobile, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  Mobile = class(ValidateClass)
  private
    FChannelTypesId: Integer;
    FChannelLensId: Integer;
    FSNB: string;
    FSNB_Specified: boolean;
    FBillPlansId: Integer;
    FBillPlanSclad: Integer;
    FSERVICES: ArrayOfInt;
    FSERVICES_Specified: boolean;
    procedure SetSNB(Index: Integer; const Astring: string);
    function  SNB_Specified(Index: Integer): boolean;
    procedure SetSERVICES(Index: Integer; const AArrayOfInt: ArrayOfInt);
    function  SERVICES_Specified(Index: Integer): boolean;
  published
    property ChannelTypesId: Integer     Index (IS_ATTR) read FChannelTypesId write FChannelTypesId;
    property ChannelLensId:  Integer     Index (IS_ATTR) read FChannelLensId write FChannelLensId;
    property SNB:            string      Index (IS_ATTR or IS_OPTN) read FSNB write SetSNB stored SNB_Specified;
    property BillPlansId:    Integer     Index (IS_ATTR) read FBillPlansId write FBillPlansId;
    property BillPlanSclad:  Integer     Index (IS_ATTR) read FBillPlanSclad write FBillPlanSclad;
    property SERVICES:       ArrayOfInt  Index (IS_OPTN) read FSERVICES write SetSERVICES stored SERVICES_Specified;
  end;



  // ************************************************************************ //
  // XML       : PhoneInfo, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  PhoneInfo = class(ValidateClass)
  private
    FPrefix: string;
    FPrefix_Specified: boolean;
    FNumber: string;
    FNumber_Specified: boolean;
    procedure SetPrefix(Index: Integer; const Astring: string);
    function  Prefix_Specified(Index: Integer): boolean;
    procedure SetNumber(Index: Integer; const Astring: string);
    function  Number_Specified(Index: Integer): boolean;
  published
    property Prefix: string  Index (IS_ATTR or IS_OPTN) read FPrefix write SetPrefix stored Prefix_Specified;
    property Number: string  Index (IS_ATTR or IS_OPTN) read FNumber write SetNumber stored Number_Specified;
  end;



  // ************************************************************************ //
  // XML       : AddressStreet, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  AddressStreet = class(ValidateClass)
  private
    FType_: Integer;
    FValue: string;
    FValue_Specified: boolean;
    procedure SetValue(Index: Integer; const Astring: string);
    function  Value_Specified(Index: Integer): boolean;
  published
    property Type_: Integer  Index (IS_ATTR) read FType_ write FType_;
    property Value: string   Index (IS_ATTR or IS_OPTN) read FValue write SetValue stored Value_Specified;
  end;



  // ************************************************************************ //
  // XML       : AddressPlace, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  AddressPlace = class(ValidateClass)
  private
    FType_: Integer;
    FValue: string;
    FValue_Specified: boolean;
    procedure SetValue(Index: Integer; const Astring: string);
    function  Value_Specified(Index: Integer): boolean;
  published
    property Type_: Integer  Index (IS_ATTR) read FType_ write FType_;
    property Value: string   Index (IS_ATTR or IS_OPTN) read FValue write SetValue stored Value_Specified;
  end;



  // ************************************************************************ //
  // XML       : AddressInfo, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  AddressInfo = class(ValidateClass)
  private
    FZIP: string;
    FZIP_Specified: boolean;
    FCOUNTRY: string;
    FCOUNTRY_Specified: boolean;
    FREGION: string;
    FREGION_Specified: boolean;
    FAREA: string;
    FAREA_Specified: boolean;
    FPLACE: AddressPlace;
    FPLACE_Specified: boolean;
    FSTREET: AddressStreet;
    FSTREET_Specified: boolean;
    FHOUSE: string;
    FHOUSE_Specified: boolean;
    FBUILDING: AddressBuilding;
    FBUILDING_Specified: boolean;
    FROOM: AddressRoom;
    FROOM_Specified: boolean;
    procedure SetZIP(Index: Integer; const Astring: string);
    function  ZIP_Specified(Index: Integer): boolean;
    procedure SetCOUNTRY(Index: Integer; const Astring: string);
    function  COUNTRY_Specified(Index: Integer): boolean;
    procedure SetREGION(Index: Integer; const Astring: string);
    function  REGION_Specified(Index: Integer): boolean;
    procedure SetAREA(Index: Integer; const Astring: string);
    function  AREA_Specified(Index: Integer): boolean;
    procedure SetPLACE(Index: Integer; const AAddressPlace: AddressPlace);
    function  PLACE_Specified(Index: Integer): boolean;
    procedure SetSTREET(Index: Integer; const AAddressStreet: AddressStreet);
    function  STREET_Specified(Index: Integer): boolean;
    procedure SetHOUSE(Index: Integer; const Astring: string);
    function  HOUSE_Specified(Index: Integer): boolean;
    procedure SetBUILDING(Index: Integer; const AAddressBuilding: AddressBuilding);
    function  BUILDING_Specified(Index: Integer): boolean;
    procedure SetROOM(Index: Integer; const AAddressRoom: AddressRoom);
    function  ROOM_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property ZIP:      string           Index (IS_OPTN) read FZIP write SetZIP stored ZIP_Specified;
    property COUNTRY:  string           Index (IS_OPTN) read FCOUNTRY write SetCOUNTRY stored COUNTRY_Specified;
    property REGION:   string           Index (IS_OPTN) read FREGION write SetREGION stored REGION_Specified;
    property AREA:     string           Index (IS_OPTN) read FAREA write SetAREA stored AREA_Specified;
    property PLACE:    AddressPlace     Index (IS_OPTN) read FPLACE write SetPLACE stored PLACE_Specified;
    property STREET:   AddressStreet    Index (IS_OPTN) read FSTREET write SetSTREET stored STREET_Specified;
    property HOUSE:    string           Index (IS_OPTN) read FHOUSE write SetHOUSE stored HOUSE_Specified;
    property BUILDING: AddressBuilding  Index (IS_OPTN) read FBUILDING write SetBUILDING stored BUILDING_Specified;
    property ROOM:     AddressRoom      Index (IS_OPTN) read FROOM write SetROOM stored ROOM_Specified;
  end;



  // ************************************************************************ //
  // XML       : ContractDelivery, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  ContractDelivery = class(ValidateClass)
  private
    FNotes: string;
    FNotes_Specified: boolean;
    FType_: Integer;
    procedure SetNotes(Index: Integer; const Astring: string);
    function  Notes_Specified(Index: Integer): boolean;
  published
    property Notes: string   Index (IS_ATTR or IS_OPTN) read FNotes write SetNotes stored Notes_Specified;
    property Type_: Integer  Index (IS_ATTR) read FType_ write FType_;
  end;



  // ************************************************************************ //
  // XML       : ContractDeliveryAddress, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  ContractDeliveryAddress = class(ContractDelivery)
  private
    FADDRESS: AddressInfo;
    FADDRESS_Specified: boolean;
    procedure SetADDRESS(Index: Integer; const AAddressInfo: AddressInfo);
    function  ADDRESS_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property ADDRESS: AddressInfo  Index (IS_OPTN) read FADDRESS write SetADDRESS stored ADDRESS_Specified;
  end;



  // ************************************************************************ //
  // XML       : ContractDeliveryFax, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  ContractDeliveryFax = class(ContractDelivery)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : ContractDeliveryEmail, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  ContractDeliveryEmail = class(ContractDelivery)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : ContractCustomer, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  ContractCustomer = class(ValidateClass)
  private
    FSpheresId: Integer;
    FResident_: Integer;
    FRatepayer: Integer;
    FBANKPROPLIST: BankProperties;
    FBANKPROPLIST_Specified: boolean;
    FPERSON: PersonInfo;
    FPERSON_Specified: boolean;
    FCOMPANY: CompanyInfo;
    FCOMPANY_Specified: boolean;
    FINFO: CustomerInfo;
    FINFO_Specified: boolean;
    FADDRESS: AddressInfo;
    FADDRESS_Specified: boolean;
    procedure SetBANKPROPLIST(Index: Integer; const ABankProperties: BankProperties);
    function  BANKPROPLIST_Specified(Index: Integer): boolean;
    procedure SetPERSON(Index: Integer; const APersonInfo: PersonInfo);
    function  PERSON_Specified(Index: Integer): boolean;
    procedure SetCOMPANY(Index: Integer; const ACompanyInfo: CompanyInfo);
    function  COMPANY_Specified(Index: Integer): boolean;
    procedure SetINFO(Index: Integer; const ACustomerInfo: CustomerInfo);
    function  INFO_Specified(Index: Integer): boolean;
    procedure SetADDRESS(Index: Integer; const AAddressInfo: AddressInfo);
    function  ADDRESS_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property SpheresId:    Integer         Index (IS_ATTR) read FSpheresId write FSpheresId;
    property Resident_:    Integer         Index (IS_ATTR) read FResident_ write FResident_;
    property Ratepayer:    Integer         Index (IS_ATTR) read FRatepayer write FRatepayer;
    property BANKPROPLIST: BankProperties  Index (IS_OPTN) read FBANKPROPLIST write SetBANKPROPLIST stored BANKPROPLIST_Specified;
    property PERSON:       PersonInfo      Index (IS_OPTN) read FPERSON write SetPERSON stored PERSON_Specified;
    property COMPANY:      CompanyInfo     Index (IS_OPTN) read FCOMPANY write SetCOMPANY stored COMPANY_Specified;
    property INFO:         CustomerInfo    Index (IS_OPTN) read FINFO write SetINFO stored INFO_Specified;
    property ADDRESS:      AddressInfo     Index (IS_OPTN) read FADDRESS write SetADDRESS stored ADDRESS_Specified;
  end;



  // ************************************************************************ //
  // XML       : ContractConnections, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  ContractConnections = class(ValidateClass)
  private
    FBillCyclesId: Integer;
    FPaySystemsId: Integer;
    FCONNECTIONS: Array_Of_Connection;
    FCONNECTIONS_Specified: boolean;
    procedure SetCONNECTIONS(Index: Integer; const AArray_Of_Connection: Array_Of_Connection);
    function  CONNECTIONS_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property BillCyclesId: Integer              Index (IS_ATTR) read FBillCyclesId write FBillCyclesId;
    property PaySystemsId: Integer              Index (IS_ATTR) read FPaySystemsId write FPaySystemsId;
    property CONNECTIONS:  Array_Of_Connection  Index (IS_OPTN or IS_UNBD) read FCONNECTIONS write SetCONNECTIONS stored CONNECTIONS_Specified;
  end;



  // ************************************************************************ //
  // XML       : ContractContact, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  ContractContact = class(ValidateClass)
  private
    FSexTypesId: Integer;
    FEMail: string;
    FEMail_Specified: boolean;
    FNotes: string;
    FNotes_Specified: boolean;
    FNAME_: string;
    FNAME__Specified: boolean;
    FPHONE: PhoneInfo;
    FPHONE_Specified: boolean;
    FFAX: PhoneInfo;
    FFAX_Specified: boolean;
    procedure SetEMail(Index: Integer; const Astring: string);
    function  EMail_Specified(Index: Integer): boolean;
    procedure SetNotes(Index: Integer; const Astring: string);
    function  Notes_Specified(Index: Integer): boolean;
    procedure SetNAME_(Index: Integer; const Astring: string);
    function  NAME__Specified(Index: Integer): boolean;
    procedure SetPHONE(Index: Integer; const APhoneInfo: PhoneInfo);
    function  PHONE_Specified(Index: Integer): boolean;
    procedure SetFAX(Index: Integer; const APhoneInfo: PhoneInfo);
    function  FAX_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property SexTypesId: Integer    Index (IS_ATTR) read FSexTypesId write FSexTypesId;
    property EMail:      string     Index (IS_ATTR or IS_OPTN) read FEMail write SetEMail stored EMail_Specified;
    property Notes:      string     Index (IS_ATTR or IS_OPTN) read FNotes write SetNotes stored Notes_Specified;
    property NAME_:      string     Index (IS_OPTN) read FNAME_ write SetNAME_ stored NAME__Specified;
    property PHONE:      PhoneInfo  Index (IS_OPTN) read FPHONE write SetPHONE stored PHONE_Specified;
    property FAX:        PhoneInfo  Index (IS_OPTN) read FFAX write SetFAX stored FAX_Specified;
  end;



  // ************************************************************************ //
  // XML       : Mobile4, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  Mobile4 = class(ValidateClass)
  private
    FChannelTypesId: Integer;
    FChannelLensId: Integer;
    FSNB: string;
    FSNB_Specified: boolean;
    FTransferSNB: string;
    FTransferSNB_Specified: boolean;
    FBillPlansId: Integer;
    FBillPlanSclad: Integer;
    FSERVICES: ArrayOfInt;
    FSERVICES_Specified: boolean;
    procedure SetSNB(Index: Integer; const Astring: string);
    function  SNB_Specified(Index: Integer): boolean;
    procedure SetTransferSNB(Index: Integer; const Astring: string);
    function  TransferSNB_Specified(Index: Integer): boolean;
    procedure SetSERVICES(Index: Integer; const AArrayOfInt: ArrayOfInt);
    function  SERVICES_Specified(Index: Integer): boolean;
  published
    property ChannelTypesId: Integer     Index (IS_ATTR) read FChannelTypesId write FChannelTypesId;
    property ChannelLensId:  Integer     Index (IS_ATTR) read FChannelLensId write FChannelLensId;
    property SNB:            string      Index (IS_ATTR or IS_OPTN) read FSNB write SetSNB stored SNB_Specified;
    property TransferSNB:    string      Index (IS_ATTR or IS_OPTN) read FTransferSNB write SetTransferSNB stored TransferSNB_Specified;
    property BillPlansId:    Integer     Index (IS_ATTR) read FBillPlansId write FBillPlansId;
    property BillPlanSclad:  Integer     Index (IS_ATTR) read FBillPlanSclad write FBillPlanSclad;
    property SERVICES:       ArrayOfInt  Index (IS_OPTN) read FSERVICES write SetSERVICES stored SERVICES_Specified;
  end;



  // ************************************************************************ //
  // XML       : ContractConnections4, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  ContractConnections4 = class(ValidateClass)
  private
    FBillCyclesId: Integer;
    FPaySystemsId: Integer;
    FCONNECTIONS: Array_Of_Connection4;
    FCONNECTIONS_Specified: boolean;
    procedure SetCONNECTIONS(Index: Integer; const AArray_Of_Connection4: Array_Of_Connection4);
    function  CONNECTIONS_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property BillCyclesId: Integer               Index (IS_ATTR) read FBillCyclesId write FBillCyclesId;
    property PaySystemsId: Integer               Index (IS_ATTR) read FPaySystemsId write FPaySystemsId;
    property CONNECTIONS:  Array_Of_Connection4  Index (IS_OPTN or IS_UNBD) read FCONNECTIONS write SetCONNECTIONS stored CONNECTIONS_Specified;
  end;



  // ************************************************************************ //
  // XML       : ContractDealerInfo, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  ContractDealerInfo = class(ValidateClass)
  private
    FCode: string;
    FCode_Specified: boolean;
    FPointCode: string;
    FPointCode_Specified: boolean;
    procedure SetCode(Index: Integer; const Astring: string);
    function  Code_Specified(Index: Integer): boolean;
    procedure SetPointCode(Index: Integer; const Astring: string);
    function  PointCode_Specified(Index: Integer): boolean;
  published
    property Code:      string  Index (IS_ATTR or IS_OPTN) read FCode write SetCode stored Code_Specified;
    property PointCode: string  Index (IS_ATTR or IS_OPTN) read FPointCode write SetPointCode stored PointCode_Specified;
  end;



  // ************************************************************************ //
  // XML       : Contract, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  Contract = class(ValidateClass)
  private
    FStatus: ContractStatus;
    FCode: string;
    FCode_Specified: boolean;
    FDateCreate: TXSDateTime;
    FComments: string;
    FComments_Specified: boolean;
    FClientVer: string;
    FClientVer_Specified: boolean;
    FDEALER: ContractDealerInfo;
    FDEALER_Specified: boolean;
    FABS: ContractABSInfo;
    FABS_Specified: boolean;
    FCUSTOMER: ContractCustomer;
    FCUSTOMER_Specified: boolean;
    FDELIVERYEMAIL: ContractDeliveryEmail;
    FDELIVERYEMAIL_Specified: boolean;
    FDELIVERY: ContractDelivery;
    FDELIVERY_Specified: boolean;
    FDELIVERYFAX: ContractDeliveryFax;
    FDELIVERYFAX_Specified: boolean;
    FDELIVERYADDRESS: ContractDeliveryAddress;
    FDELIVERYADDRESS_Specified: boolean;
    FCONTACT: ContractContact;
    FCONTACT_Specified: boolean;
    FCONNECTIONS: ContractConnections;
    FCONNECTIONS_Specified: boolean;
    FLOGPARAMS: ArrayOfRowLogParam;
    FLOGPARAMS_Specified: boolean;
    procedure SetCode(Index: Integer; const Astring: string);
    function  Code_Specified(Index: Integer): boolean;
    procedure SetComments(Index: Integer; const Astring: string);
    function  Comments_Specified(Index: Integer): boolean;
    procedure SetClientVer(Index: Integer; const Astring: string);
    function  ClientVer_Specified(Index: Integer): boolean;
    procedure SetDEALER(Index: Integer; const AContractDealerInfo: ContractDealerInfo);
    function  DEALER_Specified(Index: Integer): boolean;
    procedure SetABS(Index: Integer; const AContractABSInfo: ContractABSInfo);
    function  ABS_Specified(Index: Integer): boolean;
    procedure SetCUSTOMER(Index: Integer; const AContractCustomer: ContractCustomer);
    function  CUSTOMER_Specified(Index: Integer): boolean;
    procedure SetDELIVERYEMAIL(Index: Integer; const AContractDeliveryEmail: ContractDeliveryEmail);
    function  DELIVERYEMAIL_Specified(Index: Integer): boolean;
    procedure SetDELIVERY(Index: Integer; const AContractDelivery: ContractDelivery);
    function  DELIVERY_Specified(Index: Integer): boolean;
    procedure SetDELIVERYFAX(Index: Integer; const AContractDeliveryFax: ContractDeliveryFax);
    function  DELIVERYFAX_Specified(Index: Integer): boolean;
    procedure SetDELIVERYADDRESS(Index: Integer; const AContractDeliveryAddress: ContractDeliveryAddress);
    function  DELIVERYADDRESS_Specified(Index: Integer): boolean;
    procedure SetCONTACT(Index: Integer; const AContractContact: ContractContact);
    function  CONTACT_Specified(Index: Integer): boolean;
    procedure SetCONNECTIONS(Index: Integer; const AContractConnections: ContractConnections);
    function  CONNECTIONS_Specified(Index: Integer): boolean;
    procedure SetLOGPARAMS(Index: Integer; const AArrayOfRowLogParam: ArrayOfRowLogParam);
    function  LOGPARAMS_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Status:          ContractStatus           Index (IS_ATTR) read FStatus write FStatus;
    property Code:            string                   Index (IS_ATTR or IS_OPTN) read FCode write SetCode stored Code_Specified;
    property DateCreate:      TXSDateTime              Index (IS_ATTR) read FDateCreate write FDateCreate;
    property Comments:        string                   Index (IS_ATTR or IS_OPTN) read FComments write SetComments stored Comments_Specified;
    property ClientVer:       string                   Index (IS_ATTR or IS_OPTN) read FClientVer write SetClientVer stored ClientVer_Specified;
    property DEALER:          ContractDealerInfo       Index (IS_OPTN) read FDEALER write SetDEALER stored DEALER_Specified;
    property ABS:             ContractABSInfo          Index (IS_OPTN) read FABS write SetABS stored ABS_Specified;
    property CUSTOMER:        ContractCustomer         Index (IS_OPTN) read FCUSTOMER write SetCUSTOMER stored CUSTOMER_Specified;
    property DELIVERYEMAIL:   ContractDeliveryEmail    Index (IS_OPTN) read FDELIVERYEMAIL write SetDELIVERYEMAIL stored DELIVERYEMAIL_Specified;
    property DELIVERY:        ContractDelivery         Index (IS_OPTN) read FDELIVERY write SetDELIVERY stored DELIVERY_Specified;
    property DELIVERYFAX:     ContractDeliveryFax      Index (IS_OPTN) read FDELIVERYFAX write SetDELIVERYFAX stored DELIVERYFAX_Specified;
    property DELIVERYADDRESS: ContractDeliveryAddress  Index (IS_OPTN) read FDELIVERYADDRESS write SetDELIVERYADDRESS stored DELIVERYADDRESS_Specified;
    property CONTACT:         ContractContact          Index (IS_OPTN) read FCONTACT write SetCONTACT stored CONTACT_Specified;
    property CONNECTIONS:     ContractConnections      Index (IS_OPTN) read FCONNECTIONS write SetCONNECTIONS stored CONNECTIONS_Specified;
    property LOGPARAMS:       ArrayOfRowLogParam       Index (IS_OPTN) read FLOGPARAMS write SetLOGPARAMS stored LOGPARAMS_Specified;
  end;

  ArrayOfResponseContractStatus2 = array of ResponseContractStatus2;   { "http://beeline.ru/ws/dol/2006"[GblCplx] }


  // ************************************************************************ //
  // XML       : ReguestStatuses2Response, global, <element>
  // Namespace : http://beeline.ru/ws/dol/2006
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  ReguestStatuses2Response = class(TRemotable)
  private
    FReguestStatuses2Result: ArrayOfResponseContractStatus2;
    FReguestStatuses2Result_Specified: boolean;
    procedure SetReguestStatuses2Result(Index: Integer; const AArrayOfResponseContractStatus2: ArrayOfResponseContractStatus2);
    function  ReguestStatuses2Result_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property ReguestStatuses2Result: ArrayOfResponseContractStatus2  Index (IS_OPTN) read FReguestStatuses2Result write SetReguestStatuses2Result stored ReguestStatuses2Result_Specified;
  end;

  ArrayOfString1 = array of string;             { "http://beeline.ru/ws/dol/2006"[GblCplx] }


  // ************************************************************************ //
  // XML       : ResponseContractStatus2, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  ResponseContractStatus2 = class(ResponseContractStatus)
  private
    FActivatedSIMs: ArrayOfString1;
    FActivatedSIMs_Specified: boolean;
    FNotActivatedSIMs: ArrayOfString1;
    FNotActivatedSIMs_Specified: boolean;
    procedure SetActivatedSIMs(Index: Integer; const AArrayOfString1: ArrayOfString1);
    function  ActivatedSIMs_Specified(Index: Integer): boolean;
    procedure SetNotActivatedSIMs(Index: Integer; const AArrayOfString1: ArrayOfString1);
    function  NotActivatedSIMs_Specified(Index: Integer): boolean;
  published
    property ActivatedSIMs:    ArrayOfString1  Index (IS_OPTN) read FActivatedSIMs write SetActivatedSIMs stored ActivatedSIMs_Specified;
    property NotActivatedSIMs: ArrayOfString1  Index (IS_OPTN) read FNotActivatedSIMs write SetNotActivatedSIMs stored NotActivatedSIMs_Specified;
  end;



  // ************************************************************************ //
  // XML       : AddressBuilding, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  AddressBuilding = class(ValidateClass)
  private
    FType_: Integer;
    FValue: string;
    FValue_Specified: boolean;
    procedure SetValue(Index: Integer; const Astring: string);
    function  Value_Specified(Index: Integer): boolean;
  published
    property Type_: Integer  Index (IS_ATTR) read FType_ write FType_;
    property Value: string   Index (IS_ATTR or IS_OPTN) read FValue write SetValue stored Value_Specified;
  end;



  // ************************************************************************ //
  // XML       : ContractConnections2, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  ContractConnections2 = class(ValidateClass)
  private
    FBillCyclesId: Integer;
    FPaySystemsId: Integer;
    FCONNECTIONS: Array_Of_Connection2;
    FCONNECTIONS_Specified: boolean;
    procedure SetCONNECTIONS(Index: Integer; const AArray_Of_Connection2: Array_Of_Connection2);
    function  CONNECTIONS_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property BillCyclesId: Integer               Index (IS_ATTR) read FBillCyclesId write FBillCyclesId;
    property PaySystemsId: Integer               Index (IS_ATTR) read FPaySystemsId write FPaySystemsId;
    property CONNECTIONS:  Array_Of_Connection2  Index (IS_OPTN or IS_UNBD) read FCONNECTIONS write SetCONNECTIONS stored CONNECTIONS_Specified;
  end;

  ArrayOfString2 = array of string;             { "http://beeline.ru/ws/dol/2006"[GblCplx] }


  // ************************************************************************ //
  // XML       : GetSubscriberData, global, <element>
  // Namespace : http://beeline.ru/ws/dol/2006
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  GetSubscriberData = class(TRemotable)
  private
    Fctn: ArrayOfString2;
    Fctn_Specified: boolean;
    procedure Setctn(Index: Integer; const AArrayOfString2: ArrayOfString2);
    function  ctn_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
  published
    property ctn: ArrayOfString2  Index (IS_OPTN) read Fctn write Setctn stored ctn_Specified;
  end;



  // ************************************************************************ //
  // XML       : ContractImport2Response, global, <element>
  // Namespace : http://beeline.ru/ws/dol/2006
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  ContractImport2Response = class(TRemotable)
  private
    FContractImport2Result: Integer;
    Ferrors: ArrayOfString2;
    Ferrors_Specified: boolean;
    procedure Seterrors(Index: Integer; const AArrayOfString2: ArrayOfString2);
    function  errors_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
  published
    property ContractImport2Result: Integer         read FContractImport2Result write FContractImport2Result;
    property errors:                ArrayOfString2  Index (IS_OPTN) read Ferrors write Seterrors stored errors_Specified;
  end;



  // ************************************************************************ //
  // XML       : ContractImport3Response, global, <element>
  // Namespace : http://beeline.ru/ws/dol/2006
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  ContractImport3Response = class(TRemotable)
  private
    FContractImport3Result: Integer;
    Ferrors: ArrayOfString2;
    Ferrors_Specified: boolean;
    procedure Seterrors(Index: Integer; const AArrayOfString2: ArrayOfString2);
    function  errors_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
  published
    property ContractImport3Result: Integer         read FContractImport3Result write FContractImport3Result;
    property errors:                ArrayOfString2  Index (IS_OPTN) read Ferrors write Seterrors stored errors_Specified;
  end;



  // ************************************************************************ //
  // XML       : ContractImport4Response, global, <element>
  // Namespace : http://beeline.ru/ws/dol/2006
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  ContractImport4Response = class(TRemotable)
  private
    FContractImport4Result: Integer;
    Ferrors: ArrayOfString2;
    Ferrors_Specified: boolean;
    procedure Seterrors(Index: Integer; const AArrayOfString2: ArrayOfString2);
    function  errors_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
  published
    property ContractImport4Result: Integer         read FContractImport4Result write FContractImport4Result;
    property errors:                ArrayOfString2  Index (IS_OPTN) read Ferrors write Seterrors stored errors_Specified;
  end;



  // ************************************************************************ //
  // XML       : ContractImportResponse, global, <element>
  // Namespace : http://beeline.ru/ws/dol/2006
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  ContractImportResponse = class(TRemotable)
  private
    FContractImportResult: Integer;
    Ferrors: ArrayOfString2;
    Ferrors_Specified: boolean;
    procedure Seterrors(Index: Integer; const AArrayOfString2: ArrayOfString2);
    function  errors_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
  published
    property ContractImportResult: Integer         read FContractImportResult write FContractImportResult;
    property errors:               ArrayOfString2  Index (IS_OPTN) read Ferrors write Seterrors stored errors_Specified;
  end;



  // ************************************************************************ //
  // XML       : Contract2, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  Contract2 = class(ValidateClass)
  private
    FStatus: ContractStatus;
    FCode: string;
    FCode_Specified: boolean;
    FDateCreate: TXSDateTime;
    FComments: string;
    FComments_Specified: boolean;
    FClientVer: string;
    FClientVer_Specified: boolean;
    FBAN: string;
    FBAN_Specified: boolean;
    FDEALER: ContractDealerInfo;
    FDEALER_Specified: boolean;
    FABS: ContractABSInfo;
    FABS_Specified: boolean;
    FCUSTOMER: ContractCustomer;
    FCUSTOMER_Specified: boolean;
    FDELIVERY: ContractDelivery;
    FDELIVERY_Specified: boolean;
    FDELIVERYFAX: ContractDeliveryFax;
    FDELIVERYFAX_Specified: boolean;
    FDELIVERYADDRESS: ContractDeliveryAddress;
    FDELIVERYADDRESS_Specified: boolean;
    FDELIVERYEMAIL: ContractDeliveryEmail;
    FDELIVERYEMAIL_Specified: boolean;
    FCONTACT: ContractContact;
    FCONTACT_Specified: boolean;
    FCONNECTIONS: ContractConnections2;
    FCONNECTIONS_Specified: boolean;
    FLOGPARAMS: ArrayOfRowLogParam;
    FLOGPARAMS_Specified: boolean;
    FCorpBillPlanId: Integer;
    procedure SetCode(Index: Integer; const Astring: string);
    function  Code_Specified(Index: Integer): boolean;
    procedure SetComments(Index: Integer; const Astring: string);
    function  Comments_Specified(Index: Integer): boolean;
    procedure SetClientVer(Index: Integer; const Astring: string);
    function  ClientVer_Specified(Index: Integer): boolean;
    procedure SetBAN(Index: Integer; const Astring: string);
    function  BAN_Specified(Index: Integer): boolean;
    procedure SetDEALER(Index: Integer; const AContractDealerInfo: ContractDealerInfo);
    function  DEALER_Specified(Index: Integer): boolean;
    procedure SetABS(Index: Integer; const AContractABSInfo: ContractABSInfo);
    function  ABS_Specified(Index: Integer): boolean;
    procedure SetCUSTOMER(Index: Integer; const AContractCustomer: ContractCustomer);
    function  CUSTOMER_Specified(Index: Integer): boolean;
    procedure SetDELIVERY(Index: Integer; const AContractDelivery: ContractDelivery);
    function  DELIVERY_Specified(Index: Integer): boolean;
    procedure SetDELIVERYFAX(Index: Integer; const AContractDeliveryFax: ContractDeliveryFax);
    function  DELIVERYFAX_Specified(Index: Integer): boolean;
    procedure SetDELIVERYADDRESS(Index: Integer; const AContractDeliveryAddress: ContractDeliveryAddress);
    function  DELIVERYADDRESS_Specified(Index: Integer): boolean;
    procedure SetDELIVERYEMAIL(Index: Integer; const AContractDeliveryEmail: ContractDeliveryEmail);
    function  DELIVERYEMAIL_Specified(Index: Integer): boolean;
    procedure SetCONTACT(Index: Integer; const AContractContact: ContractContact);
    function  CONTACT_Specified(Index: Integer): boolean;
    procedure SetCONNECTIONS(Index: Integer; const AContractConnections2: ContractConnections2);
    function  CONNECTIONS_Specified(Index: Integer): boolean;
    procedure SetLOGPARAMS(Index: Integer; const AArrayOfRowLogParam: ArrayOfRowLogParam);
    function  LOGPARAMS_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Status:          ContractStatus           Index (IS_ATTR) read FStatus write FStatus;
    property Code:            string                   Index (IS_ATTR or IS_OPTN) read FCode write SetCode stored Code_Specified;
    property DateCreate:      TXSDateTime              Index (IS_ATTR) read FDateCreate write FDateCreate;
    property Comments:        string                   Index (IS_ATTR or IS_OPTN) read FComments write SetComments stored Comments_Specified;
    property ClientVer:       string                   Index (IS_ATTR or IS_OPTN) read FClientVer write SetClientVer stored ClientVer_Specified;
    property BAN:             string                   Index (IS_ATTR or IS_OPTN) read FBAN write SetBAN stored BAN_Specified;
    property DEALER:          ContractDealerInfo       Index (IS_OPTN) read FDEALER write SetDEALER stored DEALER_Specified;
    property ABS:             ContractABSInfo          Index (IS_OPTN) read FABS write SetABS stored ABS_Specified;
    property CUSTOMER:        ContractCustomer         Index (IS_OPTN) read FCUSTOMER write SetCUSTOMER stored CUSTOMER_Specified;
    property DELIVERY:        ContractDelivery         Index (IS_OPTN) read FDELIVERY write SetDELIVERY stored DELIVERY_Specified;
    property DELIVERYFAX:     ContractDeliveryFax      Index (IS_OPTN) read FDELIVERYFAX write SetDELIVERYFAX stored DELIVERYFAX_Specified;
    property DELIVERYADDRESS: ContractDeliveryAddress  Index (IS_OPTN) read FDELIVERYADDRESS write SetDELIVERYADDRESS stored DELIVERYADDRESS_Specified;
    property DELIVERYEMAIL:   ContractDeliveryEmail    Index (IS_OPTN) read FDELIVERYEMAIL write SetDELIVERYEMAIL stored DELIVERYEMAIL_Specified;
    property CONTACT:         ContractContact          Index (IS_OPTN) read FCONTACT write SetCONTACT stored CONTACT_Specified;
    property CONNECTIONS:     ContractConnections2     Index (IS_OPTN) read FCONNECTIONS write SetCONNECTIONS stored CONNECTIONS_Specified;
    property LOGPARAMS:       ArrayOfRowLogParam       Index (IS_OPTN) read FLOGPARAMS write SetLOGPARAMS stored LOGPARAMS_Specified;
    property CorpBillPlanId:  Integer                  Index (IS_NLBL) read FCorpBillPlanId write FCorpBillPlanId;
  end;



  // ************************************************************************ //
  // XML       : BankProperty, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  BankProperty = class(ValidateClass)
  private
    FName_: string;
    FName__Specified: boolean;
    FAccount: string;
    FAccount_Specified: boolean;
    FCorrAccount: string;
    FCorrAccount_Specified: boolean;
    FBIK: string;
    FBIK_Specified: boolean;
    procedure SetName_(Index: Integer; const Astring: string);
    function  Name__Specified(Index: Integer): boolean;
    procedure SetAccount(Index: Integer; const Astring: string);
    function  Account_Specified(Index: Integer): boolean;
    procedure SetCorrAccount(Index: Integer; const Astring: string);
    function  CorrAccount_Specified(Index: Integer): boolean;
    procedure SetBIK(Index: Integer; const Astring: string);
    function  BIK_Specified(Index: Integer): boolean;
  published
    property Name_:       string  Index (IS_ATTR or IS_OPTN) read FName_ write SetName_ stored Name__Specified;
    property Account:     string  Index (IS_ATTR or IS_OPTN) read FAccount write SetAccount stored Account_Specified;
    property CorrAccount: string  Index (IS_ATTR or IS_OPTN) read FCorrAccount write SetCorrAccount stored CorrAccount_Specified;
    property BIK:         string  Index (IS_ATTR or IS_OPTN) read FBIK write SetBIK stored BIK_Specified;
  end;



  // ************************************************************************ //
  // XML       : CustomerInfo, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  CustomerInfo = class(ValidateClass)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : PersonInfo, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  PersonInfo = class(CustomerInfo)
  private
    FType_: Integer;
    FINN: string;
    FINN_Specified: boolean;
    FSexTypesId: Integer;
    FNAME_: Name_;
    FNAME__Specified: boolean;
    FDOCUMENT: ContractDocument;
    FDOCUMENT_Specified: boolean;
    procedure SetINN(Index: Integer; const Astring: string);
    function  INN_Specified(Index: Integer): boolean;
    procedure SetNAME_(Index: Integer; const AName_: Name_);
    function  NAME__Specified(Index: Integer): boolean;
    procedure SetDOCUMENT(Index: Integer; const AContractDocument: ContractDocument);
    function  DOCUMENT_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Type_:      Integer           Index (IS_ATTR) read FType_ write FType_;
    property INN:        string            Index (IS_ATTR or IS_OPTN) read FINN write SetINN stored INN_Specified;
    property SexTypesId: Integer           Index (IS_ATTR) read FSexTypesId write FSexTypesId;
    property NAME_:      Name_             Index (IS_OPTN) read FNAME_ write SetNAME_ stored NAME__Specified;
    property DOCUMENT:   ContractDocument  Index (IS_OPTN) read FDOCUMENT write SetDOCUMENT stored DOCUMENT_Specified;
  end;



  // ************************************************************************ //
  // XML       : CompanyInfo, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  CompanyInfo = class(CustomerInfo)
  private
    FType_: Integer;
    FINN: string;
    FINN_Specified: boolean;
    FName_: string;
    FName__Specified: boolean;
    FOKONH: string;
    FOKONH_Specified: boolean;
    FOKPO: string;
    FOKPO_Specified: boolean;
    FKPP: string;
    FKPP_Specified: boolean;
    procedure SetINN(Index: Integer; const Astring: string);
    function  INN_Specified(Index: Integer): boolean;
    procedure SetName_(Index: Integer; const Astring: string);
    function  Name__Specified(Index: Integer): boolean;
    procedure SetOKONH(Index: Integer; const Astring: string);
    function  OKONH_Specified(Index: Integer): boolean;
    procedure SetOKPO(Index: Integer; const Astring: string);
    function  OKPO_Specified(Index: Integer): boolean;
    procedure SetKPP(Index: Integer; const Astring: string);
    function  KPP_Specified(Index: Integer): boolean;
  published
    property Type_: Integer  Index (IS_ATTR) read FType_ write FType_;
    property INN:   string   Index (IS_ATTR or IS_OPTN) read FINN write SetINN stored INN_Specified;
    property Name_: string   Index (IS_ATTR or IS_OPTN) read FName_ write SetName_ stored Name__Specified;
    property OKONH: string   Index (IS_ATTR or IS_OPTN) read FOKONH write SetOKONH stored OKONH_Specified;
    property OKPO:  string   Index (IS_ATTR or IS_OPTN) read FOKPO write SetOKPO stored OKPO_Specified;
    property KPP:   string   Index (IS_ATTR or IS_OPTN) read FKPP write SetKPP stored KPP_Specified;
  end;



  // ************************************************************************ //
  // XML       : AddressRoom, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  AddressRoom = class(ValidateClass)
  private
    FType_: Integer;
    FValue: string;
    FValue_Specified: boolean;
    procedure SetValue(Index: Integer; const Astring: string);
    function  Value_Specified(Index: Integer): boolean;
  published
    property Type_: Integer  Index (IS_ATTR) read FType_ write FType_;
    property Value: string   Index (IS_ATTR or IS_OPTN) read FValue write SetValue stored Value_Specified;
  end;



  // ************************************************************************ //
  // XML       : ContractDocument, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  ContractDocument = class(ValidateClass)
  private
    FSeria: string;
    FSeria_Specified: boolean;
    FNumber: string;
    FNumber_Specified: boolean;
    FGivenBy: string;
    FGivenBy_Specified: boolean;
    FDate: TXSDateTime;
    FBirthday: TXSDateTime;
    FType_: Integer;
    procedure SetSeria(Index: Integer; const Astring: string);
    function  Seria_Specified(Index: Integer): boolean;
    procedure SetNumber(Index: Integer; const Astring: string);
    function  Number_Specified(Index: Integer): boolean;
    procedure SetGivenBy(Index: Integer; const Astring: string);
    function  GivenBy_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Seria:    string       Index (IS_ATTR or IS_OPTN) read FSeria write SetSeria stored Seria_Specified;
    property Number:   string       Index (IS_ATTR or IS_OPTN) read FNumber write SetNumber stored Number_Specified;
    property GivenBy:  string       Index (IS_ATTR or IS_OPTN) read FGivenBy write SetGivenBy stored GivenBy_Specified;
    property Date:     TXSDateTime  Index (IS_ATTR) read FDate write FDate;
    property Birthday: TXSDateTime  Index (IS_ATTR) read FBirthday write FBirthday;
    property Type_:    Integer      Index (IS_ATTR) read FType_ write FType_;
  end;



  // ************************************************************************ //
  // XML       : Name, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  Name_ = class(ValidateClass)
  private
    FLast: string;
    FLast_Specified: boolean;
    FFirst: string;
    FFirst_Specified: boolean;
    FSecond: string;
    FSecond_Specified: boolean;
    procedure SetLast(Index: Integer; const Astring: string);
    function  Last_Specified(Index: Integer): boolean;
    procedure SetFirst(Index: Integer; const Astring: string);
    function  First_Specified(Index: Integer): boolean;
    procedure SetSecond(Index: Integer; const Astring: string);
    function  Second_Specified(Index: Integer): boolean;
  published
    property Last:   string  Index (IS_ATTR or IS_OPTN) read FLast write SetLast stored Last_Specified;
    property First:  string  Index (IS_ATTR or IS_OPTN) read FFirst write SetFirst stored First_Specified;
    property Second: string  Index (IS_ATTR or IS_OPTN) read FSecond write SetSecond stored Second_Specified;
  end;



  // ************************************************************************ //
  // XML       : BankProperties, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  BankProperties = class(ValidateClass)
  private
    FBANKPROPSPRIM: BankProperty;
    FBANKPROPSPRIM_Specified: boolean;
    FBANKPROPSSEC: Array_Of_BankProperty;
    FBANKPROPSSEC_Specified: boolean;
    procedure SetBANKPROPSPRIM(Index: Integer; const ABankProperty: BankProperty);
    function  BANKPROPSPRIM_Specified(Index: Integer): boolean;
    procedure SetBANKPROPSSEC(Index: Integer; const AArray_Of_BankProperty: Array_Of_BankProperty);
    function  BANKPROPSSEC_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property BANKPROPSPRIM: BankProperty           Index (IS_OPTN) read FBANKPROPSPRIM write SetBANKPROPSPRIM stored BANKPROPSPRIM_Specified;
    property BANKPROPSSEC:  Array_Of_BankProperty  Index (IS_OPTN or IS_UNBD) read FBANKPROPSSEC write SetBANKPROPSSEC stored BANKPROPSSEC_Specified;
  end;



  // ************************************************************************ //
  // XML       : LibRow, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  LibRow = class(TRemotable)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : RowId, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  RowId = class(LibRow)
  private
    FId: Integer;
  published
    property Id: Integer  Index (IS_ATTR) read FId write FId;
  end;



  // ************************************************************************ //
  // XML       : RowPrintForms, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  RowPrintForms = class(RowId)
  private
    FPAYSYSTEMSID: Integer;
    FBILLPLANSID: Integer;
    FHEADER: string;
    FHEADER_Specified: boolean;
    FREQUISITES: string;
    FREQUISITES_Specified: boolean;
    FMARKID: Integer;
    FPPersonFormTitle: string;
    FPPersonFormTitle_Specified: boolean;
    FJPersonFormTitle: string;
    FJPersonFormTitle_Specified: boolean;
    FJHeader: string;
    FJHeader_Specified: boolean;
    FRegAddressPSectionName: string;
    FRegAddressPSectionName_Specified: boolean;
    FRegAddressJSectionName: string;
    FRegAddressJSectionName_Specified: boolean;
    FDeliveryAddressSectionName: string;
    FDeliveryAddressSectionName_Specified: boolean;
    FServicesSectionName: string;
    FServicesSectionName_Specified: boolean;
    FVCSectionName: string;
    FVCSectionName_Specified: boolean;
    FJSignName: string;
    FJSignName_Specified: boolean;
    FPSignName: string;
    FPSignName_Specified: boolean;
    procedure SetHEADER(Index: Integer; const Astring: string);
    function  HEADER_Specified(Index: Integer): boolean;
    procedure SetREQUISITES(Index: Integer; const Astring: string);
    function  REQUISITES_Specified(Index: Integer): boolean;
    procedure SetPPersonFormTitle(Index: Integer; const Astring: string);
    function  PPersonFormTitle_Specified(Index: Integer): boolean;
    procedure SetJPersonFormTitle(Index: Integer; const Astring: string);
    function  JPersonFormTitle_Specified(Index: Integer): boolean;
    procedure SetJHeader(Index: Integer; const Astring: string);
    function  JHeader_Specified(Index: Integer): boolean;
    procedure SetRegAddressPSectionName(Index: Integer; const Astring: string);
    function  RegAddressPSectionName_Specified(Index: Integer): boolean;
    procedure SetRegAddressJSectionName(Index: Integer; const Astring: string);
    function  RegAddressJSectionName_Specified(Index: Integer): boolean;
    procedure SetDeliveryAddressSectionName(Index: Integer; const Astring: string);
    function  DeliveryAddressSectionName_Specified(Index: Integer): boolean;
    procedure SetServicesSectionName(Index: Integer; const Astring: string);
    function  ServicesSectionName_Specified(Index: Integer): boolean;
    procedure SetVCSectionName(Index: Integer; const Astring: string);
    function  VCSectionName_Specified(Index: Integer): boolean;
    procedure SetJSignName(Index: Integer; const Astring: string);
    function  JSignName_Specified(Index: Integer): boolean;
    procedure SetPSignName(Index: Integer; const Astring: string);
    function  PSignName_Specified(Index: Integer): boolean;
  published
    property PAYSYSTEMSID:               Integer  Index (IS_ATTR) read FPAYSYSTEMSID write FPAYSYSTEMSID;
    property BILLPLANSID:                Integer  Index (IS_ATTR) read FBILLPLANSID write FBILLPLANSID;
    property HEADER:                     string   Index (IS_ATTR or IS_OPTN) read FHEADER write SetHEADER stored HEADER_Specified;
    property REQUISITES:                 string   Index (IS_ATTR or IS_OPTN) read FREQUISITES write SetREQUISITES stored REQUISITES_Specified;
    property MARKID:                     Integer  Index (IS_ATTR) read FMARKID write FMARKID;
    property PPersonFormTitle:           string   Index (IS_ATTR or IS_OPTN) read FPPersonFormTitle write SetPPersonFormTitle stored PPersonFormTitle_Specified;
    property JPersonFormTitle:           string   Index (IS_ATTR or IS_OPTN) read FJPersonFormTitle write SetJPersonFormTitle stored JPersonFormTitle_Specified;
    property JHeader:                    string   Index (IS_ATTR or IS_OPTN) read FJHeader write SetJHeader stored JHeader_Specified;
    property RegAddressPSectionName:     string   Index (IS_ATTR or IS_OPTN) read FRegAddressPSectionName write SetRegAddressPSectionName stored RegAddressPSectionName_Specified;
    property RegAddressJSectionName:     string   Index (IS_ATTR or IS_OPTN) read FRegAddressJSectionName write SetRegAddressJSectionName stored RegAddressJSectionName_Specified;
    property DeliveryAddressSectionName: string   Index (IS_ATTR or IS_OPTN) read FDeliveryAddressSectionName write SetDeliveryAddressSectionName stored DeliveryAddressSectionName_Specified;
    property ServicesSectionName:        string   Index (IS_ATTR or IS_OPTN) read FServicesSectionName write SetServicesSectionName stored ServicesSectionName_Specified;
    property VCSectionName:              string   Index (IS_ATTR or IS_OPTN) read FVCSectionName write SetVCSectionName stored VCSectionName_Specified;
    property JSignName:                  string   Index (IS_ATTR or IS_OPTN) read FJSignName write SetJSignName stored JSignName_Specified;
    property PSignName:                  string   Index (IS_ATTR or IS_OPTN) read FPSignName write SetPSignName stored PSignName_Specified;
  end;



  // ************************************************************************ //
  // XML       : RowBank, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  RowBank = class(RowId)
  private
    FMFO: string;
    FMFO_Specified: boolean;
    FMFON: string;
    FMFON_Specified: boolean;
    FN_UCH: string;
    FN_UCH_Specified: boolean;
    FBNK: string;
    FBNK_Specified: boolean;
    FADDRESS: string;
    FADDRESS_Specified: boolean;
    FCORCH: string;
    FCORCH_Specified: boolean;
    FUER: string;
    FUER_Specified: boolean;
    procedure SetMFO(Index: Integer; const Astring: string);
    function  MFO_Specified(Index: Integer): boolean;
    procedure SetMFON(Index: Integer; const Astring: string);
    function  MFON_Specified(Index: Integer): boolean;
    procedure SetN_UCH(Index: Integer; const Astring: string);
    function  N_UCH_Specified(Index: Integer): boolean;
    procedure SetBNK(Index: Integer; const Astring: string);
    function  BNK_Specified(Index: Integer): boolean;
    procedure SetADDRESS(Index: Integer; const Astring: string);
    function  ADDRESS_Specified(Index: Integer): boolean;
    procedure SetCORCH(Index: Integer; const Astring: string);
    function  CORCH_Specified(Index: Integer): boolean;
    procedure SetUER(Index: Integer; const Astring: string);
    function  UER_Specified(Index: Integer): boolean;
  published
    property MFO:     string  Index (IS_ATTR or IS_OPTN) read FMFO write SetMFO stored MFO_Specified;
    property MFON:    string  Index (IS_ATTR or IS_OPTN) read FMFON write SetMFON stored MFON_Specified;
    property N_UCH:   string  Index (IS_ATTR or IS_OPTN) read FN_UCH write SetN_UCH stored N_UCH_Specified;
    property BNK:     string  Index (IS_ATTR or IS_OPTN) read FBNK write SetBNK stored BNK_Specified;
    property ADDRESS: string  Index (IS_ATTR or IS_OPTN) read FADDRESS write SetADDRESS stored ADDRESS_Specified;
    property CORCH:   string  Index (IS_ATTR or IS_OPTN) read FCORCH write SetCORCH stored CORCH_Specified;
    property UER:     string  Index (IS_ATTR or IS_OPTN) read FUER write SetUER stored UER_Specified;
  end;



  // ************************************************************************ //
  // XML       : RowCountry, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  RowCountry = class(RowId)
  private
    FSortNum: Integer;
    FCode: string;
    FCode_Specified: boolean;
    FEnglishName: string;
    FEnglishName_Specified: boolean;
    FTranslation: string;
    FTranslation_Specified: boolean;
    procedure SetCode(Index: Integer; const Astring: string);
    function  Code_Specified(Index: Integer): boolean;
    procedure SetEnglishName(Index: Integer; const Astring: string);
    function  EnglishName_Specified(Index: Integer): boolean;
    procedure SetTranslation(Index: Integer; const Astring: string);
    function  Translation_Specified(Index: Integer): boolean;
  published
    property SortNum:     Integer  Index (IS_ATTR) read FSortNum write FSortNum;
    property Code:        string   Index (IS_ATTR or IS_OPTN) read FCode write SetCode stored Code_Specified;
    property EnglishName: string   Index (IS_ATTR or IS_OPTN) read FEnglishName write SetEnglishName stored EnglishName_Specified;
    property Translation: string   Index (IS_ATTR or IS_OPTN) read FTranslation write SetTranslation stored Translation_Specified;
  end;



  // ************************************************************************ //
  // XML       : RowScladLink, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  RowScladLink = class(LibRow)
  private
    FSNB: string;
    FSNB_Specified: boolean;
    FType_: LinkType;
    FSerNum: string;
    FSerNum_Specified: boolean;
    FSOC: string;
    FSOC_Specified: boolean;
    FHLR: string;
    FHLR_Specified: boolean;
    FRegionCode: string;
    FRegionCode_Specified: boolean;
    procedure SetSNB(Index: Integer; const Astring: string);
    function  SNB_Specified(Index: Integer): boolean;
    procedure SetSerNum(Index: Integer; const Astring: string);
    function  SerNum_Specified(Index: Integer): boolean;
    procedure SetSOC(Index: Integer; const Astring: string);
    function  SOC_Specified(Index: Integer): boolean;
    procedure SetHLR(Index: Integer; const Astring: string);
    function  HLR_Specified(Index: Integer): boolean;
    procedure SetRegionCode(Index: Integer; const Astring: string);
    function  RegionCode_Specified(Index: Integer): boolean;
  published
    property SNB:        string    Index (IS_ATTR or IS_OPTN) read FSNB write SetSNB stored SNB_Specified;
    property Type_:      LinkType  Index (IS_ATTR) read FType_ write FType_;
    property SerNum:     string    Index (IS_ATTR or IS_OPTN) read FSerNum write SetSerNum stored SerNum_Specified;
    property SOC:        string    Index (IS_ATTR or IS_OPTN) read FSOC write SetSOC stored SOC_Specified;
    property HLR:        string    Index (IS_ATTR or IS_OPTN) read FHLR write SetHLR stored HLR_Specified;
    property RegionCode: string    Index (IS_ATTR or IS_OPTN) read FRegionCode write SetRegionCode stored RegionCode_Specified;
  end;



  // ************************************************************************ //
  // XML       : RowScladLinkHistory, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  RowScladLinkHistory = class(RowScladLink)
  private
    FChangeSOCDate: TXSDateTime;
  public
    destructor Destroy; override;
  published
    property ChangeSOCDate: TXSDateTime  Index (IS_ATTR) read FChangeSOCDate write FChangeSOCDate;
  end;



  // ************************************************************************ //
  // XML       : RowBPlanService, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  RowBPlanService = class(LibRow)
  private
    FBillPlansId: Integer;
    FServicesId: Integer;
    FMandatory: Integer;
  published
    property BillPlansId: Integer  Index (IS_ATTR) read FBillPlansId write FBillPlansId;
    property ServicesId:  Integer  Index (IS_ATTR) read FServicesId write FServicesId;
    property Mandatory:   Integer  Index (IS_ATTR) read FMandatory write FMandatory;
  end;



  // ************************************************************************ //
  // XML       : RowIdName, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  RowIdName = class(RowId)
  private
    FName_: string;
    FName__Specified: boolean;
    procedure SetName_(Index: Integer; const Astring: string);
    function  Name__Specified(Index: Integer): boolean;
  published
    property Name_: string  Index (IS_ATTR or IS_OPTN) read FName_ write SetName_ stored Name__Specified;
  end;



  // ************************************************************************ //
  // XML       : RowIdNameAddress, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  RowIdNameAddress = class(RowIdName)
  private
    FAddress: AddressInfo;
    FAddress_Specified: boolean;
    procedure SetAddress(Index: Integer; const AAddressInfo: AddressInfo);
    function  Address_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Address: AddressInfo  Index (IS_OPTN) read FAddress write SetAddress stored Address_Specified;
  end;



  // ************************************************************************ //
  // XML       : RowIdNameShortName, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  RowIdNameShortName = class(RowIdName)
  private
    FShortName: string;
    FShortName_Specified: boolean;
    procedure SetShortName(Index: Integer; const Astring: string);
    function  ShortName_Specified(Index: Integer): boolean;
  published
    property ShortName: string  Index (IS_ATTR or IS_OPTN) read FShortName write SetShortName stored ShortName_Specified;
  end;



  // ************************************************************************ //
  // XML       : RowIdNameCode, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  RowIdNameCode = class(RowIdName)
  private
    FCode: string;
    FCode_Specified: boolean;
    procedure SetCode(Index: Integer; const Astring: string);
    function  Code_Specified(Index: Integer): boolean;
  published
    property Code: string  Index (IS_ATTR or IS_OPTN) read FCode write SetCode stored Code_Specified;
  end;



  // ************************************************************************ //
  // XML       : RowProduct, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  RowProduct = class(RowIdNameCode)
  private
    FCellNetsId: Integer;
  published
    property CellNetsId: Integer  Index (IS_ATTR) read FCellNetsId write FCellNetsId;
  end;



  // ************************************************************************ //
  // XML       : RowBillPlan, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  RowBillPlan = class(RowIdNameCode)
  private
    FPaySystemsId: Integer;
    FCellNetsId: Integer;
    FChannelLensId: Integer;
    FEnable: Integer;
    FAccept: Integer;
    FSOC: string;
    FSOC_Specified: boolean;
    procedure SetSOC(Index: Integer; const Astring: string);
    function  SOC_Specified(Index: Integer): boolean;
  published
    property PaySystemsId:  Integer  Index (IS_ATTR) read FPaySystemsId write FPaySystemsId;
    property CellNetsId:    Integer  Index (IS_ATTR) read FCellNetsId write FCellNetsId;
    property ChannelLensId: Integer  Index (IS_ATTR) read FChannelLensId write FChannelLensId;
    property Enable:        Integer  Index (IS_ATTR) read FEnable write FEnable;
    property Accept:        Integer  Index (IS_ATTR) read FAccept write FAccept;
    property SOC:           string   Index (IS_ATTR or IS_OPTN) read FSOC write SetSOC stored SOC_Specified;
  end;



  // ************************************************************************ //
  // XML       : RowLogParam, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  RowLogParam = class(RowIdNameCode)
  private
    FComments: string;
    FComments_Specified: boolean;
    FValue: Boolean;
    procedure SetComments(Index: Integer; const Astring: string);
    function  Comments_Specified(Index: Integer): boolean;
  published
    property Comments: string   Index (IS_ATTR or IS_OPTN) read FComments write SetComments stored Comments_Specified;
    property Value:    Boolean  Index (IS_ATTR) read FValue write FValue;
  end;



  // ************************************************************************ //
  // XML       : Contract4, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  Contract4 = class(ValidateClass)
  private
    FStatus: ContractStatus;
    FCode: string;
    FCode_Specified: boolean;
    FDateCreate: TXSDateTime;
    FComments: string;
    FComments_Specified: boolean;
    FClientVer: string;
    FClientVer_Specified: boolean;
    FBAN: string;
    FBAN_Specified: boolean;
    FBEN: string;
    FBEN_Specified: boolean;
    FDEALER: ContractDealerInfo;
    FDEALER_Specified: boolean;
    FABS: ContractABSInfo;
    FABS_Specified: boolean;
    FCUSTOMER: ContractCustomer;
    FCUSTOMER_Specified: boolean;
    FDELIVERY: ContractDelivery;
    FDELIVERY_Specified: boolean;
    FDELIVERYADDRESS: ContractDeliveryAddress;
    FDELIVERYADDRESS_Specified: boolean;
    FDELIVERYEMAIL: ContractDeliveryEmail;
    FDELIVERYEMAIL_Specified: boolean;
    FDELIVERYFAX: ContractDeliveryFax;
    FDELIVERYFAX_Specified: boolean;
    FCONTACT: ContractContact;
    FCONTACT_Specified: boolean;
    FCONNECTIONS: ContractConnections4;
    FCONNECTIONS_Specified: boolean;
    FLOGPARAMS: ArrayOfRowLogParam;
    FLOGPARAMS_Specified: boolean;
    FCorpBillPlanId: Integer;
    FAddOption: Boolean;
    FIsTransferNumber: Boolean;
    procedure SetCode(Index: Integer; const Astring: string);
    function  Code_Specified(Index: Integer): boolean;
    procedure SetComments(Index: Integer; const Astring: string);
    function  Comments_Specified(Index: Integer): boolean;
    procedure SetClientVer(Index: Integer; const Astring: string);
    function  ClientVer_Specified(Index: Integer): boolean;
    procedure SetBAN(Index: Integer; const Astring: string);
    function  BAN_Specified(Index: Integer): boolean;
    procedure SetBEN(Index: Integer; const Astring: string);
    function  BEN_Specified(Index: Integer): boolean;
    procedure SetDEALER(Index: Integer; const AContractDealerInfo: ContractDealerInfo);
    function  DEALER_Specified(Index: Integer): boolean;
    procedure SetABS(Index: Integer; const AContractABSInfo: ContractABSInfo);
    function  ABS_Specified(Index: Integer): boolean;
    procedure SetCUSTOMER(Index: Integer; const AContractCustomer: ContractCustomer);
    function  CUSTOMER_Specified(Index: Integer): boolean;
    procedure SetDELIVERY(Index: Integer; const AContractDelivery: ContractDelivery);
    function  DELIVERY_Specified(Index: Integer): boolean;
    procedure SetDELIVERYADDRESS(Index: Integer; const AContractDeliveryAddress: ContractDeliveryAddress);
    function  DELIVERYADDRESS_Specified(Index: Integer): boolean;
    procedure SetDELIVERYEMAIL(Index: Integer; const AContractDeliveryEmail: ContractDeliveryEmail);
    function  DELIVERYEMAIL_Specified(Index: Integer): boolean;
    procedure SetDELIVERYFAX(Index: Integer; const AContractDeliveryFax: ContractDeliveryFax);
    function  DELIVERYFAX_Specified(Index: Integer): boolean;
    procedure SetCONTACT(Index: Integer; const AContractContact: ContractContact);
    function  CONTACT_Specified(Index: Integer): boolean;
    procedure SetCONNECTIONS(Index: Integer; const AContractConnections4: ContractConnections4);
    function  CONNECTIONS_Specified(Index: Integer): boolean;
    procedure SetLOGPARAMS(Index: Integer; const AArrayOfRowLogParam: ArrayOfRowLogParam);
    function  LOGPARAMS_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Status:           ContractStatus           Index (IS_ATTR) read FStatus write FStatus;
    property Code:             string                   Index (IS_ATTR or IS_OPTN) read FCode write SetCode stored Code_Specified;
    property DateCreate:       TXSDateTime              Index (IS_ATTR) read FDateCreate write FDateCreate;
    property Comments:         string                   Index (IS_ATTR or IS_OPTN) read FComments write SetComments stored Comments_Specified;
    property ClientVer:        string                   Index (IS_ATTR or IS_OPTN) read FClientVer write SetClientVer stored ClientVer_Specified;
    property BAN:              string                   Index (IS_ATTR or IS_OPTN) read FBAN write SetBAN stored BAN_Specified;
    property BEN:              string                   Index (IS_ATTR or IS_OPTN) read FBEN write SetBEN stored BEN_Specified;
    property DEALER:           ContractDealerInfo       Index (IS_OPTN) read FDEALER write SetDEALER stored DEALER_Specified;
    property ABS:              ContractABSInfo          Index (IS_OPTN) read FABS write SetABS stored ABS_Specified;
    property CUSTOMER:         ContractCustomer         Index (IS_OPTN) read FCUSTOMER write SetCUSTOMER stored CUSTOMER_Specified;
    property DELIVERY:         ContractDelivery         Index (IS_OPTN) read FDELIVERY write SetDELIVERY stored DELIVERY_Specified;
    property DELIVERYADDRESS:  ContractDeliveryAddress  Index (IS_OPTN) read FDELIVERYADDRESS write SetDELIVERYADDRESS stored DELIVERYADDRESS_Specified;
    property DELIVERYEMAIL:    ContractDeliveryEmail    Index (IS_OPTN) read FDELIVERYEMAIL write SetDELIVERYEMAIL stored DELIVERYEMAIL_Specified;
    property DELIVERYFAX:      ContractDeliveryFax      Index (IS_OPTN) read FDELIVERYFAX write SetDELIVERYFAX stored DELIVERYFAX_Specified;
    property CONTACT:          ContractContact          Index (IS_OPTN) read FCONTACT write SetCONTACT stored CONTACT_Specified;
    property CONNECTIONS:      ContractConnections4     Index (IS_OPTN) read FCONNECTIONS write SetCONNECTIONS stored CONNECTIONS_Specified;
    property LOGPARAMS:        ArrayOfRowLogParam       Index (IS_OPTN) read FLOGPARAMS write SetLOGPARAMS stored LOGPARAMS_Specified;
    property CorpBillPlanId:   Integer                  Index (IS_NLBL) read FCorpBillPlanId write FCorpBillPlanId;
    property AddOption:        Boolean                  Index (IS_NLBL) read FAddOption write FAddOption;
    property IsTransferNumber: Boolean                  Index (IS_NLBL) read FIsTransferNumber write FIsTransferNumber;
  end;



  // ************************************************************************ //
  // XML       : Contract3, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  Contract3 = class(ValidateClass)
  private
    FStatus: ContractStatus;
    FCode: string;
    FCode_Specified: boolean;
    FDateCreate: TXSDateTime;
    FComments: string;
    FComments_Specified: boolean;
    FClientVer: string;
    FClientVer_Specified: boolean;
    FBAN: string;
    FBAN_Specified: boolean;
    FBEN: string;
    FBEN_Specified: boolean;
    FDEALER: ContractDealerInfo;
    FDEALER_Specified: boolean;
    FABS: ContractABSInfo;
    FABS_Specified: boolean;
    FCUSTOMER: ContractCustomer;
    FCUSTOMER_Specified: boolean;
    FDELIVERYADDRESS: ContractDeliveryAddress;
    FDELIVERYADDRESS_Specified: boolean;
    FDELIVERY: ContractDelivery;
    FDELIVERY_Specified: boolean;
    FDELIVERYFAX: ContractDeliveryFax;
    FDELIVERYFAX_Specified: boolean;
    FDELIVERYEMAIL: ContractDeliveryEmail;
    FDELIVERYEMAIL_Specified: boolean;
    FCONTACT: ContractContact;
    FCONTACT_Specified: boolean;
    FCONNECTIONS: ContractConnections2;
    FCONNECTIONS_Specified: boolean;
    FLOGPARAMS: ArrayOfRowLogParam;
    FLOGPARAMS_Specified: boolean;
    FCorpBillPlanId: Integer;
    FAddOption: Boolean;
    procedure SetCode(Index: Integer; const Astring: string);
    function  Code_Specified(Index: Integer): boolean;
    procedure SetComments(Index: Integer; const Astring: string);
    function  Comments_Specified(Index: Integer): boolean;
    procedure SetClientVer(Index: Integer; const Astring: string);
    function  ClientVer_Specified(Index: Integer): boolean;
    procedure SetBAN(Index: Integer; const Astring: string);
    function  BAN_Specified(Index: Integer): boolean;
    procedure SetBEN(Index: Integer; const Astring: string);
    function  BEN_Specified(Index: Integer): boolean;
    procedure SetDEALER(Index: Integer; const AContractDealerInfo: ContractDealerInfo);
    function  DEALER_Specified(Index: Integer): boolean;
    procedure SetABS(Index: Integer; const AContractABSInfo: ContractABSInfo);
    function  ABS_Specified(Index: Integer): boolean;
    procedure SetCUSTOMER(Index: Integer; const AContractCustomer: ContractCustomer);
    function  CUSTOMER_Specified(Index: Integer): boolean;
    procedure SetDELIVERYADDRESS(Index: Integer; const AContractDeliveryAddress: ContractDeliveryAddress);
    function  DELIVERYADDRESS_Specified(Index: Integer): boolean;
    procedure SetDELIVERY(Index: Integer; const AContractDelivery: ContractDelivery);
    function  DELIVERY_Specified(Index: Integer): boolean;
    procedure SetDELIVERYFAX(Index: Integer; const AContractDeliveryFax: ContractDeliveryFax);
    function  DELIVERYFAX_Specified(Index: Integer): boolean;
    procedure SetDELIVERYEMAIL(Index: Integer; const AContractDeliveryEmail: ContractDeliveryEmail);
    function  DELIVERYEMAIL_Specified(Index: Integer): boolean;
    procedure SetCONTACT(Index: Integer; const AContractContact: ContractContact);
    function  CONTACT_Specified(Index: Integer): boolean;
    procedure SetCONNECTIONS(Index: Integer; const AContractConnections2: ContractConnections2);
    function  CONNECTIONS_Specified(Index: Integer): boolean;
    procedure SetLOGPARAMS(Index: Integer; const AArrayOfRowLogParam: ArrayOfRowLogParam);
    function  LOGPARAMS_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Status:          ContractStatus           Index (IS_ATTR) read FStatus write FStatus;
    property Code:            string                   Index (IS_ATTR or IS_OPTN) read FCode write SetCode stored Code_Specified;
    property DateCreate:      TXSDateTime              Index (IS_ATTR) read FDateCreate write FDateCreate;
    property Comments:        string                   Index (IS_ATTR or IS_OPTN) read FComments write SetComments stored Comments_Specified;
    property ClientVer:       string                   Index (IS_ATTR or IS_OPTN) read FClientVer write SetClientVer stored ClientVer_Specified;
    property BAN:             string                   Index (IS_ATTR or IS_OPTN) read FBAN write SetBAN stored BAN_Specified;
    property BEN:             string                   Index (IS_ATTR or IS_OPTN) read FBEN write SetBEN stored BEN_Specified;
    property DEALER:          ContractDealerInfo       Index (IS_OPTN) read FDEALER write SetDEALER stored DEALER_Specified;
    property ABS:             ContractABSInfo          Index (IS_OPTN) read FABS write SetABS stored ABS_Specified;
    property CUSTOMER:        ContractCustomer         Index (IS_OPTN) read FCUSTOMER write SetCUSTOMER stored CUSTOMER_Specified;
    property DELIVERYADDRESS: ContractDeliveryAddress  Index (IS_OPTN) read FDELIVERYADDRESS write SetDELIVERYADDRESS stored DELIVERYADDRESS_Specified;
    property DELIVERY:        ContractDelivery         Index (IS_OPTN) read FDELIVERY write SetDELIVERY stored DELIVERY_Specified;
    property DELIVERYFAX:     ContractDeliveryFax      Index (IS_OPTN) read FDELIVERYFAX write SetDELIVERYFAX stored DELIVERYFAX_Specified;
    property DELIVERYEMAIL:   ContractDeliveryEmail    Index (IS_OPTN) read FDELIVERYEMAIL write SetDELIVERYEMAIL stored DELIVERYEMAIL_Specified;
    property CONTACT:         ContractContact          Index (IS_OPTN) read FCONTACT write SetCONTACT stored CONTACT_Specified;
    property CONNECTIONS:     ContractConnections2     Index (IS_OPTN) read FCONNECTIONS write SetCONNECTIONS stored CONNECTIONS_Specified;
    property LOGPARAMS:       ArrayOfRowLogParam       Index (IS_OPTN) read FLOGPARAMS write SetLOGPARAMS stored LOGPARAMS_Specified;
    property CorpBillPlanId:  Integer                  Index (IS_NLBL) read FCorpBillPlanId write FCorpBillPlanId;
    property AddOption:       Boolean                  Index (IS_NLBL) read FAddOption write FAddOption;
  end;



  // ************************************************************************ //
  // XML       : Connection2, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  Connection2 = class(ValidateClass)
  private
    FProductsId: Integer;
    FPhoneOwner: Integer;
    FIMSI: string;
    FIMSI_Specified: boolean;
    FSimLock: Integer;
    FSerNumber: string;
    FSerNumber_Specified: boolean;
    FCellNetsId: Integer;
    FMOBILES: Mobile;
    FMOBILES_Specified: boolean;
    FActivatedPLE: Boolean;
    procedure SetIMSI(Index: Integer; const Astring: string);
    function  IMSI_Specified(Index: Integer): boolean;
    procedure SetSerNumber(Index: Integer; const Astring: string);
    function  SerNumber_Specified(Index: Integer): boolean;
    procedure SetMOBILES(Index: Integer; const AMobile: Mobile);
    function  MOBILES_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property ProductsId:   Integer  Index (IS_ATTR) read FProductsId write FProductsId;
    property PhoneOwner:   Integer  Index (IS_ATTR) read FPhoneOwner write FPhoneOwner;
    property IMSI:         string   Index (IS_ATTR or IS_OPTN) read FIMSI write SetIMSI stored IMSI_Specified;
    property SimLock:      Integer  Index (IS_ATTR) read FSimLock write FSimLock;
    property SerNumber:    string   Index (IS_ATTR or IS_OPTN) read FSerNumber write SetSerNumber stored SerNumber_Specified;
    property CellNetsId:   Integer  Index (IS_ATTR) read FCellNetsId write FCellNetsId;
    property MOBILES:      Mobile   Index (IS_OPTN) read FMOBILES write SetMOBILES stored MOBILES_Specified;
    property ActivatedPLE: Boolean  Index (IS_NLBL) read FActivatedPLE write FActivatedPLE;
  end;



  // ************************************************************************ //
  // XML       : GetSubscriberDataResult, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  GetSubscriberDataResult = class(TRemotable)
  private
    FCTN: string;
    FCTN_Specified: boolean;
    FOperatorCode: string;
    FOperatorCode_Specified: boolean;
    FOperatorID: string;
    FOperatorID_Specified: boolean;
    FOperatorName: string;
    FOperatorName_Specified: boolean;
    FOperatorShortName: string;
    FOperatorShortName_Specified: boolean;
    FRegionCode: string;
    FRegionCode_Specified: boolean;
    FHLR: string;
    FHLR_Specified: boolean;
    FMarketCode: string;
    FMarketCode_Specified: boolean;
    FIsBeelineSubscriber: Boolean;
    FIsBeelinePool: Boolean;
    FError: string;
    FError_Specified: boolean;
    procedure SetCTN(Index: Integer; const Astring: string);
    function  CTN_Specified(Index: Integer): boolean;
    procedure SetOperatorCode(Index: Integer; const Astring: string);
    function  OperatorCode_Specified(Index: Integer): boolean;
    procedure SetOperatorID(Index: Integer; const Astring: string);
    function  OperatorID_Specified(Index: Integer): boolean;
    procedure SetOperatorName(Index: Integer; const Astring: string);
    function  OperatorName_Specified(Index: Integer): boolean;
    procedure SetOperatorShortName(Index: Integer; const Astring: string);
    function  OperatorShortName_Specified(Index: Integer): boolean;
    procedure SetRegionCode(Index: Integer; const Astring: string);
    function  RegionCode_Specified(Index: Integer): boolean;
    procedure SetHLR(Index: Integer; const Astring: string);
    function  HLR_Specified(Index: Integer): boolean;
    procedure SetMarketCode(Index: Integer; const Astring: string);
    function  MarketCode_Specified(Index: Integer): boolean;
    procedure SetError(Index: Integer; const Astring: string);
    function  Error_Specified(Index: Integer): boolean;
  published
    property CTN:                 string   Index (IS_OPTN) read FCTN write SetCTN stored CTN_Specified;
    property OperatorCode:        string   Index (IS_OPTN) read FOperatorCode write SetOperatorCode stored OperatorCode_Specified;
    property OperatorID:          string   Index (IS_OPTN) read FOperatorID write SetOperatorID stored OperatorID_Specified;
    property OperatorName:        string   Index (IS_OPTN) read FOperatorName write SetOperatorName stored OperatorName_Specified;
    property OperatorShortName:   string   Index (IS_OPTN) read FOperatorShortName write SetOperatorShortName stored OperatorShortName_Specified;
    property RegionCode:          string   Index (IS_OPTN) read FRegionCode write SetRegionCode stored RegionCode_Specified;
    property HLR:                 string   Index (IS_OPTN) read FHLR write SetHLR stored HLR_Specified;
    property MarketCode:          string   Index (IS_OPTN) read FMarketCode write SetMarketCode stored MarketCode_Specified;
    property IsBeelineSubscriber: Boolean  read FIsBeelineSubscriber write FIsBeelineSubscriber;
    property IsBeelinePool:       Boolean  read FIsBeelinePool write FIsBeelinePool;
    property Error:               string   Index (IS_OPTN) read FError write SetError stored Error_Specified;
  end;



  // ************************************************************************ //
  // XML       : Connection4, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  Connection4 = class(ValidateClass)
  private
    FProductsId: Integer;
    FPhoneOwner: Integer;
    FIMSI: string;
    FIMSI_Specified: boolean;
    FSimLock: Integer;
    FSerNumber: string;
    FSerNumber_Specified: boolean;
    FCellNetsId: Integer;
    FMOBILES: Mobile4;
    FMOBILES_Specified: boolean;
    FActivatedPLE: Boolean;
    procedure SetIMSI(Index: Integer; const Astring: string);
    function  IMSI_Specified(Index: Integer): boolean;
    procedure SetSerNumber(Index: Integer; const Astring: string);
    function  SerNumber_Specified(Index: Integer): boolean;
    procedure SetMOBILES(Index: Integer; const AMobile4: Mobile4);
    function  MOBILES_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property ProductsId:   Integer  Index (IS_ATTR) read FProductsId write FProductsId;
    property PhoneOwner:   Integer  Index (IS_ATTR) read FPhoneOwner write FPhoneOwner;
    property IMSI:         string   Index (IS_ATTR or IS_OPTN) read FIMSI write SetIMSI stored IMSI_Specified;
    property SimLock:      Integer  Index (IS_ATTR) read FSimLock write FSimLock;
    property SerNumber:    string   Index (IS_ATTR or IS_OPTN) read FSerNumber write SetSerNumber stored SerNumber_Specified;
    property CellNetsId:   Integer  Index (IS_ATTR) read FCellNetsId write FCellNetsId;
    property MOBILES:      Mobile4  Index (IS_OPTN) read FMOBILES write SetMOBILES stored MOBILES_Specified;
    property ActivatedPLE: Boolean  Index (IS_NLBL) read FActivatedPLE write FActivatedPLE;
  end;



  // ************************************************************************ //
  // XML       : TransferNumberRequestsStatus, global, <complexType>
  // Namespace : http://beeline.ru/ws/dol/2006
  // ************************************************************************ //
  TransferNumberRequestsStatus = class(TRemotable)
  private
    FTransferIdentifier: string;
    FTransferIdentifier_Specified: boolean;
    FTransferCTN: string;
    FTransferCTN_Specified: boolean;
    FStatus: string;
    FStatus_Specified: boolean;
    FProcessDate: TXSDateTime;
    FStatedDate: TXSDateTime;
    FActualDate: TXSDateTime;
    FError: string;
    FError_Specified: boolean;
    FCanCancel: Boolean;
    FCantCancelReason: string;
    FCantCancelReason_Specified: boolean;
    procedure SetTransferIdentifier(Index: Integer; const Astring: string);
    function  TransferIdentifier_Specified(Index: Integer): boolean;
    procedure SetTransferCTN(Index: Integer; const Astring: string);
    function  TransferCTN_Specified(Index: Integer): boolean;
    procedure SetStatus(Index: Integer; const Astring: string);
    function  Status_Specified(Index: Integer): boolean;
    procedure SetError(Index: Integer; const Astring: string);
    function  Error_Specified(Index: Integer): boolean;
    procedure SetCantCancelReason(Index: Integer; const Astring: string);
    function  CantCancelReason_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property TransferIdentifier: string       Index (IS_OPTN) read FTransferIdentifier write SetTransferIdentifier stored TransferIdentifier_Specified;
    property TransferCTN:        string       Index (IS_OPTN) read FTransferCTN write SetTransferCTN stored TransferCTN_Specified;
    property Status:             string       Index (IS_OPTN) read FStatus write SetStatus stored Status_Specified;
    property ProcessDate:        TXSDateTime  read FProcessDate write FProcessDate;
    property StatedDate:         TXSDateTime  read FStatedDate write FStatedDate;
    property ActualDate:         TXSDateTime  Index (IS_NLBL) read FActualDate write FActualDate;
    property Error:              string       Index (IS_OPTN) read FError write SetError stored Error_Specified;
    property CanCancel:          Boolean      read FCanCancel write FCanCancel;
    property CantCancelReason:   string       Index (IS_OPTN) read FCantCancelReason write SetCantCancelReason stored CantCancelReason_Specified;
  end;


  // ************************************************************************ //
  // Namespace : http://beeline.ru/ws/dol/2006
  // soapAction: http://beeline.ru/ws/dol/2006/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : DOLServiceSoap12
  // service   : DOLService
  // port      : DOLServiceSoap12
  // URL       : https://dealer.beeline.ru/dealer/WebService/DOL.asmx
  // ************************************************************************ //
  DOLServiceSoap = interface(IInvokable)
  ['{C9DF96EF-5F76-1724-2018-1261DE133FF0}']
    function  ReguestStatuses(const parameters: ReguestStatuses): ReguestStatusesResponse; stdcall;
    function  ReguestStatuses2(const parameters: ReguestStatuses2): ReguestStatuses2Response; stdcall;

    // Cannot unwrap: 
    //     - More than one strictly out element was found
    function  ContractImport(const parameters: ContractImport): ContractImportResponse; stdcall;

    // Cannot unwrap: 
    //     - More than one strictly out element was found
    function  ContractImport2(const parameters: ContractImport2): ContractImport2Response; stdcall;

    // Cannot unwrap: 
    //     - More than one strictly out element was found
    function  ContractImport3(const parameters: ContractImport3): ContractImport3Response; stdcall;

    // Cannot unwrap: 
    //     - More than one strictly out element was found
    function  ContractImport4(const parameters: ContractImport4): ContractImport4Response; stdcall;
    function  GetLibVersion(const parameters: GetLibVersion): GetLibVersionResponse; stdcall;

    // Cannot unwrap: 
    //     - More than one strictly out element was found
    function  GetLibVersions(const parameters: GetLibVersions): GetLibVersionsResponse; stdcall;
    function  GetLibrary(const parameters: GetLibrary): GetLibraryResponse; stdcall;
    function  GetCertificatePermission(const parameters: GetCertificatePermission): GetCertificatePermissionResponse; stdcall;
    function  Ping(const parameters: Ping): PingResponse; stdcall;
    function  GetDealerType(const parameters: GetDealerType): GetDealerTypeResponse; stdcall;
    function  GetSubscriberData(const parameters: GetSubscriberData): GetSubscriberDataResponse; stdcall;
    function  GetTransferNumberRequestsStatus(const parameters: GetTransferNumberRequestsStatus): GetTransferNumberRequestsStatusResponse; stdcall;
  end;

function GetDOLServiceSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): DOLServiceSoap;


implementation
  uses SysUtils;

function GetDOLServiceSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): DOLServiceSoap;
const
  defWSDL = 'C:\Users\TARIFER\Desktop\Текущие файлики для клиентов\робот DOL\DOLBeline.wsdl';
  defURL  = 'https://dealer.beeline.ru/dealer/WebService/DOL.asmx';
  defSvc  = 'DOLService';
  defPrt  = 'DOLServiceSoap12';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as DOLServiceSoap);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


constructor ContractImport.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor ContractImport.Destroy;
begin
  SysUtils.FreeAndNil(FCONTRACT);
  inherited Destroy;
end;

constructor ContractImport4.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor ContractImport4.Destroy;
begin
  SysUtils.FreeAndNil(FCONTRACT);
  inherited Destroy;
end;

constructor ContractImport2.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor ContractImport2.Destroy;
begin
  SysUtils.FreeAndNil(FCONTRACT);
  inherited Destroy;
end;

constructor ContractImport3.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor ContractImport3.Destroy;
begin
  SysUtils.FreeAndNil(FCONTRACT);
  inherited Destroy;
end;

destructor LibraryVersions.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FPUBLIC_)-1 do
    SysUtils.FreeAndNil(FPUBLIC_[I]);
  System.SetLength(FPUBLIC_, 0);
  for I := 0 to System.Length(FPOINT)-1 do
    SysUtils.FreeAndNil(FPOINT[I]);
  System.SetLength(FPOINT, 0);
  inherited Destroy;
end;

procedure LibraryVersions.SetPUBLIC_(Index: Integer; const AArrayOfLibraryVersion: ArrayOfLibraryVersion);
begin
  FPUBLIC_ := AArrayOfLibraryVersion;
  FPUBLIC__Specified := True;
end;

function LibraryVersions.PUBLIC__Specified(Index: Integer): boolean;
begin
  Result := FPUBLIC__Specified;
end;

procedure LibraryVersions.SetPOINT(Index: Integer; const AArray_Of_Point: Array_Of_Point);
begin
  FPOINT := AArray_Of_Point;
  FPOINT_Specified := True;
end;

function LibraryVersions.POINT_Specified(Index: Integer): boolean;
begin
  Result := FPOINT_Specified;
end;

constructor GetCertificatePermission.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor GetCertificatePermissionResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor GetCertificatePermissionResponse.Destroy;
begin
  SysUtils.FreeAndNil(FGetCertificatePermissionResult);
  inherited Destroy;
end;

procedure GetCertificatePermissionResponse.SetGetCertificatePermissionResult(Index: Integer; const ACertificatePermission: CertificatePermission);
begin
  FGetCertificatePermissionResult := ACertificatePermission;
  FGetCertificatePermissionResult_Specified := True;
end;

function GetCertificatePermissionResponse.GetCertificatePermissionResult_Specified(Index: Integer): boolean;
begin
  Result := FGetCertificatePermissionResult_Specified;
end;

constructor Ping.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor GetLibraryResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor GetLibraryResponse.Destroy;
begin
  SysUtils.FreeAndNil(FLIBRARY_);
  inherited Destroy;
end;

constructor GetLibVersions.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor PingResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor GetTransferNumberRequestsStatusResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor GetTransferNumberRequestsStatusResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FGetTransferNumberRequestsStatusResult)-1 do
    SysUtils.FreeAndNil(FGetTransferNumberRequestsStatusResult[I]);
  System.SetLength(FGetTransferNumberRequestsStatusResult, 0);
  inherited Destroy;
end;

procedure GetTransferNumberRequestsStatusResponse.SetGetTransferNumberRequestsStatusResult(Index: Integer; const AArrayOfTransferNumberRequestsStatus: ArrayOfTransferNumberRequestsStatus);
begin
  FGetTransferNumberRequestsStatusResult := AArrayOfTransferNumberRequestsStatus;
  FGetTransferNumberRequestsStatusResult_Specified := True;
end;

function GetTransferNumberRequestsStatusResponse.GetTransferNumberRequestsStatusResult_Specified(Index: Integer): boolean;
begin
  Result := FGetTransferNumberRequestsStatusResult_Specified;
end;

constructor GetSubscriberDataResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor GetSubscriberDataResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FGetSubscriberDataResult)-1 do
    SysUtils.FreeAndNil(FGetSubscriberDataResult[I]);
  System.SetLength(FGetSubscriberDataResult, 0);
  inherited Destroy;
end;

procedure GetSubscriberDataResponse.SetGetSubscriberDataResult(Index: Integer; const AArrayOfGetSubscriberDataResult: ArrayOfGetSubscriberDataResult);
begin
  FGetSubscriberDataResult := AArrayOfGetSubscriberDataResult;
  FGetSubscriberDataResult_Specified := True;
end;

function GetSubscriberDataResponse.GetSubscriberDataResult_Specified(Index: Integer): boolean;
begin
  Result := FGetSubscriberDataResult_Specified;
end;

constructor GetDealerType.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor ArrayOfChoice1.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FRowLogParam)-1 do
    SysUtils.FreeAndNil(FRowLogParam[I]);
  System.SetLength(FRowLogParam, 0);
  for I := 0 to System.Length(FRowIdName)-1 do
    SysUtils.FreeAndNil(FRowIdName[I]);
  System.SetLength(FRowIdName, 0);
  for I := 0 to System.Length(FRowScladLinkHistory)-1 do
    SysUtils.FreeAndNil(FRowScladLinkHistory[I]);
  System.SetLength(FRowScladLinkHistory, 0);
  for I := 0 to System.Length(FRowBPlanService)-1 do
    SysUtils.FreeAndNil(FRowBPlanService[I]);
  System.SetLength(FRowBPlanService, 0);
  for I := 0 to System.Length(FRowBillPlan)-1 do
    SysUtils.FreeAndNil(FRowBillPlan[I]);
  System.SetLength(FRowBillPlan, 0);
  for I := 0 to System.Length(FRowPrintForms)-1 do
    SysUtils.FreeAndNil(FRowPrintForms[I]);
  System.SetLength(FRowPrintForms, 0);
  for I := 0 to System.Length(FRowIdNameAddress)-1 do
    SysUtils.FreeAndNil(FRowIdNameAddress[I]);
  System.SetLength(FRowIdNameAddress, 0);
  for I := 0 to System.Length(FRowBank)-1 do
    SysUtils.FreeAndNil(FRowBank[I]);
  System.SetLength(FRowBank, 0);
  for I := 0 to System.Length(FRowIdNameShortName)-1 do
    SysUtils.FreeAndNil(FRowIdNameShortName[I]);
  System.SetLength(FRowIdNameShortName, 0);
  for I := 0 to System.Length(FRowIdNameCode)-1 do
    SysUtils.FreeAndNil(FRowIdNameCode[I]);
  System.SetLength(FRowIdNameCode, 0);
  for I := 0 to System.Length(FRowScladLink)-1 do
    SysUtils.FreeAndNil(FRowScladLink[I]);
  System.SetLength(FRowScladLink, 0);
  for I := 0 to System.Length(FRowProduct)-1 do
    SysUtils.FreeAndNil(FRowProduct[I]);
  System.SetLength(FRowProduct, 0);
  for I := 0 to System.Length(FRowCountry)-1 do
    SysUtils.FreeAndNil(FRowCountry[I]);
  System.SetLength(FRowCountry, 0);
  inherited Destroy;
end;

procedure ArrayOfChoice1.SetRowLogParam(Index: Integer; const AArrayOfRowLogParam: ArrayOfRowLogParam);
begin
  FRowLogParam := AArrayOfRowLogParam;
  FRowLogParam_Specified := True;
end;

function ArrayOfChoice1.RowLogParam_Specified(Index: Integer): boolean;
begin
  Result := FRowLogParam_Specified;
end;

procedure ArrayOfChoice1.SetRowIdName(Index: Integer; const AArray_Of_RowIdName: Array_Of_RowIdName);
begin
  FRowIdName := AArray_Of_RowIdName;
  FRowIdName_Specified := True;
end;

function ArrayOfChoice1.RowIdName_Specified(Index: Integer): boolean;
begin
  Result := FRowIdName_Specified;
end;

procedure ArrayOfChoice1.SetRowScladLinkHistory(Index: Integer; const AArray_Of_RowScladLinkHistory: Array_Of_RowScladLinkHistory);
begin
  FRowScladLinkHistory := AArray_Of_RowScladLinkHistory;
  FRowScladLinkHistory_Specified := True;
end;

function ArrayOfChoice1.RowScladLinkHistory_Specified(Index: Integer): boolean;
begin
  Result := FRowScladLinkHistory_Specified;
end;

procedure ArrayOfChoice1.SetRowBPlanService(Index: Integer; const AArray_Of_RowBPlanService: Array_Of_RowBPlanService);
begin
  FRowBPlanService := AArray_Of_RowBPlanService;
  FRowBPlanService_Specified := True;
end;

function ArrayOfChoice1.RowBPlanService_Specified(Index: Integer): boolean;
begin
  Result := FRowBPlanService_Specified;
end;

procedure ArrayOfChoice1.SetRowBillPlan(Index: Integer; const AArray_Of_RowBillPlan: Array_Of_RowBillPlan);
begin
  FRowBillPlan := AArray_Of_RowBillPlan;
  FRowBillPlan_Specified := True;
end;

function ArrayOfChoice1.RowBillPlan_Specified(Index: Integer): boolean;
begin
  Result := FRowBillPlan_Specified;
end;

procedure ArrayOfChoice1.SetRowPrintForms(Index: Integer; const AArray_Of_RowPrintForms: Array_Of_RowPrintForms);
begin
  FRowPrintForms := AArray_Of_RowPrintForms;
  FRowPrintForms_Specified := True;
end;

function ArrayOfChoice1.RowPrintForms_Specified(Index: Integer): boolean;
begin
  Result := FRowPrintForms_Specified;
end;

procedure ArrayOfChoice1.SetRowIdNameAddress(Index: Integer; const AArray_Of_RowIdNameAddress: Array_Of_RowIdNameAddress);
begin
  FRowIdNameAddress := AArray_Of_RowIdNameAddress;
  FRowIdNameAddress_Specified := True;
end;

function ArrayOfChoice1.RowIdNameAddress_Specified(Index: Integer): boolean;
begin
  Result := FRowIdNameAddress_Specified;
end;

procedure ArrayOfChoice1.SetRowBank(Index: Integer; const AArray_Of_RowBank: Array_Of_RowBank);
begin
  FRowBank := AArray_Of_RowBank;
  FRowBank_Specified := True;
end;

function ArrayOfChoice1.RowBank_Specified(Index: Integer): boolean;
begin
  Result := FRowBank_Specified;
end;

procedure ArrayOfChoice1.SetRowIdNameShortName(Index: Integer; const AArray_Of_RowIdNameShortName: Array_Of_RowIdNameShortName);
begin
  FRowIdNameShortName := AArray_Of_RowIdNameShortName;
  FRowIdNameShortName_Specified := True;
end;

function ArrayOfChoice1.RowIdNameShortName_Specified(Index: Integer): boolean;
begin
  Result := FRowIdNameShortName_Specified;
end;

procedure ArrayOfChoice1.SetRowIdNameCode(Index: Integer; const AArray_Of_RowIdNameCode: Array_Of_RowIdNameCode);
begin
  FRowIdNameCode := AArray_Of_RowIdNameCode;
  FRowIdNameCode_Specified := True;
end;

function ArrayOfChoice1.RowIdNameCode_Specified(Index: Integer): boolean;
begin
  Result := FRowIdNameCode_Specified;
end;

procedure ArrayOfChoice1.SetRowScladLink(Index: Integer; const AArray_Of_RowScladLink: Array_Of_RowScladLink);
begin
  FRowScladLink := AArray_Of_RowScladLink;
  FRowScladLink_Specified := True;
end;

function ArrayOfChoice1.RowScladLink_Specified(Index: Integer): boolean;
begin
  Result := FRowScladLink_Specified;
end;

procedure ArrayOfChoice1.SetRowProduct(Index: Integer; const AArray_Of_RowProduct: Array_Of_RowProduct);
begin
  FRowProduct := AArray_Of_RowProduct;
  FRowProduct_Specified := True;
end;

function ArrayOfChoice1.RowProduct_Specified(Index: Integer): boolean;
begin
  Result := FRowProduct_Specified;
end;

procedure ArrayOfChoice1.SetRowCountry(Index: Integer; const AArray_Of_RowCountry: Array_Of_RowCountry);
begin
  FRowCountry := AArray_Of_RowCountry;
  FRowCountry_Specified := True;
end;

function ArrayOfChoice1.RowCountry_Specified(Index: Integer): boolean;
begin
  Result := FRowCountry_Specified;
end;

constructor GetDealerTypeResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor ReguestStatusesResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor ReguestStatusesResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FReguestStatusesResult)-1 do
    SysUtils.FreeAndNil(FReguestStatusesResult[I]);
  System.SetLength(FReguestStatusesResult, 0);
  inherited Destroy;
end;

procedure ReguestStatusesResponse.SetReguestStatusesResult(Index: Integer; const AArrayOfResponseContractStatus: ArrayOfResponseContractStatus);
begin
  FReguestStatusesResult := AArrayOfResponseContractStatus;
  FReguestStatusesResult_Specified := True;
end;

function ReguestStatusesResponse.ReguestStatusesResult_Specified(Index: Integer): boolean;
begin
  Result := FReguestStatusesResult_Specified;
end;

constructor ReguestStatuses.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor ReguestStatuses.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Frequests)-1 do
    SysUtils.FreeAndNil(Frequests[I]);
  System.SetLength(Frequests, 0);
  inherited Destroy;
end;

procedure ReguestStatuses.Setrequests(Index: Integer; const AArrayOfRequest: ArrayOfRequest);
begin
  Frequests := AArrayOfRequest;
  Frequests_Specified := True;
end;

function ReguestStatuses.requests_Specified(Index: Integer): boolean;
begin
  Result := Frequests_Specified;
end;

constructor ReguestStatuses2.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor ReguestStatuses2.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Frequests)-1 do
    SysUtils.FreeAndNil(Frequests[I]);
  System.SetLength(Frequests, 0);
  inherited Destroy;
end;

procedure ReguestStatuses2.Setrequests(Index: Integer; const AArrayOfRequest: ArrayOfRequest);
begin
  Frequests := AArrayOfRequest;
  Frequests_Specified := True;
end;

function ReguestStatuses2.requests_Specified(Index: Integer): boolean;
begin
  Result := Frequests_Specified;
end;

procedure Request.SetPointCode(Index: Integer; const Astring: string);
begin
  FPointCode := Astring;
  FPointCode_Specified := True;
end;

function Request.PointCode_Specified(Index: Integer): boolean;
begin
  Result := FPointCode_Specified;
end;

procedure Request.SetCode(Index: Integer; const Astring: string);
begin
  FCode := Astring;
  FCode_Specified := True;
end;

function Request.Code_Specified(Index: Integer): boolean;
begin
  Result := FCode_Specified;
end;

destructor ContractABSInfo.Destroy;
begin
  SysUtils.FreeAndNil(FDate);
  inherited Destroy;
end;

procedure ContractABSInfo.SetCode(Index: Integer; const Astring: string);
begin
  FCode := Astring;
  FCode_Specified := True;
end;

function ContractABSInfo.Code_Specified(Index: Integer): boolean;
begin
  Result := FCode_Specified;
end;

constructor GetTransferNumberRequestsStatus.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

procedure GetTransferNumberRequestsStatus.SettransferIdentifier(Index: Integer; const Astring: string);
begin
  FtransferIdentifier := Astring;
  FtransferIdentifier_Specified := True;
end;

function GetTransferNumberRequestsStatus.transferIdentifier_Specified(Index: Integer): boolean;
begin
  Result := FtransferIdentifier_Specified;
end;

procedure GetTransferNumberRequestsStatus.Setctn(Index: Integer; const Astring: string);
begin
  Fctn := Astring;
  Fctn_Specified := True;
end;

function GetTransferNumberRequestsStatus.ctn_Specified(Index: Integer): boolean;
begin
  Result := Fctn_Specified;
end;

constructor GetLibrary.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

procedure GetLibrary.SetlibraryCode(Index: Integer; const Astring: string);
begin
  FlibraryCode := Astring;
  FlibraryCode_Specified := True;
end;

function GetLibrary.libraryCode_Specified(Index: Integer): boolean;
begin
  Result := FlibraryCode_Specified;
end;

constructor GetLibVersionResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

procedure GetLibVersionResponse.SetGetLibVersionResult(Index: Integer; const Astring: string);
begin
  FGetLibVersionResult := Astring;
  FGetLibVersionResult_Specified := True;
end;

function GetLibVersionResponse.GetLibVersionResult_Specified(Index: Integer): boolean;
begin
  Result := FGetLibVersionResult_Specified;
end;

destructor CertificatePermission.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FPoints)-1 do
    SysUtils.FreeAndNil(FPoints[I]);
  System.SetLength(FPoints, 0);
  inherited Destroy;
end;

procedure CertificatePermission.SetOwnerPointCode(Index: Integer; const Astring: string);
begin
  FOwnerPointCode := Astring;
  FOwnerPointCode_Specified := True;
end;

function CertificatePermission.OwnerPointCode_Specified(Index: Integer): boolean;
begin
  Result := FOwnerPointCode_Specified;
end;

procedure CertificatePermission.SetOwnerName(Index: Integer; const Astring: string);
begin
  FOwnerName := Astring;
  FOwnerName_Specified := True;
end;

function CertificatePermission.OwnerName_Specified(Index: Integer): boolean;
begin
  Result := FOwnerName_Specified;
end;

procedure CertificatePermission.SetPoints(Index: Integer; const AArrayOfDealerPoint: ArrayOfDealerPoint);
begin
  FPoints := AArrayOfDealerPoint;
  FPoints_Specified := True;
end;

function CertificatePermission.Points_Specified(Index: Integer): boolean;
begin
  Result := FPoints_Specified;
end;

destructor Library_.Destroy;
begin
  SysUtils.FreeAndNil(FITEM);
  inherited Destroy;
end;

procedure Library_.SetCode(Index: Integer; const Astring: string);
begin
  FCode := Astring;
  FCode_Specified := True;
end;

function Library_.Code_Specified(Index: Integer): boolean;
begin
  Result := FCode_Specified;
end;

procedure Library_.SetVersion(Index: Integer; const Astring: string);
begin
  FVersion := Astring;
  FVersion_Specified := True;
end;

function Library_.Version_Specified(Index: Integer): boolean;
begin
  Result := FVersion_Specified;
end;

procedure Library_.SetITEM(Index: Integer; const AArrayOfChoice1: ArrayOfChoice1);
begin
  FITEM := AArrayOfChoice1;
  FITEM_Specified := True;
end;

function Library_.ITEM_Specified(Index: Integer): boolean;
begin
  Result := FITEM_Specified;
end;

procedure DealerPoint.SetDealerCode(Index: Integer; const Astring: string);
begin
  FDealerCode := Astring;
  FDealerCode_Specified := True;
end;

function DealerPoint.DealerCode_Specified(Index: Integer): boolean;
begin
  Result := FDealerCode_Specified;
end;

procedure DealerPoint.SetDealerName(Index: Integer; const Astring: string);
begin
  FDealerName := Astring;
  FDealerName_Specified := True;
end;

function DealerPoint.DealerName_Specified(Index: Integer): boolean;
begin
  Result := FDealerName_Specified;
end;

procedure DealerPoint.SetPointCode(Index: Integer; const Astring: string);
begin
  FPointCode := Astring;
  FPointCode_Specified := True;
end;

function DealerPoint.PointCode_Specified(Index: Integer): boolean;
begin
  Result := FPointCode_Specified;
end;

procedure DealerPoint.SetName_(Index: Integer; const Astring: string);
begin
  FName_ := Astring;
  FName__Specified := True;
end;

function DealerPoint.Name__Specified(Index: Integer): boolean;
begin
  Result := FName__Specified;
end;

constructor GetLibVersionsResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor GetLibVersionsResponse.Destroy;
begin
  SysUtils.FreeAndNil(FGetLibVersionsResult);
  inherited Destroy;
end;

procedure GetLibVersionsResponse.SetGetLibVersionsResult(Index: Integer; const ALibraryVersions: LibraryVersions);
begin
  FGetLibVersionsResult := ALibraryVersions;
  FGetLibVersionsResult_Specified := True;
end;

function GetLibVersionsResponse.GetLibVersionsResult_Specified(Index: Integer): boolean;
begin
  Result := FGetLibVersionsResult_Specified;
end;

procedure GetLibVersionsResponse.Seterrors(Index: Integer; const AArrayOfAnyType: ArrayOfAnyType);
begin
  Ferrors := AArrayOfAnyType;
  Ferrors_Specified := True;
end;

function GetLibVersionsResponse.errors_Specified(Index: Integer): boolean;
begin
  Result := Ferrors_Specified;
end;

procedure LibraryVersion.SetCode(Index: Integer; const Astring: string);
begin
  FCode := Astring;
  FCode_Specified := True;
end;

function LibraryVersion.Code_Specified(Index: Integer): boolean;
begin
  Result := FCode_Specified;
end;

procedure LibraryVersion.SetVersion(Index: Integer; const Astring: string);
begin
  FVersion := Astring;
  FVersion_Specified := True;
end;

function LibraryVersion.Version_Specified(Index: Integer): boolean;
begin
  Result := FVersion_Specified;
end;

destructor Point.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FITEM)-1 do
    SysUtils.FreeAndNil(FITEM[I]);
  System.SetLength(FITEM, 0);
  inherited Destroy;
end;

procedure Point.SetCode(Index: Integer; const Astring: string);
begin
  FCode := Astring;
  FCode_Specified := True;
end;

function Point.Code_Specified(Index: Integer): boolean;
begin
  Result := FCode_Specified;
end;

procedure Point.SetITEM(Index: Integer; const AArrayOfLibraryVersion: ArrayOfLibraryVersion);
begin
  FITEM := AArrayOfLibraryVersion;
  FITEM_Specified := True;
end;

function Point.ITEM_Specified(Index: Integer): boolean;
begin
  Result := FITEM_Specified;
end;

constructor GetLibVersion.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

procedure GetLibVersion.Setcode(Index: Integer; const Astring: string);
begin
  Fcode := Astring;
  Fcode_Specified := True;
end;

function GetLibVersion.code_Specified(Index: Integer): boolean;
begin
  Result := Fcode_Specified;
end;

destructor ResponseContractStatus.Destroy;
begin
  SysUtils.FreeAndNil(FABSContractDate);
  inherited Destroy;
end;

procedure ResponseContractStatus.SetPointCode(Index: Integer; const Astring: string);
begin
  FPointCode := Astring;
  FPointCode_Specified := True;
end;

function ResponseContractStatus.PointCode_Specified(Index: Integer): boolean;
begin
  Result := FPointCode_Specified;
end;

procedure ResponseContractStatus.SetCode(Index: Integer; const Astring: string);
begin
  FCode := Astring;
  FCode_Specified := True;
end;

function ResponseContractStatus.Code_Specified(Index: Integer): boolean;
begin
  Result := FCode_Specified;
end;

procedure ResponseContractStatus.SetABSContractCode(Index: Integer; const Astring: string);
begin
  FABSContractCode := Astring;
  FABSContractCode_Specified := True;
end;

function ResponseContractStatus.ABSContractCode_Specified(Index: Integer): boolean;
begin
  Result := FABSContractCode_Specified;
end;

procedure ResponseContractStatus.SetSystemError(Index: Integer; const Astring: string);
begin
  FSystemError := Astring;
  FSystemError_Specified := True;
end;

function ResponseContractStatus.SystemError_Specified(Index: Integer): boolean;
begin
  Result := FSystemError_Specified;
end;

procedure ResponseContractStatus.SetErrors(Index: Integer; const AArrayOfString: ArrayOfString);
begin
  FErrors := AArrayOfString;
  FErrors_Specified := True;
end;

function ResponseContractStatus.Errors_Specified(Index: Integer): boolean;
begin
  Result := FErrors_Specified;
end;

destructor Connection.Destroy;
begin
  SysUtils.FreeAndNil(FMOBILES);
  inherited Destroy;
end;

procedure Connection.SetIMSI(Index: Integer; const Astring: string);
begin
  FIMSI := Astring;
  FIMSI_Specified := True;
end;

function Connection.IMSI_Specified(Index: Integer): boolean;
begin
  Result := FIMSI_Specified;
end;

procedure Connection.SetSerNumber(Index: Integer; const Astring: string);
begin
  FSerNumber := Astring;
  FSerNumber_Specified := True;
end;

function Connection.SerNumber_Specified(Index: Integer): boolean;
begin
  Result := FSerNumber_Specified;
end;

procedure Connection.SetMOBILES(Index: Integer; const AMobile: Mobile);
begin
  FMOBILES := AMobile;
  FMOBILES_Specified := True;
end;

function Connection.MOBILES_Specified(Index: Integer): boolean;
begin
  Result := FMOBILES_Specified;
end;

procedure Mobile.SetSNB(Index: Integer; const Astring: string);
begin
  FSNB := Astring;
  FSNB_Specified := True;
end;

function Mobile.SNB_Specified(Index: Integer): boolean;
begin
  Result := FSNB_Specified;
end;

procedure Mobile.SetSERVICES(Index: Integer; const AArrayOfInt: ArrayOfInt);
begin
  FSERVICES := AArrayOfInt;
  FSERVICES_Specified := True;
end;

function Mobile.SERVICES_Specified(Index: Integer): boolean;
begin
  Result := FSERVICES_Specified;
end;

procedure PhoneInfo.SetPrefix(Index: Integer; const Astring: string);
begin
  FPrefix := Astring;
  FPrefix_Specified := True;
end;

function PhoneInfo.Prefix_Specified(Index: Integer): boolean;
begin
  Result := FPrefix_Specified;
end;

procedure PhoneInfo.SetNumber(Index: Integer; const Astring: string);
begin
  FNumber := Astring;
  FNumber_Specified := True;
end;

function PhoneInfo.Number_Specified(Index: Integer): boolean;
begin
  Result := FNumber_Specified;
end;

procedure AddressStreet.SetValue(Index: Integer; const Astring: string);
begin
  FValue := Astring;
  FValue_Specified := True;
end;

function AddressStreet.Value_Specified(Index: Integer): boolean;
begin
  Result := FValue_Specified;
end;

procedure AddressPlace.SetValue(Index: Integer; const Astring: string);
begin
  FValue := Astring;
  FValue_Specified := True;
end;

function AddressPlace.Value_Specified(Index: Integer): boolean;
begin
  Result := FValue_Specified;
end;

destructor AddressInfo.Destroy;
begin
  SysUtils.FreeAndNil(FPLACE);
  SysUtils.FreeAndNil(FSTREET);
  SysUtils.FreeAndNil(FBUILDING);
  SysUtils.FreeAndNil(FROOM);
  inherited Destroy;
end;

procedure AddressInfo.SetZIP(Index: Integer; const Astring: string);
begin
  FZIP := Astring;
  FZIP_Specified := True;
end;

function AddressInfo.ZIP_Specified(Index: Integer): boolean;
begin
  Result := FZIP_Specified;
end;

procedure AddressInfo.SetCOUNTRY(Index: Integer; const Astring: string);
begin
  FCOUNTRY := Astring;
  FCOUNTRY_Specified := True;
end;

function AddressInfo.COUNTRY_Specified(Index: Integer): boolean;
begin
  Result := FCOUNTRY_Specified;
end;

procedure AddressInfo.SetREGION(Index: Integer; const Astring: string);
begin
  FREGION := Astring;
  FREGION_Specified := True;
end;

function AddressInfo.REGION_Specified(Index: Integer): boolean;
begin
  Result := FREGION_Specified;
end;

procedure AddressInfo.SetAREA(Index: Integer; const Astring: string);
begin
  FAREA := Astring;
  FAREA_Specified := True;
end;

function AddressInfo.AREA_Specified(Index: Integer): boolean;
begin
  Result := FAREA_Specified;
end;

procedure AddressInfo.SetPLACE(Index: Integer; const AAddressPlace: AddressPlace);
begin
  FPLACE := AAddressPlace;
  FPLACE_Specified := True;
end;

function AddressInfo.PLACE_Specified(Index: Integer): boolean;
begin
  Result := FPLACE_Specified;
end;

procedure AddressInfo.SetSTREET(Index: Integer; const AAddressStreet: AddressStreet);
begin
  FSTREET := AAddressStreet;
  FSTREET_Specified := True;
end;

function AddressInfo.STREET_Specified(Index: Integer): boolean;
begin
  Result := FSTREET_Specified;
end;

procedure AddressInfo.SetHOUSE(Index: Integer; const Astring: string);
begin
  FHOUSE := Astring;
  FHOUSE_Specified := True;
end;

function AddressInfo.HOUSE_Specified(Index: Integer): boolean;
begin
  Result := FHOUSE_Specified;
end;

procedure AddressInfo.SetBUILDING(Index: Integer; const AAddressBuilding: AddressBuilding);
begin
  FBUILDING := AAddressBuilding;
  FBUILDING_Specified := True;
end;

function AddressInfo.BUILDING_Specified(Index: Integer): boolean;
begin
  Result := FBUILDING_Specified;
end;

procedure AddressInfo.SetROOM(Index: Integer; const AAddressRoom: AddressRoom);
begin
  FROOM := AAddressRoom;
  FROOM_Specified := True;
end;

function AddressInfo.ROOM_Specified(Index: Integer): boolean;
begin
  Result := FROOM_Specified;
end;

procedure ContractDelivery.SetNotes(Index: Integer; const Astring: string);
begin
  FNotes := Astring;
  FNotes_Specified := True;
end;

function ContractDelivery.Notes_Specified(Index: Integer): boolean;
begin
  Result := FNotes_Specified;
end;

destructor ContractDeliveryAddress.Destroy;
begin
  SysUtils.FreeAndNil(FADDRESS);
  inherited Destroy;
end;

procedure ContractDeliveryAddress.SetADDRESS(Index: Integer; const AAddressInfo: AddressInfo);
begin
  FADDRESS := AAddressInfo;
  FADDRESS_Specified := True;
end;

function ContractDeliveryAddress.ADDRESS_Specified(Index: Integer): boolean;
begin
  Result := FADDRESS_Specified;
end;

destructor ContractCustomer.Destroy;
begin
  SysUtils.FreeAndNil(FBANKPROPLIST);
  SysUtils.FreeAndNil(FPERSON);
  SysUtils.FreeAndNil(FCOMPANY);
  SysUtils.FreeAndNil(FINFO);
  SysUtils.FreeAndNil(FADDRESS);
  inherited Destroy;
end;

procedure ContractCustomer.SetBANKPROPLIST(Index: Integer; const ABankProperties: BankProperties);
begin
  FBANKPROPLIST := ABankProperties;
  FBANKPROPLIST_Specified := True;
end;

function ContractCustomer.BANKPROPLIST_Specified(Index: Integer): boolean;
begin
  Result := FBANKPROPLIST_Specified;
end;

procedure ContractCustomer.SetPERSON(Index: Integer; const APersonInfo: PersonInfo);
begin
  FPERSON := APersonInfo;
  FPERSON_Specified := True;
end;

function ContractCustomer.PERSON_Specified(Index: Integer): boolean;
begin
  Result := FPERSON_Specified;
end;

procedure ContractCustomer.SetCOMPANY(Index: Integer; const ACompanyInfo: CompanyInfo);
begin
  FCOMPANY := ACompanyInfo;
  FCOMPANY_Specified := True;
end;

function ContractCustomer.COMPANY_Specified(Index: Integer): boolean;
begin
  Result := FCOMPANY_Specified;
end;

procedure ContractCustomer.SetINFO(Index: Integer; const ACustomerInfo: CustomerInfo);
begin
  FINFO := ACustomerInfo;
  FINFO_Specified := True;
end;

function ContractCustomer.INFO_Specified(Index: Integer): boolean;
begin
  Result := FINFO_Specified;
end;

procedure ContractCustomer.SetADDRESS(Index: Integer; const AAddressInfo: AddressInfo);
begin
  FADDRESS := AAddressInfo;
  FADDRESS_Specified := True;
end;

function ContractCustomer.ADDRESS_Specified(Index: Integer): boolean;
begin
  Result := FADDRESS_Specified;
end;

destructor ContractConnections.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FCONNECTIONS)-1 do
    SysUtils.FreeAndNil(FCONNECTIONS[I]);
  System.SetLength(FCONNECTIONS, 0);
  inherited Destroy;
end;

procedure ContractConnections.SetCONNECTIONS(Index: Integer; const AArray_Of_Connection: Array_Of_Connection);
begin
  FCONNECTIONS := AArray_Of_Connection;
  FCONNECTIONS_Specified := True;
end;

function ContractConnections.CONNECTIONS_Specified(Index: Integer): boolean;
begin
  Result := FCONNECTIONS_Specified;
end;

destructor ContractContact.Destroy;
begin
  SysUtils.FreeAndNil(FPHONE);
  SysUtils.FreeAndNil(FFAX);
  inherited Destroy;
end;

procedure ContractContact.SetEMail(Index: Integer; const Astring: string);
begin
  FEMail := Astring;
  FEMail_Specified := True;
end;

function ContractContact.EMail_Specified(Index: Integer): boolean;
begin
  Result := FEMail_Specified;
end;

procedure ContractContact.SetNotes(Index: Integer; const Astring: string);
begin
  FNotes := Astring;
  FNotes_Specified := True;
end;

function ContractContact.Notes_Specified(Index: Integer): boolean;
begin
  Result := FNotes_Specified;
end;

procedure ContractContact.SetNAME_(Index: Integer; const Astring: string);
begin
  FNAME_ := Astring;
  FNAME__Specified := True;
end;

function ContractContact.NAME__Specified(Index: Integer): boolean;
begin
  Result := FNAME__Specified;
end;

procedure ContractContact.SetPHONE(Index: Integer; const APhoneInfo: PhoneInfo);
begin
  FPHONE := APhoneInfo;
  FPHONE_Specified := True;
end;

function ContractContact.PHONE_Specified(Index: Integer): boolean;
begin
  Result := FPHONE_Specified;
end;

procedure ContractContact.SetFAX(Index: Integer; const APhoneInfo: PhoneInfo);
begin
  FFAX := APhoneInfo;
  FFAX_Specified := True;
end;

function ContractContact.FAX_Specified(Index: Integer): boolean;
begin
  Result := FFAX_Specified;
end;

procedure Mobile4.SetSNB(Index: Integer; const Astring: string);
begin
  FSNB := Astring;
  FSNB_Specified := True;
end;

function Mobile4.SNB_Specified(Index: Integer): boolean;
begin
  Result := FSNB_Specified;
end;

procedure Mobile4.SetTransferSNB(Index: Integer; const Astring: string);
begin
  FTransferSNB := Astring;
  FTransferSNB_Specified := True;
end;

function Mobile4.TransferSNB_Specified(Index: Integer): boolean;
begin
  Result := FTransferSNB_Specified;
end;

procedure Mobile4.SetSERVICES(Index: Integer; const AArrayOfInt: ArrayOfInt);
begin
  FSERVICES := AArrayOfInt;
  FSERVICES_Specified := True;
end;

function Mobile4.SERVICES_Specified(Index: Integer): boolean;
begin
  Result := FSERVICES_Specified;
end;

destructor ContractConnections4.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FCONNECTIONS)-1 do
    SysUtils.FreeAndNil(FCONNECTIONS[I]);
  System.SetLength(FCONNECTIONS, 0);
  inherited Destroy;
end;

procedure ContractConnections4.SetCONNECTIONS(Index: Integer; const AArray_Of_Connection4: Array_Of_Connection4);
begin
  FCONNECTIONS := AArray_Of_Connection4;
  FCONNECTIONS_Specified := True;
end;

function ContractConnections4.CONNECTIONS_Specified(Index: Integer): boolean;
begin
  Result := FCONNECTIONS_Specified;
end;

procedure ContractDealerInfo.SetCode(Index: Integer; const Astring: string);
begin
  FCode := Astring;
  FCode_Specified := True;
end;

function ContractDealerInfo.Code_Specified(Index: Integer): boolean;
begin
  Result := FCode_Specified;
end;

procedure ContractDealerInfo.SetPointCode(Index: Integer; const Astring: string);
begin
  FPointCode := Astring;
  FPointCode_Specified := True;
end;

function ContractDealerInfo.PointCode_Specified(Index: Integer): boolean;
begin
  Result := FPointCode_Specified;
end;

destructor Contract.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FLOGPARAMS)-1 do
    SysUtils.FreeAndNil(FLOGPARAMS[I]);
  System.SetLength(FLOGPARAMS, 0);
  SysUtils.FreeAndNil(FDateCreate);
  SysUtils.FreeAndNil(FDEALER);
  SysUtils.FreeAndNil(FABS);
  SysUtils.FreeAndNil(FCUSTOMER);
  SysUtils.FreeAndNil(FDELIVERYEMAIL);
  SysUtils.FreeAndNil(FDELIVERY);
  SysUtils.FreeAndNil(FDELIVERYFAX);
  SysUtils.FreeAndNil(FDELIVERYADDRESS);
  SysUtils.FreeAndNil(FCONTACT);
  SysUtils.FreeAndNil(FCONNECTIONS);
  inherited Destroy;
end;

procedure Contract.SetCode(Index: Integer; const Astring: string);
begin
  FCode := Astring;
  FCode_Specified := True;
end;

function Contract.Code_Specified(Index: Integer): boolean;
begin
  Result := FCode_Specified;
end;

procedure Contract.SetComments(Index: Integer; const Astring: string);
begin
  FComments := Astring;
  FComments_Specified := True;
end;

function Contract.Comments_Specified(Index: Integer): boolean;
begin
  Result := FComments_Specified;
end;

procedure Contract.SetClientVer(Index: Integer; const Astring: string);
begin
  FClientVer := Astring;
  FClientVer_Specified := True;
end;

function Contract.ClientVer_Specified(Index: Integer): boolean;
begin
  Result := FClientVer_Specified;
end;

procedure Contract.SetDEALER(Index: Integer; const AContractDealerInfo: ContractDealerInfo);
begin
  FDEALER := AContractDealerInfo;
  FDEALER_Specified := True;
end;

function Contract.DEALER_Specified(Index: Integer): boolean;
begin
  Result := FDEALER_Specified;
end;

procedure Contract.SetABS(Index: Integer; const AContractABSInfo: ContractABSInfo);
begin
  FABS := AContractABSInfo;
  FABS_Specified := True;
end;

function Contract.ABS_Specified(Index: Integer): boolean;
begin
  Result := FABS_Specified;
end;

procedure Contract.SetCUSTOMER(Index: Integer; const AContractCustomer: ContractCustomer);
begin
  FCUSTOMER := AContractCustomer;
  FCUSTOMER_Specified := True;
end;

function Contract.CUSTOMER_Specified(Index: Integer): boolean;
begin
  Result := FCUSTOMER_Specified;
end;

procedure Contract.SetDELIVERYEMAIL(Index: Integer; const AContractDeliveryEmail: ContractDeliveryEmail);
begin
  FDELIVERYEMAIL := AContractDeliveryEmail;
  FDELIVERYEMAIL_Specified := True;
end;

function Contract.DELIVERYEMAIL_Specified(Index: Integer): boolean;
begin
  Result := FDELIVERYEMAIL_Specified;
end;

procedure Contract.SetDELIVERY(Index: Integer; const AContractDelivery: ContractDelivery);
begin
  FDELIVERY := AContractDelivery;
  FDELIVERY_Specified := True;
end;

function Contract.DELIVERY_Specified(Index: Integer): boolean;
begin
  Result := FDELIVERY_Specified;
end;

procedure Contract.SetDELIVERYFAX(Index: Integer; const AContractDeliveryFax: ContractDeliveryFax);
begin
  FDELIVERYFAX := AContractDeliveryFax;
  FDELIVERYFAX_Specified := True;
end;

function Contract.DELIVERYFAX_Specified(Index: Integer): boolean;
begin
  Result := FDELIVERYFAX_Specified;
end;

procedure Contract.SetDELIVERYADDRESS(Index: Integer; const AContractDeliveryAddress: ContractDeliveryAddress);
begin
  FDELIVERYADDRESS := AContractDeliveryAddress;
  FDELIVERYADDRESS_Specified := True;
end;

function Contract.DELIVERYADDRESS_Specified(Index: Integer): boolean;
begin
  Result := FDELIVERYADDRESS_Specified;
end;

procedure Contract.SetCONTACT(Index: Integer; const AContractContact: ContractContact);
begin
  FCONTACT := AContractContact;
  FCONTACT_Specified := True;
end;

function Contract.CONTACT_Specified(Index: Integer): boolean;
begin
  Result := FCONTACT_Specified;
end;

procedure Contract.SetCONNECTIONS(Index: Integer; const AContractConnections: ContractConnections);
begin
  FCONNECTIONS := AContractConnections;
  FCONNECTIONS_Specified := True;
end;

function Contract.CONNECTIONS_Specified(Index: Integer): boolean;
begin
  Result := FCONNECTIONS_Specified;
end;

procedure Contract.SetLOGPARAMS(Index: Integer; const AArrayOfRowLogParam: ArrayOfRowLogParam);
begin
  FLOGPARAMS := AArrayOfRowLogParam;
  FLOGPARAMS_Specified := True;
end;

function Contract.LOGPARAMS_Specified(Index: Integer): boolean;
begin
  Result := FLOGPARAMS_Specified;
end;

constructor ReguestStatuses2Response.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor ReguestStatuses2Response.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FReguestStatuses2Result)-1 do
    SysUtils.FreeAndNil(FReguestStatuses2Result[I]);
  System.SetLength(FReguestStatuses2Result, 0);
  inherited Destroy;
end;

procedure ReguestStatuses2Response.SetReguestStatuses2Result(Index: Integer; const AArrayOfResponseContractStatus2: ArrayOfResponseContractStatus2);
begin
  FReguestStatuses2Result := AArrayOfResponseContractStatus2;
  FReguestStatuses2Result_Specified := True;
end;

function ReguestStatuses2Response.ReguestStatuses2Result_Specified(Index: Integer): boolean;
begin
  Result := FReguestStatuses2Result_Specified;
end;

procedure ResponseContractStatus2.SetActivatedSIMs(Index: Integer; const AArrayOfString1: ArrayOfString1);
begin
  FActivatedSIMs := AArrayOfString1;
  FActivatedSIMs_Specified := True;
end;

function ResponseContractStatus2.ActivatedSIMs_Specified(Index: Integer): boolean;
begin
  Result := FActivatedSIMs_Specified;
end;

procedure ResponseContractStatus2.SetNotActivatedSIMs(Index: Integer; const AArrayOfString1: ArrayOfString1);
begin
  FNotActivatedSIMs := AArrayOfString1;
  FNotActivatedSIMs_Specified := True;
end;

function ResponseContractStatus2.NotActivatedSIMs_Specified(Index: Integer): boolean;
begin
  Result := FNotActivatedSIMs_Specified;
end;

procedure AddressBuilding.SetValue(Index: Integer; const Astring: string);
begin
  FValue := Astring;
  FValue_Specified := True;
end;

function AddressBuilding.Value_Specified(Index: Integer): boolean;
begin
  Result := FValue_Specified;
end;

destructor ContractConnections2.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FCONNECTIONS)-1 do
    SysUtils.FreeAndNil(FCONNECTIONS[I]);
  System.SetLength(FCONNECTIONS, 0);
  inherited Destroy;
end;

procedure ContractConnections2.SetCONNECTIONS(Index: Integer; const AArray_Of_Connection2: Array_Of_Connection2);
begin
  FCONNECTIONS := AArray_Of_Connection2;
  FCONNECTIONS_Specified := True;
end;

function ContractConnections2.CONNECTIONS_Specified(Index: Integer): boolean;
begin
  Result := FCONNECTIONS_Specified;
end;

constructor GetSubscriberData.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

procedure GetSubscriberData.Setctn(Index: Integer; const AArrayOfString2: ArrayOfString2);
begin
  Fctn := AArrayOfString2;
  Fctn_Specified := True;
end;

function GetSubscriberData.ctn_Specified(Index: Integer): boolean;
begin
  Result := Fctn_Specified;
end;

constructor ContractImport2Response.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

procedure ContractImport2Response.Seterrors(Index: Integer; const AArrayOfString2: ArrayOfString2);
begin
  Ferrors := AArrayOfString2;
  Ferrors_Specified := True;
end;

function ContractImport2Response.errors_Specified(Index: Integer): boolean;
begin
  Result := Ferrors_Specified;
end;

constructor ContractImport3Response.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

procedure ContractImport3Response.Seterrors(Index: Integer; const AArrayOfString2: ArrayOfString2);
begin
  Ferrors := AArrayOfString2;
  Ferrors_Specified := True;
end;

function ContractImport3Response.errors_Specified(Index: Integer): boolean;
begin
  Result := Ferrors_Specified;
end;

constructor ContractImport4Response.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

procedure ContractImport4Response.Seterrors(Index: Integer; const AArrayOfString2: ArrayOfString2);
begin
  Ferrors := AArrayOfString2;
  Ferrors_Specified := True;
end;

function ContractImport4Response.errors_Specified(Index: Integer): boolean;
begin
  Result := Ferrors_Specified;
end;

constructor ContractImportResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

procedure ContractImportResponse.Seterrors(Index: Integer; const AArrayOfString2: ArrayOfString2);
begin
  Ferrors := AArrayOfString2;
  Ferrors_Specified := True;
end;

function ContractImportResponse.errors_Specified(Index: Integer): boolean;
begin
  Result := Ferrors_Specified;
end;

destructor Contract2.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FLOGPARAMS)-1 do
    SysUtils.FreeAndNil(FLOGPARAMS[I]);
  System.SetLength(FLOGPARAMS, 0);
  SysUtils.FreeAndNil(FDateCreate);
  SysUtils.FreeAndNil(FDEALER);
  SysUtils.FreeAndNil(FABS);
  SysUtils.FreeAndNil(FCUSTOMER);
  SysUtils.FreeAndNil(FDELIVERY);
  SysUtils.FreeAndNil(FDELIVERYFAX);
  SysUtils.FreeAndNil(FDELIVERYADDRESS);
  SysUtils.FreeAndNil(FDELIVERYEMAIL);
  SysUtils.FreeAndNil(FCONTACT);
  SysUtils.FreeAndNil(FCONNECTIONS);
  inherited Destroy;
end;

procedure Contract2.SetCode(Index: Integer; const Astring: string);
begin
  FCode := Astring;
  FCode_Specified := True;
end;

function Contract2.Code_Specified(Index: Integer): boolean;
begin
  Result := FCode_Specified;
end;

procedure Contract2.SetComments(Index: Integer; const Astring: string);
begin
  FComments := Astring;
  FComments_Specified := True;
end;

function Contract2.Comments_Specified(Index: Integer): boolean;
begin
  Result := FComments_Specified;
end;

procedure Contract2.SetClientVer(Index: Integer; const Astring: string);
begin
  FClientVer := Astring;
  FClientVer_Specified := True;
end;

function Contract2.ClientVer_Specified(Index: Integer): boolean;
begin
  Result := FClientVer_Specified;
end;

procedure Contract2.SetBAN(Index: Integer; const Astring: string);
begin
  FBAN := Astring;
  FBAN_Specified := True;
end;

function Contract2.BAN_Specified(Index: Integer): boolean;
begin
  Result := FBAN_Specified;
end;

procedure Contract2.SetDEALER(Index: Integer; const AContractDealerInfo: ContractDealerInfo);
begin
  FDEALER := AContractDealerInfo;
  FDEALER_Specified := True;
end;

function Contract2.DEALER_Specified(Index: Integer): boolean;
begin
  Result := FDEALER_Specified;
end;

procedure Contract2.SetABS(Index: Integer; const AContractABSInfo: ContractABSInfo);
begin
  FABS := AContractABSInfo;
  FABS_Specified := True;
end;

function Contract2.ABS_Specified(Index: Integer): boolean;
begin
  Result := FABS_Specified;
end;

procedure Contract2.SetCUSTOMER(Index: Integer; const AContractCustomer: ContractCustomer);
begin
  FCUSTOMER := AContractCustomer;
  FCUSTOMER_Specified := True;
end;

function Contract2.CUSTOMER_Specified(Index: Integer): boolean;
begin
  Result := FCUSTOMER_Specified;
end;

procedure Contract2.SetDELIVERY(Index: Integer; const AContractDelivery: ContractDelivery);
begin
  FDELIVERY := AContractDelivery;
  FDELIVERY_Specified := True;
end;

function Contract2.DELIVERY_Specified(Index: Integer): boolean;
begin
  Result := FDELIVERY_Specified;
end;

procedure Contract2.SetDELIVERYFAX(Index: Integer; const AContractDeliveryFax: ContractDeliveryFax);
begin
  FDELIVERYFAX := AContractDeliveryFax;
  FDELIVERYFAX_Specified := True;
end;

function Contract2.DELIVERYFAX_Specified(Index: Integer): boolean;
begin
  Result := FDELIVERYFAX_Specified;
end;

procedure Contract2.SetDELIVERYADDRESS(Index: Integer; const AContractDeliveryAddress: ContractDeliveryAddress);
begin
  FDELIVERYADDRESS := AContractDeliveryAddress;
  FDELIVERYADDRESS_Specified := True;
end;

function Contract2.DELIVERYADDRESS_Specified(Index: Integer): boolean;
begin
  Result := FDELIVERYADDRESS_Specified;
end;

procedure Contract2.SetDELIVERYEMAIL(Index: Integer; const AContractDeliveryEmail: ContractDeliveryEmail);
begin
  FDELIVERYEMAIL := AContractDeliveryEmail;
  FDELIVERYEMAIL_Specified := True;
end;

function Contract2.DELIVERYEMAIL_Specified(Index: Integer): boolean;
begin
  Result := FDELIVERYEMAIL_Specified;
end;

procedure Contract2.SetCONTACT(Index: Integer; const AContractContact: ContractContact);
begin
  FCONTACT := AContractContact;
  FCONTACT_Specified := True;
end;

function Contract2.CONTACT_Specified(Index: Integer): boolean;
begin
  Result := FCONTACT_Specified;
end;

procedure Contract2.SetCONNECTIONS(Index: Integer; const AContractConnections2: ContractConnections2);
begin
  FCONNECTIONS := AContractConnections2;
  FCONNECTIONS_Specified := True;
end;

function Contract2.CONNECTIONS_Specified(Index: Integer): boolean;
begin
  Result := FCONNECTIONS_Specified;
end;

procedure Contract2.SetLOGPARAMS(Index: Integer; const AArrayOfRowLogParam: ArrayOfRowLogParam);
begin
  FLOGPARAMS := AArrayOfRowLogParam;
  FLOGPARAMS_Specified := True;
end;

function Contract2.LOGPARAMS_Specified(Index: Integer): boolean;
begin
  Result := FLOGPARAMS_Specified;
end;

procedure BankProperty.SetName_(Index: Integer; const Astring: string);
begin
  FName_ := Astring;
  FName__Specified := True;
end;

function BankProperty.Name__Specified(Index: Integer): boolean;
begin
  Result := FName__Specified;
end;

procedure BankProperty.SetAccount(Index: Integer; const Astring: string);
begin
  FAccount := Astring;
  FAccount_Specified := True;
end;

function BankProperty.Account_Specified(Index: Integer): boolean;
begin
  Result := FAccount_Specified;
end;

procedure BankProperty.SetCorrAccount(Index: Integer; const Astring: string);
begin
  FCorrAccount := Astring;
  FCorrAccount_Specified := True;
end;

function BankProperty.CorrAccount_Specified(Index: Integer): boolean;
begin
  Result := FCorrAccount_Specified;
end;

procedure BankProperty.SetBIK(Index: Integer; const Astring: string);
begin
  FBIK := Astring;
  FBIK_Specified := True;
end;

function BankProperty.BIK_Specified(Index: Integer): boolean;
begin
  Result := FBIK_Specified;
end;

destructor PersonInfo.Destroy;
begin
  SysUtils.FreeAndNil(FNAME_);
  SysUtils.FreeAndNil(FDOCUMENT);
  inherited Destroy;
end;

procedure PersonInfo.SetINN(Index: Integer; const Astring: string);
begin
  FINN := Astring;
  FINN_Specified := True;
end;

function PersonInfo.INN_Specified(Index: Integer): boolean;
begin
  Result := FINN_Specified;
end;

procedure PersonInfo.SetNAME_(Index: Integer; const AName_: Name_);
begin
  FNAME_ := AName_;
  FNAME__Specified := True;
end;

function PersonInfo.NAME__Specified(Index: Integer): boolean;
begin
  Result := FNAME__Specified;
end;

procedure PersonInfo.SetDOCUMENT(Index: Integer; const AContractDocument: ContractDocument);
begin
  FDOCUMENT := AContractDocument;
  FDOCUMENT_Specified := True;
end;

function PersonInfo.DOCUMENT_Specified(Index: Integer): boolean;
begin
  Result := FDOCUMENT_Specified;
end;

procedure CompanyInfo.SetINN(Index: Integer; const Astring: string);
begin
  FINN := Astring;
  FINN_Specified := True;
end;

function CompanyInfo.INN_Specified(Index: Integer): boolean;
begin
  Result := FINN_Specified;
end;

procedure CompanyInfo.SetName_(Index: Integer; const Astring: string);
begin
  FName_ := Astring;
  FName__Specified := True;
end;

function CompanyInfo.Name__Specified(Index: Integer): boolean;
begin
  Result := FName__Specified;
end;

procedure CompanyInfo.SetOKONH(Index: Integer; const Astring: string);
begin
  FOKONH := Astring;
  FOKONH_Specified := True;
end;

function CompanyInfo.OKONH_Specified(Index: Integer): boolean;
begin
  Result := FOKONH_Specified;
end;

procedure CompanyInfo.SetOKPO(Index: Integer; const Astring: string);
begin
  FOKPO := Astring;
  FOKPO_Specified := True;
end;

function CompanyInfo.OKPO_Specified(Index: Integer): boolean;
begin
  Result := FOKPO_Specified;
end;

procedure CompanyInfo.SetKPP(Index: Integer; const Astring: string);
begin
  FKPP := Astring;
  FKPP_Specified := True;
end;

function CompanyInfo.KPP_Specified(Index: Integer): boolean;
begin
  Result := FKPP_Specified;
end;

procedure AddressRoom.SetValue(Index: Integer; const Astring: string);
begin
  FValue := Astring;
  FValue_Specified := True;
end;

function AddressRoom.Value_Specified(Index: Integer): boolean;
begin
  Result := FValue_Specified;
end;

destructor ContractDocument.Destroy;
begin
  SysUtils.FreeAndNil(FDate);
  SysUtils.FreeAndNil(FBirthday);
  inherited Destroy;
end;

procedure ContractDocument.SetSeria(Index: Integer; const Astring: string);
begin
  FSeria := Astring;
  FSeria_Specified := True;
end;

function ContractDocument.Seria_Specified(Index: Integer): boolean;
begin
  Result := FSeria_Specified;
end;

procedure ContractDocument.SetNumber(Index: Integer; const Astring: string);
begin
  FNumber := Astring;
  FNumber_Specified := True;
end;

function ContractDocument.Number_Specified(Index: Integer): boolean;
begin
  Result := FNumber_Specified;
end;

procedure ContractDocument.SetGivenBy(Index: Integer; const Astring: string);
begin
  FGivenBy := Astring;
  FGivenBy_Specified := True;
end;

function ContractDocument.GivenBy_Specified(Index: Integer): boolean;
begin
  Result := FGivenBy_Specified;
end;

procedure Name_.SetLast(Index: Integer; const Astring: string);
begin
  FLast := Astring;
  FLast_Specified := True;
end;

function Name_.Last_Specified(Index: Integer): boolean;
begin
  Result := FLast_Specified;
end;

procedure Name_.SetFirst(Index: Integer; const Astring: string);
begin
  FFirst := Astring;
  FFirst_Specified := True;
end;

function Name_.First_Specified(Index: Integer): boolean;
begin
  Result := FFirst_Specified;
end;

procedure Name_.SetSecond(Index: Integer; const Astring: string);
begin
  FSecond := Astring;
  FSecond_Specified := True;
end;

function Name_.Second_Specified(Index: Integer): boolean;
begin
  Result := FSecond_Specified;
end;

destructor BankProperties.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FBANKPROPSSEC)-1 do
    SysUtils.FreeAndNil(FBANKPROPSSEC[I]);
  System.SetLength(FBANKPROPSSEC, 0);
  SysUtils.FreeAndNil(FBANKPROPSPRIM);
  inherited Destroy;
end;

procedure BankProperties.SetBANKPROPSPRIM(Index: Integer; const ABankProperty: BankProperty);
begin
  FBANKPROPSPRIM := ABankProperty;
  FBANKPROPSPRIM_Specified := True;
end;

function BankProperties.BANKPROPSPRIM_Specified(Index: Integer): boolean;
begin
  Result := FBANKPROPSPRIM_Specified;
end;

procedure BankProperties.SetBANKPROPSSEC(Index: Integer; const AArray_Of_BankProperty: Array_Of_BankProperty);
begin
  FBANKPROPSSEC := AArray_Of_BankProperty;
  FBANKPROPSSEC_Specified := True;
end;

function BankProperties.BANKPROPSSEC_Specified(Index: Integer): boolean;
begin
  Result := FBANKPROPSSEC_Specified;
end;

procedure RowPrintForms.SetHEADER(Index: Integer; const Astring: string);
begin
  FHEADER := Astring;
  FHEADER_Specified := True;
end;

function RowPrintForms.HEADER_Specified(Index: Integer): boolean;
begin
  Result := FHEADER_Specified;
end;

procedure RowPrintForms.SetREQUISITES(Index: Integer; const Astring: string);
begin
  FREQUISITES := Astring;
  FREQUISITES_Specified := True;
end;

function RowPrintForms.REQUISITES_Specified(Index: Integer): boolean;
begin
  Result := FREQUISITES_Specified;
end;

procedure RowPrintForms.SetPPersonFormTitle(Index: Integer; const Astring: string);
begin
  FPPersonFormTitle := Astring;
  FPPersonFormTitle_Specified := True;
end;

function RowPrintForms.PPersonFormTitle_Specified(Index: Integer): boolean;
begin
  Result := FPPersonFormTitle_Specified;
end;

procedure RowPrintForms.SetJPersonFormTitle(Index: Integer; const Astring: string);
begin
  FJPersonFormTitle := Astring;
  FJPersonFormTitle_Specified := True;
end;

function RowPrintForms.JPersonFormTitle_Specified(Index: Integer): boolean;
begin
  Result := FJPersonFormTitle_Specified;
end;

procedure RowPrintForms.SetJHeader(Index: Integer; const Astring: string);
begin
  FJHeader := Astring;
  FJHeader_Specified := True;
end;

function RowPrintForms.JHeader_Specified(Index: Integer): boolean;
begin
  Result := FJHeader_Specified;
end;

procedure RowPrintForms.SetRegAddressPSectionName(Index: Integer; const Astring: string);
begin
  FRegAddressPSectionName := Astring;
  FRegAddressPSectionName_Specified := True;
end;

function RowPrintForms.RegAddressPSectionName_Specified(Index: Integer): boolean;
begin
  Result := FRegAddressPSectionName_Specified;
end;

procedure RowPrintForms.SetRegAddressJSectionName(Index: Integer; const Astring: string);
begin
  FRegAddressJSectionName := Astring;
  FRegAddressJSectionName_Specified := True;
end;

function RowPrintForms.RegAddressJSectionName_Specified(Index: Integer): boolean;
begin
  Result := FRegAddressJSectionName_Specified;
end;

procedure RowPrintForms.SetDeliveryAddressSectionName(Index: Integer; const Astring: string);
begin
  FDeliveryAddressSectionName := Astring;
  FDeliveryAddressSectionName_Specified := True;
end;

function RowPrintForms.DeliveryAddressSectionName_Specified(Index: Integer): boolean;
begin
  Result := FDeliveryAddressSectionName_Specified;
end;

procedure RowPrintForms.SetServicesSectionName(Index: Integer; const Astring: string);
begin
  FServicesSectionName := Astring;
  FServicesSectionName_Specified := True;
end;

function RowPrintForms.ServicesSectionName_Specified(Index: Integer): boolean;
begin
  Result := FServicesSectionName_Specified;
end;

procedure RowPrintForms.SetVCSectionName(Index: Integer; const Astring: string);
begin
  FVCSectionName := Astring;
  FVCSectionName_Specified := True;
end;

function RowPrintForms.VCSectionName_Specified(Index: Integer): boolean;
begin
  Result := FVCSectionName_Specified;
end;

procedure RowPrintForms.SetJSignName(Index: Integer; const Astring: string);
begin
  FJSignName := Astring;
  FJSignName_Specified := True;
end;

function RowPrintForms.JSignName_Specified(Index: Integer): boolean;
begin
  Result := FJSignName_Specified;
end;

procedure RowPrintForms.SetPSignName(Index: Integer; const Astring: string);
begin
  FPSignName := Astring;
  FPSignName_Specified := True;
end;

function RowPrintForms.PSignName_Specified(Index: Integer): boolean;
begin
  Result := FPSignName_Specified;
end;

procedure RowBank.SetMFO(Index: Integer; const Astring: string);
begin
  FMFO := Astring;
  FMFO_Specified := True;
end;

function RowBank.MFO_Specified(Index: Integer): boolean;
begin
  Result := FMFO_Specified;
end;

procedure RowBank.SetMFON(Index: Integer; const Astring: string);
begin
  FMFON := Astring;
  FMFON_Specified := True;
end;

function RowBank.MFON_Specified(Index: Integer): boolean;
begin
  Result := FMFON_Specified;
end;

procedure RowBank.SetN_UCH(Index: Integer; const Astring: string);
begin
  FN_UCH := Astring;
  FN_UCH_Specified := True;
end;

function RowBank.N_UCH_Specified(Index: Integer): boolean;
begin
  Result := FN_UCH_Specified;
end;

procedure RowBank.SetBNK(Index: Integer; const Astring: string);
begin
  FBNK := Astring;
  FBNK_Specified := True;
end;

function RowBank.BNK_Specified(Index: Integer): boolean;
begin
  Result := FBNK_Specified;
end;

procedure RowBank.SetADDRESS(Index: Integer; const Astring: string);
begin
  FADDRESS := Astring;
  FADDRESS_Specified := True;
end;

function RowBank.ADDRESS_Specified(Index: Integer): boolean;
begin
  Result := FADDRESS_Specified;
end;

procedure RowBank.SetCORCH(Index: Integer; const Astring: string);
begin
  FCORCH := Astring;
  FCORCH_Specified := True;
end;

function RowBank.CORCH_Specified(Index: Integer): boolean;
begin
  Result := FCORCH_Specified;
end;

procedure RowBank.SetUER(Index: Integer; const Astring: string);
begin
  FUER := Astring;
  FUER_Specified := True;
end;

function RowBank.UER_Specified(Index: Integer): boolean;
begin
  Result := FUER_Specified;
end;

procedure RowCountry.SetCode(Index: Integer; const Astring: string);
begin
  FCode := Astring;
  FCode_Specified := True;
end;

function RowCountry.Code_Specified(Index: Integer): boolean;
begin
  Result := FCode_Specified;
end;

procedure RowCountry.SetEnglishName(Index: Integer; const Astring: string);
begin
  FEnglishName := Astring;
  FEnglishName_Specified := True;
end;

function RowCountry.EnglishName_Specified(Index: Integer): boolean;
begin
  Result := FEnglishName_Specified;
end;

procedure RowCountry.SetTranslation(Index: Integer; const Astring: string);
begin
  FTranslation := Astring;
  FTranslation_Specified := True;
end;

function RowCountry.Translation_Specified(Index: Integer): boolean;
begin
  Result := FTranslation_Specified;
end;

procedure RowScladLink.SetSNB(Index: Integer; const Astring: string);
begin
  FSNB := Astring;
  FSNB_Specified := True;
end;

function RowScladLink.SNB_Specified(Index: Integer): boolean;
begin
  Result := FSNB_Specified;
end;

procedure RowScladLink.SetSerNum(Index: Integer; const Astring: string);
begin
  FSerNum := Astring;
  FSerNum_Specified := True;
end;

function RowScladLink.SerNum_Specified(Index: Integer): boolean;
begin
  Result := FSerNum_Specified;
end;

procedure RowScladLink.SetSOC(Index: Integer; const Astring: string);
begin
  FSOC := Astring;
  FSOC_Specified := True;
end;

function RowScladLink.SOC_Specified(Index: Integer): boolean;
begin
  Result := FSOC_Specified;
end;

procedure RowScladLink.SetHLR(Index: Integer; const Astring: string);
begin
  FHLR := Astring;
  FHLR_Specified := True;
end;

function RowScladLink.HLR_Specified(Index: Integer): boolean;
begin
  Result := FHLR_Specified;
end;

procedure RowScladLink.SetRegionCode(Index: Integer; const Astring: string);
begin
  FRegionCode := Astring;
  FRegionCode_Specified := True;
end;

function RowScladLink.RegionCode_Specified(Index: Integer): boolean;
begin
  Result := FRegionCode_Specified;
end;

destructor RowScladLinkHistory.Destroy;
begin
  SysUtils.FreeAndNil(FChangeSOCDate);
  inherited Destroy;
end;

procedure RowIdName.SetName_(Index: Integer; const Astring: string);
begin
  FName_ := Astring;
  FName__Specified := True;
end;

function RowIdName.Name__Specified(Index: Integer): boolean;
begin
  Result := FName__Specified;
end;

destructor RowIdNameAddress.Destroy;
begin
  SysUtils.FreeAndNil(FAddress);
  inherited Destroy;
end;

procedure RowIdNameAddress.SetAddress(Index: Integer; const AAddressInfo: AddressInfo);
begin
  FAddress := AAddressInfo;
  FAddress_Specified := True;
end;

function RowIdNameAddress.Address_Specified(Index: Integer): boolean;
begin
  Result := FAddress_Specified;
end;

procedure RowIdNameShortName.SetShortName(Index: Integer; const Astring: string);
begin
  FShortName := Astring;
  FShortName_Specified := True;
end;

function RowIdNameShortName.ShortName_Specified(Index: Integer): boolean;
begin
  Result := FShortName_Specified;
end;

procedure RowIdNameCode.SetCode(Index: Integer; const Astring: string);
begin
  FCode := Astring;
  FCode_Specified := True;
end;

function RowIdNameCode.Code_Specified(Index: Integer): boolean;
begin
  Result := FCode_Specified;
end;

procedure RowBillPlan.SetSOC(Index: Integer; const Astring: string);
begin
  FSOC := Astring;
  FSOC_Specified := True;
end;

function RowBillPlan.SOC_Specified(Index: Integer): boolean;
begin
  Result := FSOC_Specified;
end;

procedure RowLogParam.SetComments(Index: Integer; const Astring: string);
begin
  FComments := Astring;
  FComments_Specified := True;
end;

function RowLogParam.Comments_Specified(Index: Integer): boolean;
begin
  Result := FComments_Specified;
end;

destructor Contract4.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FLOGPARAMS)-1 do
    SysUtils.FreeAndNil(FLOGPARAMS[I]);
  System.SetLength(FLOGPARAMS, 0);
  SysUtils.FreeAndNil(FDateCreate);
  SysUtils.FreeAndNil(FDEALER);
  SysUtils.FreeAndNil(FABS);
  SysUtils.FreeAndNil(FCUSTOMER);
  SysUtils.FreeAndNil(FDELIVERY);
  SysUtils.FreeAndNil(FDELIVERYADDRESS);
  SysUtils.FreeAndNil(FDELIVERYEMAIL);
  SysUtils.FreeAndNil(FDELIVERYFAX);
  SysUtils.FreeAndNil(FCONTACT);
  SysUtils.FreeAndNil(FCONNECTIONS);
  inherited Destroy;
end;

procedure Contract4.SetCode(Index: Integer; const Astring: string);
begin
  FCode := Astring;
  FCode_Specified := True;
end;

function Contract4.Code_Specified(Index: Integer): boolean;
begin
  Result := FCode_Specified;
end;

procedure Contract4.SetComments(Index: Integer; const Astring: string);
begin
  FComments := Astring;
  FComments_Specified := True;
end;

function Contract4.Comments_Specified(Index: Integer): boolean;
begin
  Result := FComments_Specified;
end;

procedure Contract4.SetClientVer(Index: Integer; const Astring: string);
begin
  FClientVer := Astring;
  FClientVer_Specified := True;
end;

function Contract4.ClientVer_Specified(Index: Integer): boolean;
begin
  Result := FClientVer_Specified;
end;

procedure Contract4.SetBAN(Index: Integer; const Astring: string);
begin
  FBAN := Astring;
  FBAN_Specified := True;
end;

function Contract4.BAN_Specified(Index: Integer): boolean;
begin
  Result := FBAN_Specified;
end;

procedure Contract4.SetBEN(Index: Integer; const Astring: string);
begin
  FBEN := Astring;
  FBEN_Specified := True;
end;

function Contract4.BEN_Specified(Index: Integer): boolean;
begin
  Result := FBEN_Specified;
end;

procedure Contract4.SetDEALER(Index: Integer; const AContractDealerInfo: ContractDealerInfo);
begin
  FDEALER := AContractDealerInfo;
  FDEALER_Specified := True;
end;

function Contract4.DEALER_Specified(Index: Integer): boolean;
begin
  Result := FDEALER_Specified;
end;

procedure Contract4.SetABS(Index: Integer; const AContractABSInfo: ContractABSInfo);
begin
  FABS := AContractABSInfo;
  FABS_Specified := True;
end;

function Contract4.ABS_Specified(Index: Integer): boolean;
begin
  Result := FABS_Specified;
end;

procedure Contract4.SetCUSTOMER(Index: Integer; const AContractCustomer: ContractCustomer);
begin
  FCUSTOMER := AContractCustomer;
  FCUSTOMER_Specified := True;
end;

function Contract4.CUSTOMER_Specified(Index: Integer): boolean;
begin
  Result := FCUSTOMER_Specified;
end;

procedure Contract4.SetDELIVERY(Index: Integer; const AContractDelivery: ContractDelivery);
begin
  FDELIVERY := AContractDelivery;
  FDELIVERY_Specified := True;
end;

function Contract4.DELIVERY_Specified(Index: Integer): boolean;
begin
  Result := FDELIVERY_Specified;
end;

procedure Contract4.SetDELIVERYADDRESS(Index: Integer; const AContractDeliveryAddress: ContractDeliveryAddress);
begin
  FDELIVERYADDRESS := AContractDeliveryAddress;
  FDELIVERYADDRESS_Specified := True;
end;

function Contract4.DELIVERYADDRESS_Specified(Index: Integer): boolean;
begin
  Result := FDELIVERYADDRESS_Specified;
end;

procedure Contract4.SetDELIVERYEMAIL(Index: Integer; const AContractDeliveryEmail: ContractDeliveryEmail);
begin
  FDELIVERYEMAIL := AContractDeliveryEmail;
  FDELIVERYEMAIL_Specified := True;
end;

function Contract4.DELIVERYEMAIL_Specified(Index: Integer): boolean;
begin
  Result := FDELIVERYEMAIL_Specified;
end;

procedure Contract4.SetDELIVERYFAX(Index: Integer; const AContractDeliveryFax: ContractDeliveryFax);
begin
  FDELIVERYFAX := AContractDeliveryFax;
  FDELIVERYFAX_Specified := True;
end;

function Contract4.DELIVERYFAX_Specified(Index: Integer): boolean;
begin
  Result := FDELIVERYFAX_Specified;
end;

procedure Contract4.SetCONTACT(Index: Integer; const AContractContact: ContractContact);
begin
  FCONTACT := AContractContact;
  FCONTACT_Specified := True;
end;

function Contract4.CONTACT_Specified(Index: Integer): boolean;
begin
  Result := FCONTACT_Specified;
end;

procedure Contract4.SetCONNECTIONS(Index: Integer; const AContractConnections4: ContractConnections4);
begin
  FCONNECTIONS := AContractConnections4;
  FCONNECTIONS_Specified := True;
end;

function Contract4.CONNECTIONS_Specified(Index: Integer): boolean;
begin
  Result := FCONNECTIONS_Specified;
end;

procedure Contract4.SetLOGPARAMS(Index: Integer; const AArrayOfRowLogParam: ArrayOfRowLogParam);
begin
  FLOGPARAMS := AArrayOfRowLogParam;
  FLOGPARAMS_Specified := True;
end;

function Contract4.LOGPARAMS_Specified(Index: Integer): boolean;
begin
  Result := FLOGPARAMS_Specified;
end;

destructor Contract3.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FLOGPARAMS)-1 do
    SysUtils.FreeAndNil(FLOGPARAMS[I]);
  System.SetLength(FLOGPARAMS, 0);
  SysUtils.FreeAndNil(FDateCreate);
  SysUtils.FreeAndNil(FDEALER);
  SysUtils.FreeAndNil(FABS);
  SysUtils.FreeAndNil(FCUSTOMER);
  SysUtils.FreeAndNil(FDELIVERYADDRESS);
  SysUtils.FreeAndNil(FDELIVERY);
  SysUtils.FreeAndNil(FDELIVERYFAX);
  SysUtils.FreeAndNil(FDELIVERYEMAIL);
  SysUtils.FreeAndNil(FCONTACT);
  SysUtils.FreeAndNil(FCONNECTIONS);
  inherited Destroy;
end;

procedure Contract3.SetCode(Index: Integer; const Astring: string);
begin
  FCode := Astring;
  FCode_Specified := True;
end;

function Contract3.Code_Specified(Index: Integer): boolean;
begin
  Result := FCode_Specified;
end;

procedure Contract3.SetComments(Index: Integer; const Astring: string);
begin
  FComments := Astring;
  FComments_Specified := True;
end;

function Contract3.Comments_Specified(Index: Integer): boolean;
begin
  Result := FComments_Specified;
end;

procedure Contract3.SetClientVer(Index: Integer; const Astring: string);
begin
  FClientVer := Astring;
  FClientVer_Specified := True;
end;

function Contract3.ClientVer_Specified(Index: Integer): boolean;
begin
  Result := FClientVer_Specified;
end;

procedure Contract3.SetBAN(Index: Integer; const Astring: string);
begin
  FBAN := Astring;
  FBAN_Specified := True;
end;

function Contract3.BAN_Specified(Index: Integer): boolean;
begin
  Result := FBAN_Specified;
end;

procedure Contract3.SetBEN(Index: Integer; const Astring: string);
begin
  FBEN := Astring;
  FBEN_Specified := True;
end;

function Contract3.BEN_Specified(Index: Integer): boolean;
begin
  Result := FBEN_Specified;
end;

procedure Contract3.SetDEALER(Index: Integer; const AContractDealerInfo: ContractDealerInfo);
begin
  FDEALER := AContractDealerInfo;
  FDEALER_Specified := True;
end;

function Contract3.DEALER_Specified(Index: Integer): boolean;
begin
  Result := FDEALER_Specified;
end;

procedure Contract3.SetABS(Index: Integer; const AContractABSInfo: ContractABSInfo);
begin
  FABS := AContractABSInfo;
  FABS_Specified := True;
end;

function Contract3.ABS_Specified(Index: Integer): boolean;
begin
  Result := FABS_Specified;
end;

procedure Contract3.SetCUSTOMER(Index: Integer; const AContractCustomer: ContractCustomer);
begin
  FCUSTOMER := AContractCustomer;
  FCUSTOMER_Specified := True;
end;

function Contract3.CUSTOMER_Specified(Index: Integer): boolean;
begin
  Result := FCUSTOMER_Specified;
end;

procedure Contract3.SetDELIVERYADDRESS(Index: Integer; const AContractDeliveryAddress: ContractDeliveryAddress);
begin
  FDELIVERYADDRESS := AContractDeliveryAddress;
  FDELIVERYADDRESS_Specified := True;
end;

function Contract3.DELIVERYADDRESS_Specified(Index: Integer): boolean;
begin
  Result := FDELIVERYADDRESS_Specified;
end;

procedure Contract3.SetDELIVERY(Index: Integer; const AContractDelivery: ContractDelivery);
begin
  FDELIVERY := AContractDelivery;
  FDELIVERY_Specified := True;
end;

function Contract3.DELIVERY_Specified(Index: Integer): boolean;
begin
  Result := FDELIVERY_Specified;
end;

procedure Contract3.SetDELIVERYFAX(Index: Integer; const AContractDeliveryFax: ContractDeliveryFax);
begin
  FDELIVERYFAX := AContractDeliveryFax;
  FDELIVERYFAX_Specified := True;
end;

function Contract3.DELIVERYFAX_Specified(Index: Integer): boolean;
begin
  Result := FDELIVERYFAX_Specified;
end;

procedure Contract3.SetDELIVERYEMAIL(Index: Integer; const AContractDeliveryEmail: ContractDeliveryEmail);
begin
  FDELIVERYEMAIL := AContractDeliveryEmail;
  FDELIVERYEMAIL_Specified := True;
end;

function Contract3.DELIVERYEMAIL_Specified(Index: Integer): boolean;
begin
  Result := FDELIVERYEMAIL_Specified;
end;

procedure Contract3.SetCONTACT(Index: Integer; const AContractContact: ContractContact);
begin
  FCONTACT := AContractContact;
  FCONTACT_Specified := True;
end;

function Contract3.CONTACT_Specified(Index: Integer): boolean;
begin
  Result := FCONTACT_Specified;
end;

procedure Contract3.SetCONNECTIONS(Index: Integer; const AContractConnections2: ContractConnections2);
begin
  FCONNECTIONS := AContractConnections2;
  FCONNECTIONS_Specified := True;
end;

function Contract3.CONNECTIONS_Specified(Index: Integer): boolean;
begin
  Result := FCONNECTIONS_Specified;
end;

procedure Contract3.SetLOGPARAMS(Index: Integer; const AArrayOfRowLogParam: ArrayOfRowLogParam);
begin
  FLOGPARAMS := AArrayOfRowLogParam;
  FLOGPARAMS_Specified := True;
end;

function Contract3.LOGPARAMS_Specified(Index: Integer): boolean;
begin
  Result := FLOGPARAMS_Specified;
end;

destructor Connection2.Destroy;
begin
  SysUtils.FreeAndNil(FMOBILES);
  inherited Destroy;
end;

procedure Connection2.SetIMSI(Index: Integer; const Astring: string);
begin
  FIMSI := Astring;
  FIMSI_Specified := True;
end;

function Connection2.IMSI_Specified(Index: Integer): boolean;
begin
  Result := FIMSI_Specified;
end;

procedure Connection2.SetSerNumber(Index: Integer; const Astring: string);
begin
  FSerNumber := Astring;
  FSerNumber_Specified := True;
end;

function Connection2.SerNumber_Specified(Index: Integer): boolean;
begin
  Result := FSerNumber_Specified;
end;

procedure Connection2.SetMOBILES(Index: Integer; const AMobile: Mobile);
begin
  FMOBILES := AMobile;
  FMOBILES_Specified := True;
end;

function Connection2.MOBILES_Specified(Index: Integer): boolean;
begin
  Result := FMOBILES_Specified;
end;

procedure GetSubscriberDataResult.SetCTN(Index: Integer; const Astring: string);
begin
  FCTN := Astring;
  FCTN_Specified := True;
end;

function GetSubscriberDataResult.CTN_Specified(Index: Integer): boolean;
begin
  Result := FCTN_Specified;
end;

procedure GetSubscriberDataResult.SetOperatorCode(Index: Integer; const Astring: string);
begin
  FOperatorCode := Astring;
  FOperatorCode_Specified := True;
end;

function GetSubscriberDataResult.OperatorCode_Specified(Index: Integer): boolean;
begin
  Result := FOperatorCode_Specified;
end;

procedure GetSubscriberDataResult.SetOperatorID(Index: Integer; const Astring: string);
begin
  FOperatorID := Astring;
  FOperatorID_Specified := True;
end;

function GetSubscriberDataResult.OperatorID_Specified(Index: Integer): boolean;
begin
  Result := FOperatorID_Specified;
end;

procedure GetSubscriberDataResult.SetOperatorName(Index: Integer; const Astring: string);
begin
  FOperatorName := Astring;
  FOperatorName_Specified := True;
end;

function GetSubscriberDataResult.OperatorName_Specified(Index: Integer): boolean;
begin
  Result := FOperatorName_Specified;
end;

procedure GetSubscriberDataResult.SetOperatorShortName(Index: Integer; const Astring: string);
begin
  FOperatorShortName := Astring;
  FOperatorShortName_Specified := True;
end;

function GetSubscriberDataResult.OperatorShortName_Specified(Index: Integer): boolean;
begin
  Result := FOperatorShortName_Specified;
end;

procedure GetSubscriberDataResult.SetRegionCode(Index: Integer; const Astring: string);
begin
  FRegionCode := Astring;
  FRegionCode_Specified := True;
end;

function GetSubscriberDataResult.RegionCode_Specified(Index: Integer): boolean;
begin
  Result := FRegionCode_Specified;
end;

procedure GetSubscriberDataResult.SetHLR(Index: Integer; const Astring: string);
begin
  FHLR := Astring;
  FHLR_Specified := True;
end;

function GetSubscriberDataResult.HLR_Specified(Index: Integer): boolean;
begin
  Result := FHLR_Specified;
end;

procedure GetSubscriberDataResult.SetMarketCode(Index: Integer; const Astring: string);
begin
  FMarketCode := Astring;
  FMarketCode_Specified := True;
end;

function GetSubscriberDataResult.MarketCode_Specified(Index: Integer): boolean;
begin
  Result := FMarketCode_Specified;
end;

procedure GetSubscriberDataResult.SetError(Index: Integer; const Astring: string);
begin
  FError := Astring;
  FError_Specified := True;
end;

function GetSubscriberDataResult.Error_Specified(Index: Integer): boolean;
begin
  Result := FError_Specified;
end;

destructor Connection4.Destroy;
begin
  SysUtils.FreeAndNil(FMOBILES);
  inherited Destroy;
end;

procedure Connection4.SetIMSI(Index: Integer; const Astring: string);
begin
  FIMSI := Astring;
  FIMSI_Specified := True;
end;

function Connection4.IMSI_Specified(Index: Integer): boolean;
begin
  Result := FIMSI_Specified;
end;

procedure Connection4.SetSerNumber(Index: Integer; const Astring: string);
begin
  FSerNumber := Astring;
  FSerNumber_Specified := True;
end;

function Connection4.SerNumber_Specified(Index: Integer): boolean;
begin
  Result := FSerNumber_Specified;
end;

procedure Connection4.SetMOBILES(Index: Integer; const AMobile4: Mobile4);
begin
  FMOBILES := AMobile4;
  FMOBILES_Specified := True;
end;

function Connection4.MOBILES_Specified(Index: Integer): boolean;
begin
  Result := FMOBILES_Specified;
end;

destructor TransferNumberRequestsStatus.Destroy;
begin
  SysUtils.FreeAndNil(FProcessDate);
  SysUtils.FreeAndNil(FStatedDate);
  SysUtils.FreeAndNil(FActualDate);
  inherited Destroy;
end;

procedure TransferNumberRequestsStatus.SetTransferIdentifier(Index: Integer; const Astring: string);
begin
  FTransferIdentifier := Astring;
  FTransferIdentifier_Specified := True;
end;

function TransferNumberRequestsStatus.TransferIdentifier_Specified(Index: Integer): boolean;
begin
  Result := FTransferIdentifier_Specified;
end;

procedure TransferNumberRequestsStatus.SetTransferCTN(Index: Integer; const Astring: string);
begin
  FTransferCTN := Astring;
  FTransferCTN_Specified := True;
end;

function TransferNumberRequestsStatus.TransferCTN_Specified(Index: Integer): boolean;
begin
  Result := FTransferCTN_Specified;
end;

procedure TransferNumberRequestsStatus.SetStatus(Index: Integer; const Astring: string);
begin
  FStatus := Astring;
  FStatus_Specified := True;
end;

function TransferNumberRequestsStatus.Status_Specified(Index: Integer): boolean;
begin
  Result := FStatus_Specified;
end;

procedure TransferNumberRequestsStatus.SetError(Index: Integer; const Astring: string);
begin
  FError := Astring;
  FError_Specified := True;
end;

function TransferNumberRequestsStatus.Error_Specified(Index: Integer): boolean;
begin
  Result := FError_Specified;
end;

procedure TransferNumberRequestsStatus.SetCantCancelReason(Index: Integer; const Astring: string);
begin
  FCantCancelReason := Astring;
  FCantCancelReason_Specified := True;
end;

function TransferNumberRequestsStatus.CantCancelReason_Specified(Index: Integer): boolean;
begin
  Result := FCantCancelReason_Specified;
end;

initialization
  { DOLServiceSoap }
  InvRegistry.RegisterInterface(TypeInfo(DOLServiceSoap), 'http://beeline.ru/ws/dol/2006', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(DOLServiceSoap), 'http://beeline.ru/ws/dol/2006/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(DOLServiceSoap), ioDocument);
  InvRegistry.RegisterInvokeOptions(TypeInfo(DOLServiceSoap), ioLiteral);
  InvRegistry.RegisterInvokeOptions(TypeInfo(DOLServiceSoap), ioSOAP12);
  RemClassRegistry.RegisterXSClass(ContractImport, 'http://beeline.ru/ws/dol/2006', 'ContractImport');
  RemClassRegistry.RegisterSerializeOptions(ContractImport, [xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfTransferNumberRequestsStatus), 'http://beeline.ru/ws/dol/2006', 'ArrayOfTransferNumberRequestsStatus');
  RemClassRegistry.RegisterXSClass(ContractImport4, 'http://beeline.ru/ws/dol/2006', 'ContractImport4');
  RemClassRegistry.RegisterSerializeOptions(ContractImport4, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(ContractImport2, 'http://beeline.ru/ws/dol/2006', 'ContractImport2');
  RemClassRegistry.RegisterSerializeOptions(ContractImport2, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(ContractImport3, 'http://beeline.ru/ws/dol/2006', 'ContractImport3');
  RemClassRegistry.RegisterSerializeOptions(ContractImport3, [xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfGetSubscriberDataResult), 'http://beeline.ru/ws/dol/2006', 'ArrayOfGetSubscriberDataResult');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfLibraryVersion), 'http://beeline.ru/ws/dol/2006', 'ArrayOfLibraryVersion');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfDealerPoint), 'http://beeline.ru/ws/dol/2006', 'ArrayOfDealerPoint');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RowScladLinkHistory), 'http://beeline.ru/ws/dol/2006', 'Array_Of_RowScladLinkHistory');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RowBPlanService), 'http://beeline.ru/ws/dol/2006', 'Array_Of_RowBPlanService');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RowBillPlan), 'http://beeline.ru/ws/dol/2006', 'Array_Of_RowBillPlan');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RowIdName), 'http://beeline.ru/ws/dol/2006', 'Array_Of_RowIdName');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_Connection2), 'http://beeline.ru/ws/dol/2006', 'Array_Of_Connection2');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_Connection4), 'http://beeline.ru/ws/dol/2006', 'Array_Of_Connection4');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_Point), 'http://beeline.ru/ws/dol/2006', 'Array_Of_Point');
  RemClassRegistry.RegisterXSClass(LibraryVersions, 'http://beeline.ru/ws/dol/2006', 'LibraryVersions');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(LibraryVersions), 'PUBLIC_', '[ArrayItemName="ITEM", ExtName="PUBLIC"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RowPrintForms), 'http://beeline.ru/ws/dol/2006', 'Array_Of_RowPrintForms');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RowScladLink), 'http://beeline.ru/ws/dol/2006', 'Array_Of_RowScladLink');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RowProduct), 'http://beeline.ru/ws/dol/2006', 'Array_Of_RowProduct');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RowCountry), 'http://beeline.ru/ws/dol/2006', 'Array_Of_RowCountry');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RowIdNameCode), 'http://beeline.ru/ws/dol/2006', 'Array_Of_RowIdNameCode');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RowIdNameAddress), 'http://beeline.ru/ws/dol/2006', 'Array_Of_RowIdNameAddress');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RowBank), 'http://beeline.ru/ws/dol/2006', 'Array_Of_RowBank');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RowIdNameShortName), 'http://beeline.ru/ws/dol/2006', 'Array_Of_RowIdNameShortName');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_BankProperty), 'http://beeline.ru/ws/dol/2006', 'Array_Of_BankProperty');
  RemClassRegistry.RegisterXSClass(GetCertificatePermission, 'http://beeline.ru/ws/dol/2006', 'GetCertificatePermission');
  RemClassRegistry.RegisterSerializeOptions(GetCertificatePermission, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(GetCertificatePermissionResponse, 'http://beeline.ru/ws/dol/2006', 'GetCertificatePermissionResponse');
  RemClassRegistry.RegisterSerializeOptions(GetCertificatePermissionResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(Ping, 'http://beeline.ru/ws/dol/2006', 'Ping');
  RemClassRegistry.RegisterSerializeOptions(Ping, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(GetLibraryResponse, 'http://beeline.ru/ws/dol/2006', 'GetLibraryResponse');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(GetLibraryResponse), 'LIBRARY_', '[ExtName="LIBRARY"]');
  RemClassRegistry.RegisterSerializeOptions(GetLibraryResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(GetLibVersions, 'http://beeline.ru/ws/dol/2006', 'GetLibVersions');
  RemClassRegistry.RegisterSerializeOptions(GetLibVersions, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(PingResponse, 'http://beeline.ru/ws/dol/2006', 'PingResponse');
  RemClassRegistry.RegisterSerializeOptions(PingResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(GetTransferNumberRequestsStatusResponse, 'http://beeline.ru/ws/dol/2006', 'GetTransferNumberRequestsStatusResponse');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(GetTransferNumberRequestsStatusResponse), 'GetTransferNumberRequestsStatusResult', '[ArrayItemName="TransferNumberRequestsStatus"]');
  RemClassRegistry.RegisterSerializeOptions(GetTransferNumberRequestsStatusResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_Connection), 'http://beeline.ru/ws/dol/2006', 'Array_Of_Connection');
  RemClassRegistry.RegisterXSClass(GetSubscriberDataResponse, 'http://beeline.ru/ws/dol/2006', 'GetSubscriberDataResponse');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(GetSubscriberDataResponse), 'GetSubscriberDataResult', '[ArrayItemName="GetSubscriberDataResult"]');
  RemClassRegistry.RegisterSerializeOptions(GetSubscriberDataResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(GetDealerType, 'http://beeline.ru/ws/dol/2006', 'GetDealerType');
  RemClassRegistry.RegisterSerializeOptions(GetDealerType, [xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfRowLogParam), 'http://beeline.ru/ws/dol/2006', 'ArrayOfRowLogParam');
  RemClassRegistry.RegisterXSClass(ArrayOfChoice1, 'http://beeline.ru/ws/dol/2006', 'ArrayOfChoice1');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(ArrayOfChoice1), 'RowLogParam', '[ArrayItemName="LOGPARAM"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfInt), 'http://beeline.ru/ws/dol/2006', 'ArrayOfInt');
  RemClassRegistry.RegisterXSClass(GetDealerTypeResponse, 'http://beeline.ru/ws/dol/2006', 'GetDealerTypeResponse');
  RemClassRegistry.RegisterSerializeOptions(GetDealerTypeResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfResponseContractStatus), 'http://beeline.ru/ws/dol/2006', 'ArrayOfResponseContractStatus');
  RemClassRegistry.RegisterXSClass(ReguestStatusesResponse, 'http://beeline.ru/ws/dol/2006', 'ReguestStatusesResponse');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(ReguestStatusesResponse), 'ReguestStatusesResult', '[ArrayItemName="ResponseContractStatus"]');
  RemClassRegistry.RegisterSerializeOptions(ReguestStatusesResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfRequest), 'http://beeline.ru/ws/dol/2006', 'ArrayOfRequest');
  RemClassRegistry.RegisterXSClass(ReguestStatuses, 'http://beeline.ru/ws/dol/2006', 'ReguestStatuses');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(ReguestStatuses), 'requests', '[ArrayItemName="Request"]');
  RemClassRegistry.RegisterSerializeOptions(ReguestStatuses, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(ReguestStatuses2, 'http://beeline.ru/ws/dol/2006', 'ReguestStatuses2');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(ReguestStatuses2), 'requests', '[ArrayItemName="Request"]');
  RemClassRegistry.RegisterSerializeOptions(ReguestStatuses2, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(Request, 'http://beeline.ru/ws/dol/2006', 'Request');
  RemClassRegistry.RegisterXSClass(ContractABSInfo, 'http://beeline.ru/ws/dol/2006', 'ContractABSInfo');
  RemClassRegistry.RegisterXSClass(GetTransferNumberRequestsStatus, 'http://beeline.ru/ws/dol/2006', 'GetTransferNumberRequestsStatus');
  RemClassRegistry.RegisterSerializeOptions(GetTransferNumberRequestsStatus, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(GetLibrary, 'http://beeline.ru/ws/dol/2006', 'GetLibrary');
  RemClassRegistry.RegisterSerializeOptions(GetLibrary, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(GetLibVersionResponse, 'http://beeline.ru/ws/dol/2006', 'GetLibVersionResponse');
  RemClassRegistry.RegisterSerializeOptions(GetLibVersionResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(CertificatePermission, 'http://beeline.ru/ws/dol/2006', 'CertificatePermission');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(CertificatePermission), 'Points', '[ArrayItemName="DealerPoint"]');
  RemClassRegistry.RegisterXSClass(Library_, 'http://beeline.ru/ws/dol/2006', 'Library_', 'Library');
  RemClassRegistry.RegisterXSInfo(TypeInfo(CertificateAccesses), 'http://beeline.ru/ws/dol/2006', 'CertificateAccesses');
  RemClassRegistry.RegisterXSClass(DealerPoint, 'http://beeline.ru/ws/dol/2006', 'DealerPoint');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(DealerPoint), 'Name_', '[ExtName="Name"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfAnyType), 'http://beeline.ru/ws/dol/2006', 'ArrayOfAnyType');
  RemClassRegistry.RegisterXSClass(GetLibVersionsResponse, 'http://beeline.ru/ws/dol/2006', 'GetLibVersionsResponse');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(GetLibVersionsResponse), 'errors', '[ArrayItemName="anyType"]');
  RemClassRegistry.RegisterSerializeOptions(GetLibVersionsResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(LibraryVersion, 'http://beeline.ru/ws/dol/2006', 'LibraryVersion');
  RemClassRegistry.RegisterXSClass(Point, 'http://beeline.ru/ws/dol/2006', 'Point');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(Point), 'ITEM', '[ArrayItemName="ITEM"]');
  RemClassRegistry.RegisterXSClass(GetLibVersion, 'http://beeline.ru/ws/dol/2006', 'GetLibVersion');
  RemClassRegistry.RegisterSerializeOptions(GetLibVersion, [xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfString), 'http://beeline.ru/ws/dol/2006', 'ArrayOfString');
  RemClassRegistry.RegisterXSClass(ResponseContractStatus, 'http://beeline.ru/ws/dol/2006', 'ResponseContractStatus');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(ResponseContractStatus), 'Errors', '[ArrayItemName="Error"]');
  RemClassRegistry.RegisterXSClass(ValidateClass, 'http://beeline.ru/ws/dol/2006', 'ValidateClass');
  RemClassRegistry.RegisterXSClass(Connection, 'http://beeline.ru/ws/dol/2006', 'Connection');
  RemClassRegistry.RegisterXSClass(Mobile, 'http://beeline.ru/ws/dol/2006', 'Mobile');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(Mobile), 'SERVICES', '[ArrayItemName="SERVICESId"]');
  RemClassRegistry.RegisterXSClass(PhoneInfo, 'http://beeline.ru/ws/dol/2006', 'PhoneInfo');
  RemClassRegistry.RegisterXSClass(AddressStreet, 'http://beeline.ru/ws/dol/2006', 'AddressStreet');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(AddressStreet), 'Type_', '[ExtName="Type"]');
  RemClassRegistry.RegisterXSClass(AddressPlace, 'http://beeline.ru/ws/dol/2006', 'AddressPlace');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(AddressPlace), 'Type_', '[ExtName="Type"]');
  RemClassRegistry.RegisterXSClass(AddressInfo, 'http://beeline.ru/ws/dol/2006', 'AddressInfo');
  RemClassRegistry.RegisterXSClass(ContractDelivery, 'http://beeline.ru/ws/dol/2006', 'ContractDelivery');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(ContractDelivery), 'Type_', '[ExtName="Type"]');
  RemClassRegistry.RegisterXSClass(ContractDeliveryAddress, 'http://beeline.ru/ws/dol/2006', 'ContractDeliveryAddress');
  RemClassRegistry.RegisterXSClass(ContractDeliveryFax, 'http://beeline.ru/ws/dol/2006', 'ContractDeliveryFax');
  RemClassRegistry.RegisterXSClass(ContractDeliveryEmail, 'http://beeline.ru/ws/dol/2006', 'ContractDeliveryEmail');
  RemClassRegistry.RegisterXSClass(ContractCustomer, 'http://beeline.ru/ws/dol/2006', 'ContractCustomer');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(ContractCustomer), 'Resident_', '[ExtName="Resident"]');
  RemClassRegistry.RegisterXSClass(ContractConnections, 'http://beeline.ru/ws/dol/2006', 'ContractConnections');
  RemClassRegistry.RegisterXSClass(ContractContact, 'http://beeline.ru/ws/dol/2006', 'ContractContact');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(ContractContact), 'NAME_', '[ExtName="NAME"]');
  RemClassRegistry.RegisterXSClass(Mobile4, 'http://beeline.ru/ws/dol/2006', 'Mobile4');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(Mobile4), 'SERVICES', '[ArrayItemName="SERVICESId"]');
  RemClassRegistry.RegisterXSClass(ContractConnections4, 'http://beeline.ru/ws/dol/2006', 'ContractConnections4');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ContractStatus), 'http://beeline.ru/ws/dol/2006', 'ContractStatus');
  RemClassRegistry.RegisterXSClass(ContractDealerInfo, 'http://beeline.ru/ws/dol/2006', 'ContractDealerInfo');
  RemClassRegistry.RegisterXSClass(Contract, 'http://beeline.ru/ws/dol/2006', 'Contract');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(Contract), 'LOGPARAMS', '[ArrayItemName="LOGPARAM"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfResponseContractStatus2), 'http://beeline.ru/ws/dol/2006', 'ArrayOfResponseContractStatus2');
  RemClassRegistry.RegisterXSClass(ReguestStatuses2Response, 'http://beeline.ru/ws/dol/2006', 'ReguestStatuses2Response');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(ReguestStatuses2Response), 'ReguestStatuses2Result', '[ArrayItemName="ResponseContractStatus2"]');
  RemClassRegistry.RegisterSerializeOptions(ReguestStatuses2Response, [xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfString1), 'http://beeline.ru/ws/dol/2006', 'ArrayOfString1');
  RemClassRegistry.RegisterXSClass(ResponseContractStatus2, 'http://beeline.ru/ws/dol/2006', 'ResponseContractStatus2');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(ResponseContractStatus2), 'ActivatedSIMs', '[ArrayItemName="SIM"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(ResponseContractStatus2), 'NotActivatedSIMs', '[ArrayItemName="SIM"]');
  RemClassRegistry.RegisterXSClass(AddressBuilding, 'http://beeline.ru/ws/dol/2006', 'AddressBuilding');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(AddressBuilding), 'Type_', '[ExtName="Type"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(LinkType), 'http://beeline.ru/ws/dol/2006', 'LinkType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(LinkType), '_0', '0');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(LinkType), '_1', '1');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(LinkType), '_2', '2');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(LinkType), '_3', '3');
  RemClassRegistry.RegisterXSClass(ContractConnections2, 'http://beeline.ru/ws/dol/2006', 'ContractConnections2');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfString2), 'http://beeline.ru/ws/dol/2006', 'ArrayOfString2');
  RemClassRegistry.RegisterXSClass(GetSubscriberData, 'http://beeline.ru/ws/dol/2006', 'GetSubscriberData');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(GetSubscriberData), 'ctn', '[ArrayItemName="string"]');
  RemClassRegistry.RegisterSerializeOptions(GetSubscriberData, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(ContractImport2Response, 'http://beeline.ru/ws/dol/2006', 'ContractImport2Response');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(ContractImport2Response), 'errors', '[ArrayItemName="string"]');
  RemClassRegistry.RegisterSerializeOptions(ContractImport2Response, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(ContractImport3Response, 'http://beeline.ru/ws/dol/2006', 'ContractImport3Response');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(ContractImport3Response), 'errors', '[ArrayItemName="string"]');
  RemClassRegistry.RegisterSerializeOptions(ContractImport3Response, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(ContractImport4Response, 'http://beeline.ru/ws/dol/2006', 'ContractImport4Response');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(ContractImport4Response), 'errors', '[ArrayItemName="string"]');
  RemClassRegistry.RegisterSerializeOptions(ContractImport4Response, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(ContractImportResponse, 'http://beeline.ru/ws/dol/2006', 'ContractImportResponse');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(ContractImportResponse), 'errors', '[ArrayItemName="string"]');
  RemClassRegistry.RegisterSerializeOptions(ContractImportResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(Contract2, 'http://beeline.ru/ws/dol/2006', 'Contract2');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(Contract2), 'LOGPARAMS', '[ArrayItemName="LOGPARAM"]');
  RemClassRegistry.RegisterXSClass(BankProperty, 'http://beeline.ru/ws/dol/2006', 'BankProperty');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(BankProperty), 'Name_', '[ExtName="Name"]');
  RemClassRegistry.RegisterXSClass(CustomerInfo, 'http://beeline.ru/ws/dol/2006', 'CustomerInfo');
  RemClassRegistry.RegisterXSClass(PersonInfo, 'http://beeline.ru/ws/dol/2006', 'PersonInfo');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(PersonInfo), 'Type_', '[ExtName="Type"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(PersonInfo), 'NAME_', '[ExtName="NAME"]');
  RemClassRegistry.RegisterXSClass(CompanyInfo, 'http://beeline.ru/ws/dol/2006', 'CompanyInfo');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(CompanyInfo), 'Type_', '[ExtName="Type"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(CompanyInfo), 'Name_', '[ExtName="Name"]');
  RemClassRegistry.RegisterXSClass(AddressRoom, 'http://beeline.ru/ws/dol/2006', 'AddressRoom');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(AddressRoom), 'Type_', '[ExtName="Type"]');
  RemClassRegistry.RegisterXSClass(ContractDocument, 'http://beeline.ru/ws/dol/2006', 'ContractDocument');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(ContractDocument), 'Type_', '[ExtName="Type"]');
  RemClassRegistry.RegisterXSClass(Name_, 'http://beeline.ru/ws/dol/2006', 'Name_', 'Name');
  RemClassRegistry.RegisterXSClass(BankProperties, 'http://beeline.ru/ws/dol/2006', 'BankProperties');
  RemClassRegistry.RegisterXSClass(LibRow, 'http://beeline.ru/ws/dol/2006', 'LibRow');
  RemClassRegistry.RegisterXSClass(RowId, 'http://beeline.ru/ws/dol/2006', 'RowId');
  RemClassRegistry.RegisterXSClass(RowPrintForms, 'http://beeline.ru/ws/dol/2006', 'RowPrintForms');
  RemClassRegistry.RegisterXSClass(RowBank, 'http://beeline.ru/ws/dol/2006', 'RowBank');
  RemClassRegistry.RegisterXSClass(RowCountry, 'http://beeline.ru/ws/dol/2006', 'RowCountry');
  RemClassRegistry.RegisterXSClass(RowScladLink, 'http://beeline.ru/ws/dol/2006', 'RowScladLink');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(RowScladLink), 'Type_', '[ExtName="Type"]');
  RemClassRegistry.RegisterXSClass(RowScladLinkHistory, 'http://beeline.ru/ws/dol/2006', 'RowScladLinkHistory');
  RemClassRegistry.RegisterXSClass(RowBPlanService, 'http://beeline.ru/ws/dol/2006', 'RowBPlanService');
  RemClassRegistry.RegisterXSClass(RowIdName, 'http://beeline.ru/ws/dol/2006', 'RowIdName');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(RowIdName), 'Name_', '[ExtName="Name"]');
  RemClassRegistry.RegisterXSClass(RowIdNameAddress, 'http://beeline.ru/ws/dol/2006', 'RowIdNameAddress');
  RemClassRegistry.RegisterXSClass(RowIdNameShortName, 'http://beeline.ru/ws/dol/2006', 'RowIdNameShortName');
  RemClassRegistry.RegisterXSClass(RowIdNameCode, 'http://beeline.ru/ws/dol/2006', 'RowIdNameCode');
  RemClassRegistry.RegisterXSClass(RowProduct, 'http://beeline.ru/ws/dol/2006', 'RowProduct');
  RemClassRegistry.RegisterXSClass(RowBillPlan, 'http://beeline.ru/ws/dol/2006', 'RowBillPlan');
  RemClassRegistry.RegisterXSClass(RowLogParam, 'http://beeline.ru/ws/dol/2006', 'RowLogParam');
  RemClassRegistry.RegisterXSClass(Contract4, 'http://beeline.ru/ws/dol/2006', 'Contract4');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(Contract4), 'LOGPARAMS', '[ArrayItemName="LOGPARAM"]');
  RemClassRegistry.RegisterXSClass(Contract3, 'http://beeline.ru/ws/dol/2006', 'Contract3');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(Contract3), 'LOGPARAMS', '[ArrayItemName="LOGPARAM"]');
  RemClassRegistry.RegisterXSClass(Connection2, 'http://beeline.ru/ws/dol/2006', 'Connection2');
  RemClassRegistry.RegisterXSClass(GetSubscriberDataResult, 'http://beeline.ru/ws/dol/2006', 'GetSubscriberDataResult');
  RemClassRegistry.RegisterXSClass(Connection4, 'http://beeline.ru/ws/dol/2006', 'Connection4');
  RemClassRegistry.RegisterXSClass(TransferNumberRequestsStatus, 'http://beeline.ru/ws/dol/2006', 'TransferNumberRequestsStatus');

end.