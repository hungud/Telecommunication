unit ReportPaymentPassenger;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ActnList, StdCtrls, Buttons, ExtCtrls, MemDS, DBAccess, Ora,
  Grids, DBGrids, CRGrid,PhoneNumberInputFrm;

type
  TReportPaymentPassengerForm = class(TForm)
    dsReport: TDataSource;
    ReportGrid: TCRDBGrid;
    qReport: TOraQuery;
    Panel1: TPanel;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    btInfoAbonent: TBitBtn;
    alReport: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    qReportPhone: TStringField;
    qReportSUM_PAY: TFloatField;
    qReportDATE_INSERT: TStringField;
    qReportDATE_PAY: TStringField;
    procedure aExcelExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FPhoneNumberInputFrm : TPhoneNumberInputForm;
  end;

procedure DoReportPaymentPassenger;

var
  ReportPaymentPassengerForm: TReportPaymentPassengerForm;

implementation

{$R *.dfm}

uses IntecExportGrid, ShowUserStat, Main;

procedure DoReportPaymentPassenger;
var ReportFrm : TReportPaymentPassengerForm;
begin
  ReportFrm:=TReportPaymentPassengerForm.Create(Nil);
  try
    // Отчет
    ReportFrm.aRefresh.Execute;
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportPaymentPassengerForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2(ReportPaymentPassengerForm.Caption,'',
      ReportGrid, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportPaymentPassengerForm.aRefreshExecute(Sender: TObject);
begin
  qReport.Close;
  qReport.Open;
end;

procedure TReportPaymentPassengerForm.aShowUserStatInfoExecute(
  Sender: TObject);
begin
  if qReport.Active and (qReport.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE').AsString, 0);
end;



end.
