unit ReportHotBillingDelay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ActnList, MemDS, DBAccess, Ora, Grids, DBGrids, CRGrid, StdCtrls,
  Buttons, ExtCtrls, IntecExportGrid, ShowUserStat, ContractsRegistration_Utils;

type
  TReportHotBillingDelayForm = class(TForm)
    Panel1: TPanel;
    lPeriod: TLabel;
    lAccount: TLabel;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    btInfoAbonent: TBitBtn;
    cbPeriod: TComboBox;
    cbSearch: TCheckBox;
    cbAccounts: TComboBox;
    PhoneNumberViolationsGrid: TCRDBGrid;
    qAccounts: TOraQuery;
    qPeriods: TOraQuery;
    alReports: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    qReports: TOraQuery;
    dsReports: TDataSource;
    qReportsFILE_NAME: TStringField;
    qReportsLOAD_SDATE: TDateTimeField;
    qReportsMD: TFloatField;
    qReportsMMD: TFloatField;
    procedure aExcelExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbAccountsChange(Sender: TObject);
    procedure cbPeriodChange(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoReportHotBillingDelay;

var
  ReportHotBillingDelayForm: TReportHotBillingDelayForm;

implementation

{$R *.dfm}

uses Main;

procedure DoReportHotBillingDelay;
var ReportFrm : TReportHotBillingDelayForm;
    Sdvig:integer;
begin
  ReportFrm:=TReportHotBillingDelayForm.Create(Nil);
  try
    // Период
    ReportFrm.qPeriods.SQL.Strings[1]:=' where substr(hbf.file_name,-3)=''csv''';
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
      ReportFrm.lAccount.Show;
      ReportFrm.cbAccounts.Show;
      ReportFrm.qAccounts.Open;
      ReportFrm.cbAccounts.Items.AddObject('Все', Pointer(-1));
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
      if Integer(ReportFrm.cbAccounts.Items.objects[ReportFrm.cbAccounts.ItemIndex])<>0 then
        ReportFrm.qReports.ParamByName('PACCOUNT_ID').asInteger :=
          Integer(ReportFrm.cbAccounts.Items.objects[ReportFrm.cbAccounts.ItemIndex])
      else ReportFrm.qReports.ParamByName('PACCOUNT_ID').Clear;
    end;
    // Отчет
    ReportFrm.cbPeriodChange(ReportFrm.cbPeriod);
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportHotBillingDelayForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2(ReportHotBillingDelayForm.Caption + ' за ' + cbPeriod.Text + ' по состоянию на '+DateToStr(Date),'',
      PhoneNumberViolationsGrid, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportHotBillingDelayForm.aRefreshExecute(Sender: TObject);
begin
  qReports.Close;
  qReports.Open;
end;

procedure TReportHotBillingDelayForm.aShowUserStatInfoExecute(Sender: TObject);
begin
  if qReports.Active and (qReports.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReports.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TReportHotBillingDelayForm.cbAccountsChange(Sender: TObject);
var
  Account : integer;
begin
  if cbAccounts.ItemIndex >= 0 then
    Account := Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex])
  else Account:=0;
  if Account<>0 then
  begin
    qReports.ParamByName('PACCOUNT_ID').asInteger := Account;
    aRefresh.Execute;
  end else
  begin
    qReports.ParamByName('PACCOUNT_ID').Clear;
   // aRefresh.Execute;
  end;
end;

procedure TReportHotBillingDelayForm.cbPeriodChange(Sender: TObject);
var Period : Integer;
begin
  if cbPeriod.ItemIndex >= 0 then
    Period := Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
  else
    Period := -1;
  qReports.SQL.Strings[8]:='  from call_'+Copy(Inttostr(Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])),5, 2)+'_'+Copy(Inttostr(Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])),1, 4)+' hb,';
  qReports.ParamByName('PYEAR_MONTH').AsInteger := Period;

  //aRefresh.Execute;
end;

end.
