unit ReportFinanceModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, ActnList, Grids, DBGrids, CRGrid, StdCtrls,
  Buttons, ExtCtrls, IntecExportGrid, ShowUserStat, Vcl.Samples.Gauges,
  Vcl.ComCtrls;

type
  TReportFinance = class(TForm)
    Panel1: TPanel;
    lPeriod: TLabel;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    btInfoAbonent: TBitBtn;
    cbPeriod: TComboBox;
    cbSearch: TCheckBox;
    grData: TCRDBGrid;
    ActionList: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    qPeriods: TOraQuery;
    qReport: TOraQuery;
    dsReport: TDataSource;
    qReportSimTrade: TOraQuery;
    cbGroup: TCheckBox;
    qReportSimTradeGroup: TOraQuery;
    Timer1: TTimer;
    procedure cbPeriodChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aRefreshExecute(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbGroupClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SHOW_ProgressBar;
    procedure SHOW_LastDateRep;
    procedure SHOW_Report;
  end;

  procedure DoFinanceReport;

var
  ReportFinance: TReportFinance;

  record_count : integer;
  session_id : integer;
  last_date_rep : TDateTime;
  last_session_id : integer;

  FAccid : string;
  FAccount : string;
  fShowOne : integer;
  YEAR_MONTH : integer;

implementation

uses ContractsRegistration_Utils, PassWord, ExportGridToExcelPDF;

{$R *.dfm}

{ TReportFinance }

procedure DoFinanceReport;
var
 ReportFrm : TReportFinance;
begin

  ReportFrm := TReportFinance.Create(Nil);
  try
    ReportFrm.FormStyle := fsMDIChild;
    ReportFrm.Show;

    ReportFrm.qPeriods.Open;
    while not ReportFrm.qPeriods.EOF do
    begin
      ReportFrm.cbPeriod.Items.AddObject(
        ReportFrm.qPeriods.FieldByName('YEAR_MONTH_NAME').AsString,
        TObject(ReportFrm.qPeriods.FieldByName('YEAR_MONTH').AsInteger)
        );
      ReportFrm.qPeriods.Next;
    end;
    ReportFrm.cbPeriod.ItemIndex:=0;
    YEAR_MONTH:=integer(ReportFrm.cbPeriod.Items.Objects[ReportFrm.cbPeriod.ItemIndex]);
    ReportFrm.qReport.ParamByName('YEAR_MONTH').AsInteger:=YEAR_MONTH;
  finally
    //ReportFrm.Free;
  end;
end;

procedure TReportFinance.aExcelExecute(Sender: TObject);
begin
  //ExportDBGridToExcel('Финансовый отчёт','', grData, False)
  ExportDBGrid('Финансовый отчёт','','Finance_'+cbPeriod.Text, grData, True, True);
end;

procedure TReportFinance.aRefreshExecute(Sender: TObject);
begin
  qReport.Active:=false;
  cbPeriodChange(Self);
  qReport.Active:=true;
end;

procedure TReportFinance.aShowUserStatInfoExecute(Sender: TObject);
begin
  if qreport.Active and (qreport.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qreport.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TReportFinance.cbGroupClick(Sender: TObject);
var
  i1:integer;
begin
  qReport.Close;
  if cbGroup.Checked then
  begin
    qReport.SQL.text:=qReportSimTradeGroup.SQL.Text;

    for i1:= 0 to 23 do
      grData.Columns.Items[i1].Visible:=false;

    for i1:= 29 to 30 do
      grData.Columns.Items[i1].Visible:=false;

    for i1:= 31 to 35 do
      grData.Columns.Items[i1].Visible:=true;

    for i1:= 25 to 26 do
      grData.Columns.Items[i1].Visible:=true;

    aShowUserStatInfo.Enabled:=false;
  end
  else
  begin
    qReport.SQL.text:=qReportSimTrade.SQL.Text;
    for i1:= 0 to 23 do
      grData.Columns.Items[i1].Visible:=true;
    for i1:= 29 to 30 do
      grData.Columns.Items[i1].Visible:=true;
    for i1:= 31 to 35 do
      grData.Columns.Items[i1].Visible:=false;
    for i1:= 25 to 26 do
      grData.Columns.Items[i1].Visible:=false;
    aShowUserStatInfo.Enabled:=true;
  end;

  for i1:= 4 to 15 do
    grData.Columns.Items[i1].Visible:=false;
  for i1:= 29 to 35 do
    grData.Columns.Items[i1].Visible:=false;
//  grData.Columns.Items[21].Visible:=false;


  for i1 := 9 to 12 do
    grData.Columns.Items[i1].Visible := false;


  if cbPeriod.ItemIndex >= 0 then
  begin
    i1:=integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex]);
    qReport.ParamByName('YEAR_MONTH').AsInteger:=i1;
    YEAR_MONTH:= qReport.ParamByName('YEAR_MONTH').AsInteger;
  end;
end;

procedure TReportFinance.cbPeriodChange(Sender: TObject);
var
  i1:integer;
begin
  aRefresh.Enabled:=true;
  btRefresh.Enabled:=true;
  if cbPeriod.ItemIndex >= 0 then
  begin
    i1:=integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex]);
    qReport.ParamByName('YEAR_MONTH').AsInteger:=i1;
    YEAR_MONTH :=qReport.ParamByName('YEAR_MONTH').AsInteger;
  end ;
end;

procedure TReportFinance.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TReportFinance.FormCreate(Sender: TObject);
begin
  cbGroupClick(self);
end;

procedure TReportFinance.SHOW_ProgressBar;
begin
  //вызов вывода отчета - запроcом через кверю
  SHOW_Report;
end;

procedure TReportFinance.SHOW_LastDateRep;
var
  SqlOra : TOraQuery;
begin

  SqlOra:=TOraQuery.Create(nil);
  with SqlOra do
  begin
     //
    Close;
    sql.Clear;
    sql.add(' select distinct a.balance_date, a.session_id ');
    sql.add(' from (select max(DATE_REPORT) balance_date, max(session_id) session_id  from finance_report) a, ');
    sql.add(' finance_report b where b.year_month='+iNTTOSTR(YEAR_MONTH));
      // MessageDlg('sql.Text= '+sql.Text, mtConfirmation, [mbOK], 0);
    Execute;
    session_id:=FieldByName('session_id').Asinteger;
  end;
end;


procedure TReportFinance.SHOW_Report;
begin
  qReport.Active:=false;
  cbPeriodChange(Self);
  qReport.Active:=true;
end;


procedure TReportFinance.Timer1Timer(Sender: TObject);
var
  SqlOra : TOraQuery;
begin
  SqlOra:=TOraQuery.Create(nil);
  with SqlOra do
  begin
    Close;
    sql.Clear;
    sql.add(' select count(*) ncount from finance_report where  session_id='+IntToStr(session_id)+' and phone_number<>''0000000000'' ' );
    Execute;
    close;
  end;
end;

end.
