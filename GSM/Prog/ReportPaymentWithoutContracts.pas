unit ReportPaymentWithoutContracts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ActnList, StdCtrls, Buttons, ExtCtrls, MemDS, DBAccess, Ora,
  Grids, DBGrids, CRGrid;

type
  TReportPaymentWithoutContractsForm = class(TForm)
    dsReport: TDataSource;
    ReportGrid: TCRDBGrid;
    qReport: TOraQuery;
    Panel1: TPanel;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    btInfoAbonent: TBitBtn;
    cbSearch: TCheckBox;
    alReport: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    qReportPHONE_NUMBER: TStringField;
    qReportPAYMENT_DATE: TDateTimeField;
    qReportPAYMENT_SUM: TFloatField;
    qReportPAYMENT_NUMBER: TStringField;
    qReportCONTRACT_DATE: TDateTimeField;
    qReportTARIFF_CODE: TStringField;
    qPeriods: TOraQuery;
    Label1: TLabel;
    cbPeriod: TComboBox;
    procedure aExcelExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbPeriodChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoReportPaymentWithoutContracts;

var
  ReportPaymentWithoutContractsForm: TReportPaymentWithoutContractsForm;

implementation

{$R *.dfm}

uses IntecExportGrid, ShowUserStat, Main;

procedure DoReportPaymentWithoutContracts;
var
  ReportFrm : TReportPaymentWithoutContractsForm;
begin
  ReportFrm:=TReportPaymentWithoutContractsForm.Create(Nil);
  try
     // Период
    ReportFrm.qPeriods.Open;
    while not ReportFrm.qPeriods.EOF do
    begin
      ReportFrm.cbPeriod.Items.AddObject(
        ReportFrm.qPeriods.FieldByName('YEAR_MONTH_NAME').AsString,
        TObject(ReportFrm.qPeriods.FieldByName('YEAR_MONTH').AsInteger)
        );
      ReportFrm.qPeriods.Next;
    end;
    ReportFrm.qPeriods.Close;
    if ReportFrm.cbPeriod.Items.Count > 0 then
      ReportFrm.cbPeriod.ItemIndex := 0;
    // Обновим.
    ReportFrm.cbPeriodChange(ReportFrm.cbPeriod);
    // Отчет
    //ReportFrm.aRefresh.Execute;
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportPaymentWithoutContractsForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2(ReportPaymentWithoutContractsForm.Caption,'',
      ReportGrid, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportPaymentWithoutContractsForm.aRefreshExecute(Sender: TObject);
begin
  qReport.Close;
  qReport.Open;
end;

procedure TReportPaymentWithoutContractsForm.aShowUserStatInfoExecute(
  Sender: TObject);
begin
  if qReport.Active and (qReport.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TReportPaymentWithoutContractsForm.cbPeriodChange(Sender: TObject);
var
  Period : Integer;
begin
  if cbPeriod.ItemIndex >= 0 then
    Period := Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
  else
    Period := -1;
  qReport.ParamByName('YEAR_MONTH').AsInteger := Period;
  aRefresh.Execute;
end;

procedure TReportPaymentWithoutContractsForm.FormCreate(Sender: TObject);
begin
  if MainForm.FUseFilialBlockAccess then
    qReport.SQL.Append('AND GET_FILIAL_ID_BY_PHONE(P.PHONE_NUMBER) = ' + IntToStr(MainForm.FFilial));
end;

end.
