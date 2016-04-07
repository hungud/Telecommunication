unit ReportFinanceHistoryPhoneActiv;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, CRGrid,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ActnList, Data.DB, MemDS,
  DBAccess, Ora;

type
  TReportFinanceHistoryPhoneActivForm = class(TForm)
    qReport: TOraQuery;
    dsReport: TDataSource;
    alReport: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    qPeriods: TOraQuery;
    Panel1: TPanel;
    lPeriod: TLabel;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    btInfoAbonent: TBitBtn;
    cbPeriod: TComboBox;
    cbSearch: TCheckBox;
    GridReport: TCRDBGrid;
    qReportPHONE_NUMBER: TStringField;
    qReportBAN: TFloatField;
    BitBtn1: TBitBtn;
    cbAccounts: TComboBox;
    procedure aExcelExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbPeriodChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoReportFinancePhoneActivList;

var
  ReportFinanceHistoryPhoneActivForm: TReportFinanceHistoryPhoneActivForm;

implementation

{$R *.dfm}

uses IntecExportGrid, ShowUserStat, ContractsRegistration_Utils;

procedure DoReportFinancePhoneActivList;
var ReportFrm : TReportFinanceHistoryPhoneActivForm;
    Sdvig:integer;
begin
  ReportFrm:=TReportFinanceHistoryPhoneActivForm.Create(Nil);
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
    ReportFrm.cbAccounts.ItemIndex:=0;
    if ReportFrm.cbPeriod.Items.Count > 0 then
      ReportFrm.cbPeriod.ItemIndex := 0;
    // Отчет
    ReportFrm.cbPeriodChange(ReportFrm.cbPeriod);
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportFinanceHistoryPhoneActivForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Отчёт по активным номерам за  ' + cbPeriod.Text,'',
      GridReport, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportFinanceHistoryPhoneActivForm.aRefreshExecute(Sender: TObject);
begin
  qReport.Close;
  case cbAccounts.ItemIndex of
    0: Begin
      qReport.SQL.Clear;
      qReport.SQL.Add('SELECT * ');
      qReport.SQL.Add('FROM PHONE_ACTIV_LOG ');
      qReport.SQL.Add('WHERE YEAR_MONTH=:YEAR_MONTH ');
      qReport.SQL.Add('ORDER BY PHONE_NUMBER');
    End;
    1: Begin
      qReport.SQL.Clear;
      qReport.SQL.Add('select * ');
      qReport.SQL.Add('from PHONE_ACTIV_LOG t1 ');
      qReport.SQL.Add('where t1.year_month=:YEAR_MONTH ');
      qReport.SQL.Add('and phone_number in (select t2.phone_number ');
      qReport.SQL.Add('from DB_LOADER_ACCOUNT_PHONES t2, accounts ac ');
      qReport.SQL.Add('where t2.year_month=:YEAR_MONTH ');
      qReport.SQL.Add('and T2.ACCOUNT_ID=AC.ACCOUNT_ID ');
      qReport.SQL.Add('and T1.PHONE_NUMBER=T2.PHONE_NUMBER ');
      qReport.SQL.Add('and AC.IS_COLLECTOR=1) ');
      qReport.SQL.Add('ORDER BY t1.PHONE_NUMBER');
    End;
    2: Begin
      qReport.SQL.Clear;
      qReport.SQL.Add('select * ');
      qReport.SQL.Add('from PHONE_ACTIV_LOG t1 ');
      qReport.SQL.Add('where t1.year_month=:YEAR_MONTH ');
      qReport.SQL.Add('and phone_number not in (select t2.phone_number ');
      qReport.SQL.Add('from DB_LOADER_ACCOUNT_PHONES t2, accounts ac ');
      qReport.SQL.Add('where t2.year_month=:YEAR_MONTH ');
      qReport.SQL.Add('and T2.ACCOUNT_ID=AC.ACCOUNT_ID ');
      qReport.SQL.Add('and T1.PHONE_NUMBER=T2.PHONE_NUMBER ');
      qReport.SQL.Add('and AC.IS_COLLECTOR=1) ');
      qReport.SQL.Add('ORDER BY t1.PHONE_NUMBER');
    End;
  end;
  cbPeriodChange(cbPeriod);
  qReport.Open;
end;

procedure TReportFinanceHistoryPhoneActivForm.aShowUserStatInfoExecute(Sender: TObject);
begin
  if qReport.Active and (qReport.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TReportFinanceHistoryPhoneActivForm.BitBtn1Click(Sender: TObject);
var SqlOra : TOraQuery;
    bill_new_report :string;
begin
SqlOra:=TOraQuery.Create(nil);
with SqlOra do
        begin
         try
        Close;
        sql.Clear;
        sql.add(' select to_char(bill_load, ''YYYYMM'') as bill_new_report, bill_load date_new_report  ');
        sql.add(' from (with t as (select max(year_month) year_month, trunc(sysdate) d from PHONE_ACTIV_LOG)  ');
        sql.add(' select CASE WHEN add_months(to_date(year_month, ''YYYYMM''), 1) >=trunc(d, ''MM'') then d  ');
        sql.add(' else add_months(to_date(year_month, ''YYYYMM''), 1) END bill_load from t) ');
        Execute;
         except
                  on e : exception do
                  MessageDlg('Ошибка выполнения запроса: '+sql.Text, mtError, [mbOK], 0);
                end;

            if  FieldByName('date_new_report').AsDateTime=Date then
            begin
              MessageDlg('Период '+FieldByName('bill_new_report').AsString+' не готов для загрузки в отчет!', mtError, [mbOK], 0);
            end;

            bill_new_report:= FieldByName('bill_new_report').AsString;

            if  FieldByName('date_new_report').AsDateTime<Date then
            begin
         Close;
        sql.Clear;
        sql.add('begin GET_ACTIV_PHONES('+bill_new_report+') ;end;');
        Execute;
        qPeriods.Close;
qPeriods.Open;

    while not qPeriods.EOF do
    begin
      cbPeriod.Items.AddObject(
        qPeriods.FieldByName('YEAR_MONTH_NAME').AsString,
        TObject(qPeriods.FieldByName('YEAR_MONTH').AsInteger)
        );
      qPeriods.Next;
    end;
    qPeriods.Close;
    if cbPeriod.Items.Count > 0 then
      cbPeriod.ItemIndex := 0;
    // Отчет
    cbPeriodChange(cbPeriod);
            end;

        end;

 end;

procedure TReportFinanceHistoryPhoneActivForm.cbPeriodChange(Sender: TObject);
var Period : Integer;
begin
  if cbPeriod.ItemIndex >= 0 then
    Period := Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
  else
    Period := -1;
  qReport.ParamByName('YEAR_MONTH').AsInteger := Period;
 // aRefresh.Execute;
end;

end.
