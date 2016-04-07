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
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoShowBillDetails(PhoneNumber: string; YearMonth: integer; Title: string);

var
  ShowBillDetailsForm: TShowBillDetailsForm;

implementation

{$R *.dfm}

uses IntecExportGrid;

procedure DoShowBillDetails(PhoneNumber: string; YearMonth: Integer; Title: string);
var ReportFrm : TShowBillDetailsForm;
begin
  ReportFrm:=TShowBillDetailsForm.Create(Nil);
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
  end;
end;

procedure TShowBillDetailsForm.BitBtn1Click(Sender: TObject);
begin
  ExportDBGridToExcel(ShowBillDetailsForm.Caption, CRDBGrid1);
end;

end.
