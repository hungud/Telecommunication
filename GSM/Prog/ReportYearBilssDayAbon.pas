unit ReportYearBilssDayAbon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, StdCtrls, Buttons, ExtCtrls, Grids,
  DBGrids, CRGrid, IntecExportGrid, ShowUserStat, ContractsRegistration_Utils,
  ActnList;

type
  TReportYearBilssDayAbonForm = class(TForm)
    dsReport: TDataSource;
    grReport: TCRDBGrid;
    Panel1: TPanel;
    lPeriod: TLabel;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    btInfoAbonent: TBitBtn;
    cbPeriod: TComboBox;
    cbSearch: TCheckBox;
    qReport: TOraQuery;
    qYears: TOraQuery;
    alReport: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    qReportPHONE_NUMBER: TStringField;
    qReportBILL_01: TFloatField;
    qReportBILL_02: TFloatField;
    qReportBILL_03: TFloatField;
    qReportBILL_04: TFloatField;
    qReportBILL_05: TFloatField;
    qReportBILL_06: TFloatField;
    qReportBILL_07: TFloatField;
    qReportBILL_08: TFloatField;
    qReportBILL_09: TFloatField;
    qReportBILL_10: TFloatField;
    qReportBILL_11: TFloatField;
    qReportBILL_12: TFloatField;
    qReportSUTOCHN_ABON: TFloatField;
    procedure cbPeriodChange(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoReportYearBilssDayAbon;

var
  ReportYearBilssDayAbonForm: TReportYearBilssDayAbonForm;

implementation

{$R *.dfm}

uses ExportGridToExcelPDF;

procedure DoReportYearBilssDayAbon;
var ReportFrm : TReportYearBilssDayAbonForm;
    Sdvig:integer;
begin
  ReportFrm:=TReportYearBilssDayAbonForm.Create(Nil);
  try
    // Период
    ReportFrm.qYears.Open;
    while not ReportFrm.qYears.EOF do
    begin
      ReportFrm.cbPeriod.Items.AddObject(
        ReportFrm.qYears.FieldByName('YEARS').AsString,
        TObject(ReportFrm.qYears.FieldByName('YEARS').AsInteger)
        );
      ReportFrm.qYears.Next;
    end;
    ReportFrm.qYears.Close;
    if ReportFrm.cbPeriod.Items.Count > 0 then
      ReportFrm.cbPeriod.ItemIndex := 0;
    // Отчет
    ReportFrm.cbPeriodChange(ReportFrm.cbPeriod);
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportYearBilssDayAbonForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
//    ExportDBGridToExcel2('Счета за ' + cbPeriod.Text,'', GrReport, nil, False, True);
    ExportDBGrid('Счета за ' + cbPeriod.Text,'','Счета_за_год_'+cbPeriod.Text, GrReport, True, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportYearBilssDayAbonForm.aRefreshExecute(Sender: TObject);
begin
  qReport.Close;
  qReport.Open;
end;

procedure TReportYearBilssDayAbonForm.aShowUserStatInfoExecute(Sender: TObject);
begin
  if qReport.Active and (qReport.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TReportYearBilssDayAbonForm.cbPeriodChange(Sender: TObject);
var Period: integer;
begin
  if cbPeriod.ItemIndex >= 0 then
    Period := Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
  else
    Period := -1;
  qReport.ParamByName('YEARS').AsInteger := Period;
end;

end.
