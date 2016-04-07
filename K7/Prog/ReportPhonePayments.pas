unit ReportPhonePayments;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, Grids, DBGrids, CRGrid, StdCtrls, Buttons,
  ExtCtrls, IntecExportGrid, ActnList;

type
  TReportPhonePaymentsFrm = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    cbPeriod: TComboBox;
    qPeriods: TOraQuery;
    ActionList1: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    Payments: TCRDBGrid;
    qReport: TOraQuery;
    DataSource1: TDataSource;
    qReportPHONE_NUMBER: TStringField;
    qReportPAYMENT_SUM: TFloatField;
    qReportPAYMENT_NUMBER: TStringField;
    qReportPAYMENT_STATUS_TEXT: TStringField;
    cbSearch: TCheckBox;
    cbAccounts: TComboBox;
    lAccount: TLabel;
    qAccounts: TOraQuery;
    qReportDATE_CREATED: TDateTimeField;
    qReportACCOUNT_NUMBER: TFloatField;
    qReportPAYMENT_DATE: TDateTimeField;
    qReportLOGIN: TStringField;
    qReportCOMPANY_NAME: TStringField;
    procedure aExcelExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbPeriodChange(Sender: TObject);
    procedure cbOperatorNamesChange(Sender: TObject);
    procedure cbSearchClick(Sender: TObject);
    procedure cbAccountsChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoReportPhonePayments;

//var ReportPhonePaymentsFrm: TReportPhonePaymentsFrm;

implementation

{$R *.dfm}

uses ShowUserStat, ContractsRegistration_Utils, Excel2000, Main;

procedure DoReportPhonePayments;
var ReportFrm : TReportPhonePaymentsFrm;
    Sdvig:integer;
begin
  ReportFrm := TReportPhonePaymentsFrm.Create(Nil);
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
{    // Операторы
    ReportFrm.cbOperatorNames.Items.Add('Все');
    ReportFrm.qOperators.Open;
    while not ReportFrm.qOperators.EOF do
    begin
      ReportFrm.cbOperatorNames.Items.Add(
        ReportFrm.qOperators.FieldByName('OPERATOR_NAME').AsString
        );
      ReportFrm.qOperators.Next;
    end;
    ReportFrm.qOperators.Close;
    if ReportFrm.cbOperatorNames.Items.Count > 0 then
      ReportFrm.cbOperatorNames.ItemIndex := 0;   }
    if GetConstantValue('REPORTS_USE_ACCOUNT_THREADS')='1' then
    begin
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

      if Integer(ReportFrm.cbAccounts.Items.objects[ReportFrm.cbAccounts.ItemIndex])<>0 then
        ReportFrm.qReport.ParamByName('ACCOUNT_ID').asInteger :=
          Integer(ReportFrm.cbAccounts.Items.objects[ReportFrm.cbAccounts.ItemIndex])
      else
        ReportFrm.qReport.ParamByName('ACCOUNT_ID').Clear;
    end
    else
    begin
      Sdvig:=ReportFrm.cbAccounts.Left+ReportFrm.cbAccounts.Width;
      ReportFrm.lAccount.Hide;
      ReportFrm.cbAccounts.Hide;
      ReportFrm.BitBtn1.Left:=ReportFrm.BitBtn1.Left-Sdvig;
      ReportFrm.BitBtn2.Left:=ReportFrm.BitBtn2.Left-Sdvig;
      ReportFrm.BitBtn3.Left:=ReportFrm.BitBtn3.Left-Sdvig;
      ReportFrm.cbSearch.Left:=ReportFrm.cbSearch.Left-Sdvig;
      ReportFrm.Label1.Left:=ReportFrm.Label1.Left-Sdvig;
      ReportFrm.cbPeriod.Left:=ReportFrm.cbPeriod.Left-Sdvig;
      ReportFrm.qReport.ParamByName('ACCOUNT_ID').Clear;
    end;
    // Обновим.
    ReportFrm.cbPeriodChange(ReportFrm.cbPeriod);
//    ReportFrm.aRefresh.Execute;
    ReportFrm.qReport.Open;
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;


procedure TReportPhonePaymentsFrm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Отчёт по детализации за ' + cbPeriod.Text + ' по состоянию на '+DateToStr(Date),'',
      Payments, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportPhonePaymentsFrm.aRefreshExecute(Sender: TObject);
begin
  qReport.Close;
  qReport.Open;
end;

procedure TReportPhonePaymentsFrm.aShowUserStatInfoExecute(Sender: TObject);
begin
  if qReport.Active and (qReport.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TReportPhonePaymentsFrm.cbAccountsChange(Sender: TObject);
var
  Account : integer;
begin
  if cbAccounts.ItemIndex >= 0 then
    Account := Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex])
  else
    Account:=0;

  if Account<>0 then
  begin
    qReport.ParamByName('ACCOUNT_ID').asInteger := Account;
    //aRefresh.Execute;
  end
  else
    qReport.ParamByName('ACCOUNT_ID').Clear;
end;

procedure TReportPhonePaymentsFrm.cbOperatorNamesChange(Sender: TObject);
var
  OperatorName : String;
begin
 { if cbOperatorNames.ItemIndex > 0 then
    OperatorName := cbOperatorNames.Items[cbOperatorNames.ItemIndex]
  else
    OperatorName := '';
  qReport.ParamByName('OPERATOR_NAME').AsString := OperatorName;
  aRefresh.Execute;   }
end;

procedure TReportPhonePaymentsFrm.cbPeriodChange(Sender: TObject);
var
  Period : Integer;
begin
  if cbPeriod.ItemIndex >= 0 then
    Period := Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
  else
    Period := -1;
  qReport.ParamByName('YEAR_MONTH').AsInteger := Period;
 // aRefresh.Execute;
end;

procedure TReportPhonePaymentsFrm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    Payments.OptionsEx:=Payments.OptionsEx+[dgeSearchBar]
  else
    Payments.OptionsEx:=Payments.OptionsEx-[dgeSearchBar];
end;

procedure TReportPhonePaymentsFrm.FormCreate(Sender: TObject);
begin
  if MainForm.FUseFilialBlockAccess then
  begin
    qReport.SQL.Append('AND ' + IntToStr(MainForm.FFilial)
     + ' = (SELECT AC.FILIAL_ID FROM ACCOUNTS AC '
     + 'WHERE p.ACCOUNT_ID = AC.ACCOUNT_ID)');
    qAccounts.SQL.Insert(2, 'WHERE FILIAL_ID=' + IntToStr(MainForm.FFilial));
  end;

  qReport.SQL.Append('ORDER BY PAYMENT_DATE DESC ');
end;

end.
