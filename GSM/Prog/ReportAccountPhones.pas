unit ReportAccountPhones;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ActnList, MemDS, DBAccess, Ora, Grids, DBGrids, CRGrid, StdCtrls,
  Buttons, ExtCtrls, IntecExportGrid, ShowUserStat, ContractsRegistration_Utils;

type
  TReportAccountPhonesForm = class(TForm)
    Panel1: TPanel;
    lPeriod: TLabel;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    btInfoAbonent: TBitBtn;
    cbPeriod: TComboBox;
    cbSearch: TCheckBox;
    PhoneNumberViolationsGrid: TCRDBGrid;
    qPeriods: TOraQuery;
    alReports: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    qReports: TOraQuery;
    dsReports: TDataSource;
    qReportsPHONE_IS_ACTIVE: TIntegerField;
    qReportsLAST_CHECK_DATE_TIME: TDateTimeField;
    qReportsCONSERVATION: TIntegerField;
    qReportsSYSTEM_BLOCK: TIntegerField;
    qReportsACCOUNT_NUMBER: TFloatField;
    qReportsPHONE_NUMBER: TStringField;
    qReportsCELL_PLAN_CODE: TStringField;
    cbSubstValues: TCheckBox;
    qReportsDETAIL_SUM: TFloatField;
    qReportsIS_CONTRACT: TStringField;
    pCount: TPanel;
    qReportsCONTRACT_NUM: TFloatField;
    qReportsTARIFF_NAME: TStringField;
    procedure aExcelExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbPeriodChange(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure cbSubstValuesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoReportAccountPhones;

var
  ReportAccountPhonesForm: TReportAccountPhonesForm;

implementation

uses Main;

{$R *.dfm}

procedure DoReportAccountPhones;
var ReportFrm : TReportAccountPhonesForm;
    Sdvig:integer;
begin
  ReportFrm:=TReportAccountPhonesForm.Create(Nil);
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
    begin
      ReportFrm.qReports.ParamByName('ACCOUNT_ID').Clear;
    end;
    // Отчет
    ReportFrm.cbPeriodChange(ReportFrm.cbPeriod);
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportAccountPhonesForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2(ReportAccountPhonesForm.Caption + ' за ' + cbPeriod.Text + ' по состоянию на '+DateToStr(Date),'',
      PhoneNumberViolationsGrid, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportAccountPhonesForm.aRefreshExecute(Sender: TObject);
var CountPhone: integer;
begin
  qReports.Close;
  qReports.Open;
  if qReports.Active and (qReports.RecordCount > 0) then
  begin
    CountPhone:= qReports.RecordCount;
    pCount.Font.Color:= ClGreen;
  end else
  begin
    CountPhone:=0;
    pCount.Font.Color:= ClRed;
  end;
  pCount.Caption:='Количество номеров: ' + IntToStr(CountPhone);
end;

procedure TReportAccountPhonesForm.aShowUserStatInfoExecute(Sender: TObject);
begin
  if qReports.Active and (qReports.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReports.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TReportAccountPhonesForm.cbPeriodChange(Sender: TObject);
var Period : Integer;
begin
  if cbPeriod.ItemIndex >= 0 then
    Period := Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
  else
    Period := -1;
  qReports.ParamByName('YEAR_MONTH').AsInteger := Period;
  //aRefresh.Execute;
end;

procedure TReportAccountPhonesForm.cbSubstValuesClick(Sender: TObject);
 var
  sqlValue:string;
begin
  if cbSubstValues.Checked then
  begin
    PhoneNumberViolationsGrid.Columns.Items[9].Visible:=true;
    PhoneNumberViolationsGrid.Columns.Items[10].Visible:=true;
  end
  else
    PhoneNumberViolationsGrid.Columns.Items[9].Visible:=false;
end;

procedure TReportAccountPhonesForm.FormCreate(Sender: TObject);
begin
  if MainForm.FUseFilialBlockAccess then
    qReports.SQL.Insert(9, 'AND A.FILIAL_ID=' + IntToStr(MainForm.FFilial));

  PhoneNumberViolationsGrid.Columns.Items[1].Visible:=True;
  PhoneNumberViolationsGrid.Columns.Items[2].Visible:=True;
  PhoneNumberViolationsGrid.Columns.Items[4].Visible:=False;
  PhoneNumberViolationsGrid.Columns.Items[6].Visible:=False;
  PhoneNumberViolationsGrid.Columns.Items[7].Visible:=False;
  PhoneNumberViolationsGrid.Columns.Items[8].Visible:=False;
  PhoneNumberViolationsGrid.Columns.Items[9].Visible:=False;
  PhoneNumberViolationsGrid.Columns.Items[10].Visible:=True;
  cbSubstValues.Visible := False;
  cbSearch.Visible := False;

end;

end.
