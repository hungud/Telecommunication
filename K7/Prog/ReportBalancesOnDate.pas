unit ReportBalancesOnDate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ComCtrls, Grids, DBGrids, CRGrid, MemDS, DBAccess, Ora, ActnList,
  StdCtrls, Buttons, ExtCtrls;

type
  TReportBalancesOnDateForm = class(TForm)
    Panel1: TPanel;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    btInfoAbonent: TBitBtn;
    cbSearch: TCheckBox;
    aReport: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    qReport: TOraQuery;
    dsReport: TDataSource;
    ReportGrid: TCRDBGrid;
    dtpDateTime: TDateTimePicker;
    qReportPHONE_NUMBER: TStringField;
    qReportBALANCE: TFloatField;
    qReportBILL_SUM_DATE: TFloatField;
    qReportBILL_SUM_DATE_NEW_MONTH: TFloatField;
    cbFilter: TCheckBox;
    procedure aExcelExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbSearchClick(Sender: TObject);
    procedure cbFilterClick(Sender: TObject);
    procedure dtpDateTimeChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoReportBalancesOnDate;

var
  ReportBalancesOnDateForm: TReportBalancesOnDateForm;

implementation

{$R *.dfm}

uses IntecExportGrid, ShowUserStat;

procedure DoReportBalancesOnDate;
var ReportFrm : TReportBalancesOnDateForm;
begin
  ReportFrm:=TReportBalancesOnDateForm.Create(Nil);
  try
    // Отчет
    ReportFrm.dtpDateTime.Date:= Date;
    ReportFrm.dtpDateTime.Time:= Time;
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportBalancesOnDateForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Баланс на ' + dtpDateTime.ToString,'',
      ReportGrid, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportBalancesOnDateForm.aRefreshExecute(Sender: TObject);
begin
  qReport.Close;
  qReport.Open;
end;

procedure TReportBalancesOnDateForm.aShowUserStatInfoExecute(Sender: TObject);
begin
  if qReport.Active and (qReport.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TReportBalancesOnDateForm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    ReportGrid.OptionsEx:=ReportGrid.OptionsEx+[dgeSearchBar]
  else
    ReportGrid.OptionsEx:=ReportGrid.OptionsEx-[dgeSearchBar];
end;

procedure TReportBalancesOnDateForm.cbFilterClick(Sender: TObject);
begin
  if cbFilter.Checked then
    ReportGrid.OptionsEx:=ReportGrid.OptionsEx+[dgeFilterBar]
  else
    ReportGrid.OptionsEx:=ReportGrid.OptionsEx-[dgeFilterBar];
end;

procedure TReportBalancesOnDateForm.dtpDateTimeChange(Sender: TObject);
begin
  qReport.ParamByName('pDATE').AsDateTime:=dtpDateTime.DateTime;
end;

end.
