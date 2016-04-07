unit ReportLoadMonitor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, Grids, DBGrids, CRGrid, StdCtrls, ExtCtrls,
  ActnList, Buttons;

type
  TReportLoadMonitorForm = class(TForm)
    Panel1: TPanel;
    cbPeriod: TComboBox;
    ReportGrid: TCRDBGrid;
    qReport: TOraQuery;
    qPeriods: TOraQuery;
    dsReport: TDataSource;
    qReportLOGIN: TStringField;
    qReportCOUNT_PHONE: TFloatField;
    qReportCOUNT_BILLS: TFloatField;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    ActionList: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    qReportLOAD_SUM_CALLS: TFloatField;
    qReportBILL_SUM_CALLS: TFloatField;
    qReportDETAIL_SUM_NO_LOAD: TFloatField;
    procedure cbPeriodChange(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoReportLoadMonitor;

var
  ReportLoadMonitorForm: TReportLoadMonitorForm;

implementation

{$R *.dfm}

Uses IntecExportGrid;

procedure DoReportLoadMonitor;
var ReportFrm : TReportLoadMonitorForm;
    Sdvig:integer;
begin
  ReportFrm:=TReportLoadMonitorForm.Create(Nil);
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
    // Отчет
    ReportFrm.cbPeriodChange(ReportFrm.cbPeriod);
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportLoadMonitorForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2(ReportLoadMonitorForm.Caption + ' за ' + cbPeriod.Text + ' по состоянию на '+DateToStr(Date),
      ReportGrid, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportLoadMonitorForm.aRefreshExecute(Sender: TObject);
begin
  qReport.Close;
  qReport.Open;
end;

procedure TReportLoadMonitorForm.cbPeriodChange(Sender: TObject);
var Period: integer;
begin
  if cbPeriod.ItemIndex >= 0 then
    Period := Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
  else
    Period := -1;
  qReport.ParamByName('YEAR_MONTH').AsInteger := Period;
  aRefresh.Execute;
end;

end.
