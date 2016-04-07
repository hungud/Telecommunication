unit ReportVirtualPayments;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, Grids, DBGrids, CRGrid, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TReportVirtualPaymentsForm = class(TForm)
    gReport: TCRDBGrid;
    qReport: TOraQuery;
    dsReport: TDataSource;
    qReportPHONE_NUMBER: TStringField;
    qReportPAYMENT_SUM: TFloatField;
    qReportPAYMENT_DATE_TIME: TDateTimeField;
    qReportUSER_CREATED: TStringField;
    qReportDATE_CREATED: TDateTimeField;
    qReportUSER_LAST_UPDATED: TStringField;
    qReportDATE_LAST_UPDATED: TDateTimeField;
    qReportREMARK: TStringField;
    pButton: TPanel;
    Label1: TLabel;
    btLoadInExcel: TBitBtn;
    cbPeriod: TComboBox;
    qPeriod: TOraQuery;
    qReportCOMPANY_NAME: TStringField;
    qReportRECEIVED_PAYMENT_TYPE_NAME: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure btRefreshClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btLoadInExcelClick(Sender: TObject);
    procedure cbPeriodChange(Sender: TObject);
  private
    procedure Update;
  public
    { Public declarations }
  end;

procedure DoReportVirtualPayments;

var
  ReportVirtualPaymentsForm: TReportVirtualPaymentsForm;

implementation

{$R *.dfm}

uses IntecExportGrid;

procedure DoReportVirtualPayments;
var ReportFrm : TReportVirtualPaymentsForm;
begin
  ReportFrm:=TReportVirtualPaymentsForm.Create(Nil);
  try
    ReportFrm.ShowModal;
  finally
    ReportFrm.qReport.Close;
    ReportFrm.Free;
  end;
end;

procedure TReportVirtualPaymentsForm.btLoadInExcelClick(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2(ReportVirtualPaymentsForm.Caption,'',
      gReport, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportVirtualPaymentsForm.btRefreshClick(Sender: TObject);
begin
  Update;
end;

procedure TReportVirtualPaymentsForm.cbPeriodChange(Sender: TObject);
begin
  Update;
end;

procedure TReportVirtualPaymentsForm.FormCreate(Sender: TObject);
begin
  cbPeriod.Items.Clear;
  qPeriod.Open;
  qPeriod.First;
  while not qPeriod.Eof do
  begin
    cbPeriod.Items.AddObject(qPeriod.FieldByName('mm_year').AsString,
                             TObject(qPeriod.FieldByName('period').AsInteger) );
    qPeriod.Next;
  end;

  if qPeriod.RecordCount > 0 then
    cbPeriod.ItemIndex := 0
  else
    cbPeriod.ItemIndex := -1;
end;

procedure TReportVirtualPaymentsForm.FormShow(Sender: TObject);
begin
  Update;
end;

procedure TReportVirtualPaymentsForm.Update;
begin
  if cbPeriod.ItemIndex >= 0 then
  begin
    qReport.Close;
    qReport.ParamByName('PERIOD').Value :=  Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex]);
    qReport.Open;
  end
  else
    MessageBox(Handle, 'Нет периодов для выборки', '', MB_ICONINFORMATION + MB_OK);
end;

end.
