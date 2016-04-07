unit ShowBillDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, CRGrid, StdCtrls, Buttons, ExtCtrls, MemDS,
  DBAccess, Ora;

type
  TShowBillDetailsForm = class(TForm)
    qBillDetails: TOraQuery;
    dsBillDetails: TDataSource;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    CRDBGrid1: TCRDBGrid;
    qBillDetailsBILL_SUM: TFloatField;
    qBillDetailsSUBSCRIBER_PAYMENT_NEW: TFloatField;
    qBillDetailsSUBSCRIBER_PAYMENT_ADD_NEW: TFloatField;
    qBillDetailsCALLS_LOCAL_COST: TFloatField;
    qBillDetailsCALLS_OTHER_CITY_COST: TFloatField;
    qBillDetailsCALLS_OTHER_COUNTRY_COST: TFloatField;
    qBillDetailsINTERNET_COST: TFloatField;
    qBillDetailsMESSAGES_COST: TFloatField;
    qBillDetailsNATIONAL_ROAMING_COST: TFloatField;
    qBillDetailsOTHER_COUNTRY_ROAMING_COST: TFloatField;
    qBillDetailsSINGLE_PAYMENTS: TFloatField;
    qBillDetailsDATE_BEGIN: TDateTimeField;
    qBillDetailsDATE_END: TDateTimeField;
    qBillDetailsPHONE_NUMBER: TStringField;
    qBillDetailsSUBSCRIBER_PAYMENT_ADD_VOZVRAT: TFloatField;
    qServiceParam: TOraQuery;
    qServiceParamVOLUME_EXCEEDED: TFloatField;
    qServiceParamCASE: TStringField;
    qServiceParamSUBSTRDB_LOADER_PCKGGET_VOLUME_SERVICEPHONE_NUMYEAR_MONTSVSERVICE_VOLUME_ID1DECODEINSTRDB_LOADER_PCKGGET_VOLUME_SERVICEPHONE_NUMYEAR_MONTSVSERVICE_VOLUME_ID11LENGTHDB_LOADER_PCKGGET_VOLUME_SERVICEPHONE_NUMYEAR_MONTS: TStringField;
    qServiceParamCASE_1: TStringField;
    qSMSUSSD: TOraQuery;
    qSMSUSSDDATE_SEND: TDateTimeField;
    qSMSUSSDSMS: TStringField;
    qSMSUSSDSMS_TEXT: TStringField;
    qSMSUSSDINSERT_DATE: TDateTimeField;
    qSMSUSSDUPDATE_DATE: TDateTimeField;
    qSMSUSSDSTATUS_DESC: TStringField;
    qSMSUSSDERROR_DESC: TStringField;
    qSMSUSSDERR_ALL: TStringField;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoShowBillDetails(PhoneNumber: string; YearMonth: integer; Title: string;typeform :string);

var
  ShowBillDetailsForm: TShowBillDetailsForm;
//
implementation

{$R *.dfm}

uses IntecExportGrid;

procedure DoShowBillDetails(PhoneNumber: string; YearMonth: Integer; Title: string;
typeform :string);
var ReportFrm : TShowBillDetailsForm;
begin
  ReportFrm:=TShowBillDetailsForm.Create(Nil);
  if typeform='BILL' then
  try
    // Отчет
    ReportFrm.Caption:=PhoneNumber+' - '+Title;
    ReportFrm.qBillDetails.ParamByName('PHONE_NUMBER').AsString:=PhoneNumber;
    ReportFrm.qBillDetails.ParamByName('YEAR_MONTH').AsInteger:=YearMonth;
    ReportFrm.qBillDetails.Open;
    ReportFrm.ShowModal;
  finally
    ReportFrm.qBillDetails.Close;
    ReportFrm.Free;
  end
  else
  if typeform='SERVICE' then
  try
    // Отчет
    ReportFrm.Caption:=PhoneNumber+' - '+Title;
    ReportFrm.dsBillDetails.Enabled:=false;
    ReportFrm.dsBillDetails.DataSet:=ReportFrm.qServiceParam;
    ReportFrm.dsBillDetails.Enabled:=true;
    ReportFrm.qServiceParam.ParamByName('phone_num').AsString:=PhoneNumber;
    ReportFrm.qServiceParam.ParamByName('Year_MONT').AsInteger:=YearMonth;
    ReportFrm.qServiceParam.ParamByName('opt_code').AsString:=Title;
    ReportFrm.qServiceParam.Open;
    ReportFrm.ShowModal;
  finally
    ReportFrm.qBillDetails.Close;
    ReportFrm.Free;
  end
  else
  if typeform='SMSUSSD' then
  try
    // Отчет
    ReportFrm.Caption:=PhoneNumber+' - '+Title;
    ReportFrm.dsBillDetails.Enabled:=false;
    ReportFrm.dsBillDetails.DataSet:=ReportFrm.qSMSUSSD;
    ReportFrm.dsBillDetails.Enabled:=true;
    ReportFrm.qSMSUSSD.ParamByName('PHONE_NUMBER').AsString:=PhoneNumber;
    //ReportFrm.qSMSUSSD.ParamByName('YEAR_MONTH').AsInteger:=YearMonth;
    ReportFrm.qSMSUSSD.Open;
    ReportFrm.ShowModal;
  finally
    ReportFrm.qBillDetails.Close;
    ReportFrm.Free;
  end
end;

procedure TShowBillDetailsForm.BitBtn1Click(Sender: TObject);
begin
  ExportDBGridToExcel(ShowBillDetailsForm.Caption,'', CRDBGrid1);
end;

end.
