unit ReportBillNegative;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, ActnList, Grids, DBGrids, CRGrid, StdCtrls,
  Buttons, ExtCtrls;

type
  TReportBillNegativeForm = class(TForm)
    Panel1: TPanel;
    lPeriod: TLabel;
    lAccount: TLabel;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    btInfoAbonent: TBitBtn;
    cbPeriod: TComboBox;
    cbSearch: TCheckBox;
    cbAccounts: TComboBox;
    grData: TCRDBGrid;
    ActionList: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    qAccounts: TOraQuery;
    qPeriods: TOraQuery;
    qReport: TOraQuery;
    dsReport: TDataSource;
    qReportYEAR_MONTH: TFloatField;
    qReportPHONE_NUMBER: TStringField;
    qReportLogin: TStringField;
    qReportaccount_id: TFloatField;
    qReportbill_sum: TFloatField;
    qReportbill_sum_new: TFloatField;
    qReportdifferent: TFloatField;
    procedure aRefreshExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbPeriodChange(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure cbSearchClick(Sender: TObject);
    procedure cbAccountsChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ReportBillNegativeForm: TReportBillNegativeForm;

procedure DoReportBillNegative;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils, IntecExportGrid, ShowUserStat, Main;

procedure DoReportBillNegative;
var ReportFrm : TReportBillNegativeForm;
    Sdvig:integer;
begin
  ReportFrm:=TReportBillNegativeForm.Create(Nil);
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
    if ReportFrm.cbPeriod.Items.Count > 1 then
      ReportFrm.cbPeriod.ItemIndex := 1
    else
      if ReportFrm.cbPeriod.Items.Count > 0 then
      ReportFrm.cbPeriod.ItemIndex := 0;
    ReportFrm.lAccount.Show;
    ReportFrm.cbAccounts.Show;
    ReportFrm.qAccounts.Open;
    ReportFrm.cbAccounts.Items.AddObject('Все', Pointer(0));
    while not ReportFrm.qAccounts.EOF do
    begin
      ReportFrm.cbAccounts.Items.AddObject(
        ReportFrm.qAccounts.FieldByName('LOGIN').AsString,
        Pointer(ReportFrm.qAccounts.FieldByName('ACCOUNT_ID').AsInteger)
        );
      ReportFrm.qAccounts.Next;
    end;
    ReportFrm.qAccounts.Close;
    if ReportFrm.cbAccounts.Items.Count > 0 then
      ReportFrm.cbAccounts.ItemIndex := 0;
    // Отчет
    ReportFrm.cbPeriodChange(ReportFrm.cbPeriod);
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportBillNegativeForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Счета выставленные в минус за ' + cbPeriod.Text + ' по состоянию на '+DateToStr(Date),'',
      grData, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportBillNegativeForm.aRefreshExecute(Sender: TObject);
begin
  qReport.Close;
  qReport.Open;
end;

procedure TReportBillNegativeForm.aShowUserStatInfoExecute(
  Sender: TObject);
begin
  if qReport.Active and (qReport.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER').AsString, 0);
end;


procedure TReportBillNegativeForm.cbAccountsChange(Sender: TObject);
var
  Account : integer;
begin
  if cbAccounts.ItemIndex >= 0 then
    Account := Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex])
  else Account:=0;
  if Account<>0 then
  begin
    qReport.ParamByName('ACCOUNT_ID').asInteger := Account;
//    aRefresh.Execute;
  end;
end;

procedure TReportBillNegativeForm.cbPeriodChange(Sender: TObject);
var Period : Integer;
begin
  if cbPeriod.ItemIndex >= 0 then
    Period := Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
  else
    Period := -1;
  qReport.ParamByName('YEAR_MONTH').AsInteger := Period;
  //aRefresh.Execute;
end;

procedure TReportBillNegativeForm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    grData.OptionsEx:=grData.OptionsEx+[dgeSearchBar]
  else
    grData.OptionsEx:=grData.OptionsEx-[dgeSearchBar];
end;

end.
