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
    qAccounts: TOraQuery;
    qPeriods: TOraQuery;
    qReport: TOraQuery;
    dsReport: TDataSource;
    qReportSimTrade: TOraQuery;
    cbGroup: TCheckBox;
    qReportSimTradeGroup: TOraQuery;
    qReportLontana: TOraQuery;
    qReportLontanaGroup: TOraQuery;
    Panel2: TPanel;
    StatusBar1: TStatusBar;
    Gauge1: TGauge;
    Timer1: TTimer;
    CBRefresh: TCheckBox;
    Lb_daterep: TLabel;
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
 PasswordDlg: TPasswordDlg;

begin
  if (GetConstantValue('SERVER_NAME') ='GSM_CORP') then begin
   PasswordDlg := TPasswordDlg.Create(Nil);
   if (PasswordDlg.ShowModal=mrCancel) then
    exit;
   if (PasswordDlg.Password.Text<>GetConstantValue('PAS_FINANCE_REPORT')) then begin
    ShowMessage('Пароль не верен!');
    exit;
   end;
  end;

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
         if (GetConstantValue('SERVER_NAME') ='GSM_CORP') then
          ReportFrm.SHOW_LastDateRep;
        //  ReportFrm.SHOW_ProgressBar;

   {ReportFrm.cbAccounts.Clear;
    ReportFrm.cbAccounts.Items.AddObject('Все', Pointer(0));
    ReportFrm.qAccounts.Open;
    while not ReportFrm.qAccounts.EOF do
    begin
      ReportFrm.cbAccounts.Items.AddObject(
        ReportFrm.qAccounts.FieldByName('LOGIN').AsString,
        Pointer(ReportFrm.qAccounts.FieldByName('ACCOUNT_ID').AsInteger)
        );
      ReportFrm.qAccounts.Next;
    end;
    ReportFrm.qAccounts.Close; }

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
  if GetConstantValue('SERVER_NAME')='SIM_TRADE' then
  begin
   qReport.Active:=false;
   cbPeriodChange(Self);
   qReport.Active:=true;
  end;

        if (GetConstantValue('SERVER_NAME') ='GSM_CORP') then
          begin
         cbPeriodChange(Self);
         SHOW_ProgressBar;
         Panel2.Visible:=true;
         StatusBar1.Visible:=true;
         Gauge1.Visible:=true;
         CBRefresh.Visible:=true;
         Lb_daterep.Visible:=true;
            end;

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
  CBRefresh.Checked:=false;
  qReport.Close;
  //qReport.Fields.Clear;
  //qReport.SQL.Clear;

  if cbGroup.Checked then
  begin
    if GetConstantValue('SERVER_NAME')='SIM_TRADE' then
      qReport.SQL.text:=qReportSimTradeGroup.SQL.Text
    else
      qReport.SQL.text:=qReportLontanaGroup.SQL.Text;
    //  MessageDlg('qReport.SQL.text= '+qReport.SQL.text, mtConfirmation, [mbOK], 0);

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
    if GetConstantValue('SERVER_NAME')='SIM_TRADE' then
      qReport.SQL.text:=qReportSimTrade.SQL.Text
    else
      qReport.SQL.text:=qReportLontana.SQL.Text;
   //qReport.Active:=false;
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
  if GetConstantValue('SERVER_NAME')='SIM_TRADE' then
  begin
    for i1:= 4 to 15 do
      grData.Columns.Items[i1].Visible:=false;
    for i1:= 29 to 35 do
      grData.Columns.Items[i1].Visible:=false;
    grData.Columns.Items[21].Visible:=false;
  end;

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
  s:string;
  i1:integer;
begin
   aRefresh.Enabled:=true;
   btRefresh.Enabled:=true;
   if cbPeriod.ItemIndex >= 0 then begin
    i1:=integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex]);
    qReport.ParamByName('YEAR_MONTH').AsInteger:=i1;
    YEAR_MONTH :=qReport.ParamByName('YEAR_MONTH').AsInteger;
    if (GetConstantValue('SERVER_NAME') ='GSM_CORP') then
    SHOW_LastDateRep;
     end ;


end;

procedure TReportFinance.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TReportFinance.FormCreate(Sender: TObject);
 var
  i1:integer;
begin
 cbGroupClick(self);

 //SHOW_LastDateRep;

 if (GetConstantValue('SERVER_NAME') ='GSM_CORP') then
          begin
        // cbPeriodChange(Self);
        // SHOW_ProgressBar;
         Panel2.Visible:=true;
         StatusBar1.Visible:=true;
         Gauge1.Visible:=true;
         CBRefresh.Visible:=true;
         Lb_daterep.Visible:=true;
            end;

end;

procedure TReportFinance.SHOW_ProgressBar;
var SqlOra : TOraQuery;
    Rep_Progress : Boolean;
    sql_text : string;

begin
  SqlOra:=TOraQuery.Create(nil);

// вывод отчета на экран по последней дате
if cbrefresh.Checked=False then
 begin
    StatusBar1.SimpleText:='Процесс вывода данных для отчета';
    //вызов вывода отчета - запроcом через кверю
    SHOW_Report;

end;

 // формирование отчета с пересбором данных
if cbrefresh.Checked=True then  begin

StatusBar1.Color:=clBtnFace;
Rep_Progress:=True;
with SqlOra do
    begin
     // определим сколько джобов запущено по данному процессу
     Close;
     sql.Clear;
     sql.add('select count(*) as count_jod_work from dba_jobs where  what like ''%balance.finance_balance_jobs%'' ');

   //  MessageDlg('sql.Text= '+sql.Text, mtConfirmation, [mbOK], 0);
     Execute;

     if FieldByName('count_jod_work').AsInteger>0 then
     begin
     Rep_Progress:=False;
     MessageDlg('В данный момент запущено формирование отчета , попробуйте сформировать отчет позже. ', mtConfirmation, [mbOK], 0);
     end;

    end;

     if Rep_Progress=True then begin

StatusBar1.SimpleText:='Процесс формирования данных для отчета';

with SqlOra do
    begin
      // назначение номера сессии формирования отчета
     Close;
     sql.Clear;
     sql.Text:='select s_session_balnow.nextval as sessionid from dual';
     Execute;
     session_id:=sqlOra.FieldByName('sessionid').AsInteger;
        begin
                  try
                   Close;
                   sql.Clear;

                   sql.Text:='begin balance.finance_balphone('+IntToStr(YEAR_MONTH)+','+IntToStr(session_id)+','''+FAccid+'''); end;';

                   Execute;
                  except
                      on e : exception do
                      MessageDlg('Ошибка выполнения balance.finance_balphone', mtError, [mbOK], 0);
                  end;
            end;

        Close;
        sql.Clear;
        sql.Text:='SELECT count(*) as record_count from finance_balance_phone where session_id='+IntToStr(session_id)+' and phone_number<>''0000000000'' ';
        Execute;
        record_count:=sqlOra.FieldByName('record_count').AsInteger;
        Gauge1.MaxValue:=record_count;

            // запускаем  джобы на заполнение testdelta_balance
          begin
                  try
                   Close;
                   sql.Clear;
                   sql.Text:='begin balance.finance_balance_jobs('+IntToStr(session_id)+'); end;';
                   Execute;
                  except
                      on e : exception do
                      MessageDlg('Ошибка выполнения balance.finance_balance_jobs', mtError, [mbOK], 0);
                  end;
            end;

        end;

            Timer1.Enabled:=true; //запуск таймера

       end;
end;
end;

procedure TReportFinance.SHOW_LastDateRep;
var SqlOra : TOraQuery;
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
     Lb_daterep.Caption:='Дата последнего отчета '+FieldByName('balance_date').AsString;
     session_id:=FieldByName('session_id').Asinteger;
       end;


end;


procedure TReportFinance.SHOW_Report;
var SqlOra : TOraQuery;
 begin

 qReport.Active:=false;
 cbPeriodChange(Self);
 qReport.Active:=true;


end;


procedure TReportFinance.Timer1Timer(Sender: TObject);
var SqlOra : TOraQuery;
   plusPG1 : integer;
   sql_text : string;
   ncount_jobs : integer;
begin
 ncount_jobs:=10;

SqlOra:=TOraQuery.Create(nil);
with SqlOra do
        begin
        Close;
        sql.Clear;
        sql.add(' select count(*) ncount from finance_report where  session_id='+IntToStr(session_id)+' and phone_number<>''0000000000'' ' );
        Execute;
        plusPG1:=sqlOra.FieldByName('ncount').AsInteger;
        StatusBar1.SimpleText:='Обработано записей '+inttostr(plusPG1)+' из '+inttostr(Gauge1.MaxValue);
        Gauge1.Progress:= plusPG1;
        close;
        end;



    If (Gauge1.Progress=Gauge1.MaxValue)    Then
    begin

    Timer1.Enabled:=False;
    Gauge1.Progress:=0;
    StatusBar1.Color:=clMoneyGreen;
    StatusBar1.SimpleText:='Процесс вывода данных для отчета на экран';

    //вызов вывода отчета - запроом через кверю
         SHOW_Report;

    StatusBar1.SimpleText:='Отчет сформирован';
    SHOW_LastDateRep;
    CBRefresh.Checked:=false;
    end;

end;

end.
